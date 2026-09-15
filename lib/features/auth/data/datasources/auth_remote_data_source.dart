import 'package:dio/dio.dart';

import '../models/auth_tokens_model.dart';
import '../models/user_model.dart';

/// Auth endpoints defined in `docs/api-contract.md`.
class AuthRemoteDataSource {
  AuthRemoteDataSource(this._dio);

  final Dio _dio;

  Future<({UserModel user, AuthTokensModel tokens})> login(
    String email,
    String password,
  ) async {
    final response = await _dio.post<Map<String, dynamic>>(
      '/auth/login',
      data: {'email': email, 'password': password},
    );
    return _parse(response.data!);
  }

  Future<({UserModel user, AuthTokensModel tokens})> register(
    String name,
    String email,
    String password,
  ) async {
    final response = await _dio.post<Map<String, dynamic>>(
      '/auth/register',
      data: {'name': name, 'email': email, 'password': password},
    );
    return _parse(response.data!);
  }

  Future<void> forgotPassword(String email) async {
    await _dio.post<void>('/auth/forgot-password', data: {'email': email});
  }

  Future<void> logout() async {
    await _dio.post<void>('/auth/logout');
  }

  ({UserModel user, AuthTokensModel tokens}) _parse(
    Map<String, dynamic> data,
  ) {
    return (
      user: UserModel.fromJson(data['user'] as Map<String, dynamic>),
      tokens: AuthTokensModel.fromJson(data['tokens'] as Map<String, dynamic>),
    );
  }
}
