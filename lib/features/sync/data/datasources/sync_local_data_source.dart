import 'package:drift/drift.dart';

import '../../../../core/storage/app_database.dart';
import '../../domain/entities/sync_operation.dart';

/// Drift-backed local storage for the sync queue.
class SyncLocalDataSource {
  SyncLocalDataSource(this._db);

  final AppDatabase _db;

  Future<void> enqueue(SyncOperation operation) async {
    await _db.into(_db.syncOperations).insert(_toCompanion(operation));
  }

  Future<List<SyncOperation>> getPending({int limit = 100}) async {
    final rows = await (_db.select(_db.syncOperations)
          ..where((t) => t.status.equals('pending'))
          ..orderBy([(t) => OrderingTerm.asc(t.timestamp)])
          ..limit(limit))
        .get();
    return rows.map(_toEntity).toList();
  }

  Future<void> markSyncing(String id) async {
    await (_db.update(_db.syncOperations)..where((t) => t.id.equals(id)))
        .write(const SyncOperationsCompanion(status: Value('syncing')));
  }

  Future<void> markSynced(String id) async {
    await (_db.update(_db.syncOperations)..where((t) => t.id.equals(id)))
        .write(const SyncOperationsCompanion(status: Value('synced')));
  }

  Future<void> markFailed(String id, String error) async {
    await (_db.update(_db.syncOperations)..where((t) => t.id.equals(id)))
        .write(
      SyncOperationsCompanion(
        status: const Value('failed'),
        retryCount: const Value(1),
        lastError: Value(error),
      ),
    );
  }

  SyncOperation _toEntity(SyncOperationRow row) => SyncOperation(
        id: row.id,
        entityId: row.entityId,
        entityType: row.entityType,
        operation: SyncOperationType.values.byName(row.operation),
        payload: row.payload,
        timestamp: row.timestamp,
        status: SyncStatus.values.byName(row.status),
        retryCount: row.retryCount,
        lastError: row.lastError,
        idempotencyKey: row.idempotencyKey,
      );

  SyncOperationsCompanion _toCompanion(SyncOperation op) =>
      SyncOperationsCompanion.insert(
        id: op.id,
        entityId: op.entityId,
        entityType: op.entityType,
        operation: op.operation.name,
        payload: op.payload,
        timestamp: op.timestamp,
        status: Value(op.status.name),
        retryCount: Value(op.retryCount),
        lastError: Value(op.lastError),
        idempotencyKey: op.idempotencyKey,
      );
}
