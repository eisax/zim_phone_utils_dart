import 'phone_model.dart';

class PhoneController {
  final PhoneModel model = PhoneModel();

  bool isValid(String number) => model.validateNumber(number);

  String formatLocal(String number) {
    if (!isValid(number)) throw Exception('Invalid phone number provided');
    return model.formatToLocal(number);
  }

  String formatInternational(String number) {
    if (!isValid(number)) throw Exception('Invalid phone number provided');
    return model.formatToInternational(number);
  }

  String? detectCarrier(String number) {
    if (!isValid(number)) return null;
    return model.detectMobileCarrier(number);
  }

  String? detectArea(String number) {
    if (!isValid(number)) return null;
    return model.detectLandlineArea(number);
  }

  String getNumberType(String number) => model.getNumberType(number);

  Map<String, dynamic> getPhoneInfo(String number) => model.getPhoneInfo(number);

  Map<String, List<String>> getCarrierPrefixes() => model.mobileCarriers;

  Map<String, String> getAreaCodes() => model.landlineAreaCodes;

  Map<String, String> formatBoth(String number) {
    if (!isValid(number)) throw Exception('Invalid phone number provided');
    return {
      'local': formatLocal(number),
      'international': formatInternational(number),
    };
  }

  bool isMobile(String number) => getNumberType(number) == 'mobile';

  bool isLandline(String number) => getNumberType(number) == 'landline';
} 