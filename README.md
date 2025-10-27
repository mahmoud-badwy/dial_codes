<!--
This README describes the package. If you publish this package to pub.dev,
this README's contents appear on the landing page for your package.

For information about how to write a good package README, see the guide for
[writing package pages](https://dart.dev/tools/pub/writing-package-pages).

For general information about developing packages, see the Dart guide for
[creating packages](https://dart.dev/guides/libraries/create-packages)
and the Flutter guide for
[developing packages and plugins](https://flutter.dev/to/develop-packages).
-->

# Dial Codes

A comprehensive Flutter package that provides easy access to country information including dial codes, country codes, flags, and more. Perfect for building international phone number inputs, country selectors, and other country-related features.

## Features

- 📞 Complete list of international dial codes
- 🌍 Country information (name, code, emoji, unicode, flag image URL)
- 🔍 Search and filter countries
- 🚀 Fast and efficient with built-in caching
- 📱 Easy to use API
- 🎯 Type-safe with full Dart null-safety support

## Getting Started

Add this package to your `pubspec.yaml`:

```yaml
dependencies:
  dial_codes: ^0.0.1
```

Then run:

```bash
flutter pub get
```

## Usage

### Basic Usage

```dart
import 'package:dial_codes/dial_codes.dart';

// Get all countries
final countries = await DialCodesService.instance.getCountries();

// Get a specific country by code
final egypt = await DialCodesService.instance.getCountryByCode('EG');
print('${egypt?.name} - ${egypt?.dialCode}'); // Egypt - +20

// Get a country by name
final usa = await DialCodesService.instance.getCountryByName('United States');

// Get a country by dial code
final uk = await DialCodesService.instance.getCountryByDialCode('+44');
```

### Search Countries

```dart
// Search countries by name, code, or dial code
final results = await DialCodesService.instance.searchCountries('united');
for (var country in results) {
  print('${country.emoji} ${country.name} (${country.dialCode})');
}
```

### Sorted Lists

```dart
// Get countries sorted by name
final byName = await DialCodesService.instance.getCountriesSortedByName();

// Get countries sorted by dial code
final byDialCode = await DialCodesService.instance.getCountriesSortedByDialCode();
```

### Using the Country Model

```dart
final country = await DialCodesService.instance.getCountryByCode('US');

if (country != null) {
  print('Name: ${country.name}');
  print('Code: ${country.code}');
  print('Emoji: ${country.emoji}');
  print('Unicode: ${country.unicode}');
  print('Dial Code: ${country.dialCode}');
  print('Flag Image: ${country.image}'); // SVG image URL
}
```

### Displaying Country Flags

Each country includes both an emoji flag and an SVG image URL:

**Option 1: Using Emoji Flags (No Dependencies)**
```dart
Text(
  country.emoji,  // 🇺🇸
  style: TextStyle(fontSize: 32),
)
```

**Option 2: Using SVG Images**

Add `flutter_svg` to your `pubspec.yaml`:
```yaml
dependencies:
  flutter_svg: ^2.0.0
```

Then display the SVG flag:
```dart
import 'package:flutter_svg/flutter_svg.dart';

SvgPicture.network(
  country.image,  // https://cdn.jsdelivr.net/npm/country-flag-emoji-json@2.0.0/dist/images/US.svg
  width: 32,
  height: 32,
  placeholderBuilder: (context) => CircularProgressIndicator(),
)
```

### Building a Country Picker

```dart
import 'package:flutter/material.dart';
import 'package:dial_codes/dial_codes.dart';

class CountryPickerExample extends StatefulWidget {
  @override
  _CountryPickerExampleState createState() => _CountryPickerExampleState();
}

class _CountryPickerExampleState extends State<CountryPickerExample> {
  List<Country> countries = [];
  Country? selectedCountry;

  @override
  void initState() {
    super.initState();
    loadCountries();
  }

  Future<void> loadCountries() async {
    final loadedCountries = await DialCodesService.instance.getCountries();
    setState(() {
      countries = loadedCountries;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('Select Country')),
      body: ListView.builder(
        itemCount: countries.length,
        itemBuilder: (context, index) {
          final country = countries[index];
          return ListTile(
            leading: Text(
              country.emoji,
              style: TextStyle(fontSize: 32),
            ),
            title: Text(country.name),
            subtitle: Text(country.dialCode),
            onTap: () {
              setState(() {
                selectedCountry = country;
              });
            },
            selected: selectedCountry == country,
          );
        },
      ),
    );
  }
}
```

## Country Data Structure

Each `Country` object contains:

- `name`: Full country name (e.g., "United States")
- `code`: ISO 3166-1 alpha-2 country code (e.g., "US")
- `emoji`: Country flag emoji (e.g., "🇺🇸")
- `unicode`: Unicode representation of the flag (e.g., "U+1F1FA U+1F1F8")
- `dialCode`: International dialing code (e.g., "+1")
- `image`: URL to the country's flag SVG image (e.g., "https://cdn.jsdelivr.net/npm/country-flag-emoji-json@2.0.0/dist/images/US.svg")

## API Reference

### DialCodesService

The main service class for accessing country data.

#### Methods

- `getCountries()`: Returns all countries
- `getCountryByCode(String code)`: Find country by ISO code
- `getCountryByName(String name)`: Find country by name
- `getCountryByDialCode(String dialCode)`: Find country by dial code
- `searchCountries(String query)`: Search countries by name, code, or dial code
- `getCountriesSortedByName()`: Get countries sorted alphabetically by name
- `getCountriesSortedByDialCode()`: Get countries sorted by dial code
- `getCountriesCount()`: Get the total number of countries
- `clearCache()`: Clear the cached countries list

## Performance

The package uses caching to ensure optimal performance. The country data is loaded once and cached in memory. You can manually clear the cache using `clearCache()` if needed.

## Data Source

The country data includes over 240 countries and territories with their official dial codes, flags, and other information.

## Contributing

Contributions are welcome! Please feel free to submit a Pull Request.

## License

This project is licensed under the MIT License - see the LICENSE file for details.

## Support

If you encounter any issues or have questions, please file an issue on the GitHub repository.
