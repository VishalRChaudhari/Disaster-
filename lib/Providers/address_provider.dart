import 'package:flutter/foundation.dart';
import 'package:geocoding/geocoding.dart'; // For converting lat/lng to address

class LocationProvider with ChangeNotifier {
  String _address = "Fetching address...";

  String get address => _address;

  // Function to convert latitude and longitude to address
  Future<void> getAddressFromLatLng(double latitude, double longitude) async {
    try {
      // Fetch the list of placemarks (addresses) from the given coordinates
      List<Placemark> placemarks = await placemarkFromCoordinates(latitude, longitude);
      
      // Check if we have any placemarks returned
      if (placemarks.isNotEmpty) {
        Placemark place = placemarks[0]; // Use the first available placemark
        
        // Set the human-readable address
        _address = "${place.name}, ${place.locality}, ${place.administrativeArea}, ${place.country}";
      } else {
        _address = "Address not found.";
      }
    } catch (e) {
      _address = "Failed to get address.";
    }
    
    // Notify listeners to update the UI
    notifyListeners();
  }
}
