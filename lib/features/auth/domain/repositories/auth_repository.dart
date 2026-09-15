import '../entities/auth_tokens.dart';
import '../entities/user.dart';

/// Authentication contract (domain port).
///
/// Implementations may target JWT, OAuth2, or Firebase Authentication without
/// any change to the presentation layer.
abstract interface class AuthRepository {
  Future<User> login({required String email, required String password});

  Future<User> register({
    required String name,
    required String email,
    required String password,
  });

  Future<void> logout();

  Future<void> forgotPassword(String email);

  /// Returns the locally cached session user, or `null` when logged out.
  Future<User?> currentUser();

  Future<bool> isBiometricEnabled();

  Future<bool> authenticateWithBiometrics();

  /// Stores freshly issued tokens after a refresh (used by the network layer).
  Future<void> saveTokens(AuthTokens tokens);
}
