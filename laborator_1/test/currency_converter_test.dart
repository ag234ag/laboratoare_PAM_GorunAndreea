import 'package:flutter_test/flutter_test.dart';
import 'package:laborator_1/models/currency.dart';
import 'package:laborator_1/services/currency_converter.dart';

void main() {
  test('Conversii între monede diferite folosind MDL', () {
    expect(CurrencyConverter.convert(100, Currency.eur, Currency.mdl), 1950);
    expect(
      CurrencyConverter.convert(100, Currency.mdl, Currency.usd),
      closeTo(5.6179775, 0.000001),
    );
    expect(
      CurrencyConverter.convert(10, Currency.gbp, Currency.ron),
      closeTo(58.2051282, 0.000001),
    );
    expect(CurrencyConverter.convert(10, Currency.eur, Currency.ron), 50);
  });

  test('Aceeași monedă păstrează suma', () {
    for (final currency in Currency.values) {
      expect(
        CurrencyConverter.convert(123.45, currency, currency),
        closeTo(123.45, 1e-10),
      );
    }
  });

  test('Valori zecimale și ambii separatori', () {
    for (final input in ['12,50', '12.50', ' 12,50 ']) {
      expect(CurrencyConverter.parseAmount(input), 12.5);
      expect(
        CurrencyConverter.convert(
          CurrencyConverter.parseAmount(input),
          Currency.eur,
          Currency.ron,
        ),
        62.5,
      );
    }
    expect(CurrencyConverter.parseAmount(',5'), 0.5);
  });

  test('Respinge valori goale, nepozitive și caractere nevalide', () {
    for (final input in [
      '',
      ' ',
      '0',
      '0,00',
      '-1',
      'abc',
      '12x',
      '1.2.3',
      '1,2.3',
      'NaN',
      'Infinity',
      '1e3',
      '1 000',
    ]) {
      expect(
        () => CurrencyConverter.parseAmount(input),
        throwsFormatException,
        reason: input,
      );
    }
    for (final amount in [0.0, -1.0, double.nan, double.infinity, 1e308]) {
      expect(
        () => CurrencyConverter.convert(amount, Currency.eur, Currency.mdl),
        throwsFormatException,
      );
    }
  });
}
