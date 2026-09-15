import '../../../../core/domain/money.dart';
import '../entities/financial_goal.dart';

/// Financial goal contract (domain port).
abstract interface class GoalRepository {
  Stream<List<FinancialGoal>> watchGoals();

  Future<FinancialGoal> createGoal(FinancialGoal goal);

  Future<FinancialGoal> updateGoal(FinancialGoal goal);

  Future<void> deleteGoal(String id);

  /// Adds [amount] to a goal's current amount (and completes it if reached).
  Future<FinancialGoal> deposit({required String id, required Money amount});
}
