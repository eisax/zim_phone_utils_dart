import 'sanitize.dart';
import 'validation.dart';
import 'data.dart';

String formatToLocalUtil(String number) {
  if (!validateNumberUtil(number)) throw Exception('Invalid phone number');
  return '0${extractCoreUtil(number)}';
}

String formatToInternationalUtil(String number) {
  if (!validateNumberUtil(number)) throw Exception('Invalid phone number');
  return '+$kCountryCode${extractCoreUtil(number)}';
} 