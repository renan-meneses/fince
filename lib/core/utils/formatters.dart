import 'package:intl/intl.dart';

import '../domain/money.dart';

/// Formats a date-only value, e.g. `15/09/2026`.
String formatDate(DateTime date, {String? locale}) =>
    DateFormat.yMd(locale ?? 'pt_BR').format(date);

/// Formats a month/year value, e.g. `setembro de 2026`.
String formatMonthYear(DateTime date, {String? locale}) =>
    DateFormat.yMMMM(locale ?? 'pt_BR').format(date);

/// Parses a user-entered amount into a [Money] value, throwing
/// [FormatException] on invalid input so callers can surface a validation
/// message without leaking parser details.
Money parseMoneyInput(String input, String currency) {
  final trimmed = input.trim();
  if (trimmed.isEmpty) {
    throw const FormatException('empty amount');
  }
  return Money.parse(trimmed, currency);
}
