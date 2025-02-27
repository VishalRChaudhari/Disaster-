/*import 'dart:convert';
import 'package:disastermanagement/sec.dart';
import 'package:flutter/material.dart';
import 'package:flutter_typeahead/flutter_typeahead.dart';
import 'package:http/http.dart' as http;

class SearchCity extends StatefulWidget {
  const SearchCity({super.key});

  @override
  State<SearchCity> createState() => _SearchCityState();
}

class _SearchCityState extends State<SearchCity> {

  Future<List<String>> fetchCities(String query) async {
    final url = Uri.parse(
        'http://api.openweathermap.org/geo/1.0/direct?q=$query&limit=5&appid=$weatherApiKey');
    final response = await http.get(url);

    if (response.statusCode == 200) {
      final data = json.decode(response.body) as List;
      return data.map((city) => city['name'] as String).toList();
    } else {
      throw Exception('Failed to load cities');
    }
  }
}

  @override
  Widget build(BuildContext context) {
    return TypeAheadField<String>(
        
      textFieldConfiguration: TextFieldConfiguration(
        decoration: InputDecoration(
          labelText: 'Search for a city',
          prefixIcon: const Icon(Icons.search),
          border: OutlineInputBorder(
            borderRadius: BorderRadius.circular(8.0),
          ),
        ),
      ),
      suggestionsCallback: fetchCities,
      itemBuilder: (context, suggestion) {
        return ListTile(title: Text(suggestion));
      },
      onSuggestionSelected: (suggestion) {
        
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text('You selected: $suggestion')),
        );
      },
    );
  }
}
*/