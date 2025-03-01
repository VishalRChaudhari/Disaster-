import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:disastermanagement/Widgets/news.dart';
import 'package:disastermanagement/Widgets/weatherCard.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

class DisasterPage extends StatefulWidget {
  const DisasterPage({super.key});

  @override
  State<DisasterPage> createState() => _DisasterPage();
}

final FirebaseAuth _auth = FirebaseAuth.instance;
final FirebaseFirestore _firestore = FirebaseFirestore.instance;

class _DisasterPage extends State<DisasterPage> {
  // User data
  Map<String, dynamic>? userData;
  bool isLoading = true;

  @override
  void initState() {
    super.initState();
    fetchUserProfile();
  }

  Future<void> fetchUserProfile() async {
    try {
      // Get the current user's UID
      final User? user = _auth.currentUser;
      if (user != null) {
        final uid = user.uid;

        // Fetch user data from Firestore
        final DocumentSnapshot userDoc =
            await _firestore.collection('Users').doc(uid).get();

        if (userDoc.exists) {
          setState(() {
            userData = userDoc.data() as Map<String, dynamic>;
            isLoading = false;
          });
        } else {
          setState(() {
            isLoading = false;
          });
          ScaffoldMessenger.of(context).showSnackBar(
            const SnackBar(content: Text('User data not found.')),
          );
        }
      }
    } catch (e) {
      setState(() {
        isLoading = false;
      });
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('Error fetching profile: $e')),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(left: 12, top: 8, bottom: 8, right: 12),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          //search location
          TextField(
            decoration: InputDecoration(
              filled: true,
              fillColor: Theme.of(context).colorScheme.primary.withOpacity(0.1),
              enabledBorder: OutlineInputBorder(
                borderRadius: BorderRadius.circular(25),
                borderSide: BorderSide(color: Colors.grey.shade400),
              ),
              focusedBorder: OutlineInputBorder(
                borderRadius: BorderRadius.circular(25),
                borderSide: const BorderSide(color: Colors.blue, width: 2),
              ),
              prefixIcon: const Icon(Icons.search, color: Colors.grey),
              hintText: 'Search City',
              contentPadding: const EdgeInsets.all(15),
            ),
          ),
          //const SearchCity(),
          const SizedBox(
            height: 10,
          ),
          //hello card

          SizedBox(
            width: double.infinity,
            height: 120,
            child: Card(
              elevation: 1,
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(15),
              ),
              color: Theme.of(context).colorScheme.secondaryContainer,
              child: Padding(
                padding: const EdgeInsets.symmetric(horizontal: 20),
                child: Row(
                  children: [
                    CircleAvatar(
                      radius: 30,
                      backgroundColor: Theme.of(context).colorScheme.primary,
                      child: const Icon(FontAwesomeIcons.user,
                          size: 30, color: Colors.white),
                    ),
                    const SizedBox(width: 15),
                    Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        const Text(
                          'Hello...',
                          style: TextStyle(fontSize: 16, color: Colors.black54),
                        ),
                        Text(
                          userData?['name'] ?? 'Guest',
                          style: const TextStyle(
                            fontSize: 24,
                            fontWeight: FontWeight.bold,
                            color: Colors.black87,
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
              ),
            ),
          ),

          //location fetch
          const SizedBox(
            height: 10,
          ),
          //weather display
          const WeatherCard(),
          const SizedBox(
            height: 10,
          ),
          const Text(
            'Latest News',
            style: TextStyle(
              fontSize: 30,
            ),
          ),
          const SizedBox(
            height: 10,
          ),
          const Expanded(
            child: News(),
          ),
        ],
      ),
    );
  }
}
