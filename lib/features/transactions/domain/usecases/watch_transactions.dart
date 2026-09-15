import '../entities/transaction.dart';
import '../entities/transaction_filter.dart';
import '../repositories/transaction_repository.dart';

/// Observes transactions matching [filter].
class WatchTransactions {
  const WatchTransactions(this._repository);

  final TransactionRepository _repository;

  Stream<List<Transaction>> call({
    TransactionFilter filter = const TransactionFilter(),
    TransactionSort sort = TransactionSort.dateDesc,
  }) =>
      _repository.watchTransactions(filter: filter, sort: sort);
}
