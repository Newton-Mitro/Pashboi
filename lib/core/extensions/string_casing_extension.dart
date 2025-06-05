extension StringCasingExtension on String {
  String toTitleCase() {
    if (trim().isEmpty) return '';
    return toLowerCase()
        .split(' ')
        .map((word) {
          if (word.isEmpty) return '';
          return word[0].toUpperCase() + word.substring(1);
        })
        .join(' ');
  }
}
