import 'dart:async';

import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../../core/errors/failure.dart';
import '../../domain/entities/recurring_transaction.dart';
import '../../domain/usecases/delete_recurring_transaction.dart';
import '../../domain/usecases/generate_due_occurrences.dart';
import '../../domain/usecases/watch_recurring_transactions.dart';
import 'recurring_state.dart';

/// Exposes the reactive recurring-transaction list and generation action.
class RecurringCubit extends Cubit<RecurringState> {
  RecurringCubit({
    required WatchRecurringTransactions watch,
    required DeleteRecurringTransaction delete,
    required GenerateDueOccurrences generate,
  })  : _delete = delete,
        _generate = generate,
        super(const RecurringState.loading()) {
    _subscription = watch().listen(_onData, onError: _onError);
  }

  final DeleteRecurringTransaction _delete;
  final GenerateDueOccurrences _generate;

  late final StreamSubscription<List<RecurringTransaction>> _subscription;

  void _onData(List<RecurringTransaction> items) {
    if (!isClosed) emit(RecurringState.loaded(items));
  }

  void _onError(Object error) {
    if (!isClosed) {
      emit(RecurringState.failure(
        error is Failure ? error : UnknownFailure(message: error.toString()),
      ));
    }
  }

  Future<void> delete(String id) => _delete(id);

  Future<int> generateNow() => _generate(DateTime.now());

  @override
  Future<void> close() {
    _subscription.cancel();
    return super.close();
  }
}
