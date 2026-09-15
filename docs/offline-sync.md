# Offline Synchronization

## 1. Principles

- **Local-first.** Drift is the source of truth at runtime. Reads never block on the network.
- **Write, then sync.** Every mutation is committed locally first and *also* enqueued for the
  remote backend — atomically, in the same database transaction.
- **Idempotent replay.** Replaying a queued operation any number of times yields the same final
  state as replaying it once.
- **Ordered, resumable, observable.** The queue is durable, retried with backoff, and its
  failures are reported to observability (redacted).

## 2. Architecture

```
 UI → use case
        ├── write local DB (Drift)  ──┐  (single transaction)
        └── enqueue SyncOperation ────┘
                │
        SyncManager (drains queue)
                │
        RemoteDataSource (Dio)
                │
        ┌───────▼────────┐
        │  Remote backend │
        └────────────────┘
```

## 3. `SyncOperation`

| Field | Meaning |
| --- | --- |
| `id` | UUID |
| `entityId` | UUID of the affected entity (stable across retries) |
| `entityType` | `user \| account \| transaction \| category \| credit_card \| invoice \| installment \| budget \| goal \| recurring_transaction` |
| `operation` | `create \| update \| delete` |
| `payload` | JSON of the full entity DTO at write time |
| `timestamp` | client time of the mutation (for last-write-wins) |
| `status` | `pending \| syncing \| synced \| failed` |
| `retryCount` | incremented per failed attempt |
| `lastError` | redacted, non-sensitive error string |
| `idempotencyKey` | client UUID reused as the HTTP `Idempotency-Key` |

## 4. Write path (atomic)

`AccountRepositoryImpl`, `TransactionRepositoryImpl`, etc. all funnel through one helper:

```dart
Future<T> runMutation(Future<T> Function() localWrite, SyncOperation op) async {
  return db.transaction(() async {
    final result = await localWrite();       // insert/update/delete in Drift
    await syncQueue.enqueue(op);             // append SyncOperation
    return result;
  });
}
```

This guarantees a local change is never lost even if the app is killed right after the write.

## 5. Sync manager flow

1. Listens to `connectivity_plus`; on regain of connectivity, and on a periodic timer, it drains
   the queue.
2. Loads the oldest `pending`/`failed` operations (bounded batch, e.g. 100).
3. Marks them `syncing`, POSTs them to `POST /v1/sync`, then:
   - `synced` → delete/mark `synced` (kept for audit), clear `retryCount`;
   - `failed` (4xx validation/conflict) → `failed`, no auto-retry beyond a cap;
   - `failed` (5xx/network) → back to `pending` with `retryCount++` and **exponential backoff**
     (`min(2^retryCount * base, maxDelay)`).
4. Repeats until the queue is empty or no connectivity.

The `SyncManager` is a BLoC (or a plain `ChangeNotifier`) registered as a singleton so there is
exactly one drainer.

## 6. Idempotency

- Every operation carries a client-generated **`idempotencyKey`** (also the HTTP header).
- The backend stores processed idempotency keys and, on replay, returns the original response
  instead of re-applying — safe against double-submits caused by network retries.
- **Deletes are idempotent by nature** (deleting a missing record is a `200/204` success).
- **Creates use client UUID entity ids**, so a replayed create is an upsert on the same id, not a
  duplicate row.
- **Updates are last-write-wins** by `updatedAt`/`timestamp`: the server applies the newer
  timestamp and ignores the older one, so out-of-order replay converges.

## 7. Conflict resolution

- Single-device-first: **last-write-wins** on `updatedAt`.
- The `SyncOperation.timestamp` is the tie-breaker; ties prefer the server's existing row.
- Multi-device merge is a future enhancement; the contract already carries per-field timestamps
  if finer merge granularity is needed later.

## 8. Recurring generation interplay

Recurring generation is **local-only and idempotent** (see domain model). Generated transactions
are enqueued like any other create, so they sync once connectivity returns. Because generation
uses a stable `occurrenceKey`, a re-run after a crash cannot produce duplicates.

## 9. Failure handling & observability

- Each failed batch raises a redacted event to `RemoteLog`/Crashlytics (entity type + operation
  only — **never the payload**, which may contain amounts).
- The sync status is surfaced in the UI (a small "pending sync (3)" badge) so the user has
  visibility without being interrupted.

## 10. Testability

The queue and manager are unit-testable with a fake `RemoteDataSource` and in-memory Drift:

- enqueue is atomic with the local write,
- replay is idempotent (same key twice → one remote effect),
- backoff increments and eventually marks `failed`,
- out-of-order updates converge to last-write-wins.
