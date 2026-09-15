import 'package:freezed_annotation/freezed_annotation.dart';

import '../../../../core/domain/money.dart';

part 'credit_card.freezed.dart';

/// Credit card brand.
enum CardBrand { visa, mastercard, amex, elo, hipercard, other }

/// A registered credit card.
@freezed
abstract class CreditCard with _$CreditCard {
  const factory CreditCard({
    required String id,
    required String name,
    required CardBrand brand,
    required Money creditLimit,
    required Money availableLimit,
    required String currency,
    required int closingDay,
    required int dueDay,
    String? linkedAccountId,
    required DateTime createdAt,
    required bool isActive,
  }) = _CreditCard;
}
