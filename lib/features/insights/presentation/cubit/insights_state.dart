import 'package:freezed_annotation/freezed_annotation.dart';

import '../../../../core/errors/failure.dart';
import '../../domain/entities/financial_insight.dart';

part 'insights_state.freezed.dart';

@freezed
sealed class InsightsState with _$InsightsState {
  const factory InsightsState.loading() = InsightsLoading;

  const factory InsightsState.loaded(List<FinancialInsight> insights) =
      InsightsLoaded;

  const factory InsightsState.failure(Failure failure) = InsightsFailure;
}
