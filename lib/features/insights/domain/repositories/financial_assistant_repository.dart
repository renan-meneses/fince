import '../entities/financial_insight.dart';
import '../entities/financial_snapshot.dart';

/// Financial assistant contract.
///
/// Implementations receive a structured [FinancialSnapshot] DTO (never
/// application internals) and return insights. The deterministic rule engine
/// implements this today; a future AI assistant implements the same contract.
abstract interface class FinancialAssistantRepository {
  Future<List<FinancialInsight>> generateInsights(FinancialSnapshot snapshot);
}
