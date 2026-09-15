import '../entities/sync_operation.dart';

/// Result of a single queued operation on the remote backend.
class SyncResult {
  const SyncResult({
    required this.idempotencyKey,
    required this.synced,
    this.reason,
  });

  final String idempotencyKey;
  final bool synced;
  final String? reason;
}

/// Remote sync contract. The Dio implementation targets `POST /sync`
/// (see `docs/api-contract.md`).
abstract interface class SyncRemoteSource {
  Future<List<SyncResult>> push(List<SyncOperation> operations);
}
