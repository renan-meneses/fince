import 'package:freezed_annotation/freezed_annotation.dart';

import '../../../../core/domain/money.dart';

part 'account.freezed.dart';

/// Financial account type.
enum AccountType { checking, savings, cash, digitalWallet, investment }

/// A financial account (checking, savings, cash, wallet, investment).
@freezed
abstract class Account with _$Account {
  const factory Account({
    required String id,
    required String name,
    required AccountType type,
    required Money currentBalance,
    required Money initialBalance,
    required String currency,
    String? institution,
    required String color,
    required String icon,
    required DateTime createdAt,
    required bool isActive,
  }) = _Account;
}
