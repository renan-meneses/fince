import 'package:freezed_annotation/freezed_annotation.dart';

import '../../../../core/domain/money.dart';
import 'budget.dart';

part 'budget_status.freezed.dart';

/// A budget plus its derived spending metrics.
@freezed
abstract class BudgetStatus with _$BudgetStatus {
  const factory BudgetStatus({
    required Budget budget,
    required String categoryName,
    required String categoryColor,
    required String categoryIcon,
    required Money spent,
    required Money remaining,
    required double percentUsed,
  }) = _BudgetStatus;
}
