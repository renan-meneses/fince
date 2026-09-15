import '../entities/report_entities.dart';
import '../repositories/report_repository.dart';

class GetIncomeVsExpense {
  const GetIncomeVsExpense(this._repository);

  final ReportRepository _repository;

  Future<IncomeExpenseReport> call({required DateTime start, required DateTime end}) =>
      _repository.getIncomeVsExpense(start: start, end: end);
}
