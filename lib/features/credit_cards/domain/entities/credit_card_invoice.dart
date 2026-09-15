import 'package:freezed_annotation/freezed_annotation.dart';

import '../../../../core/domain/money.dart';

part 'credit_card_invoice.freezed.dart';

/// Invoice lifecycle state.
enum InvoiceStatus { open, closed, paid, overdue }

/// A monthly credit-card invoice.
@freezed
abstract class CreditCardInvoice with _$CreditCardInvoice {
  const factory CreditCardInvoice({
    required String id,
    required String creditCardId,
    required DateTime periodStart,
    required DateTime periodEnd,
    required DateTime closingDate,
    required DateTime dueDate,
    required Money totalAmount,
    required Money paidAmount,
    required String currency,
    required InvoiceStatus status,
    DateTime? paidAt,
  }) = _CreditCardInvoice;
}
