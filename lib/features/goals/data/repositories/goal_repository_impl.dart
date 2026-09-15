import '../../../../core/domain/money.dart';
import '../../../../core/errors/exception_to_failure.dart';
import '../../domain/entities/financial_goal.dart';
import '../../domain/repositories/goal_repository.dart';
import '../datasources/goal_local_data_source.dart';

/// Local-first [GoalRepository].
class GoalRepositoryImpl implements GoalRepository {
  GoalRepositoryImpl({required GoalLocalDataSource local}) : _local = local;

  final GoalLocalDataSource _local;

  @override
  Stream<List<FinancialGoal>> watchGoals() => _local.watchAll();

  @override
  Future<FinancialGoal> createGoal(FinancialGoal goal) async {
    try {
      return await _local.insert(goal);
    } catch (e) {
      throw mapExceptionToFailure(e);
    }
  }

  @override
  Future<FinancialGoal> updateGoal(FinancialGoal goal) async {
    try {
      return await _local.update(goal);
    } catch (e) {
      throw mapExceptionToFailure(e);
    }
  }

  @override
  Future<void> deleteGoal(String id) async {
    try {
      await _local.delete(id);
    } catch (e) {
      throw mapExceptionToFailure(e);
    }
  }

  @override
  Future<FinancialGoal> deposit({required String id, required Money amount}) async {
    try {
      return await _local.deposit(id: id, amount: amount);
    } catch (e) {
      throw mapExceptionToFailure(e);
    }
  }
}
