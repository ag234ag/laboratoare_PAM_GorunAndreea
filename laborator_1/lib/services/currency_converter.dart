import '../models/currency.dart';

class CurrencyConverter {
  static double parseAmount(String input) {
    final text = input.trim();
    if (text.isEmpty) {
      throw const FormatException('Introduceți suma de convertit.');
    }
    if (!RegExp(r'^-?(\d+([.,]\d*)?|[.,]\d+)$').hasMatch(text)) {
      throw const FormatException(
        'Folosiți doar cifre și un singur separator zecimal: virgulă sau punct.',
      );
    }
    final amount = double.tryParse(text.replaceAll(',', '.'));
    if (amount == null || !amount.isFinite) {
      throw const FormatException('Suma introdusă este prea mare.');
    }
    if (amount <= 0) {
      throw const FormatException('Introduceți o sumă mai mare decât zero.');
    }
    return amount;
  }

  static double convert(double amount, Currency source, Currency destination) {
    if (!amount.isFinite || amount <= 0) {
      throw const FormatException(
        'Introduceți o sumă validă mai mare decât zero.',
      );
    }
    final result = amount * source.rateInMdl / destination.rateInMdl;
    // Păstrăm afișarea cu exact două zecimale, fără notație exponențială.
    if (!result.isFinite || result >= 1e21) {
      throw const FormatException(
        'Suma este prea mare. Introduceți o sumă mai mică.',
      );
    }
    return result;
  }
}
