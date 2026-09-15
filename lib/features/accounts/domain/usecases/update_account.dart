import '../entities/account.dart';
import '../repositories/account_repository.dart';

/// Persists changes to an existing account.
class UpdateAccount {
  const UpdateAccount(this._repository);

  final AccountRepository _repository;

  Future<Account> call(Account account) => _repository.updateAccount(account);
}
