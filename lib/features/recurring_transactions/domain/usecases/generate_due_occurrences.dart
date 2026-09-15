import '../repositories/recurring_transaction_repository.dart';

class GenerateDueOccurrences {
  const GenerateDueOccurrences(this._repository);

  final RecurringTransactionRepository _repository;

  Future<int> call(DateTime now) => _repository.generateDueOccurrences(now);
}
