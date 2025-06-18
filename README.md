# zim_phone_utils_dart

A comprehensive Dart utility library for validating, formatting, and detecting carriers for Zimbabwean phone numbers (mobile and landline).

## Features

✅ **Mobile Number Support**
- Econet: 077, 078
- NetOne: 071  
- Telecel: 073

✅ **Landline Number Support**
- Harare: 024
- Bulawayo: 029
- Gweru: 054
- Mutare: 020
- Masvingo: 039
- Kwekwe: 055
- Chinhoyi: 067
- Marondera: 065
- Bindura: 066

✅ **Multiple Format Support**
- Local: 0772123456, 0242123456
- International: +263772123456, +263242123456
- Without +: 263772123456, 263242123456

✅ **MVC Architecture**
- Clean separation of concerns
- Easy to maintain and extend
- Well-documented code

## Installation

Add to your `pubspec.yaml`:

```yaml
dependencies:
  zim_phone_utils_dart:
    git:
      url: <your-repo-url>
      # Or use the published version when available
```

Then run:

```bash
dart pub get
```

## Quick Start

```dart
import 'package:zim_phone_utils_dart/zim_phone_utils_dart.dart';

final phone = PhoneController();

// Validate a phone number
phone.isValid('0772123456'); // true
phone.isValid('0242123456'); // true
phone.isValid('invalid');    // false

// Format numbers
phone.formatLocal('+263772123456');        // '0772123456'
phone.formatInternational('0772123456');   // '+263772123456'

// Detect carrier (mobile only)
phone.detectCarrier('0772123456'); // 'Econet'
phone.detectCarrier('0712123456'); // 'NetOne'
phone.detectCarrier('0732123456'); // 'Telecel'

// Detect area (landline only)
phone.detectArea('0242123456'); // 'Harare'
phone.detectArea('0292123456'); // 'Bulawayo'
```

## API Reference

### Core Functions

#### `isValid(String number)`
Validates if a phone number is a valid Zimbabwean number.

```dart
phone.isValid('0772123456');     // true
phone.isValid('+263772123456');  // true
phone.isValid('0242123456');     // true
phone.isValid('invalid');        // false
```

#### `formatLocal(String number)`
Formats a phone number to local Zimbabwean format.

```dart
phone.formatLocal('+263772123456');  // '0772123456'
phone.formatLocal('263772123456');   // '0772123456'
phone.formatLocal('0772123456');     // '0772123456'
```

#### `formatInternational(String number)`
Formats a phone number to international format.

```dart
phone.formatInternational('0772123456');    // '+263772123456'
phone.formatInternational('263772123456');  // '+263772123456'
phone.formatInternational('+263772123456'); // '+263772123456'
```

#### `formatBoth(String number)`
Returns both local and international formats.

```dart
final result = phone.formatBoth('0772123456');
// {
//   'local': '0772123456',
//   'international': '+263772123456'
// }
```

### Detection Functions

#### `detectCarrier(String number)`
Detects the mobile carrier for mobile numbers.

```dart
phone.detectCarrier('0772123456'); // 'Econet'
phone.detectCarrier('0782123456'); // 'Econet'
phone.detectCarrier('0712123456'); // 'NetOne'
phone.detectCarrier('0732123456'); // 'Telecel'
phone.detectCarrier('0242123456'); // null (landline)
```

#### `detectArea(String number)`
Detects the city/area for landline numbers.

```dart
phone.detectArea('0242123456'); // 'Harare'
phone.detectArea('0292123456'); // 'Bulawayo'
phone.detectArea('0542123456'); // 'Gweru'
phone.detectArea('0772123456'); // null (mobile)
```

### Type Detection

#### `getNumberType(String number)`
Returns the type of phone number.

```dart
phone.getNumberType('0772123456'); // 'mobile'
phone.getNumberType('0242123456'); // 'landline'
phone.getNumberType('invalid');    // 'invalid'
```

#### `isMobile(String number)`
Checks if a number is a mobile number.

```dart
phone.isMobile('0772123456'); // true
phone.isMobile('0242123456'); // false
```

#### `isLandline(String number)`
Checks if a number is a landline number.

```dart
phone.isLandline('0242123456'); // true
phone.isLandline('0772123456'); // false
```

### Comprehensive Information

#### `getPhoneInfo(String number)`
Returns comprehensive information about a phone number.

```dart
final info = phone.getPhoneInfo('0772123456');
// {
//   'isValid': true,
//   'type': 'mobile',
//   'local': '0772123456',
//   'international': '+263772123456',
//   'carrier': 'Econet',
//   'area': null
// }

final landlineInfo = phone.getPhoneInfo('0242123456');
// {
//   'isValid': true,
//   'type': 'landline',
//   'local': '0242123456',
//   'international': '+263242123456',
//   'carrier': null,
//   'area': 'Harare'
// }
```

### Utility Functions

#### `getCarrierPrefixes()`
Returns all supported mobile carrier prefixes.

```dart
final prefixes = phone.getCarrierPrefixes();
// {
//   'econet': ['077', '078'],
//   'netone': ['071'],
//   'telecel': ['073']
// }
```

#### `getAreaCodes()`
Returns all supported landline area codes.

```dart
final areaCodes = phone.getAreaCodes();
// {
//   'harare': '024',
//   'bulawayo': '029',
//   'gweru': '054',
//   'mutare': '020',
//   'masvingo': '039',
//   'kwekwe': '055',
//   'chinhoyi': '067',
//   'marondera': '065',
//   'bindura': '066'
// }
```

## Usage Examples

### Form Validation

```dart
import 'package:zim_phone_utils_dart/zim_phone_utils_dart.dart';

final phone = PhoneController();

Map<String, dynamic> validatePhoneForm(String phoneNumber) {
  if (!phone.isValid(phoneNumber)) {
    return { 'valid': false, 'error': 'Invalid phone number' };
  }
  final info = phone.getPhoneInfo(phoneNumber);
  return {
    'valid': true,
    'formatted': info['local'],
    'type': info['type'],
    'carrier': info['carrier'],
    'area': info['area'],
  };
}

// Usage
final result = validatePhoneForm('077 212 3456');
print(result);
// {
//   'valid': true,
//   'formatted': '0772123456',
//   'type': 'mobile',
//   'carrier': 'Econet',
//   'area': null
// }
```

### Database Normalization

```dart
final phone = PhoneController();

Map<String, dynamic> normalizePhoneForDatabase(String phoneNumber) {
  if (!phone.isValid(phoneNumber)) {
    throw Exception('Invalid phone number');
  }
  return {
    'local': phone.formatLocal(phoneNumber),
    'international': phone.formatInternational(phoneNumber),
    'carrier': phone.detectCarrier(phoneNumber),
    'area': phone.detectArea(phoneNumber),
    'type': phone.getNumberType(phoneNumber),
  };
}
```

### Contact List Processing

```dart
final phone = PhoneController();

List<Map<String, dynamic>> processContactList(List<Map<String, dynamic>> contacts) {
  return contacts.map((contact) {
    final phoneInfo = phone.getPhoneInfo(contact['phone']);
    return {
      ...contact,
      'phone': phoneInfo['local'],
      'phoneInternational': phoneInfo['international'],
      'carrier': phoneInfo['carrier'],
      'area': phoneInfo['area'],
      'isValid': phoneInfo['isValid'],
    };
  }).where((contact) => contact['isValid'] == true).toList();
}
```

## Supported Formats

### Mobile Numbers
- **Local**: `0772123456`, `0782123456`, `0712123456`, `0732123456`
- **International with +**: `+263772123456`, `+263782123456`, `+263712123456`, `+263732123456`
- **International without +**: `263772123456`, `263782123456`, `263712123456`, `263732123456`

### Landline Numbers
- **Local**: `0242123456`, `0292123456`, `0542123456`, etc.
- **International with +**: `+263242123456`, `+263292123456`, `+263542123456`, etc.
- **International without +**: `263242123456`, `263292123456`, `263542123456`, etc.

### Input Sanitization
The library automatically handles:
- Spaces: `077 212 3456`
- Dashes: `077-212-3456`
- Parentheses: `(077) 212-3456`
- Dots: `077.212.3456`

## Testing

Run the test suite:

```bash
dart test
```

## Architecture

This library follows the MVC (Model-View-Controller) pattern:

- **Model** (`lib/src/phone_model.dart`): Contains all business logic for phone number validation, formatting, and carrier detection
- **Controller** (`lib/src/phone_controller.dart`): Handles input sanitization and provides clean public methods
- **View**: Not applicable in this context, but logging and result formatting are separated

## Contributing

1. Fork the repository
2. Create a feature branch
3. Make your changes
4. Add tests for new functionality
5. Run the test suite
6. Submit a pull request

## License

MIT License - see LICENSE file for details.

## Support

For issues and questions, please open an issue on GitHub.

---

**Made with ❤️ for Zimbabwe @kudahndhlovu**
