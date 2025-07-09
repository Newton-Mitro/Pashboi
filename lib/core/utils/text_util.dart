class TextUtil {
  static String truncateText(String text, {int maxLength = 25}) {
    return text.length > maxLength
        ? '${text.substring(0, maxLength)}...'
        : text;
  }
}
