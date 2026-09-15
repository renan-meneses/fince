import '../../../../core/domain/money.dart';
import '../../../../core/errors/failure.dart';
import '../entities/financial_goal.dart';
import '../repositories/goal_repository.dart';

/// Adds money to a goal.
class DepositToGoal {
  const DepositToGoal(this._repository);

  final GoalRepository _repository;

  Future<FinancialGoal> call({required String id, required Money amount}) {
    if (!amount.isPositive) {
      throw const ValidationFailure(message: 'O valor deve ser maior que zero.');
    }
    return _repository.deposit(id: id, amount: amount);
  }
}
