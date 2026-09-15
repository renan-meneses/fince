import '../entities/budget.dart';
import '../entities/budget_status.dart';

/// Budget contract (domain port).
abstract interface class BudgetRepository {
  /// Reactive budget statuses for a month, with computed spending.
  Stream<List<BudgetStatus>> watchBudgets(String month);

  Future<Budget> createBudget(Budget budget);

  Future<Budget> updateBudget(Budget budget);

  Future<void> deleteBudget(String id);
}
