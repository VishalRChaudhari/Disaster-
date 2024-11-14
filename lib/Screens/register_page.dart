import 'package:disastermanagement/Screens/home.dart';
import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:intl/intl.dart';
import 'package:location/location.dart';

class RegisterPage extends StatefulWidget {
  const RegisterPage({super.key});
  @override
  // ignore: library_private_types_in_public_api
  _RegisterPage createState() => _RegisterPage();
}

class _RegisterPage extends State<RegisterPage> {
  final _formKey = GlobalKey<FormState>();
  final _titleController = TextEditingController();
  String _selectedDisasterType = 'Flood';
  DateTime? _selectedDate;
  LocationData? _currentLocation;
  Location location = Location();

  Future<void> _pickDate(BuildContext context) async {
    final DateTime? picked = await showDatePicker(
      context: context,
      initialDate: DateTime.now(),
      firstDate: DateTime(2020),
      lastDate: DateTime(2101),
    );
    if (picked != null && picked != _selectedDate) {
      setState(() {
        _selectedDate = picked;
      });
    }
  }

  Future<void> _fetchCurrentLocation() async {
    _currentLocation = await location.getLocation();
    setState(() {});
  }

  Future<void> _registerDisaster() async {
    if (_formKey.currentState!.validate()) {
      await FirebaseFirestore.instance.collection('disasters').add(
        {
          'title': _titleController.text,
          'type': _selectedDisasterType,
          'date': _selectedDate?.toIso8601String(),
          'location': {
            'latitude': _currentLocation?.latitude,
            'longitude': _currentLocation?.longitude,
          },
        },
      );

      // ignore: use_build_context_synchronously
      /*ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Disaster registered successfully!')),
      );*/
      Navigator.of(context).pushReplacement(
        MaterialPageRoute(
          builder: (context) => const HomePage(),
        ),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(16.0),
      child: Form(
        key: _formKey,
        child: Column(
          children: [
            TextFormField(
              controller: _titleController,
              decoration: const InputDecoration(labelText: 'Disaster Heading'),
              validator: (value) {
                if (value == null || value.isEmpty) {
                  return 'Please enter a title';
                }
                return null;
              },
            ),
            const SizedBox(height: 20),
            DropdownButtonFormField<String>(
              value: _selectedDisasterType,
              onChanged: (value) {
                setState(() {
                  _selectedDisasterType = value!;
                });
              },
              items: const [
                DropdownMenuItem(
                  value: 'Flood',
                  child: Text('Flood'),
                ),
                DropdownMenuItem(
                  value: 'Earthquake',
                  child: Text('Earthquake'),
                ),
                DropdownMenuItem(
                  value: 'Fire',
                  child: Text('Fire'),
                ),
                DropdownMenuItem(
                  value: 'Tornado',
                  child: Text('Tornado'),
                ),
              ],
              decoration: const InputDecoration(labelText: 'Type of Disaster'),
            ),
            const SizedBox(height: 20),
            Row(
              children: [
                Text(
                  _selectedDate == null
                      ? 'Select Date'
                      : DateFormat.yMd().format(_selectedDate!),
                ),
                IconButton(
                  icon: const Icon(Icons.calendar_today),
                  onPressed: () => _pickDate(context),
                ),
              ],
            ),
            Row(
              children: [
                Text(_currentLocation == null
                    ? 'Location not selected'
                    : 'Lat: ${_currentLocation!.latitude}, Long: ${_currentLocation!.longitude}'),
                IconButton(
                  icon: const Icon(Icons.location_on),
                  onPressed: _fetchCurrentLocation,
                ),
              ],
            ),
            const SizedBox(height: 20),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                ElevatedButton(
                  onPressed: () => _registerDisaster,
                  child: const Text('Register'),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
