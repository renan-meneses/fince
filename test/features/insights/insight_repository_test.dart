import 'package:fince/core/domain/money.dart';
import 'package:fince/features/insights/data/repositories/rule_based_insight_repository.dart';
import 'package:fince/features/insights/domain/entities/financial_snapshot.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  final repository = RuleBasedInsightRepository();

  test('generates deterministic insights from a snapshot', () async {
    final snapshot = FinancialSnapshot(
      period: '2026-09',
      income: Money(100000, 'BRL'),
      expenses: Money(86000, 'BRL'),
      expensesByCategory: [
        CategorySpend(name: 'Alimentação', amount: Money(12000, 'BRL')),
        CategorySpend(name: 'Assinaturas', amount: Money(7740, 'BRL')),
      ],
      previousExpensesByCategory: [
        CategorySpend(name: 'Alimentação', amount: Money(10000, 'BRL')),
      ],
      budgets: [
        BudgetUsage(
          name: 'Alimentação',
          spent: Money(87000, 'BRL'),
          limit: Money(100000, 'BRL'),
        ),
      ],
    );

    final insights = await repository.generateInsights(snapshot);
    final types = insights.map((i) => i.type).toSet();

    expect(
      types,
      containsAll([
        'category_increase',
        'budget_usage',
        'subscription_share',
        'savings_rate',
      ]),
    );
  });

  test('generates no insights for a stable snapshot', () async {
    final snapshot = FinancialSnapshot(
      period: '2026-09',
      income: Money(100000, 'BRL'),
      expenses: Money(95000, 'BRL'),
      expensesByCategory: [
        CategorySpend(name: 'Alimentação', amount: Money(30000, 'BRL')),
      ],
      previousExpensesByCategory: [
        CategorySpend(name: 'Alimentação', amount: Money(30000, 'BRL')),
      ],
      budgets: [
        BudgetUsage(
          name: 'Alimentação',
          spent: Money(50000, 'BRL'),
          limit: Money(100000, 'BRL'),
        ),
      ],
    );

    final insights = await repository.generateInsights(snapshot);
    expect(insights, isEmpty);
  });
}
