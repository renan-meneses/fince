import 'package:freezed_annotation/freezed_annotation.dart';

import '../../../../core/errors/failure.dart';
import '../../domain/entities/financial_overview.dart';

part 'dashboard_state.freezed.dart';

@freezed
sealed class DashboardState with _$DashboardState {
  const factory DashboardState.loading() = DashboardLoading;

  const factory DashboardState.loaded(FinancialOverview overview) =
      DashboardLoaded;

  const factory DashboardState.failure(Failure failure) = DashboardFailure;
}
