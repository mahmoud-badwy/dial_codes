import 'package:flutter/material.dart';
import 'package:dial_codes/dial_codes.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Dial Codes Example',
      theme: ThemeData(primarySwatch: Colors.blue, useMaterial3: true),
      home: const CountryListPage(),
    );
  }
}

class CountryListPage extends StatefulWidget {
  const CountryListPage({super.key});

  @override
  State<CountryListPage> createState() => _CountryListPageState();
}

class _CountryListPageState extends State<CountryListPage> {
  List<Country> countries = [];
  List<Country> filteredCountries = [];
  bool isLoading = true;
  String searchQuery = '';
  Country? selectedCountry;

  @override
  void initState() {
    super.initState();
    loadCountries();
  }

  Future<void> loadCountries() async {
    setState(() => isLoading = true);

    final loadedCountries = await DialCodesService.instance
        .getCountriesSortedByName();

    setState(() {
      countries = loadedCountries;
      filteredCountries = loadedCountries;
      isLoading = false;
    });
  }

  void searchCountries(String query) {
    setState(() {
      searchQuery = query;
      if (query.isEmpty) {
        filteredCountries = countries;
      } else {
        filteredCountries = countries.where((country) {
          return country.name.toLowerCase().contains(query.toLowerCase()) ||
              country.code.toLowerCase().contains(query.toLowerCase()) ||
              country.dialCode.contains(query);
        }).toList();
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Country Dial Codes'), elevation: 2),
      body: Column(
        children: [
          // Search Bar
          Padding(
            padding: const EdgeInsets.all(16.0),
            child: TextField(
              decoration: InputDecoration(
                hintText: 'Search countries...',
                prefixIcon: const Icon(Icons.search),
                suffixIcon: searchQuery.isNotEmpty
                    ? IconButton(
                        icon: const Icon(Icons.clear),
                        onPressed: () {
                          searchCountries('');
                        },
                      )
                    : null,
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(12),
                ),
                filled: true,
                fillColor: Colors.grey[100],
              ),
              onChanged: searchCountries,
            ),
          ),

          // Selected Country Display
          if (selectedCountry != null)
            Container(
              margin: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
              padding: const EdgeInsets.all(16),
              decoration: BoxDecoration(
                color: Colors.blue[50],
                borderRadius: BorderRadius.circular(12),
                border: Border.all(color: Colors.blue[200]!),
              ),
              child: Row(
                children: [
                  Text(
                    selectedCountry!.emoji,
                    style: const TextStyle(fontSize: 48),
                  ),
                  const SizedBox(width: 16),
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          selectedCountry!.name,
                          style: const TextStyle(
                            fontSize: 18,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        const SizedBox(height: 4),
                        Text(
                          '${selectedCountry!.code} • ${selectedCountry!.dialCode}',
                          style: TextStyle(
                            fontSize: 14,
                            color: Colors.grey[700],
                          ),
                        ),
                      ],
                    ),
                  ),
                  IconButton(
                    icon: const Icon(Icons.close),
                    onPressed: () {
                      setState(() => selectedCountry = null);
                    },
                  ),
                ],
              ),
            ),

          // Stats
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  '${filteredCountries.length} ${filteredCountries.length == 1 ? 'country' : 'countries'}',
                  style: TextStyle(
                    color: Colors.grey[600],
                    fontWeight: FontWeight.w500,
                  ),
                ),
                if (isLoading)
                  const SizedBox(
                    width: 20,
                    height: 20,
                    child: CircularProgressIndicator(strokeWidth: 2),
                  ),
              ],
            ),
          ),

          // Country List
          Expanded(
            child: isLoading
                ? const Center(child: CircularProgressIndicator())
                : filteredCountries.isEmpty
                ? Center(
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Icon(
                          Icons.search_off,
                          size: 64,
                          color: Colors.grey[400],
                        ),
                        const SizedBox(height: 16),
                        Text(
                          'No countries found',
                          style: TextStyle(
                            fontSize: 18,
                            color: Colors.grey[600],
                          ),
                        ),
                      ],
                    ),
                  )
                : ListView.builder(
                    itemCount: filteredCountries.length,
                    itemBuilder: (context, index) {
                      final country = filteredCountries[index];
                      final isSelected = selectedCountry == country;

                      return Card(
                        margin: const EdgeInsets.symmetric(
                          horizontal: 16,
                          vertical: 4,
                        ),
                        elevation: isSelected ? 4 : 1,
                        color: isSelected ? Colors.blue[50] : null,
                        child: ListTile(
                          leading: Text(
                            country.emoji,
                            style: const TextStyle(fontSize: 32),
                          ),
                          title: Text(
                            country.name,
                            style: TextStyle(
                              fontWeight: isSelected
                                  ? FontWeight.bold
                                  : FontWeight.normal,
                            ),
                          ),
                          subtitle: Text(
                            '${country.code} • ${country.dialCode}',
                          ),
                          trailing: isSelected
                              ? const Icon(
                                  Icons.check_circle,
                                  color: Colors.blue,
                                )
                              : null,
                          onTap: () {
                            setState(() {
                              selectedCountry = isSelected ? null : country;
                            });
                          },
                        ),
                      );
                    },
                  ),
          ),
        ],
      ),
    );
  }
}
