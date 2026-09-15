import 'dart:async';

import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../../core/errors/failure.dart';
import '../../../../core/utils/date_utils.dart';
import '../../domain/entities/financial_overview.dart';
import '../../domain/usecases/watch_overview.dart';
import 'dashboard_state.dart';

/// Quick-select periods for the dashboard.
enum DashboardPeriod { currentMonth, previousMonth, custom }

/// Exposes the reactive financial overview for the selected period.
class DashboardCubit extends Cubit<DashboardState> {
  DashboardCubit({required WatchOverview watchOverview})
      : _watchOverview = watchOverview,
        super(const DashboardState.loading()) {
    _relisten();
  }

  final WatchOverview _watchOverview;

  DateTime _start = DateTime.now().startOfMonth;
  DateTime _end = DateTime.now().startOfNextMonth;
  StreamSubscription<FinancialOverview>? _subscription;

  void setPeriod(DateTime start, DateTime end) {
    _start = start;
    _end = end;
    _relisten();
  }

  void _relisten() {
    emit(const DashboardState.loading());
    _subscription?.cancel();
    _subscription = _watchOverview(start: _start, end: _end).listen(
      (overview) {
        if (!isClosed) emit(DashboardState.loaded(overview));
      },
      onError: (Object error) {
        if (!isClosed) {
          emit(DashboardState.failure(
            error is Failure
                ? error
                : UnknownFailure(message: error.toString()),
          ));
        }
      },
    );
  }

  @override
  Future<void> close() {
    _subscription?.cancel();
    return super.close();
  }
}
