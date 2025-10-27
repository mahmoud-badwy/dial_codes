import 'package:flutter/material.dart';
import '../models/country.dart';
import '../dial_codes_service.dart';

/// A dialog that displays a list of countries for selection
class CountryPickerDialog extends StatefulWidget {
  /// Whether to show a search bar
  final bool showSearch;

  /// Title of the dialog
  final String title;

  /// Hint text for the search field
  final String searchHint;

  /// Whether to show country flags (emoji)
  final bool showFlags;

  /// Whether to show country codes
  final bool showCountryCodes;

  /// Whether to show dial codes
  final bool showDialCodes;

  /// Custom text style for country names
  final TextStyle? countryNameStyle;

  /// Custom text style for country codes and dial codes
  final TextStyle? subtitleStyle;

  /// Custom decoration for the search field
  final InputDecoration? searchDecoration;

  const CountryPickerDialog({
    super.key,
    this.showSearch = true,
    this.title = 'Select Country',
    this.searchHint = 'Search countries...',
    this.showFlags = true,
    this.showCountryCodes = true,
    this.showDialCodes = true,
    this.countryNameStyle,
    this.subtitleStyle,
    this.searchDecoration,
  });

  @override
  State<CountryPickerDialog> createState() => _CountryPickerDialogState();

  /// Show the country picker dialog
  static Future<Country?> show(
    BuildContext context, {
    bool showSearch = true,
    String title = 'Select Country',
    String searchHint = 'Search countries...',
    bool showFlags = true,
    bool showCountryCodes = true,
    bool showDialCodes = true,
    TextStyle? countryNameStyle,
    TextStyle? subtitleStyle,
    InputDecoration? searchDecoration,
  }) {
    return showDialog<Country>(
      context: context,
      builder: (context) => CountryPickerDialog(
        showSearch: showSearch,
        title: title,
        searchHint: searchHint,
        showFlags: showFlags,
        showCountryCodes: showCountryCodes,
        showDialCodes: showDialCodes,
        countryNameStyle: countryNameStyle,
        subtitleStyle: subtitleStyle,
        searchDecoration: searchDecoration,
      ),
    );
  }
}

class _CountryPickerDialogState extends State<CountryPickerDialog> {
  List<Country> _countries = [];
  List<Country> _filteredCountries = [];
  bool _isLoading = true;
  String _searchQuery = '';
  final TextEditingController _searchController = TextEditingController();

  @override
  void initState() {
    super.initState();
    _loadCountries();
  }

  @override
  void dispose() {
    _searchController.dispose();
    super.dispose();
  }

  Future<void> _loadCountries() async {
    setState(() => _isLoading = true);
    final countries = await DialCodesService.instance
        .getCountriesSortedByName();
    setState(() {
      _countries = countries;
      _filteredCountries = countries;
      _isLoading = false;
    });
  }

  void _filterCountries(String query) {
    setState(() {
      _searchQuery = query;
      if (query.isEmpty) {
        _filteredCountries = _countries;
      } else {
        _filteredCountries = _countries.where((country) {
          final lowerQuery = query.toLowerCase();
          return country.name.toLowerCase().contains(lowerQuery) ||
              country.code.toLowerCase().contains(lowerQuery) ||
              country.dialCode.contains(query);
        }).toList();
      }
    });
  }

  String _buildSubtitle(Country country) {
    final parts = <String>[];
    if (widget.showCountryCodes) {
      parts.add(country.code);
    }
    if (widget.showDialCodes) {
      parts.add(country.dialCode);
    }
    return parts.join(' • ');
  }

  @override
  Widget build(BuildContext context) {
    return Dialog(
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          // Header
          Padding(
            padding: const EdgeInsets.all(16.0),
            child: Row(
              children: [
                Expanded(
                  child: Text(
                    widget.title,
                    style: Theme.of(context).textTheme.titleLarge,
                  ),
                ),
                IconButton(
                  icon: const Icon(Icons.close),
                  onPressed: () => Navigator.of(context).pop(),
                ),
              ],
            ),
          ),

          // Search bar
          if (widget.showSearch)
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 16.0),
              child: TextField(
                controller: _searchController,
                decoration:
                    widget.searchDecoration ??
                    InputDecoration(
                      hintText: widget.searchHint,
                      prefixIcon: const Icon(Icons.search),
                      suffixIcon: _searchQuery.isNotEmpty
                          ? IconButton(
                              icon: const Icon(Icons.clear),
                              onPressed: () {
                                _searchController.clear();
                                _filterCountries('');
                              },
                            )
                          : null,
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(12),
                      ),
                    ),
                onChanged: _filterCountries,
              ),
            ),

          const SizedBox(height: 8),

          // Country list
          Flexible(
            child: _isLoading
                ? const Center(child: CircularProgressIndicator())
                : _filteredCountries.isEmpty
                ? Center(
                    child: Padding(
                      padding: const EdgeInsets.all(32.0),
                      child: Text(
                        'No countries found',
                        style: TextStyle(color: Colors.grey[600]),
                      ),
                    ),
                  )
                : ListView.builder(
                    shrinkWrap: true,
                    itemCount: _filteredCountries.length,
                    itemBuilder: (context, index) {
                      final country = _filteredCountries[index];
                      return ListTile(
                        leading: widget.showFlags
                            ? Text(
                                country.emoji,
                                style: const TextStyle(fontSize: 28),
                              )
                            : null,
                        title: Text(
                          country.name,
                          style: widget.countryNameStyle,
                        ),
                        subtitle: Text(
                          _buildSubtitle(country),
                          style: widget.subtitleStyle,
                        ),
                        onTap: () => Navigator.of(context).pop(country),
                      );
                    },
                  ),
          ),
        ],
      ),
    );
  }
}
