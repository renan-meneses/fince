import '../entities/recurring_transaction.dart';
import '../repositories/recurring_transaction_repository.dart';

class WatchRecurringTransactions {
  const WatchRecurringTransactions(this._repository);

  final RecurringTransactionRepository _repository;

  Stream<List<RecurringTransaction>> call() => _repository.watchAll();
}
