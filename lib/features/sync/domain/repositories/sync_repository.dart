import '../entities/sync_operation.dart';

/// Sync queue contract (domain port).
abstract interface class SyncRepository {
  Future<void> enqueue(SyncOperation operation);

  Future<List<SyncOperation>> getPending({int limit = 100});

  Future<void> markSyncing(String id);

  Future<void> markSynced(String id);

  Future<void> markFailed(String id, String error);
}
