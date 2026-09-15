import 'dart:async';

import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../../core/domain/money.dart';
import '../../../../core/errors/failure.dart';
import '../../domain/entities/financial_goal.dart';
import '../../domain/usecases/create_goal.dart';
import '../../domain/usecases/delete_goal.dart';
import '../../domain/usecases/deposit_to_goal.dart';
import '../../domain/usecases/watch_goals.dart';
import 'goals_state.dart';

/// Exposes the reactive goal list and goal actions.
class GoalsCubit extends Cubit<GoalsState> {
  GoalsCubit({
    required WatchGoals watchGoals,
    required CreateGoal createGoal,
    required DeleteGoal deleteGoal,
    required DepositToGoal depositToGoal,
  })  : _createGoal = createGoal,
        _deleteGoal = deleteGoal,
        _depositToGoal = depositToGoal,
        super(const GoalsState.loading()) {
    _subscription = watchGoals().listen(_onData, onError: _onError);
  }

  final CreateGoal _createGoal;
  final DeleteGoal _deleteGoal;
  final DepositToGoal _depositToGoal;

  late final StreamSubscription<List<FinancialGoal>> _subscription;

  void _onData(List<FinancialGoal> goals) {
    if (!isClosed) emit(GoalsState.loaded(goals));
  }

  void _onError(Object error) {
    if (!isClosed) {
      emit(GoalsState.failure(
        error is Failure ? error : UnknownFailure(message: error.toString()),
      ));
    }
  }

  Future<void> createGoal({
    required String name,
    required Money targetAmount,
    DateTime? targetDate,
    String? description,
  }) =>
      _createGoal(
        name: name,
        targetAmount: targetAmount,
        targetDate: targetDate,
        description: description,
      );

  Future<void> deleteGoal(String id) => _deleteGoal(id);

  Future<void> deposit({required String id, required Money amount}) =>
      _depositToGoal(id: id, amount: amount);

  @override
  Future<void> close() {
    _subscription.cancel();
    return super.close();
  }
}
