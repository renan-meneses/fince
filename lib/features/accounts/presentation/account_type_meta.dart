import 'package:flutter/material.dart';

import '../domain/entities/account.dart';

export '../../../../core/utils/color_utils.dart';

/// Presentation metadata for account types (labels, icons, default colors).
String accountTypeLabel(AccountType type) => switch (type) {
      AccountType.checking => 'Conta corrente',
      AccountType.savings => 'Poupança',
      AccountType.cash => 'Dinheiro',
      AccountType.digitalWallet => 'Carteira digital',
      AccountType.investment => 'Investimentos',
    };

IconData accountTypeIcon(AccountType type) => switch (type) {
      AccountType.checking => Icons.account_balance_rounded,
      AccountType.savings => Icons.savings_rounded,
      AccountType.cash => Icons.payments_rounded,
      AccountType.digitalWallet => Icons.account_balance_wallet_rounded,
      AccountType.investment => Icons.trending_up_rounded,
    };

Color accountTypeColor(AccountType type) => switch (type) {
      AccountType.checking => const Color(0xFF0B6E4F),
      AccountType.savings => const Color(0xFF3B82F6),
      AccountType.cash => const Color(0xFFF2A03D),
      AccountType.digitalWallet => const Color(0xFF7C3AED),
      AccountType.investment => const Color(0xFF0E7490),
    };

const List<Color> accountColorOptions = [
  Color(0xFF0B6E4F),
  Color(0xFF3B82F6),
  Color(0xFFF2A03D),
  Color(0xFF7C3AED),
  Color(0xFF0E7490),
  Color(0xFFD64550),
];

const List<IconData> accountIconOptions = [
  Icons.account_balance_rounded,
  Icons.savings_rounded,
  Icons.payments_rounded,
  Icons.account_balance_wallet_rounded,
  Icons.trending_up_rounded,
  Icons.credit_card_rounded,
];

const Map<String, IconData> _accountIconMap = {
  'bank': Icons.account_balance_rounded,
  'savings': Icons.savings_rounded,
  'cash': Icons.payments_rounded,
  'wallet': Icons.account_balance_wallet_rounded,
  'investment': Icons.trending_up_rounded,
  'card': Icons.credit_card_rounded,
};

/// Resolves a stored icon name to an [IconData], defaulting safely.
IconData accountIconByName(String? name) =>
    _accountIconMap[name] ?? Icons.account_balance_wallet_rounded;

/// Returns a stable name for [icon] for persistence.
String accountIconName(IconData icon) => _accountIconMap.entries
    .firstWhere(
      (e) => e.value == icon,
      orElse: () => const MapEntry('wallet', Icons.account_balance_wallet_rounded),
    )
    .key;
