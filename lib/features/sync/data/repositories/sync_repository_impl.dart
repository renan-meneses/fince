import '../../../../core/errors/exception_to_failure.dart';
import '../../domain/entities/sync_operation.dart';
import '../../domain/repositories/sync_repository.dart';
import '../datasources/sync_local_data_source.dart';

/// Local-first [SyncRepository].
class SyncRepositoryImpl implements SyncRepository {
  SyncRepositoryImpl({required SyncLocalDataSource local}) : _local = local;

  final SyncLocalDataSource _local;

  @override
  Future<void> enqueue(SyncOperation operation) async {
    try {
      await _local.enqueue(operation);
    } catch (e) {
      throw mapExceptionToFailure(e);
    }
  }

  @override
  Future<List<SyncOperation>> getPending({int limit = 100}) async {
    try {
      return await _local.getPending(limit: limit);
    } catch (e) {
      throw mapExceptionToFailure(e);
    }
  }

  @override
  Future<void> markSyncing(String id) => _local.markSyncing(id);

  @override
  Future<void> markSynced(String id) => _local.markSynced(id);

  @override
  Future<void> markFailed(String id, String error) =>
      _local.markFailed(id, error);
}
