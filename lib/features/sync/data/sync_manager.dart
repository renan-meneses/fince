import '../domain/entities/sync_operation.dart';
import '../domain/repositories/sync_remote_source.dart';
import '../domain/repositories/sync_repository.dart';

/// Drains the offline sync queue toward the remote backend.
///
/// Idempotency: each operation carries a stable [SyncOperation.idempotencyKey];
/// the backend deduplicates replayed requests. The queue is drained in bounded
/// batches and failures are marked for retry.
class SyncManager {
  SyncManager({required SyncRepository repository, required SyncRemoteSource remote})
      : _repository = repository,
        _remote = remote;

  final SyncRepository _repository;
  final SyncRemoteSource _remote;

  /// Pushes pending operations and returns how many were synced.
  Future<int> drain() async {
    final pending = await _repository.getPending(limit: 100);
    if (pending.isEmpty) return 0;

    for (final op in pending) {
      await _repository.markSyncing(op.id);
    }

    final results = await _remote.push(pending);

    var synced = 0;
    for (final op in pending) {
      final result = _findResult(results, op.idempotencyKey);
      if (result != null && result.synced) {
        await _repository.markSynced(op.id);
        synced++;
      } else {
        await _repository.markFailed(op.id, result?.reason ?? 'Unknown error');
      }
    }
    return synced;
  }

  SyncResult? _findResult(List<SyncResult> results, String idempotencyKey) {
    for (final r in results) {
      if (r.idempotencyKey == idempotencyKey) return r;
    }
    return null;
  }
}
