import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../../core/errors/failure.dart';
import '../../../../core/utils/date_utils.dart';
import '../../domain/usecases/generate_insights.dart';
import 'insights_state.dart';

/// Generates insights for the current month.
class InsightsCubit extends Cubit<InsightsState> {
  InsightsCubit({required GenerateInsights generateInsights})
      : _generateInsights = generateInsights,
        super(const InsightsState.loading()) {
    load();
  }

  final GenerateInsights _generateInsights;

  Future<void> load() async {
    emit(const InsightsState.loading());
    try {
      final insights = await _generateInsights(
        month: monthKey(DateTime.now()),
      );
      emit(InsightsState.loaded(insights));
    } on Failure catch (failure) {
      emit(InsightsState.failure(failure));
    }
  }
}
