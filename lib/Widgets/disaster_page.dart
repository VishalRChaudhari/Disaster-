import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:disastermanagement/Widgets/news.dart';
import 'package:disastermanagement/Widgets/weatherCard.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

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
          /*const Padding(
            padding: EdgeInsets.only(
              top: 10,
            ),
            child: TextField(
              decoration: InputDecoration(
                filled: true,
                enabled: true,
                enabledBorder: OutlineInputBorder(
                  borderRadius: BorderRadius.all(
                    Radius.circular(25),
                  ),
                ),
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.all(
                    Radius.circular(25),
                  ),
                ),
                label: Text('Search City'),
                contentPadding: EdgeInsets.all(15),
              ),
            ),
          ),*/
          //const SearchCity(),
          const SizedBox(
            height: 10,
          ),
          //hello card

          SizedBox(
            width: double.infinity,
            height: 110,
            child: Card(
              elevation: 3,
              child: Padding(
                padding: const EdgeInsets.only(left: 20),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const Text(
                      'Hello...',
                      style: TextStyle(
                        fontSize: 15,
                      ),
                    ),
                    Text(
                      '${userData?['name'] ?? 'N/A'}',
                      style: const TextStyle(
                        fontSize: 26,
                      ),
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
            ' News',
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
