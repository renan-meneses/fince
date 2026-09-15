import '../repositories/goal_repository.dart';

class DeleteGoal {
  const DeleteGoal(this._repository);

  final GoalRepository _repository;

  Future<void> call(String id) => _repository.deleteGoal(id);
}
