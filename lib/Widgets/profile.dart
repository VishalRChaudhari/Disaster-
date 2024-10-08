import 'package:flutter/material.dart';

class ProfilePage extends StatefulWidget {
  const ProfilePage({super.key});

  @override
  State<ProfilePage> createState() => _ProfilePageState();
}

class _ProfilePageState extends State<ProfilePage> {
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Column(children: [
        // Profile Picture (Optional)
        CircleAvatar(
          radius: 70.0,
          backgroundImage: const AssetImage(
              'assets/profile_pic.png'), // Replace with your image path
          backgroundColor: Colors.grey[200],
        ),
        const SizedBox(height: 15),

        // Username
        const Text('Vishal'),
        const SizedBox(
          height: 5,
        ),
        // Email ID
        const Text('vishalchaudhari7800@gmai.com'),
        const SizedBox(
          height: 5,
        ),
        // Mobile Number
        const Text('9923080241'),
      ]),
    );
  }
}
