import '../entities/account.dart';
import '../repositories/account_repository.dart';

/// Observes the reactive list of accounts.
class WatchAccounts {
  const WatchAccounts(this._repository);

  final AccountRepository _repository;

  Stream<List<Account>> call() => _repository.watchAccounts();
}
