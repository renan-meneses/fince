import 'package:freezed_annotation/freezed_annotation.dart';

import 'transaction.dart';

part 'transaction_filter.freezed.dart';

/// Sort order for transaction queries.
enum TransactionSort { dateDesc, dateAsc, amountDesc, amountAsc }

/// Immutable, combinable filter for transaction queries.
@freezed
abstract class TransactionFilter with _$TransactionFilter {
  const TransactionFilter._();

  const factory TransactionFilter({
    String? accountId,
    String? categoryId,
    TransactionType? type,
    DateTime? startDate,
    DateTime? endDate,
    int? minAmountMinor,
    int? maxAmountMinor,
    PaymentStatus? status,
    String? query,
  }) = _TransactionFilter;

  bool get isEmpty =>
      accountId == null &&
      categoryId == null &&
      type == null &&
      startDate == null &&
      endDate == null &&
      minAmountMinor == null &&
      maxAmountMinor == null &&
      status == null &&
      (query?.trim().isEmpty ?? true);
}
