import '../repositories/account_repository.dart';

/// Soft-deletes (archives) an account.
class ArchiveAccount {
  const ArchiveAccount(this._repository);

  final AccountRepository _repository;

  Future<void> call(String id) => _repository.archiveAccount(id);
}
