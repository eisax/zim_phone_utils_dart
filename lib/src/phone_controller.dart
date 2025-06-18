import 'phone_model.dart';

/// Controller for validating, formatting, and detecting Zimbabwean phone numbers.
class PhoneController {
  /// The underlying model containing business logic.
  final PhoneModel model = PhoneModel();

  /// Validates if a phone number is a valid Zimbabwean mobile or landline number.
  bool isValid(String number) => model.validateNumber(number);

  /// Formats a valid phone number to local Zimbabwean format (e.g., 0772123456).
  /// Throws an [Exception] if the number is invalid.
  String formatLocal(String number) {
    if (!isValid(number)) throw Exception('Invalid phone number provided');
    return model.formatToLocal(number);
  }

  /// Formats a valid phone number to international format (e.g., +263772123456).
  /// Throws an [Exception] if the number is invalid.
  String formatInternational(String number) {
    if (!isValid(number)) throw Exception('Invalid phone number provided');
    return model.formatToInternational(number);
  }

  /// Detects the mobile carrier for a valid mobile number (e.g., Econet, NetOne, Telecel).
  /// Returns null if the number is invalid or not a mobile number.
  String? detectCarrier(String number) {
    if (!isValid(number)) return null;
    return model.detectMobileCarrier(number);
  }

  /// Detects the area/city for a valid landline number (e.g., Harare, Bulawayo).
  /// Returns null if the number is invalid or not a landline number.
  String? detectArea(String number) {
    if (!isValid(number)) return null;
    return model.detectLandlineArea(number);
  }

  /// Returns the type of phone number: 'mobile', 'landline', or 'invalid'.
  String getNumberType(String number) => model.getNumberType(number);

  /// Returns comprehensive information about a phone number, including validity, type, formats, carrier, and area.
  Map<String, dynamic> getPhoneInfo(String number) => model.getPhoneInfo(number);

  /// Returns all supported mobile carrier prefixes.
  Map<String, List<String>> getCarrierPrefixes() => model.mobileCarriers;

  /// Returns all supported landline area codes.
  Map<String, String> getAreaCodes() => model.landlineAreaCodes;

  /// Returns both local and international formats for a valid phone number.
  /// Throws an [Exception] if the number is invalid.
  Map<String, String> formatBoth(String number) {
    if (!isValid(number)) throw Exception('Invalid phone number provided');
    return {
      'local': formatLocal(number),
      'international': formatInternational(number),
    };
  }

  /// Checks if the number is a valid mobile number.
  bool isMobile(String number) => getNumberType(number) == 'mobile';

  /// Checks if the number is a valid landline number.
  bool isLandline(String number) => getNumberType(number) == 'landline';
} 