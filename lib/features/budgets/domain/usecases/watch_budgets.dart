import '../entities/budget_status.dart';
import '../repositories/budget_repository.dart';

class WatchBudgets {
  const WatchBudgets(this._repository);

  final BudgetRepository _repository;

  Stream<List<BudgetStatus>> call(String month) => _repository.watchBudgets(month);
}
