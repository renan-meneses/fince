import 'package:drift/native.dart';
import 'package:fince/core/storage/app_database.dart';
import 'package:fince/features/sync/data/datasources/sync_local_data_source.dart';
import 'package:fince/features/sync/data/repositories/sync_repository_impl.dart';
import 'package:fince/features/sync/data/sync_manager.dart';
import 'package:fince/features/sync/domain/entities/sync_operation.dart';
import 'package:fince/features/sync/domain/repositories/sync_remote_source.dart';
import 'package:fince/features/sync/domain/repositories/sync_repository.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:uuid/uuid.dart';

class _FakeRemoteSource implements SyncRemoteSource {
  final appliedKeys = <String>{};

  @override
  Future<List<SyncResult>> push(List<SyncOperation> operations) async {
    return operations.map((op) {
      appliedKeys.add(op.idempotencyKey); // deduplicates by set membership
      return SyncResult(idempotencyKey: op.idempotencyKey, synced: true);
    }).toList();
  }
}

void main() {
  late AppDatabase db;
  late SyncRepository repository;
  late _FakeRemoteSource remote;
  late SyncManager manager;

  setUp(() {
    db = AppDatabase(NativeDatabase.memory());
    repository = SyncRepositoryImpl(local: SyncLocalDataSource(db));
    remote = _FakeRemoteSource();
    manager = SyncManager(repository: repository, remote: remote);
  });

  tearDown(() async {
    await db.close();
  });

  SyncOperation op({String? key, String entityId = 'e1'}) => SyncOperation(
        id: const Uuid().v4(),
        entityId: entityId,
        entityType: 'transaction',
        operation: SyncOperationType.create,
        payload: '{}',
        timestamp: DateTime.now().toUtc(),
        status: SyncStatus.pending,
        retryCount: 0,
        idempotencyKey: key ?? const Uuid().v4(),
      );

  test('enqueues operations with all sync fields', () async {
    final key = const Uuid().v4();
    await repository.enqueue(op(key: key));

    final pending = await repository.getPending();
    expect(pending, hasLength(1));
    expect(pending.first.entityId, 'e1');
    expect(pending.first.entityType, 'transaction');
    expect(pending.first.operation, SyncOperationType.create);
    expect(pending.first.status, SyncStatus.pending);
    expect(pending.first.idempotencyKey, key);
  });

  test('drain marks operations synced and is idempotent on replay', () async {
    final key = const Uuid().v4();
    await repository.enqueue(op(key: key));

    final synced = await manager.drain();
    expect(synced, 1);
    expect(remote.appliedKeys, {key});
    expect(await repository.getPending(), isEmpty);

    // Simulate a client crash before ack: the same operation is re-enqueued.
    await repository.enqueue(op(key: key, entityId: 'e1'));
    final replayed = await manager.drain();

    expect(replayed, 1);
    // The backend applied the idempotency key exactly once.
    expect(remote.appliedKeys, hasLength(1));
    expect(await repository.getPending(), isEmpty);
  });
}
