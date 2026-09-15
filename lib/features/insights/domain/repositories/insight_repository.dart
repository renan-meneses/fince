import '../entities/financial_insight.dart';

/// Insight contract (domain port): builds a snapshot from app data and
/// delegates to a [FinancialAssistantRepository].
abstract interface class InsightRepository {
  Future<List<FinancialInsight>> generateInsights({required String month});
}
