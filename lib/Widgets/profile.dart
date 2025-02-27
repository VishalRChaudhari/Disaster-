import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:disastermanagement/Screens/about_us.dart';
import 'package:disastermanagement/Screens/refer_us.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

class ProfilePage extends StatefulWidget {
  const ProfilePage({super.key});

  @override
  State<ProfilePage> createState() => _ProfilePageState();
}

class _ProfilePageState extends State<ProfilePage> {
  final FirebaseAuth _auth = FirebaseAuth.instance;
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;

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
    return Column(
      children: [
        isLoading
            ? const Center(child: CircularProgressIndicator())
            : userData == null
                ? const Center(child: Text('No profile data available.'))
                : userData == null
                    ? const Center(child: Text('No profile data available.'))
                    : Padding(
                        padding:
                            const EdgeInsets.only(left: 15, top: 15, right: 10),
                        child: Row(
                          children: [
                            //avatar
                            CircleAvatar(
                              radius: 50,
                              backgroundColor: Colors.blueAccent,
                              child: Text(
                                userData!['name'] != null &&
                                        userData!['name'].isNotEmpty
                                    ? userData!['name'][0].toUpperCase()
                                    : '?',
                                style: const TextStyle(
                                  fontSize: 40,
                                  color: Colors.white,
                                ),
                              ),
                            ),
                            const SizedBox(
                              width: 15,
                            ),
                            //name
                            Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(
                                  ' ${userData!['name'] ?? 'N/A'}',
                                  style: const TextStyle(
                                    fontSize: 25,
                                  ),
                                ),
                                Center(
                                  child: Text(
                                    ' ${userData!['email'] ?? 'N/A'}',
                                    style: const TextStyle(fontSize: 15),
                                  ),
                                ),
                              ],
                            )
                          ],
                        ),
                      ),
        Padding(
          padding: const EdgeInsets.only(left: 10, top: 5, right: 10),
          child: Column(
            children: [
              ListTile(
                leading: Icon(
                  Icons.home,
                  size: 25,
                ),
                title: Text(
                  'Home',
                  style: TextStyle(
                    fontSize: 18,
                  ),
                ),
              ),
              ListTile(
                leading: Icon(
                  Icons.phone,
                  size: 25,
                ),
                title: Text(
                  'Helplines',
                  style: TextStyle(
                    fontSize: 18,
                  ),
                ),
              ),
              ListTile(
                leading: Icon(
                  Icons.rule,
                  size: 25,
                ),
                title: Text(
                  "Dos & Don'ts",
                  style: TextStyle(
                    fontSize: 18,
                  ),
                ),
              ),
              ListTile(
                onTap: () {
                  Navigator.of(context).push(
                    MaterialPageRoute(
                      builder: (context) => ReferUs(),
                    ),
                  );
                },
                leading: Icon(
                  Icons.share,
                  size: 25,
                ),
                title: Text(
                  'Refer Us',
                  style: TextStyle(
                    fontSize: 18,
                  ),
                ),
              ),
              ListTile(
                onTap: () {
                  Navigator.of(context).push(
                    MaterialPageRoute(
                      builder: (context) => AboutUs(),
                    ),
                  );
                },
                leading: Icon(
                  Icons.info_outline,
                  size: 25,
                ),
                title: Text(
                  'About Us',
                  style: TextStyle(
                    fontSize: 18,
                  ),
                ),
              ),
              ListTile(
                leading: Icon(
                  Icons.logout,
                  size: 25,
                ),
                title: Text(
                  'Log Out',
                  style: TextStyle(
                    fontSize: 18,
                  ),
                ),
                onTap: () {
                  FirebaseAuth.instance.signOut();
                },
              ),
            ],
          ),
        )
      ],
    );
  }
}

/*
 @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        isLoading
            ? const Center(child: CircularProgressIndicator())
            : userData == null
                ? const Center(child: Text('No profile data available.'))
                : Padding(
                    padding: const EdgeInsets.all(16.0),
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.start,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Center(
                          child: CircleAvatar(
                            radius: 50,
                            backgroundColor: Colors.blueAccent,
                            child: Text(
                              userData!['name'] != null &&
                                      userData!['name'].isNotEmpty
                                  ? userData!['name'][0].toUpperCase()
                                  : '?',
                              style: const TextStyle(
                                fontSize: 40,
                                color: Colors.white,
                              ),
                            ),
                          ),
                        ),
                        const SizedBox(height: 10),
                        Center(
                          child: Text(
                            'Name: ${userData!['name'] ?? 'N/A'}',
                            style: const TextStyle(
                              fontSize: 16,
                            ),
                          ),
                        ),
                        const SizedBox(height: 10),
                        Center(
                          child: Text(
                            'Email: ${userData!['email'] ?? 'N/A'}',
                            style: const TextStyle(fontSize: 16),
                          ),
                        ),
                        const SizedBox(height: 10),
                      ],
                    ),
                  ),
      ],
    );
  }
} 
*/
