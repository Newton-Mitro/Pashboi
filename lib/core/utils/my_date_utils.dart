import 'package:intl/intl.dart';

class MyDateUtils {
  static String formatDate(DateTime? date) {
    if (date == null) return 'N/A';
    return DateFormat('dd MMM yyyy').format(date);
  }

  static String getMonthName(DateTime date) {
    return DateFormat('MMMM').format(date); // e.g., "June"
  }

  static String getShortMonthName(DateTime date) {
    return DateFormat('MMM').format(date); // e.g., "Jun"
  }
}
