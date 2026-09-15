import '../entities/financial_goal.dart';
import '../repositories/goal_repository.dart';

class WatchGoals {
  const WatchGoals(this._repository);

  final GoalRepository _repository;

  Stream<List<FinancialGoal>> call() => _repository.watchGoals();
}
