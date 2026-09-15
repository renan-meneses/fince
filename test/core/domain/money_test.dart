import 'package:fince/core/domain/money.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  group('Money construction', () {
    test('stores integer minor units', () {
      final money = Money(12345, 'BRL');
      expect(money.minorUnits, 12345);
      expect(money.currency, 'BRL');
      expect(money.decimalPlaces, 2);
    });

    test('normalizes currency code to uppercase', () {
      expect(Money(100, 'brl').currency, 'BRL');
    });

    test('rejects an invalid currency code', () {
      expect(() => Money(100, 'XYZ'), throwsA(isA<InvalidCurrencyException>()));
    });

    test('JPY uses zero decimal places', () {
      expect(Money(100, 'JPY').decimalPlaces, 0);
    });
  });

  group('Money arithmetic', () {
    test('adds two values of the same currency', () {
      expect(Money(100, 'BRL') + Money(250, 'BRL'), Money(350, 'BRL'));
    });

    test('subtracts two values of the same currency', () {
      expect(Money(250, 'BRL') - Money(100, 'BRL'), Money(150, 'BRL'));
    });

    test('throws on currency mismatch', () {
      expect(
        () => Money(100, 'BRL') + Money(100, 'USD'),
        throwsA(isA<CurrencyMismatchException>()),
      );
    });

    test('negation and absolute value', () {
      expect(-Money(100, 'BRL'), Money(-100, 'BRL'));
      expect(Money(-100, 'BRL').abs(), Money(100, 'BRL'));
    });
  });

  group('Money comparison', () {
    test('orders by minor units', () {
      expect(Money(100, 'BRL') < Money(200, 'BRL'), isTrue);
      expect(Money(200, 'BRL') > Money(100, 'BRL'), isTrue);
      expect(Money(100, 'BRL') >= Money(100, 'BRL'), isTrue);
    });

    test('throws on cross-currency comparison', () {
      expect(
        () => Money(100, 'BRL').compareTo(Money(100, 'USD')),
        throwsA(isA<CurrencyMismatchException>()),
      );
    });
  });

  group('Money.parse', () {
    test('parses comma decimal separator', () {
      expect(Money.parse('123,45', 'BRL').minorUnits, 12345);
    });

    test('parses dot decimal separator', () {
      expect(Money.parse('123.45', 'BRL').minorUnits, 12345);
    });

    test('parses thousands separators', () {
      expect(Money.parse('1.234,56', 'BRL').minorUnits, 123456);
      expect(Money.parse('1,234.56', 'BRL').minorUnits, 123456);
    });

    test('parses negative amounts', () {
      expect(Money.parse('-12,50', 'BRL').minorUnits, -1250);
    });

    test('rounds excess fractional digits by truncation', () {
      expect(Money.parse('1,999', 'BRL').minorUnits, 199);
    });
  });

  group('Money formatting', () {
    test('formats Brazilian currency with symbol', () {
      expect(Money(12345, 'BRL').format(locale: 'pt_BR'), contains('123,45'));
    });
  });
}
