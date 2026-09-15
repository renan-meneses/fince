import 'package:freezed_annotation/freezed_annotation.dart';

import '../../../../core/errors/failure.dart';
import '../../domain/entities/budget_status.dart';

part 'budgets_state.freezed.dart';

@freezed
sealed class BudgetsState with _$BudgetsState {
  const factory BudgetsState.loading() = BudgetsLoading;

  const factory BudgetsState.loaded(List<BudgetStatus> budgets) = BudgetsLoaded;

  const factory BudgetsState.failure(Failure failure) = BudgetsFailure;
}
