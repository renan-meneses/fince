import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../../core/errors/failure.dart';
import '../../../../core/utils/date_utils.dart';
import '../../domain/usecases/get_cash_flow.dart';
import '../../domain/usecases/get_expenses_by_account.dart';
import '../../domain/usecases/get_expenses_by_category.dart';
import '../../domain/usecases/get_income_vs_expense.dart';
import 'reports_state.dart';

/// Loads all report aggregations for the default period.
class ReportsCubit extends Cubit<ReportsState> {
  ReportsCubit({
    required GetIncomeVsExpense incomeVsExpense,
    required GetCashFlow cashFlow,
    required GetExpensesByCategory byCategory,
    required GetExpensesByAccount byAccount,
  })  : _incomeVsExpense = incomeVsExpense,
        _cashFlow = cashFlow,
        _byCategory = byCategory,
        _byAccount = byAccount,
        super(const ReportsState.loading()) {
    load();
  }

  final GetIncomeVsExpense _incomeVsExpense;
  final GetCashFlow _cashFlow;
  final GetExpensesByCategory _byCategory;
  final GetExpensesByAccount _byAccount;

  Future<void> load() async {
    emit(const ReportsState.loading());
    try {
      final now = DateTime.now();
      final monthStart = now.startOfMonth;
      final monthEnd = now.startOfNextMonth;
      final cashFlowStart = DateTime(now.year, now.month - 5, 1);

      final summary = await _incomeVsExpense(start: monthStart, end: monthEnd);
      final cashFlow = await _cashFlow(start: cashFlowStart, end: monthEnd);
      final byCategory = await _byCategory(start: monthStart, end: monthEnd);
      final byAccount = await _byAccount(start: monthStart, end: monthEnd);

      emit(
        ReportsState.loaded(
          ReportsData(
            summary: summary,
            cashFlow: cashFlow,
            byCategory: byCategory,
            byAccount: byAccount,
          ),
        ),
      );
    } on Failure catch (failure) {
      emit(ReportsState.failure(failure));
    }
  }
}
