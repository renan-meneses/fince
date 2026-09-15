import '../entities/financial_insight.dart';
import '../repositories/insight_repository.dart';

class GenerateInsights {
  const GenerateInsights(this._repository);

  final InsightRepository _repository;

  Future<List<FinancialInsight>> call({required String month}) =>
      _repository.generateInsights(month: month);
}
