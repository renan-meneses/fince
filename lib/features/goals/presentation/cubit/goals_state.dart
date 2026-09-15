import 'package:freezed_annotation/freezed_annotation.dart';

import '../../../../core/errors/failure.dart';
import '../../domain/entities/financial_goal.dart';

part 'goals_state.freezed.dart';

@freezed
sealed class GoalsState with _$GoalsState {
  const factory GoalsState.loading() = GoalsLoading;

  const factory GoalsState.loaded(List<FinancialGoal> goals) = GoalsLoaded;

  const factory GoalsState.failure(Failure failure) = GoalsFailure;
}
