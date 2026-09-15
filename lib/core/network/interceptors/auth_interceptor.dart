import 'package:dio/dio.dart';

/// Attaches the bearer token to outbound requests.
///
/// The token is fetched lazily from secure storage so a refreshed token is
/// always used without rebuilding the client.
class AuthInterceptor extends Interceptor {
  AuthInterceptor({required this.tokenProvider});

  final Future<String?> Function() tokenProvider;

  @override
  Future<void> onRequest(
    RequestOptions options,
    RequestInterceptorHandler handler,
  ) async {
    final token = await tokenProvider();
    if (token != null && token.isNotEmpty) {
      options.headers['Authorization'] = 'Bearer $token';
    }
    handler.next(options);
  }
}
