import '../../../../core/errors/failure.dart';
import '../../domain/entities/auth_tokens.dart';
import '../../domain/entities/user.dart';
import '../../domain/repositories/auth_repository.dart';

/// Offline, always-authenticated [AuthRepository].
///
/// The app runs fully locally with a fixed local user; login/registration are
/// reserved for future cloud synchronization and are therefore unavailable.
/// The real remote auth implementation remains in the codebase for later.
class LocalAuthRepository implements AuthRepository {
  const LocalAuthRepository();

  @override
  Future<User> login({required String email, required String password}) async {
    throw const AuthenticationFailure(
      message: 'Login disponível apenas com sincronização em nuvem.',
    );
  }

  @override
  Future<User> register({
    required String name,
    required String email,
    required String password,
  }) async {
    throw const AuthenticationFailure(
      message: 'Registro disponível apenas com sincronização em nuvem.',
    );
  }

  @override
  Future<void> logout() async {}

  @override
  Future<void> forgotPassword(String email) async {}

  @override
  Future<User?> currentUser() async => _localUser;

  @override
  Future<bool> isBiometricEnabled() async => false;

  @override
  Future<bool> authenticateWithBiometrics() async => true;

  @override
  Future<void> saveTokens(AuthTokens tokens) async {}

  static const User _localUser = User(
    id: 'local-user',
    email: 'local@fince.app',
    name: 'Usuário local',
    avatarUrl: null,
    currency: 'BRL',
    locale: 'pt_BR',
    isActive: true,
  );
}
