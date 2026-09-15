import 'package:flutter/foundation.dart';
import 'package:intl/intl.dart';

/// Thrown when arithmetic is attempted across two different currencies.
class CurrencyMismatchException implements Exception {
  const CurrencyMismatchException(this.left, this.right);

  final String left;
  final String right;

  @override
  String toString() =>
      'Cannot operate on different currencies: $left and $right';
}

/// Thrown when a currency code is not a recognized ISO 4217 code.
class InvalidCurrencyException implements Exception {
  const InvalidCurrencyException(this.currency);

  final String currency;

  @override
  String toString() => 'Invalid currency code: $currency';
}

/// An immutable monetary value stored as **integer minor units**.
///
/// Example: BRL 123.45 is stored as `minorUnits = 12345`.
///
/// Floating-point arithmetic is never used for storage or computation; the
/// only place a `double` appears is at the display boundary in [format],
/// which is exact for 2-decimal currencies within the safe integer range
/// (up to ~9e15 minor units).
@immutable
class Money implements Comparable<Money> {
  const Money._(this.minorUnits, this.currency);

  /// Creates [Money] from integer minor units, validating [currency].
  factory Money(int minorUnits, String currency) {
    final normalized = currency.toUpperCase();
    if (!_isValidCurrency(normalized)) {
      throw InvalidCurrencyException(currency);
    }
    return Money._(minorUnits, normalized);
  }

  /// Parses a human-entered amount ("123,45", "1.234,56", "123.45") into minor
  /// units without any floating-point conversion.
  factory Money.parse(String input, String currency, {int? decimalPlaces}) {
    final places = decimalPlaces ?? _decimalPlacesFor(currency);
    var s = input.trim();
    final negative = s.startsWith('-');
    if (negative) s = s.substring(1);

    final lastComma = s.lastIndexOf(',');
    final lastDot = s.lastIndexOf('.');
    final int separator;
    if (lastComma >= 0 && lastDot >= 0) {
      separator = lastComma > lastDot ? lastComma : lastDot;
    } else if (lastComma >= 0) {
      separator = lastComma;
    } else {
      separator = lastDot;
    }

    final String intPart;
    final String fracPart;
    if (separator >= 0) {
      intPart = s.substring(0, separator).replaceAll(RegExp('[^0-9]'), '');
      fracPart = s.substring(separator + 1).replaceAll(RegExp('[^0-9]'), '');
    } else {
      intPart = s.replaceAll(RegExp('[^0-9]'), '');
      fracPart = '';
    }

    final major = intPart.isEmpty ? 0 : int.parse(intPart);
    final normalizedFrac = fracPart.isEmpty
        ? 0
        : int.parse(fracPart.padRight(places, '0').substring(0, places));
    var value = major * _pow10(places) + normalizedFrac;
    if (negative) value = -value;

    return Money(value, currency);
  }

  /// The integer minor units (cents for 2-decimal currencies).
  final int minorUnits;

  /// ISO 4217 uppercase code, e.g. `BRL`.
  final String currency;

  /// Number of fractional digits this currency uses (BRL → 2, JPY → 0).
  int get decimalPlaces => _decimalPlacesFor(currency);

  bool get isZero => minorUnits == 0;
  bool get isNegative => minorUnits < 0;
  bool get isPositive => minorUnits > 0;

  Money operator +(Money other) {
    _requireSameCurrency(other);
    return Money(minorUnits + other.minorUnits, currency);
  }

  Money operator -(Money other) {
    _requireSameCurrency(other);
    return Money(minorUnits - other.minorUnits, currency);
  }

  /// Unary negation.
  Money operator -() => Money(-minorUnits, currency);

  bool operator >(Money other) => _compare(other) > 0;
  bool operator <(Money other) => _compare(other) < 0;
  bool operator >=(Money other) => _compare(other) >= 0;
  bool operator <=(Money other) => _compare(other) <= 0;

  Money abs() => Money(minorUnits.abs(), currency);

  @override
  int compareTo(Money other) => _compare(other);

  int _compare(Money other) {
    _requireSameCurrency(other);
    return minorUnits.compareTo(other.minorUnits);
  }

  void _requireSameCurrency(Money other) {
    if (other.currency != currency) {
      throw CurrencyMismatchException(currency, other.currency);
    }
  }

  /// Locale-aware currency formatting via `intl`.
  String format({String? locale}) {
    final divisor = _pow10(decimalPlaces);
    final formatter = NumberFormat.currency(
      locale: locale ?? 'pt_BR',
      symbol: _symbolFor(currency),
      decimalDigits: decimalPlaces,
    );
    // Display-only; exact for minor units within the safe integer range.
    return formatter.format(minorUnits / divisor);
  }

  @override
  bool operator ==(Object other) =>
      other is Money &&
      other.minorUnits == minorUnits &&
      other.currency == currency;

  @override
  int get hashCode => Object.hash(minorUnits, currency);

  @override
  String toString() => 'Money($currency $minorUnits)';

  static int _pow10(int n) {
    var result = 1;
    for (var i = 0; i < n; i++) {
      result *= 10;
    }
    return result;
  }

  static int _decimalPlacesFor(String currency) =>
      switch (currency) {
        'JPY' || 'KRW' || 'VND' => 0,
        'BHD' || 'KWD' || 'OMR' || 'JOD' || 'TND' || 'LYD' || 'IQD' => 3,
        _ => 2,
      };

  static bool _isValidCurrency(String code) =>
      RegExp(r'^[A-Z]{3}$').hasMatch(code) && _knownCodes.contains(code);

  static String _symbolFor(String currency) =>
      switch (currency) {
        'BRL' => r'R$',
        'USD' => r'US$',
        'EUR' => '€',
        'GBP' => '£',
        'JPY' => '¥',
        'CNY' => 'CN¥',
        'ARS' => r'AR$',
        'MXN' => r'MX$',
        'CLP' => r'CL$',
        'COP' => r'CO$',
        _ => currency,
      };

  /// A curated allow-list of ISO 4217 codes. Extend as needed; a full ISO
  /// registry can be swapped in here without touching call sites.
  static const Set<String> _knownCodes = {
    'BRL', 'USD', 'EUR', 'GBP', 'JPY', 'CNY', 'CAD', 'AUD', 'CHF', 'SEK',
    'NOK', 'DKK', 'NZD', 'SGD', 'HKD', 'KRW', 'INR', 'RUB', 'ZAR', 'MXN',
    'ARS', 'CLP', 'COP', 'PEN', 'UYU', 'PYG', 'BOB', 'VEF', 'PLN', 'TRY',
    'THB', 'MYR', 'IDR', 'PHP', 'VND', 'CZK', 'HUF', 'ILS', 'AED', 'SAR',
    'BHD', 'KWD', 'OMR', 'JOD', 'TND', 'LYD', 'IQD', 'EGP', 'NGN', 'KES',
  };
}
