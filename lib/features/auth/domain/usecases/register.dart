import '../entities/user.dart';
import '../repositories/auth_repository.dart';

/// Creates a new account and persists the resulting session.
class Register {
  const Register(this._repository);

  final AuthRepository _repository;

  Future<User> call({
    required String name,
    required String email,
    required String password,
  }) =>
      _repository.register(name: name, email: email, password: password);
}
