import 'dart:async';

import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../../core/domain/money.dart';
import '../../../../core/errors/failure.dart';
import '../../../../core/utils/date_utils.dart';
import '../../domain/entities/budget_status.dart';
import '../../domain/usecases/create_budget.dart';
import '../../domain/usecases/delete_budget.dart';
import '../../domain/usecases/watch_budgets.dart';
import 'budgets_state.dart';

/// Exposes reactive budget statuses for a selected month.
class BudgetsCubit extends Cubit<BudgetsState> {
  BudgetsCubit({
    required WatchBudgets watchBudgets,
    required CreateBudget createBudget,
    required DeleteBudget deleteBudget,
  })  : _watchBudgets = watchBudgets,
        _createBudget = createBudget,
        _deleteBudget = deleteBudget,
        super(const BudgetsState.loading()) {
    _relisten();
  }

  final WatchBudgets _watchBudgets;
  final CreateBudget _createBudget;
  final DeleteBudget _deleteBudget;

  String _month = monthKey(DateTime.now());
  StreamSubscription<List<BudgetStatus>>? _subscription;

  String get month => _month;

  void setMonth(String month) {
    _month = month;
    _relisten();
  }

  void _relisten() {
    emit(const BudgetsState.loading());
    _subscription?.cancel();
    _subscription = _watchBudgets(_month).listen(
      (budgets) {
        if (!isClosed) emit(BudgetsState.loaded(budgets));
      },
      onError: (Object error) {
        if (!isClosed) {
          emit(BudgetsState.failure(
            error is Failure
                ? error
                : UnknownFailure(message: error.toString()),
          ));
        }
      },
    );
  }

  Future<void> createBudget({
    required String categoryId,
    required Money amount,
    required String month,
  }) =>
      _createBudget(categoryId: categoryId, amount: amount, month: month);

  Future<void> deleteBudget(String id) => _deleteBudget(id);

  @override
  Future<void> close() {
    _subscription?.cancel();
    return super.close();
  }
}
