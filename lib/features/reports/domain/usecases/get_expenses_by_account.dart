import '../entities/report_entities.dart';
import '../repositories/report_repository.dart';

class GetExpensesByAccount {
  const GetExpensesByAccount(this._repository);

  final ReportRepository _repository;

  Future<List<AccountReport>> call({required DateTime start, required DateTime end}) =>
      _repository.getExpensesByAccount(start: start, end: end);
}
