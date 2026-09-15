import '../repositories/transaction_repository.dart';

/// Deletes a transaction and reverses its balance effect.
class DeleteTransaction {
  const DeleteTransaction(this._repository);

  final TransactionRepository _repository;

  Future<void> call(String id) => _repository.deleteTransaction(id);
}
