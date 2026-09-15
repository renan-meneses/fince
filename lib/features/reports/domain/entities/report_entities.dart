import 'package:freezed_annotation/freezed_annotation.dart';

import '../../../../core/domain/money.dart';

part 'report_entities.freezed.dart';

@freezed
abstract class IncomeExpenseReport with _$IncomeExpenseReport {
  const factory IncomeExpenseReport({
    required Money income,
    required Money expenses,
    required Money result,
  }) = _IncomeExpenseReport;
}

@freezed
abstract class CashFlowPoint with _$CashFlowPoint {
  const factory CashFlowPoint({
    required String period,
    required Money income,
    required Money expenses,
  }) = _CashFlowPoint;
}

@freezed
abstract class CategoryReport with _$CategoryReport {
  const factory CategoryReport({
    required String categoryId,
    required String name,
    required String color,
    required Money total,
    required double percent,
  }) = _CategoryReport;
}

@freezed
abstract class AccountReport with _$AccountReport {
  const factory AccountReport({
    required String accountId,
    required String name,
    required Money total,
  }) = _AccountReport;
}
