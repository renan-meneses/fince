import '../entities/user.dart';
import '../repositories/auth_repository.dart';

/// Restores the cached session user (used at app startup).
class GetCurrentUser {
  const GetCurrentUser(this._repository);

  final AuthRepository _repository;

  Future<User?> call() => _repository.currentUser();
}
