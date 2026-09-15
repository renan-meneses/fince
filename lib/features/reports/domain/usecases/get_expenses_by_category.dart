import '../entities/report_entities.dart';
import '../repositories/report_repository.dart';

class GetExpensesByCategory {
  const GetExpensesByCategory(this._repository);

  final ReportRepository _repository;

  Future<List<CategoryReport>> call({required DateTime start, required DateTime end}) =>
      _repository.getExpensesByCategory(start: start, end: end);
}
