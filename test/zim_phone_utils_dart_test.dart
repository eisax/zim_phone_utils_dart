import 'package:zim_phone_utils_dart/zim_phone_utils_dart.dart';
import 'package:test/test.dart';

void main() {
  final phone = PhoneController();

  group('Validation', () {
    test('Valid mobile numbers', () {
      expect(phone.isValid('0772123456'), isTrue);
      expect(phone.isValid('+263772123456'), isTrue);
      expect(phone.isValid('263772123456'), isTrue);
      expect(phone.isValid('0782123456'), isTrue);
      expect(phone.isValid('0712123456'), isTrue);
      expect(phone.isValid('0732123456'), isTrue);
    });
    test('Valid landline numbers', () {
      expect(phone.isValid('0242123456'), isTrue);
      expect(phone.isValid('+263242123456'), isTrue);
      expect(phone.isValid('263242123456'), isTrue);
      expect(phone.isValid('0292123456'), isTrue);
      expect(phone.isValid('0542123456'), isTrue);
    });
    test('Invalid numbers', () {
      expect(phone.isValid('12345'), isFalse);
      expect(phone.isValid('invalid'), isFalse);
      expect(phone.isValid('0800123456'), isFalse);
    });
  });

  group('Formatting', () {
    test('Format to local', () {
      expect(phone.formatLocal('+263772123456'), '0772123456');
      expect(phone.formatLocal('263772123456'), '0772123456');
      expect(phone.formatLocal('0772123456'), '0772123456');
    });
    test('Format to international', () {
      expect(phone.formatInternational('0772123456'), '+263772123456');
      expect(phone.formatInternational('263772123456'), '+263772123456');
      expect(phone.formatInternational('+263772123456'), '+263772123456');
    });
    test('Format both', () {
      final result = phone.formatBoth('0772123456');
      expect(result['local'], '0772123456');
      expect(result['international'], '+263772123456');
    });
  });

  group('Carrier and Area Detection', () {
    test('Detect carrier', () {
      expect(phone.detectCarrier('0772123456'), 'Econet');
      expect(phone.detectCarrier('0782123456'), 'Econet');
      expect(phone.detectCarrier('0712123456'), 'NetOne');
      expect(phone.detectCarrier('0732123456'), 'Telecel');
      expect(phone.detectCarrier('0242123456'), isNull);
    });
    test('Detect area', () {
      expect(phone.detectArea('0242123456'), 'Harare');
      expect(phone.detectArea('0292123456'), 'Bulawayo');
      expect(phone.detectArea('0542123456'), 'Gweru');
      expect(phone.detectArea('0772123456'), isNull);
    });
  });

  group('Type Detection', () {
    test('getNumberType', () {
      expect(phone.getNumberType('0772123456'), 'mobile');
      expect(phone.getNumberType('0242123456'), 'landline');
      expect(phone.getNumberType('invalid'), 'invalid');
    });
    test('isMobile', () {
      expect(phone.isMobile('0772123456'), isTrue);
      expect(phone.isMobile('0242123456'), isFalse);
    });
    test('isLandline', () {
      expect(phone.isLandline('0242123456'), isTrue);
      expect(phone.isLandline('0772123456'), isFalse);
    });
  });

  group('Comprehensive Info', () {
    test('getPhoneInfo for mobile', () {
      final info = phone.getPhoneInfo('0772123456');
      expect(info['isValid'], isTrue);
      expect(info['type'], 'mobile');
      expect(info['local'], '0772123456');
      expect(info['international'], '+263772123456');
      expect(info['carrier'], 'Econet');
      expect(info['area'], isNull);
    });
    test('getPhoneInfo for landline', () {
      final info = phone.getPhoneInfo('0242123456');
      expect(info['isValid'], isTrue);
      expect(info['type'], 'landline');
      expect(info['local'], '0242123456');
      expect(info['international'], '+263242123456');
      expect(info['carrier'], isNull);
      expect(info['area'], 'Harare');
    });
    test('getPhoneInfo for invalid', () {
      final info = phone.getPhoneInfo('invalid');
      expect(info['isValid'], isFalse);
      expect(info['type'], 'invalid');
      expect(info['local'], isNull);
      expect(info['international'], isNull);
      expect(info['carrier'], isNull);
      expect(info['area'], isNull);
    });
  });

  group('Utility Functions', () {
    test('getCarrierPrefixes', () {
      final prefixes = phone.getCarrierPrefixes();
      expect(prefixes['econet'], containsAll(['077', '078']));
      expect(prefixes['netone'], contains('071'));
      expect(prefixes['telecel'], contains('073'));
    });
    test('getAreaCodes', () {
      final areaCodes = phone.getAreaCodes();
      expect(areaCodes['harare'], '024');
      expect(areaCodes['bulawayo'], '029');
      expect(areaCodes['gweru'], '054');
      expect(areaCodes['mutare'], '020');
      expect(areaCodes['masvingo'], '039');
      expect(areaCodes['kwekwe'], '055');
      expect(areaCodes['chinhoyi'], '067');
      expect(areaCodes['marondera'], '065');
      expect(areaCodes['bindura'], '066');
    });
  });

  group('Input Sanitization', () {
    test('Handles spaces, dashes, parentheses, dots', () {
      expect(phone.isValid('077 212 3456'), isTrue);
      expect(phone.isValid('077-212-3456'), isTrue);
      expect(phone.isValid('(077) 212-3456'), isTrue);
      expect(phone.isValid('077.212.3456'), isTrue);
    });
  });
}
