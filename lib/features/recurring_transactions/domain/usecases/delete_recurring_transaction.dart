import '../repositories/recurring_transaction_repository.dart';

class DeleteRecurringTransaction {
  const DeleteRecurringTransaction(this._repository);

  final RecurringTransactionRepository _repository;

  Future<void> call(String id) => _repository.delete(id);
}
