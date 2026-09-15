import '../entities/report_entities.dart';
import '../repositories/report_repository.dart';

class GetCashFlow {
  const GetCashFlow(this._repository);

  final ReportRepository _repository;

  Future<List<CashFlowPoint>> call({required DateTime start, required DateTime end}) =>
      _repository.getCashFlow(start: start, end: end);
}
