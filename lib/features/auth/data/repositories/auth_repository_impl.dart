import 'package:local_auth/local_auth.dart';

import '../../../../core/errors/exception_to_failure.dart';
import '../../domain/entities/auth_tokens.dart';
import '../../domain/entities/user.dart';
import '../../domain/repositories/auth_repository.dart';
import '../datasources/auth_local_data_source.dart';
import '../datasources/auth_remote_data_source.dart';
import '../models/auth_tokens_model.dart';
import '../models/user_model.dart';

/// Default [AuthRepository] implementation backed by secure local storage and
/// the remote contract. Biometric checks are delegated to `local_auth`.
class AuthRepositoryImpl implements AuthRepository {
  AuthRepositoryImpl({
    required AuthRemoteDataSource remote,
    required AuthLocalDataSource local,
    LocalAuthentication? localAuth,
  })  : _remote = remote,
        _local = local,
        _localAuth = localAuth ?? LocalAuthentication();

  final AuthRemoteDataSource _remote;
  final AuthLocalDataSource _local;
  final LocalAuthentication _localAuth;

  @override
  Future<User> login({required String email, required String password}) async {
    try {
      final result = await _remote.login(email, password);
      await _persist(result.user, result.tokens);
      return result.user.toEntity();
    } catch (e) {
      throw mapExceptionToFailure(e);
    }
  }

  @override
  Future<User> register({
    required String name,
    required String email,
    required String password,
  }) async {
    try {
      final result = await _remote.register(name, email, password);
      await _persist(result.user, result.tokens);
      return result.user.toEntity();
    } catch (e) {
      throw mapExceptionToFailure(e);
    }
  }

  @override
  Future<void> logout() async {
    try {
      await _remote.logout();
    } catch (_) {
      // Best-effort remote revoke; the local session must always clear.
    }
    await _local.clear();
  }

  @override
  Future<void> forgotPassword(String email) async {
    try {
      await _remote.forgotPassword(email);
    } catch (e) {
      throw mapExceptionToFailure(e);
    }
  }

  @override
  Future<User?> currentUser() async {
    final token = await _local.readAccessToken();
    if (token == null || token.isEmpty) return null;
    final user = await _local.readUser();
    return user?.toEntity();
  }

  @override
  Future<bool> isBiometricEnabled() => _local.readBiometricEnabled();

  @override
  Future<bool> authenticateWithBiometrics() async {
    final canCheck = await _localAuth.canCheckBiometrics;
    if (!canCheck) return false;
    return _localAuth.authenticate(
      localizedReason: 'Autentique-se para acessar o Fince',
      biometricOnly: true,
    );
  }

  @override
  Future<void> saveTokens(AuthTokens tokens) => _local.saveTokens(
        AuthTokensModel(
          accessToken: tokens.accessToken,
          refreshToken: tokens.refreshToken,
          expiresIn: tokens.expiresIn,
        ),
      );

  Future<void> _persist(UserModel user, AuthTokensModel tokens) async {
    await _local.saveTokens(tokens);
    await _local.saveUser(user);
  }
}
