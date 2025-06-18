import 'sanitize.dart';
import 'data.dart';

bool isValidMobileNumberUtil(String number) {
  final core = extractCoreUtil(number);
  if (core.length != 9 || !core.startsWith('7')) return false;
  final prefix = '0${core.substring(0, 2)}';
  final allPrefixes = [
    ...kMobileCarriers['econet']!,
    ...kMobileCarriers['netone']!,
    ...kMobileCarriers['telecel']!,
  ];
  return allPrefixes.contains(prefix);
}

bool isValidLandlineNumberUtil(String number) {
  final core = extractCoreUtil(number);
  if (core.length != 9) return false;
  final areaCode = '0${core.substring(0, 2)}';
  final allAreaCodes = kLandlineAreaCodes.values;
  return allAreaCodes.contains(areaCode);
}

bool validateNumberUtil(String? number) {
  if (number == null) return false;
  return isValidMobileNumberUtil(number) || isValidLandlineNumberUtil(number);
} 