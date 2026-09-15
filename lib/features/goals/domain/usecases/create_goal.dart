import 'package:uuid/uuid.dart';

import '../../../../core/domain/money.dart';
import '../entities/financial_goal.dart';
import '../repositories/goal_repository.dart';

/// Creates a financial goal with a client UUID.
class CreateGoal {
  const CreateGoal(this._repository, {Uuid uuid = const Uuid()}) : _uuid = uuid;

  final GoalRepository _repository;
  final Uuid _uuid;

  Future<FinancialGoal> call({
    required String name,
    required Money targetAmount,
    DateTime? targetDate,
    String? description,
  }) {
    return _repository.createGoal(
      FinancialGoal(
        id: _uuid.v4(),
        name: name,
        targetAmount: targetAmount,
        currentAmount: Money(0, targetAmount.currency),
        currency: targetAmount.currency,
        targetDate: targetDate,
        description: description,
        status: GoalStatus.active,
        createdAt: DateTime.now().toUtc(),
      ),
    );
  }
}
