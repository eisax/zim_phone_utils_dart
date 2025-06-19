import 'utils/sanitize.dart';
import 'utils/validation.dart';
import 'utils/format.dart';
import 'utils/carrier.dart';
import 'utils/area.dart';
import 'utils/info.dart';
import 'utils/data.dart';

/// Model containing business logic for Zimbabwean phone number validation, formatting, and detection.
class PhoneModel {
  /// Supported mobile carrier prefixes.
  final Map<String, List<String>> mobileCarriers = kMobileCarriers;
  /// Supported landline area codes.
  final Map<String, String> landlineAreaCodes = kLandlineAreaCodes;
  /// Zimbabwe country code (263).
  final String countryCode = kCountryCode;

  /// Sanitizes a phone number by removing spaces, dashes, parentheses, and dots.
  String sanitizeNumber(String number) => sanitizeNumberUtil(number);
  /// Extracts the core part of a phone number (removes country/area code prefixes).
  String extractCore(String number) => extractCoreUtil(number);

  /// Checks if the number is a valid mobile number.
  bool isValidMobileNumber(String number) => isValidMobileNumberUtil(number);
  /// Checks if the number is a valid landline number.
  bool isValidLandlineNumber(String number) => isValidLandlineNumberUtil(number);
  /// Validates if the number is a valid mobile or landline number.
  bool validateNumber(String number) => validateNumberUtil(number);

  /// Formats a valid number to local format (e.g., 0772123456).
  String formatToLocal(String number) => formatToLocalUtil(number);
  /// Formats a valid number to international format (e.g., +263772123456).
  String formatToInternational(String number) => formatToInternationalUtil(number);

  /// Detects the mobile carrier for a valid mobile number.
  String? detectMobileCarrier(String number) => detectMobileCarrierUtil(number);
  /// Detects the area/city for a valid landline number.
  String? detectLandlineArea(String number) => detectLandlineAreaUtil(number);

  /// Returns the type of phone number: 'mobile', 'landline', or 'invalid'.
  String getNumberType(String number) => getNumberTypeUtil(number);
  /// Returns comprehensive information about a phone number.
  Map<String, dynamic> getPhoneInfo(String number) => getPhoneInfoUtil(number);
} 