import 'package:disastermanagement/sec.dart';
import 'package:flutter/material.dart';
import 'package:flutter_map/flutter_map.dart';
import 'package:latlong2/latlong.dart';
import 'dart:convert'; // For JSON decoding
import 'package:http/http.dart' as http; // For HTTP requests

class MapScreen extends StatefulWidget {
  const MapScreen({super.key});

  @override
  _MapScreenState createState() => _MapScreenState();
}

class _MapScreenState extends State<MapScreen> {
  final TextEditingController _searchController = TextEditingController();
  final MapController _mapController = MapController();
  LatLng _currentCenter =
      const LatLng(20.5937, 78.9629); // Default: Center of India
  double _currentZoom = 5.0;
  LatLng _markerPosition =
      const LatLng(20.5937, 78.9629); // Initial marker position

  Future<void> _searchCity(String city) async {
    // Replace with your Geocoding API URL and key
    // OpenCage or Nominatim API key
    final String url =
        "https://api.opencagedata.com/geocode/v1/json?q=$city&key=$geocodingAPI";

    try {
      final response = await http.get(Uri.parse(url));
      if (response.statusCode == 200) {
        final data = json.decode(response.body);
        if (data['results'].isNotEmpty) {
          final lat = data['results'][0]['geometry']['lat'];
          final lng = data['results'][0]['geometry']['lng'];
          setState(() {
            _currentCenter = LatLng(lat, lng);
            _markerPosition = LatLng(lat, lng); // Move marker to search result
            _currentZoom = 10.0; // Zoom closer to the city
          });
          _mapController.move(_currentCenter, _currentZoom);
        } else {
          _showError("No results found for '$city'.");
        }
      } else {
        _showError("Error: Unable to fetch location.");
      }
    } catch (e) {
      _showError("Error: $e");
    }
  }

  void _confirmLocation() {
    // Confirm the selected location
    showDialog(
      context: context,
      builder: (ctx) => AlertDialog(
        title: const Text("Location Selected"),
        content: Text("Latitude: ${_markerPosition.latitude}, "
            "Longitude: ${_markerPosition.longitude}"),
        actions: [
          TextButton(
            onPressed: () => Navigator.of(ctx).pop(),
            child: const Text("OK"),
          ),
        ],
      ),
    );
  }

  void _showError(String message) {
    showDialog(
      context: context,
      builder: (ctx) => AlertDialog(
        title: const Text("Error"),
        content: Text(message),
        actions: [
          TextButton(
            onPressed: () => Navigator.of(ctx).pop(),
            child: const Text("OK"),
          ),
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Padding(
          padding: const EdgeInsets.all(8.0),
          child: TextField(
            controller: _searchController,
            decoration: InputDecoration(
              hintText: "Enter city name",
              suffixIcon: IconButton(
                icon: const Icon(Icons.search),
                onPressed: () {
                  if (_searchController.text.isNotEmpty) {
                    _searchCity(_searchController.text);
                  }
                },
              ),
              border: const OutlineInputBorder(),
            ),
          ),
        ),
        Expanded(
          child: Stack(
            children: [
              FlutterMap(
                mapController: _mapController,
                options: MapOptions(
                  initialCenter: _currentCenter,
                  initialZoom: _currentZoom,
                  onTap: (tapPosition, LatLng point) {
                    setState(() {
                      _markerPosition = point; // Update marker position on tap
                    });
                  },
                ),
                children: [
                  TileLayer(
                    urlTemplate:
                        "https://{s}.tile.openstreetmap.org/{z}/{x}/{y}.png",
                    subdomains: const ['a', 'b', 'c'],
                  ),
                  MarkerLayer(
                    markers: [
                      Marker(
                        point: _markerPosition,
                        width: 80.0,
                        height: 80.0,
                        child: Container(
                          alignment: Alignment.center,
                          child: const Icon(
                            Icons.location_pin,
                            color: Colors.red,
                            size: 50,
                          ),
                        ),
                      )
                    ],
                  ),
                ],
              ),
              // Confirm Button
              Positioned(
                bottom: 20,
                left: 20,
                right: 20,
                child: Row(
                  children: [
                    SizedBox(
                      width: 300,
                      height: 40,
                      child: ElevatedButton(
                        onPressed: _confirmLocation,
                        child: const Text("Confirm Location"),
                      ),
                    ),
                    Spacer(),
                    IconButton(
                      onPressed: () {},
                      icon: Icon(Icons.my_location_outlined),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ],
    );
  }
}
