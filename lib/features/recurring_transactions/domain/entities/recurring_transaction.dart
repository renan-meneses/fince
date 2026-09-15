import 'package:freezed_annotation/freezed_annotation.dart';

import '../../../../core/domain/money.dart';
import '../../../transactions/domain/entities/transaction.dart';

part 'recurring_transaction.freezed.dart';

/// Recurrence frequency.
enum RecurrenceFrequency { daily, weekly, monthly, yearly, custom }

/// How a recurring transaction repeats.
@freezed
abstract class RecurrenceRule with _$RecurrenceRule {
  const factory RecurrenceRule({
    required RecurrenceFrequency frequency,
    @Default(1) int interval,
    int? dayOfMonth,
    @Default([]) List<int> daysOfWeek,
  }) = _RecurrenceRule;
}

/// A template that generates future transactions on a schedule.
@freezed
abstract class RecurringTransaction with _$RecurringTransaction {
  const factory RecurringTransaction({
    required String id,
    required String description,
    required Money amount,
    required TransactionType type,
    required String accountId,
    String? categoryId,
    required RecurrenceRule rule,
    required DateTime startDate,
    DateTime? endDate,
    DateTime? lastGeneratedDate,
    required DateTime nextDueDate,
    required bool isActive,
  }) = _RecurringTransaction;
}
