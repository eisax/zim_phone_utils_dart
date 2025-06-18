import 'validation.dart';
import 'format.dart';
import 'carrier.dart';
import 'area.dart';

String getNumberTypeUtil(String number) {
  if (isValidMobileNumberUtil(number)) return 'mobile';
  if (isValidLandlineNumberUtil(number)) return 'landline';
  return 'invalid';
}

Map<String, dynamic> getPhoneInfoUtil(String number) {
  final isValid = validateNumberUtil(number);
  final type = getNumberTypeUtil(number);

  final info = {
    'isValid': isValid,
    'type': type,
    'local': null,
    'international': null,
    'carrier': null,
    'area': null,
  };

  if (isValid) {
    info['local'] = formatToLocalUtil(number);
    info['international'] = formatToInternationalUtil(number);

    if (type == 'mobile') {
      info['carrier'] = detectMobileCarrierUtil(number);
    } else if (type == 'landline') {
      info['area'] = detectLandlineAreaUtil(number);
    }
  }

  return info;
} 