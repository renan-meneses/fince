import 'package:freezed_annotation/freezed_annotation.dart';

import '../../../../core/domain/money.dart';

part 'financial_goal.freezed.dart';

/// Goal lifecycle state.
enum GoalStatus { active, completed, archived }

/// A financial goal (emergency fund, travel, car, etc.).
@freezed
abstract class FinancialGoal with _$FinancialGoal {
  const factory FinancialGoal({
    required String id,
    required String name,
    required Money targetAmount,
    required Money currentAmount,
    required String currency,
    DateTime? targetDate,
    String? description,
    required GoalStatus status,
    required DateTime createdAt,
  }) = _FinancialGoal;
}
