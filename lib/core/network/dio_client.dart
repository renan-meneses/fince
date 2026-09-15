import 'package:dio/dio.dart';

import '../config/app_config.dart';
import 'interceptors/auth_interceptor.dart';
import 'interceptors/logging_interceptor.dart';

/// Builds the single [Dio] instance used by all remote data sources.
///
/// - HTTPS-only in staging/production (enforced by config base URL + callers).
/// - Auth header is injected per-request from a token provider.
/// - Logging interceptor redacts sensitive headers/bodies.
Dio buildDio(
  AppConfig config, {
  required Future<String?> Function() tokenProvider,
}) {
  final dio = Dio(
    BaseOptions(
      baseUrl: config.baseUrl,
      connectTimeout: const Duration(seconds: 15),
      receiveTimeout: const Duration(seconds: 20),
      sendTimeout: const Duration(seconds: 20),
      headers: const {'Content-Type': 'application/json'},
    ),
  );

  dio.interceptors
    ..add(AuthInterceptor(tokenProvider: tokenProvider))
    ..add(LoggingInterceptor());

  return dio;
}
