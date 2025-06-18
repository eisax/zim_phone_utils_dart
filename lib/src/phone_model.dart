import 'utils/sanitize.dart';
import 'utils/validation.dart';
import 'utils/format.dart';
import 'utils/carrier.dart';
import 'utils/area.dart';
import 'utils/info.dart';
import 'utils/data.dart';

class PhoneModel {
  final Map<String, List<String>> mobileCarriers = kMobileCarriers;
  final Map<String, String> landlineAreaCodes = kLandlineAreaCodes;
  final String countryCode = kCountryCode;

  String sanitizeNumber(String number) => sanitizeNumberUtil(number);
  String extractCore(String number) => extractCoreUtil(number);

  bool isValidMobileNumber(String number) => isValidMobileNumberUtil(number);
  bool isValidLandlineNumber(String number) => isValidLandlineNumberUtil(number);
  bool validateNumber(String number) => validateNumberUtil(number);

  String formatToLocal(String number) => formatToLocalUtil(number);
  String formatToInternational(String number) => formatToInternationalUtil(number);

  String? detectMobileCarrier(String number) => detectMobileCarrierUtil(number);
  String? detectLandlineArea(String number) => detectLandlineAreaUtil(number);

  String getNumberType(String number) => getNumberTypeUtil(number);
  Map<String, dynamic> getPhoneInfo(String number) => getPhoneInfoUtil(number);
} 