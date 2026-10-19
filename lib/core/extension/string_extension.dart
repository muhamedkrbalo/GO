
extension StringExtension on String {
  static const _mask = '•••';

  String maskPhone({int visibleDigits = 4}) {
    if (length <= visibleDigits) return this;
    return '$_mask $_mask ${substring(length - visibleDigits)}';
  }

  String maskEmail({int visibleChars = 2}) {
    final at = indexOf('@');
    if (at <= 0) return this;
    final visible = at < visibleChars ? at : visibleChars;
    return '${substring(0, visible)}$_mask${substring(at)}';
  }

  String replaceToArabicNumber() {
    return replaceAll('0', '٠')
        .replaceAll('1', '١')
        .replaceAll('2', '٢')
        .replaceAll('3', '٣')
        .replaceAll('4', '٤')
        .replaceAll('5', '٥')
        .replaceAll('6', '٦')
        .replaceAll('7', '٧')
        .replaceAll('8', '٨')
        .replaceAll('9', '٩');
  }

  String replaceToEnglishNumber() {
    return replaceAll('٠', '0')
        .replaceAll('١', '1')
        .replaceAll('٢', '2')
        .replaceAll('٣', '3')
        .replaceAll('٤', '4')
        .replaceAll('٥', '5')
        .replaceAll('٦', '6')
        .replaceAll('٧', '7')
        .replaceAll('٨', '8')
        .replaceAll('٩', '9');
  }

  String removeZero() {
    if (startsWith('0')) {
      return replaceFirst('0', '');
    } else {
      return this;
    }
  }
}
