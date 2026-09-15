import 'package:freezed_annotation/freezed_annotation.dart';

part 'sync_operation.freezed.dart';

/// Mutation kind.
enum SyncOperationType { create, update, delete }

/// Sync lifecycle state.
enum SyncStatus { pending, syncing, synced, failed }

/// A durable, idempotent queue entry (see `docs/offline-sync.md`).
@freezed
abstract class SyncOperation with _$SyncOperation {
  const factory SyncOperation({
    required String id,
    required String entityId,
    required String entityType,
    required SyncOperationType operation,
    required String payload,
    required DateTime timestamp,
    required SyncStatus status,
    required int retryCount,
    String? lastError,
    required String idempotencyKey,
  }) = _SyncOperation;
}
