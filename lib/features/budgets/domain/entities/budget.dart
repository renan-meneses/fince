import 'package:freezed_annotation/freezed_annotation.dart';

import '../../../../core/domain/money.dart';

part 'budget.freezed.dart';

/// A monthly spending limit for a category.
@freezed
abstract class Budget with _$Budget {
  const factory Budget({
    required String id,
    required String categoryId,
    required Money amount,
    required String currency,
    required String month, // 'yyyy-MM'
    required DateTime createdAt,
  }) = _Budget;
}
