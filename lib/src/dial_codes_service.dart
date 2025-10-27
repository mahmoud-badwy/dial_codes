import 'dart:convert';
import 'package:flutter/services.dart';
import 'models/country.dart';

/// Service class for managing country dial codes and information
class DialCodesService {
  static DialCodesService? _instance;
  static DialCodesService get instance => _instance ??= DialCodesService._();

  DialCodesService._();

  List<Country>? _countries;

  /// Gets the list of all countries
  ///
  /// Returns a cached list if already loaded, otherwise loads from JSON
  Future<List<Country>> getCountries() async {
    if (_countries != null) {
      return _countries!;
    }

    final String jsonString = await rootBundle.loadString(
      'packages/dial_codes/assets/json/country_codes.json',
    );

    final List<dynamic> jsonList = json.decode(jsonString);
    _countries = jsonList.map((json) => Country.fromJson(json)).toList();

    return _countries!;
  }

  /// Finds a country by its ISO code
  ///
  /// Returns null if not found
  Future<Country?> getCountryByCode(String code) async {
    final countries = await getCountries();
    try {
      return countries.firstWhere(
        (country) => country.code.toLowerCase() == code.toLowerCase(),
      );
    } catch (e) {
      return null;
    }
  }

  /// Finds a country by its name
  ///
  /// Returns null if not found
  Future<Country?> getCountryByName(String name) async {
    final countries = await getCountries();
    try {
      return countries.firstWhere(
        (country) => country.name.toLowerCase() == name.toLowerCase(),
      );
    } catch (e) {
      return null;
    }
  }

  /// Finds a country by its dial code
  ///
  /// Returns null if not found
  Future<Country?> getCountryByDialCode(String dialCode) async {
    final countries = await getCountries();
    try {
      return countries.firstWhere((country) => country.dialCode == dialCode);
    } catch (e) {
      return null;
    }
  }

  /// Searches countries by name (partial match)
  Future<List<Country>> searchCountries(String query) async {
    if (query.isEmpty) {
      return await getCountries();
    }

    final countries = await getCountries();
    final lowerQuery = query.toLowerCase();

    return countries.where((country) {
      return country.name.toLowerCase().contains(lowerQuery) ||
          country.code.toLowerCase().contains(lowerQuery) ||
          country.dialCode.contains(query);
    }).toList();
  }

  /// Gets countries sorted by name
  Future<List<Country>> getCountriesSortedByName() async {
    final countries = await getCountries();
    final sorted = List<Country>.from(countries);
    sorted.sort((a, b) => a.name.compareTo(b.name));
    return sorted;
  }

  /// Gets countries sorted by dial code
  Future<List<Country>> getCountriesSortedByDialCode() async {
    final countries = await getCountries();
    final sorted = List<Country>.from(countries);
    sorted.sort((a, b) => a.dialCode.compareTo(b.dialCode));
    return sorted;
  }

  /// Clears the cached countries list
  void clearCache() {
    _countries = null;
  }

  /// Gets the total count of countries
  Future<int> getCountriesCount() async {
    final countries = await getCountries();
    return countries.length;
  }
}
