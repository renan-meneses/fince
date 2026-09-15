import 'package:freezed_annotation/freezed_annotation.dart';

import '../../../../core/domain/money.dart';
import '../../../../core/errors/failure.dart';

part 'installment.freezed.dart';

/// Installment lifecycle state.
enum InstallmentStatus { pending, paid, overdue }

/// A single installment of a card purchase.
@freezed
abstract class Installment with _$Installment {
  const factory Installment({
    required String id,
    required String transactionId,
    String? creditCardInvoiceId,
    required int number,
    required int totalInstallments,
    required Money amount,
    required String currency,
    required DateTime dueDate,
    required InstallmentStatus status,
    DateTime? paidAt,
  }) = _Installment;
}

/// Splits a monetary total into [count] equal parts using the largest-remainder
/// method so the parts always sum exactly to [total] (no floating-point drift).
///
/// Example: BRL 1,200 into 7 parts → six parts of 171 and one part of 174.
List<Money> splitIntoInstallments(Money total, int count) {
  if (count <= 0) {
    throw const ValidationFailure(message: 'Número de parcelas inválido.');
  }
  final base = total.minorUnits ~/ count;
  final remainder = total.minorUnits % count;
  return List.generate(
    count,
    (i) => Money(base + (i < remainder ? 1 : 0), total.currency),
  );
}
