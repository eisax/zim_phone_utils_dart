String sanitizeNumberUtil(String? number) {
  if (number == null) return '';
  return number.replaceAll(RegExp(r'[ \-\(\)\.]'), '');
}

String extractCoreUtil(String number) {
  final sanitized = sanitizeNumberUtil(number);
  if (sanitized.startsWith('+263')) return sanitized.substring(4);
  if (sanitized.startsWith('263')) return sanitized.substring(3);
  if (sanitized.startsWith('0')) return sanitized.substring(1);
  return sanitized;
} 