import 'package:intl/intl.dart';

class TakaFormatter {
  static final _currencyFormat = NumberFormat.currency(
    locale: 'en_BD',
    symbol: '৳',
    decimalDigits: 0,
    customPattern: '#,###.## ৳', // Places symbol after amount
  );

  /// Formats amount to Taka format: 12,345.67৳
  static String format(num amount) {
    return _currencyFormat.format(amount);
  }

  /// Parses a Taka string back to a number (e.g., "12,345.67৳" → 12345.67)
  static num? parse(String takaString) {
    try {
      final cleaned = takaString.replaceAll('৳', '').replaceAll(',', '').trim();
      return num.parse(cleaned);
    } catch (e) {
      return null;
    }
  }
}
