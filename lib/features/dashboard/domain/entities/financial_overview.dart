import 'package:freezed_annotation/freezed_annotation.dart';

import '../../../../core/domain/money.dart';
import '../../../transactions/domain/entities/transaction.dart';

part 'financial_overview.freezed.dart';

/// Aggregated category spending for charts.
@freezed
abstract class CategoryTotal with _$CategoryTotal {
  const factory CategoryTotal({
    required String categoryId,
    required String name,
    required String color,
    required String icon,
    required Money total,
    required double percent,
  }) = _CategoryTotal;
}

/// The financial summary shown on the dashboard for a given period.
@freezed
abstract class FinancialOverview with _$FinancialOverview {
  const factory FinancialOverview({
    required Money totalBalance,
    required Money income,
    required Money expenses,
    required Money result,
    required double? variationPercent,
    required List<Transaction> recentTransactions,
    required List<CategoryTotal> expensesByCategory,
  }) = _FinancialOverview;
}
