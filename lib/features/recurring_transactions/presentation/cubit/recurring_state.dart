import 'package:freezed_annotation/freezed_annotation.dart';

import '../../../../core/errors/failure.dart';
import '../../domain/entities/recurring_transaction.dart';

part 'recurring_state.freezed.dart';

@freezed
sealed class RecurringState with _$RecurringState {
  const factory RecurringState.loading() = RecurringLoading;

  const factory RecurringState.loaded(List<RecurringTransaction> items) =
      RecurringLoaded;

  const factory RecurringState.failure(Failure failure) = RecurringFailure;
}
