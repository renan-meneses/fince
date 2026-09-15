import 'package:uuid/uuid.dart';

import '../../../../core/domain/money.dart';
import '../entities/budget.dart';
import '../repositories/budget_repository.dart';

/// Creates a budget with a client UUID.
class CreateBudget {
  const CreateBudget(this._repository, {Uuid uuid = const Uuid()}) : _uuid = uuid;

  final BudgetRepository _repository;
  final Uuid _uuid;

  Future<Budget> call({
    required String categoryId,
    required Money amount,
    required String month,
  }) {
    return _repository.createBudget(
      Budget(
        id: _uuid.v4(),
        categoryId: categoryId,
        amount: amount,
        currency: amount.currency,
        month: month,
        createdAt: DateTime.now().toUtc(),
      ),
    );
  }
}
