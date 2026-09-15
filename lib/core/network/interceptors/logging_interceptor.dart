import 'dart:developer' as developer;

import 'package:dio/dio.dart';

/// Minimal request/response logging that **never** records auth headers,
/// request bodies, or response payloads (which may contain financial data).
///
/// See `docs/security.md` for the redaction policy.
class LoggingInterceptor extends Interceptor {
  @override
  void onRequest(RequestOptions options, RequestInterceptorHandler handler) {
    developer.log(
      'HTTP ${options.method} ${options.uri.path}',
      name: 'fince.network',
    );
    handler.next(options);
  }

  @override
  void onResponse(Response<dynamic> response, ResponseInterceptorHandler handler) {
    developer.log(
      'HTTP ${response.statusCode} ${response.requestOptions.uri.path}',
      name: 'fince.network',
    );
    handler.next(response);
  }

  @override
  void onError(DioException err, ErrorInterceptorHandler handler) {
    developer.log(
      'HTTP ERROR ${err.requestOptions.uri.path} '
      '(${err.type.name})',
      name: 'fince.network',
    );
    handler.next(err);
  }
}
