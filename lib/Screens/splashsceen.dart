import 'dart:async';
import 'package:disastermanagement/Screens/Auth/auth.dart';
import 'package:disastermanagement/Screens/home.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

class SplashScreenn extends StatefulWidget {
  const SplashScreenn({super.key});
  @override
  // ignore: library_private_types_in_public_api
  _SplashScreennState createState() => _SplashScreennState();
}

class _SplashScreennState extends State<SplashScreenn> {
  @override
  void initState() {
    super.initState();
    // Navigate to the home screen after a delay of 3 seconds
    Timer(const Duration(seconds: 1), () {
      Navigator.pushReplacement(
        context,
        MaterialPageRoute(builder: (context) => homeBuild),
      );
    });
  }

  @override
  Widget build(BuildContext context) {
    return const Scaffold(
      body: Center(
        child: Text(
          'Sanjeevani',
          style: TextStyle(
            fontSize: 40,
            fontWeight: FontWeight.bold,
            color: Colors.black,
          ),
        ),
      ),
    );
  }
}

Widget homeBuild = StreamBuilder(
    stream: FirebaseAuth.instance.authStateChanges(),
    builder: (context, snapshot) {
      if (snapshot.connectionState == ConnectionState.waiting) {
        return const Center(
          child: CircularProgressIndicator(),
        );
      }
      if (snapshot.hasData) {
        return const HomePage();
      }
      return const Auth();
    });
