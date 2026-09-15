import 'package:uuid/uuid.dart';

import '../../domain/entities/financial_insight.dart';
import '../../domain/entities/financial_snapshot.dart';
import '../../domain/repositories/financial_assistant_repository.dart';

/// Deterministic rule engine. A future AI assistant implements the same
/// [FinancialAssistantRepository] contract with the same DTO.
class RuleBasedInsightRepository implements FinancialAssistantRepository {
  RuleBasedInsightRepository({Uuid uuid = const Uuid()}) : _uuid = uuid;

  final Uuid _uuid;

  @override
  Future<List<FinancialInsight>> generateInsights(
    FinancialSnapshot snapshot,
  ) async {
    final insights = <FinancialInsight>[];
    final now = DateTime.now().toUtc();

    // 1. Category spend increased vs previous month.
    for (final current in snapshot.expensesByCategory) {
      final previous = _find(snapshot.previousExpensesByCategory, current.name);
      if (previous == null || !previous.amount.isPositive) continue;
      if (!current.amount.isPositive) continue;
      final change =
          (current.amount.minorUnits - previous.amount.minorUnits) /
              previous.amount.minorUnits;
      if (change >= 0.1) {
        insights.add(
          FinancialInsight(
            id: _uuid.v4(),
            type: 'category_increase',
            title: 'Aumento em ${current.name}',
            message: 'Seus gastos com ${current.name} aumentaram '
                '${(change * 100).toStringAsFixed(0)}% em relação ao mês '
                'anterior.',
            severity: InsightSeverity.warning,
            period: snapshot.period,
            createdAt: now,
            isRead: false,
          ),
        );
      }
    }

    // 2. Budget usage threshold warnings (70% / 90%).
    for (final budget in snapshot.budgets) {
      if (!budget.limit.isPositive) continue;
      final usage = budget.spent.minorUnits / budget.limit.minorUnits;
      if (usage >= 0.7) {
        insights.add(
          FinancialInsight(
            id: _uuid.v4(),
            type: 'budget_usage',
            title: 'Orçamento de ${budget.name}',
            message: 'Você já usou ${(usage * 100).toStringAsFixed(0)}% do '
                'orçamento de ${budget.name}.',
            severity: usage >= 0.9
                ? InsightSeverity.critical
                : InsightSeverity.warning,
            period: snapshot.period,
            createdAt: now,
            isRead: false,
          ),
        );
      }
    }

    // 3. Subscription share of monthly expenses.
    final subscriptions = _find(snapshot.expensesByCategory, 'Assinaturas');
    if (subscriptions != null && snapshot.expenses.isPositive) {
      final share = subscriptions.amount.minorUnits / snapshot.expenses.minorUnits;
      insights.add(
        FinancialInsight(
          id: _uuid.v4(),
          type: 'subscription_share',
          title: 'Assinaturas',
          message: 'Suas assinaturas representam '
              '${(share * 100).toStringAsFixed(0)}% das suas despesas do mês.',
          severity: InsightSeverity.info,
          period: snapshot.period,
          createdAt: now,
          isRead: false,
        ),
      );
    }

    // 4. Savings rate.
    if (snapshot.income.isPositive) {
      final rate = (snapshot.income.minorUnits - snapshot.expenses.minorUnits) /
          snapshot.income.minorUnits;
      if (rate >= 0.1) {
        insights.add(
          FinancialInsight(
            id: _uuid.v4(),
            type: 'savings_rate',
            title: 'Economia',
            message: 'Você economizou ${(rate * 100).toStringAsFixed(0)}% '
                'da sua renda neste mês.',
            severity: InsightSeverity.info,
            period: snapshot.period,
            createdAt: now,
            isRead: false,
          ),
        );
      }
    }

    return insights;
  }

  CategorySpend? _find(List<CategorySpend> list, String name) {
    for (final item in list) {
      if (item.name == name) return item;
    }
    return null;
  }
}
