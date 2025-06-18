import 'validation.dart';
import 'sanitize.dart';
import 'data.dart';

String? detectLandlineAreaUtil(String number) {
  if (!isValidLandlineNumberUtil(number)) return null;
  final core = extractCoreUtil(number);
  final areaCode = '0${core.substring(0, 2)}';
  for (final entry in kLandlineAreaCodes.entries) {
    if (entry.value == areaCode) {
      final city = entry.key;
      return city[0].toUpperCase() + city.substring(1);
    }
  }
  return null;
} 