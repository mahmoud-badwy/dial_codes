# Widgets Guide

This guide covers the ready-to-use widgets included in the dial_codes package.

## CountryPickerDialog

A Material Design dialog for selecting countries with optional search functionality.

### Basic Usage

```dart
final country = await CountryPickerDialog.show(context);
if (country != null) {
  print('Selected: ${country.name}');
}
```

### With Search Bar (Default)

```dart
final country = await CountryPickerDialog.show(
  context,
  showSearch: true,
  title: 'Select Country',
  searchHint: 'Search countries...',
);
```

### Without Search Bar

```dart
final country = await CountryPickerDialog.show(
  context,
  showSearch: false,
  title: 'Choose Country',
);
```

### Custom Options

```dart
final country = await CountryPickerDialog.show(
  context,
  showSearch: true,
  title: 'Select Your Location',
  searchHint: 'Type to search...',
  showFlags: true,          // Show flag emojis
  showCountryCodes: false,  // Hide country codes
  showDialCodes: true,      // Show dial codes
  countryNameStyle: TextStyle(
    fontSize: 16,
    fontWeight: FontWeight.w600,
  ),
  subtitleStyle: TextStyle(
    color: Colors.grey,
  ),
);
```

### Parameters

| Parameter | Type | Default | Description |
|-----------|------|---------|-------------|
| `showSearch` | `bool` | `true` | Enable/disable search bar |
| `title` | `String` | `'Select Country'` | Dialog title |
| `searchHint` | `String` | `'Search countries...'` | Search field hint |
| `showFlags` | `bool` | `true` | Show/hide flag emojis |
| `showCountryCodes` | `bool` | `true` | Show/hide country codes |
| `showDialCodes` | `bool` | `true` | Show/hide dial codes |
| `countryNameStyle` | `TextStyle?` | `null` | Custom style for country names |
| `subtitleStyle` | `TextStyle?` | `null` | Custom style for subtitles |
| `searchDecoration` | `InputDecoration?` | `null` | Custom search field decoration |

---

## CountryDropdown

A dropdown widget for country selection with extensive customization options.

### Basic Usage

```dart
class MyWidget extends StatefulWidget {
  @override
  _MyWidgetState createState() => _MyWidgetState();
}

class _MyWidgetState extends State<MyWidget> {
  Country? selectedCountry;

  @override
  Widget build(BuildContext context) {
    return CountryDropdown(
      selectedCountry: selectedCountry,
      onChanged: (country) {
        setState(() => selectedCountry = country);
      },
    );
  }
}
```

### With Custom Decoration

```dart
CountryDropdown(
  selectedCountry: selectedCountry,
  onChanged: (country) {
    setState(() => selectedCountry = country);
  },
  decoration: InputDecoration(
    labelText: 'Select Country',
    border: OutlineInputBorder(),
    prefixIcon: Icon(Icons.public),
  ),
)
```

### Hide Flags

```dart
CountryDropdown(
  selectedCountry: selectedCountry,
  onChanged: (country) {
    setState(() => selectedCountry = country);
  },
  showFlag: false,
  decoration: InputDecoration(
    labelText: 'Country',
    border: OutlineInputBorder(),
  ),
)
```

### Show Only Dial Codes

```dart
CountryDropdown(
  selectedCountry: selectedCountry,
  onChanged: (country) {
    setState(() => selectedCountry = country);
  },
  showCountryCode: false,
  showDialCode: true,
  hint: 'Select dial code',
)
```

### Custom Item Builder

```dart
CountryDropdown(
  selectedCountry: selectedCountry,
  onChanged: (country) {
    setState(() => selectedCountry = country);
  },
  itemBuilder: (country) {
    return Row(
      children: [
        Text(country.emoji, style: TextStyle(fontSize: 24)),
        SizedBox(width: 12),
        Text('${country.name} (${country.dialCode})'),
      ],
    );
  },
  selectedItemBuilder: (country) {
    return Text('${country.emoji} ${country.dialCode}');
  },
)
```

### Parameters

| Parameter | Type | Default | Description |
|-----------|------|---------|-------------|
| `selectedCountry` | `Country?` | `null` | Currently selected country |
| `onChanged` | `ValueChanged<Country?>?` | `null` | Callback when selection changes |
| `showFlag` | `bool` | `true` | Show/hide flag emoji |
| `showCountryCode` | `bool` | `true` | Show/hide country code |
| `showDialCode` | `bool` | `true` | Show/hide dial code |
| `hint` | `String` | `'Select a country'` | Hint text |
| `decoration` | `InputDecoration?` | `null` | Input decoration |
| `style` | `TextStyle?` | `null` | Text style |
| `enabled` | `bool` | `true` | Enable/disable dropdown |
| `itemBuilder` | `Widget Function(Country)?` | `null` | Custom item builder |
| `selectedItemBuilder` | `Widget Function(Country)?` | `null` | Custom selected item builder |

---

## Complete Example

```dart
import 'package:flutter/material.dart';
import 'package:dial_codes/dial_codes.dart';

class CountrySelectionPage extends StatefulWidget {
  @override
  _CountrySelectionPageState createState() => _CountrySelectionPageState();
}

class _CountrySelectionPageState extends State<CountrySelectionPage> {
  Country? selectedFromDialog;
  Country? selectedFromDropdown;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('Country Selection')),
      body: Padding(
        padding: EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            // Dialog example
            ElevatedButton.icon(
              onPressed: () async {
                final country = await CountryPickerDialog.show(
                  context,
                  showSearch: true,
                );
                if (country != null) {
                  setState(() => selectedFromDialog = country);
                }
              },
              icon: Icon(Icons.search),
              label: Text('Open Country Picker'),
            ),
            
            if (selectedFromDialog != null) ...[
              SizedBox(height: 16),
              Card(
                child: ListTile(
                  leading: Text(
                    selectedFromDialog!.emoji,
                    style: TextStyle(fontSize: 32),
                  ),
                  title: Text(selectedFromDialog!.name),
                  subtitle: Text(
                    '${selectedFromDialog!.code} • ${selectedFromDialog!.dialCode}',
                  ),
                ),
              ),
            ],
            
            SizedBox(height: 32),
            
            // Dropdown example
            CountryDropdown(
              selectedCountry: selectedFromDropdown,
              onChanged: (country) {
                setState(() => selectedFromDropdown = country);
              },
              decoration: InputDecoration(
                labelText: 'Select Country',
                border: OutlineInputBorder(),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
```

## Tips

1. **Performance**: Both widgets use the cached country data from `DialCodesService`, so subsequent uses are very fast.

2. **Search**: The dialog search is case-insensitive and searches across country names, codes, and dial codes.

3. **Customization**: Both widgets support extensive customization through their parameters.

4. **Material Design**: Widgets follow Material Design guidelines and integrate seamlessly with Flutter's Material widgets.

5. **Responsive**: Both widgets adapt to different screen sizes and orientations.
