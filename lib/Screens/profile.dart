import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:disastermanagement/Screens/about_us.dart';
import 'package:disastermanagement/Screens/home.dart';
import 'package:disastermanagement/Screens/refer_us.dart';
import 'package:disastermanagement/Screens/helpline.dart';
import 'package:disastermanagement/data/profile_data.dart';
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
  String _name = "Loading...";
  String _email = "Loading...";

  @override
  void initState() {
    super.initState();
    fetchUserProfile();
    _loadProfile();
  }

  Future<void> _loadProfile() async {
    var profileData = await ProfileData.getProfile();
    setState(() {
      _name = profileData['name'] ?? "No Name";
      _email = profileData['email'] ?? "No Email";
    });
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
            ? const Center(
                child: CircularProgressIndicator(),
              )
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
                              radius: 40,
                              backgroundColor:
                                  Theme.of(context).colorScheme.primary,
                              child: Text(
                                userData!['name'] != null &&
                                        userData!['name'].isNotEmpty
                                    ? userData!['name'][0].toUpperCase()
                                    : '?',
                                style: const TextStyle(
                                  fontSize: 35,
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
                                  ' ${userData!['name'] ?? _name}',
                                  style: const TextStyle(
                                    fontSize: 20,
                                  ),
                                ),
                                Center(
                                  child: Text(
                                    ' ${userData!['email'] ?? _email}',
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
              const SizedBox(height: 10),
              ListTile(
                onTap: () {
                  Navigator.of(context).pushReplacement(
                    MaterialPageRoute(
                      builder: (context) => HomePage(),
                    ),
                  );
                },
                leading: Icon(
                  Icons.home,
                  size: 20,
                ),
                title: Text(
                  'Home',
                  style: TextStyle(
                    fontSize: 16,
                  ),
                ),
              ),
              Divider(
                height: 0.5,
                indent: 15,
                endIndent: 15,
                color: Theme.of(context).colorScheme.secondary,
                thickness: 0.5,
              ),
              ListTile(
                onTap: () {
                  Navigator.of(context).push(
                    MaterialPageRoute(
                      builder: (context) => Scaffold(
                        appBar: AppBar(
                          title: Text('Helplines'),
                          elevation: 4,
                        ),
                        body: SingleChildScrollView(child: HelpCard()),
                      ),
                    ),
                  );
                },
                leading: Icon(
                  Icons.phone,
                  size: 20,
                ),
                title: Text(
                  'Helplines',
                  style: TextStyle(
                    fontSize: 16,
                  ),
                ),
              ),
              Divider(
                height: 0.5,
                indent: 15,
                endIndent: 15,
                color: Theme.of(context).colorScheme.secondary,
                thickness: 0.5,
              ),
              ListTile(
                leading: Icon(
                  Icons.rule,
                  size: 20,
                ),
                title: Text(
                  "Dos & Don'ts",
                  style: TextStyle(
                    fontSize: 16,
                  ),
                ),
              ),
              Divider(
                height: 0.5,
                indent: 15,
                endIndent: 15,
                color: Theme.of(context).colorScheme.secondary,
                thickness: 0.5,
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
                  size: 20,
                ),
                title: Text(
                  'Refer Us',
                  style: TextStyle(
                    fontSize: 16,
                  ),
                ),
              ),
              Divider(
                height: 0.5,
                indent: 15,
                endIndent: 15,
                color: Theme.of(context).colorScheme.secondary,
                thickness: 0.5,
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
                  size: 20,
                ),
                title: Text(
                  'About Us',
                  style: TextStyle(
                    fontSize: 16,
                  ),
                ),
              ),
              Divider(
                height: 0.5,
                indent: 15,
                endIndent: 15,
                color: Theme.of(context).colorScheme.secondary,
                thickness: 0.5,
              ),
              ListTile(
                leading: Icon(
                  Icons.logout,
                  size: 20,
                ),
                title: Text(
                  'Log Out',
                  style: TextStyle(
                    fontSize: 16,
                  ),
                ),
                onTap: () {
                  FirebaseAuth.instance.signOut();
                },
              ),
              Divider(
                height: 0.5,
                indent: 15,
                endIndent: 15,
                color: Theme.of(context).colorScheme.secondary,
                thickness: 0.5,
              ),
            ],
          ),
        )
      ],
    );
  }
}
