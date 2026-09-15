import '../entities/user.dart';
import '../repositories/auth_repository.dart';

/// Authenticates a user with email/password and persists the session.
class Login {
  const Login(this._repository);

  final AuthRepository _repository;

  Future<User> call({required String email, required String password}) =>
      _repository.login(email: email, password: password);
}
