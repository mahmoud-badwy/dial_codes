## 0.0.2 - 2025-10-29

* Bug fixes
  - Make `Country.fromJson` resilient to null/missing JSON values to prevent
    runtime TypeError when parsing country data from assets or external JSON.

* Maintenance
  - Bumped package version to `0.0.2`.
  - Minor docs and example updates (example integrated into `testing_app`).


## 0.0.1

* Initial release of dial_codes package
* Complete country information including:
  - Country names
  - ISO country codes
  - International dial codes
  - Country flag emojis
  - Unicode representations
  - Flag image URLs (SVG)
* Features:
  - Get all countries
  - Search countries by name, code, or dial code
  - Find country by specific code, name, or dial code
  - Sort countries by name or dial code
  - Built-in caching for optimal performance
  - Full null-safety support
  - Comprehensive test coverage
* Ready-to-use widgets:
  - **CountryPickerDialog** - Dialog with optional search bar for country selection
  - **CountryDropdown** - Dropdown widget for country selection with customization options
* Widget features:
  - Optional search functionality in dialog
  - Customizable display options (flags, country codes, dial codes)
  - Material Design styling
  - Extensive customization support
* Includes example app demonstrating all features and widgets
