import 'package:flutter_test/flutter_test.dart';
import 'package:dial_codes/dial_codes.dart';
import 'package:flutter/services.dart';

void main() {
  TestWidgetsFlutterBinding.ensureInitialized();

  setUpAll(() async {
    // Mock the asset loading
    TestDefaultBinaryMessengerBinding.instance.defaultBinaryMessenger
        .setMockMethodCallHandler(const MethodChannel('flutter/assets'), (
          MethodCall methodCall,
        ) async {
          if (methodCall.method == 'loadString') {
            // Return a minimal mock JSON for testing
            return '''[
            {
              "name": "Egypt",
              "code": "EG",
              "emoji": "🇪🇬",
              "unicode": "U+1F1EA U+1F1EC",
              "dial_code": "+20",
              "image": "https://cdn.jsdelivr.net/npm/country-flag-emoji-json@2.0.0/dist/images/EG.svg"
            },
            {
              "name": "United States",
              "code": "US",
              "emoji": "🇺🇸",
              "unicode": "U+1F1FA U+1F1F8",
              "dial_code": "+1",
              "image": "https://cdn.jsdelivr.net/npm/country-flag-emoji-json@2.0.0/dist/images/US.svg"
            },
            {
              "name": "Canada",
              "code": "CA",
              "emoji": "🇨🇦",
              "unicode": "U+1F1E8 U+1F1E6",
              "dial_code": "+1",
              "image": "https://cdn.jsdelivr.net/npm/country-flag-emoji-json@2.0.0/dist/images/CA.svg"
            }
          ]''';
          }
          return null;
        });
  });

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

  group('DialCodesService', () {
    setUp(() {
      DialCodesService.instance.clearCache();
    });

    test('getCountries returns list of countries', () async {
      final service = DialCodesService.instance;
      final countries = await service.getCountries();

      expect(countries, isNotEmpty);
      expect(countries.length, 3);
    });

    test('getCountryByCode returns correct country', () async {
      final service = DialCodesService.instance;
      final country = await service.getCountryByCode('EG');

      expect(country, isNotNull);
      expect(country?.name, 'Egypt');
      expect(country?.code, 'EG');
    });

    test('getCountryByCode is case insensitive', () async {
      final service = DialCodesService.instance;
      final country = await service.getCountryByCode('eg');

      expect(country, isNotNull);
      expect(country?.code, 'EG');
    });

    test('getCountryByCode returns null for invalid code', () async {
      final service = DialCodesService.instance;
      final country = await service.getCountryByCode('XX');

      expect(country, isNull);
    });

    test('getCountryByName returns correct country', () async {
      final service = DialCodesService.instance;
      final country = await service.getCountryByName('Egypt');

      expect(country, isNotNull);
      expect(country?.name, 'Egypt');
    });

    test('getCountryByDialCode returns correct country', () async {
      final service = DialCodesService.instance;
      final country = await service.getCountryByDialCode('+20');

      expect(country, isNotNull);
      expect(country?.name, 'Egypt');
    });

    test('searchCountries returns matching countries', () async {
      final service = DialCodesService.instance;
      final results = await service.searchCountries('unit');

      expect(results.length, 1);
      expect(results.first.name, 'United States');
    });

    test('searchCountries with empty query returns all countries', () async {
      final service = DialCodesService.instance;
      final results = await service.searchCountries('');

      expect(results.length, 3);
    });

    test('getCountriesSortedByName returns sorted list', () async {
      final service = DialCodesService.instance;
      final countries = await service.getCountriesSortedByName();

      expect(countries[0].name, 'Canada');
      expect(countries[1].name, 'Egypt');
      expect(countries[2].name, 'United States');
    });

    test('getCountriesCount returns correct count', () async {
      final service = DialCodesService.instance;
      final count = await service.getCountriesCount();

      expect(count, 3);
    });

    test('clearCache works correctly', () async {
      final service = DialCodesService.instance;

      // Load countries
      await service.getCountries();

      // Clear cache
      service.clearCache();

      // Should reload
      final countries = await service.getCountries();
      expect(countries, isNotEmpty);
    });
  });
}
