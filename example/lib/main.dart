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
      home: const HomePage(),
    );
  }
}

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  int _currentIndex = 0;

  final List<Widget> _pages = [
    const CountryListPage(),
    const WidgetsDemoPage(),
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: _pages[_currentIndex],
      bottomNavigationBar: NavigationBar(
        selectedIndex: _currentIndex,
        onDestinationSelected: (index) {
          setState(() => _currentIndex = index);
        },
        destinations: const [
          NavigationDestination(icon: Icon(Icons.list), label: 'Country List'),
          NavigationDestination(
            icon: Icon(Icons.widgets),
            label: 'Widgets Demo',
          ),
        ],
      ),
    );
  }
}

class WidgetsDemoPage extends StatefulWidget {
  const WidgetsDemoPage({super.key});

  @override
  State<WidgetsDemoPage> createState() => _WidgetsDemoPageState();
}

class _WidgetsDemoPageState extends State<WidgetsDemoPage> {
  Country? selectedCountryDialog;
  Country? selectedCountryDropdown;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Widgets Demo'), elevation: 2),
      body: ListView(
        padding: const EdgeInsets.all(16.0),
        children: [
          // Dialog Examples
          Card(
            child: Padding(
              padding: const EdgeInsets.all(16.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    'Country Picker Dialog',
                    style: Theme.of(context).textTheme.titleLarge,
                  ),
                  const SizedBox(height: 16),

                  // Dialog with search
                  ElevatedButton.icon(
                    onPressed: () async {
                      final country = await CountryPickerDialog.show(
                        context,
                        showSearch: true,
                      );
                      if (country != null) {
                        setState(() => selectedCountryDialog = country);
                      }
                    },
                    icon: const Icon(Icons.search),
                    label: const Text('Open Dialog (with search)'),
                  ),
                  const SizedBox(height: 8),

                  // Dialog without search
                  OutlinedButton.icon(
                    onPressed: () async {
                      final country = await CountryPickerDialog.show(
                        context,
                        showSearch: false,
                        title: 'Choose Country',
                      );
                      if (country != null) {
                        setState(() => selectedCountryDialog = country);
                      }
                    },
                    icon: const Icon(Icons.public),
                    label: const Text('Open Dialog (no search)'),
                  ),
                  const SizedBox(height: 8),

                  // Dialog with custom options
                  FilledButton.icon(
                    onPressed: () async {
                      final country = await CountryPickerDialog.show(
                        context,
                        showSearch: true,
                        showFlags: true,
                        showCountryCodes: false,
                        showDialCodes: true,
                        title: 'Select Dial Code',
                      );
                      if (country != null) {
                        setState(() => selectedCountryDialog = country);
                      }
                    },
                    icon: const Icon(Icons.phone),
                    label: const Text('Open Dialog (custom)'),
                  ),

                  if (selectedCountryDialog != null) ...[
                    const SizedBox(height: 16),
                    const Divider(),
                    const SizedBox(height: 8),
                    ListTile(
                      leading: Text(
                        selectedCountryDialog!.emoji,
                        style: const TextStyle(fontSize: 32),
                      ),
                      title: Text(selectedCountryDialog!.name),
                      subtitle: Text(
                        '${selectedCountryDialog!.code} • ${selectedCountryDialog!.dialCode}',
                      ),
                      trailing: IconButton(
                        icon: const Icon(Icons.clear),
                        onPressed: () {
                          setState(() => selectedCountryDialog = null);
                        },
                      ),
                    ),
                  ],
                ],
              ),
            ),
          ),

          const SizedBox(height: 16),

          // Dropdown Examples
          Card(
            child: Padding(
              padding: const EdgeInsets.all(16.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    'Country Dropdown',
                    style: Theme.of(context).textTheme.titleLarge,
                  ),
                  const SizedBox(height: 16),

                  // Full dropdown
                  CountryDropdown(
                    selectedCountry: selectedCountryDropdown,
                    onChanged: (country) {
                      setState(() => selectedCountryDropdown = country);
                    },
                    decoration: const InputDecoration(
                      labelText: 'Select Country',
                      border: OutlineInputBorder(),
                    ),
                  ),
                  const SizedBox(height: 16),

                  // Dropdown without flag
                  CountryDropdown(
                    selectedCountry: selectedCountryDropdown,
                    onChanged: (country) {
                      setState(() => selectedCountryDropdown = country);
                    },
                    showFlag: false,
                    decoration: const InputDecoration(
                      labelText: 'No Flag',
                      border: OutlineInputBorder(),
                    ),
                  ),
                  const SizedBox(height: 16),

                  // Dropdown with dial code only
                  CountryDropdown(
                    selectedCountry: selectedCountryDropdown,
                    onChanged: (country) {
                      setState(() => selectedCountryDropdown = country);
                    },
                    showCountryCode: false,
                    decoration: const InputDecoration(
                      labelText: 'Country & Dial Code',
                      border: OutlineInputBorder(),
                    ),
                  ),

                  if (selectedCountryDropdown != null) ...[
                    const SizedBox(height: 16),
                    const Divider(),
                    const SizedBox(height: 8),
                    Container(
                      padding: const EdgeInsets.all(12),
                      decoration: BoxDecoration(
                        color: Colors.blue[50],
                        borderRadius: BorderRadius.circular(8),
                      ),
                      child: Row(
                        children: [
                          Text(
                            selectedCountryDropdown!.emoji,
                            style: const TextStyle(fontSize: 24),
                          ),
                          const SizedBox(width: 12),
                          Expanded(
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(
                                  selectedCountryDropdown!.name,
                                  style: const TextStyle(
                                    fontWeight: FontWeight.bold,
                                  ),
                                ),
                                Text(
                                  '${selectedCountryDropdown!.code} • ${selectedCountryDropdown!.dialCode}',
                                  style: TextStyle(
                                    fontSize: 12,
                                    color: Colors.grey[700],
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ],
                      ),
                    ),
                  ],
                ],
              ),
            ),
          ),
        ],
      ),
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
