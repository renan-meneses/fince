import 'package:freezed_annotation/freezed_annotation.dart';

import '../../../../core/errors/failure.dart';
import '../../domain/entities/report_entities.dart';

part 'reports_state.freezed.dart';

@freezed
abstract class ReportsData with _$ReportsData {
  const factory ReportsData({
    required IncomeExpenseReport summary,
    required List<CashFlowPoint> cashFlow,
    required List<CategoryReport> byCategory,
    required List<AccountReport> byAccount,
  }) = _ReportsData;
}

@freezed
sealed class ReportsState with _$ReportsState {
  const factory ReportsState.loading() = ReportsLoading;

  const factory ReportsState.loaded(ReportsData data) = ReportsLoaded;

  const factory ReportsState.failure(Failure failure) = ReportsFailure;
}
