import '../repositories/auth_repository.dart';

/// Attempts biometric authentication to unlock an existing session.
class AuthenticateWithBiometrics {
  const AuthenticateWithBiometrics(this._repository);

  final AuthRepository _repository;

  Future<bool> call() => _repository.authenticateWithBiometrics();
}
