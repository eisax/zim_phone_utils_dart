import 'validation.dart';
import 'sanitize.dart';
import 'data.dart';

String? detectMobileCarrierUtil(String number) {
  if (!isValidMobileNumberUtil(number)) return null;
  final core = extractCoreUtil(number);
  final prefix = '0${core.substring(0, 2)}';
  if (kMobileCarriers['econet']!.contains(prefix)) return 'Econet';
  if (kMobileCarriers['netone']!.contains(prefix)) return 'NetOne';
  if (kMobileCarriers['telecel']!.contains(prefix)) return 'Telecel';
  return null;
} 