import '../entities/report_entities.dart';

/// Report contract (domain port). Read-only aggregations.
abstract interface class ReportRepository {
  Future<IncomeExpenseReport> getIncomeVsExpense({
    required DateTime start,
    required DateTime end,
  });

  Future<List<CashFlowPoint>> getCashFlow({
    required DateTime start,
    required DateTime end,
  });

  Future<List<CategoryReport>> getExpensesByCategory({
    required DateTime start,
    required DateTime end,
  });

  Future<List<AccountReport>> getExpensesByAccount({
    required DateTime start,
    required DateTime end,
  });
}
