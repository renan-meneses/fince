import '../../../../core/demo/demo_credentials.dart';
import '../../../../core/errors/failure.dart';
import '../../domain/entities/auth_tokens.dart';
import '../../domain/entities/user.dart';
import '../../domain/repositories/auth_repository.dart';
import '../datasources/auth_local_data_source.dart';
import '../models/auth_tokens_model.dart';
import '../models/user_model.dart';

/// In-memory [AuthRepository] for demo mode.
///
/// Accepts the fixed [DemoCredentials] pair (no backend), persists a mock
/// session locally, and returns a fixed user. This lets the app be exercised
/// end-to-end without a server.
class DemoAuthRepository implements AuthRepository {
  DemoAuthRepository({required AuthLocalDataSource local}) : _local = local;

  final AuthLocalDataSource _local;

  @override
  Future<User> login({required String email, required String password}) async {
    final normalized = email.trim().toLowerCase();
    if (normalized != DemoCredentials.email ||
        password != DemoCredentials.password) {
      throw const AuthenticationFailure(message: 'E-mail ou senha inválidos.');
    }
    final user = _demoUser;
    await _persist(user);
    return user;
  }

  @override
  Future<User> register({
    required String name,
    required String email,
    required String password,
  }) async {
    throw const AuthenticationFailure(
      message: 'Registro indisponível no modo demo.',
    );
  }

  @override
  Future<void> logout() => _local.clear();

  @override
  Future<void> forgotPassword(String email) async {
    // No-op in demo mode.
  }

  @override
  Future<User?> currentUser() async => _demoUser;

  @override
  Future<bool> isBiometricEnabled() => _local.readBiometricEnabled();

  @override
  Future<bool> authenticateWithBiometrics() async => true;

  @override
  Future<void> saveTokens(AuthTokens tokens) async {
    await _local.saveTokens(
      AuthTokensModel(
        accessToken: tokens.accessToken,
        refreshToken: tokens.refreshToken,
        expiresIn: tokens.expiresIn,
      ),
    );
  }

  Future<void> _persist(User user) async {
    await _local.saveTokens(
      const AuthTokensModel(
        accessToken: 'demo-access-token',
        refreshToken: 'demo-refresh-token',
        expiresIn: 3600,
      ),
    );
    await _local.saveUser(
      UserModel(
        id: user.id,
        email: user.email,
        name: user.name,
        avatarUrl: user.avatarUrl,
        currency: user.currency,
        locale: user.locale,
        isActive: user.isActive,
      ),
    );
  }

  static const User _demoUser = User(
    id: DemoCredentials.userId,
    email: DemoCredentials.email,
    name: DemoCredentials.name,
    avatarUrl: null,
    currency: 'BRL',
    locale: 'pt_BR',
    isActive: true,
  );
}
