import 'package:flutter/material.dart';
import '../models/country.dart';
import '../dial_codes_service.dart';

/// A dropdown widget to display and select countries
class CountryDropdown extends StatefulWidget {
  /// The currently selected country
  final Country? selectedCountry;

  /// Callback when a country is selected
  final ValueChanged<Country?>? onChanged;

  /// Whether to show country flags
  final bool showFlag;

  /// Whether to show country code
  final bool showCountryCode;

  /// Whether to show dial code
  final bool showDialCode;

  /// Hint text when no country is selected
  final String hint;

  /// Decoration for the dropdown
  final InputDecoration? decoration;

  /// Text style for the dropdown items
  final TextStyle? style;

  /// Whether the dropdown is enabled
  final bool enabled;

  /// Custom item builder for dropdown items
  final Widget Function(Country country)? itemBuilder;

  /// Custom selected item builder
  final Widget Function(Country country)? selectedItemBuilder;

  const CountryDropdown({
    super.key,
    this.selectedCountry,
    this.onChanged,
    this.showFlag = true,
    this.showCountryCode = true,
    this.showDialCode = true,
    this.hint = 'Select a country',
    this.decoration,
    this.style,
    this.enabled = true,
    this.itemBuilder,
    this.selectedItemBuilder,
  });

  @override
  State<CountryDropdown> createState() => _CountryDropdownState();
}

class _CountryDropdownState extends State<CountryDropdown> {
  List<Country> _countries = [];
  bool _isLoading = true;

  @override
  void initState() {
    super.initState();
    _loadCountries();
  }

  Future<void> _loadCountries() async {
    final countries = await DialCodesService.instance
        .getCountriesSortedByName();
    setState(() {
      _countries = countries;
      _isLoading = false;
    });
  }

  Widget _buildDefaultItem(Country country) {
    final parts = <String>[];
    if (widget.showCountryCode) {
      parts.add(country.code);
    }
    parts.add(country.name);
    if (widget.showDialCode) {
      parts.add(country.dialCode);
    }

    return Row(
      children: [
        if (widget.showFlag) ...[
          Text(country.emoji, style: const TextStyle(fontSize: 24)),
          const SizedBox(width: 12),
        ],
        Expanded(
          child: Text(
            parts.join(' - '),
            overflow: TextOverflow.ellipsis,
            style: widget.style,
          ),
        ),
      ],
    );
  }

  Widget _buildDefaultSelectedItem(Country country) {
    final parts = <String>[];
    if (widget.showCountryCode) {
      parts.add(country.code);
    }
    if (widget.showDialCode) {
      parts.add(country.dialCode);
    }

    return Row(
      children: [
        if (widget.showFlag) ...[
          Text(country.emoji, style: const TextStyle(fontSize: 20)),
          const SizedBox(width: 8),
        ],
        Expanded(
          child: Text(
            parts.isEmpty ? country.name : parts.join(' • '),
            overflow: TextOverflow.ellipsis,
            style: widget.style,
          ),
        ),
      ],
    );
  }

  @override
  Widget build(BuildContext context) {
    if (_isLoading) {
      return InputDecorator(
        decoration:
            widget.decoration ??
            InputDecoration(
              border: const OutlineInputBorder(),
              hintText: widget.hint,
            ),
        child: const SizedBox(
          height: 20,
          width: 20,
          child: CircularProgressIndicator(strokeWidth: 2),
        ),
      );
    }

    return DropdownButtonFormField<Country>(
      value: widget.selectedCountry,
      decoration:
          widget.decoration ??
          InputDecoration(
            border: const OutlineInputBorder(),
            hintText: widget.hint,
          ),
      isExpanded: true,
      hint: Text(widget.hint),
      items: _countries.map((country) {
        return DropdownMenuItem<Country>(
          value: country,
          child:
              widget.itemBuilder?.call(country) ?? _buildDefaultItem(country),
        );
      }).toList(),
      selectedItemBuilder: widget.selectedItemBuilder != null
          ? (context) => _countries.map((country) {
              return widget.selectedItemBuilder!.call(country);
            }).toList()
          : (context) => _countries.map((country) {
              return _buildDefaultSelectedItem(country);
            }).toList(),
      onChanged: widget.enabled ? widget.onChanged : null,
      style: widget.style,
    );
  }
}
