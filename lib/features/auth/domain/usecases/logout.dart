import '../repositories/auth_repository.dart';

/// Clears the local session and notifies the backend.
class Logout {
  const Logout(this._repository);

  final AuthRepository _repository;

  Future<void> call() => _repository.logout();
}
