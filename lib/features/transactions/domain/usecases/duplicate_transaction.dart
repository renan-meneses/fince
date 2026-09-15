import '../entities/transaction.dart';
import '../repositories/transaction_repository.dart';

/// Creates a copy of an existing transaction.
class DuplicateTransaction {
  const DuplicateTransaction(this._repository);

  final TransactionRepository _repository;

  Future<Transaction> call(String id) => _repository.duplicateTransaction(id);
}
