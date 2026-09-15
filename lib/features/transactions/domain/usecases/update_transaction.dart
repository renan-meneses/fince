import '../entities/transaction.dart';
import '../repositories/transaction_repository.dart';

/// Persists changes to an existing transaction (recomputing balance effects).
class UpdateTransaction {
  const UpdateTransaction(this._repository);

  final TransactionRepository _repository;

  Future<Transaction> call(Transaction transaction) =>
      _repository.updateTransaction(transaction);
}
