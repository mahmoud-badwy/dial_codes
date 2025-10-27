import 'package:flutter_test/flutter_test.dart';
import 'package:dial_codes/dial_codes.dart';

void main() {
  group('Country Model', () {
    test('Country.fromJson creates valid Country instance', () {
      final json = {
        'name': 'Egypt',
        'code': 'EG',
        'emoji': '🇪🇬',
        'unicode': 'U+1F1EA U+1F1EC',
        'dial_code': '+20',
        'image': 'https://example.com/eg.svg',
      };

      final country = Country.fromJson(json);

      expect(country.name, 'Egypt');
      expect(country.code, 'EG');
      expect(country.emoji, '🇪🇬');
      expect(country.dialCode, '+20');
    });

    test('Country.toJson converts to valid JSON', () {
      final country = Country(
        name: 'Egypt',
        code: 'EG',
        emoji: '🇪🇬',
        unicode: 'U+1F1EA U+1F1EC',
        dialCode: '+20',
        image: 'https://example.com/eg.svg',
      );

      final json = country.toJson();

      expect(json['name'], 'Egypt');
      expect(json['code'], 'EG');
      expect(json['dial_code'], '+20');
    });

    test('Country equality works correctly', () {
      final country1 = Country(
        name: 'Egypt',
        code: 'EG',
        emoji: '🇪🇬',
        unicode: 'U+1F1EA U+1F1EC',
        dialCode: '+20',
        image: 'https://example.com/eg.svg',
      );

      final country2 = Country(
        name: 'Egypt',
        code: 'EG',
        emoji: '🇪🇬',
        unicode: 'U+1F1EA U+1F1EC',
        dialCode: '+20',
        image: 'https://example.com/eg.svg',
      );

      expect(country1, equals(country2));
    });

    test('Country.copyWith creates modified copy', () {
      final country = Country(
        name: 'Egypt',
        code: 'EG',
        emoji: '🇪🇬',
        unicode: 'U+1F1EA U+1F1EC',
        dialCode: '+20',
        image: 'https://example.com/eg.svg',
      );

      final modified = country.copyWith(name: 'Arab Republic of Egypt');

      expect(modified.name, 'Arab Republic of Egypt');
      expect(modified.code, 'EG');
      expect(modified.dialCode, '+20');
    });
  });

  group('Country Operations', () {
    test('Country can be compared for equality', () {
      final country1 = Country(
        name: 'Test',
        code: 'TS',
        emoji: '🏳️',
        unicode: 'U+1F3F3',
        dialCode: '+1',
        image: 'test.svg',
      );

      final country2 = Country(
        name: 'Test',
        code: 'TS',
        emoji: '🏳️',
        unicode: 'U+1F3F3',
        dialCode: '+1',
        image: 'test.svg',
      );

      final country3 = Country(
        name: 'Different',
        code: 'DF',
        emoji: '🏴',
        unicode: 'U+1F3F4',
        dialCode: '+2',
        image: 'diff.svg',
      );

      expect(country1 == country2, isTrue);
      expect(country1 == country3, isFalse);
    });

    test('Country hashCode works correctly', () {
      final country1 = Country(
        name: 'Test',
        code: 'TS',
        emoji: '🏳️',
        unicode: 'U+1F3F3',
        dialCode: '+1',
        image: 'test.svg',
      );

      final country2 = Country(
        name: 'Test',
        code: 'TS',
        emoji: '🏳️',
        unicode: 'U+1F3F3',
        dialCode: '+1',
        image: 'test.svg',
      );

      expect(country1.hashCode, equals(country2.hashCode));
    });
  });
}
