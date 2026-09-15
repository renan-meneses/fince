import 'package:freezed_annotation/freezed_annotation.dart';

import '../../../../core/domain/money.dart';

part 'transaction.freezed.dart';

/// Transaction kind. Transfers are neutral to income/expense reporting.
enum TransactionType { income, expense, transfer }

/// Payment state of a transaction.
enum PaymentStatus { pending, paid, overdue, cancelled }

/// A financial transaction. `amount` is always a positive magnitude; the sign
/// is implied by [type] (income credits, expense debits).
@freezed
abstract class Transaction with _$Transaction {
  const factory Transaction({
    required String id,
    required String description,
    required Money amount,
    required TransactionType type,
    required String accountId,
    String? transferAccountId,
    String? categoryId,
    String? subcategoryId,
    required DateTime date,
    required PaymentStatus paymentStatus,
    String? notes,
    @Default([]) List<String> tags,
    String? attachmentPath,
    String? transferGroupId,
    String? recurrenceId,
    String? installmentId,
    required DateTime createdAt,
    required DateTime updatedAt,
  }) = _Transaction;
}
