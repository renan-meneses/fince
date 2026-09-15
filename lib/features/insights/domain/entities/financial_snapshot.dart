import 'package:freezed_annotation/freezed_annotation.dart';

import '../../../../core/domain/money.dart';

part 'financial_snapshot.freezed.dart';

/// Structured DTOs passed to a financial assistant. They contain ONLY the
/// financial data an assistant needs — no entities, repositories, or other
/// application internals — so an AI assistant can be integrated later without
/// touching the application.
@freezed
abstract class CategorySpend with _$CategorySpend {
  const factory CategorySpend({
    required String name,
    required Money amount,
  }) = _CategorySpend;
}

@freezed
abstract class BudgetUsage with _$BudgetUsage {
  const factory BudgetUsage({
    required String name,
    required Money spent,
    required Money limit,
  }) = _BudgetUsage;
}

@freezed
abstract class FinancialSnapshot with _$FinancialSnapshot {
  const factory FinancialSnapshot({
    required String period,
    required Money income,
    required Money expenses,
    required List<CategorySpend> expensesByCategory,
    required List<CategorySpend> previousExpensesByCategory,
    required List<BudgetUsage> budgets,
  }) = _FinancialSnapshot;
}
