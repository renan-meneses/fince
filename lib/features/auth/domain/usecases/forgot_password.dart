import '../repositories/auth_repository.dart';

/// Requests a password-reset link for the given email.
class ForgotPassword {
  const ForgotPassword(this._repository);

  final AuthRepository _repository;

  Future<void> call(String email) => _repository.forgotPassword(email);
}
