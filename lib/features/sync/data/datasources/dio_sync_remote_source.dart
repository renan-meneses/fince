import 'package:dio/dio.dart';

import '../../domain/entities/sync_operation.dart';
import '../../domain/repositories/sync_remote_source.dart';

/// Targets `POST /sync` (see `docs/api-contract.md`).
class DioSyncRemoteSource implements SyncRemoteSource {
  DioSyncRemoteSource(this._dio);

  final Dio _dio;

  @override
  Future<List<SyncResult>> push(List<SyncOperation> operations) async {
    final response = await _dio.post<Map<String, dynamic>>(
      '/sync',
      data: {
        'operations': operations
            .map(
              (o) => {
                'idempotencyKey': o.idempotencyKey,
                'entityType': o.entityType,
                'operation': o.operation.name,
                'entityId': o.entityId,
                'payload': o.payload,
                'timestamp': o.timestamp.toIso8601String(),
              },
            )
            .toList(),
      },
    );

    final results = (response.data!['results'] as List<dynamic>)
        .cast<Map<String, dynamic>>()
        .map(
          (r) => SyncResult(
            idempotencyKey: r['idempotencyKey'] as String,
            synced: r['status'] == 'synced',
            reason: r['reason'] as String?,
          ),
        )
        .toList();
    return results;
  }
}
