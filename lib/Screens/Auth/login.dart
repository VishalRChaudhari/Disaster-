import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:disastermanagement/Screens/Auth/sign_in.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

class Login extends StatefulWidget {
  const Login({super.key});

  @override
  State<Login> createState() => _LoginState();
}

final _firebase = FirebaseAuth.instance;

class _LoginState extends State<Login> {
  final _emailcontroller = TextEditingController();
  final _enteredUsername = TextEditingController();
  final _enteredPassword = TextEditingController();
  final _formkey = GlobalKey<FormState>();

  void _onsubmit() async {
    final email = _emailcontroller.text;
    final username = _enteredUsername.text;
    final password = _enteredPassword.text;
    final isValid = _formkey.currentState!.validate();
    if (!isValid) {
      return;
    }
    _formkey.currentState!.save();
    try {
      final userCrdential = await _firebase.createUserWithEmailAndPassword(
          email: email, password: password);

      await FirebaseFirestore.instance
          .collection('Users')
          .doc(userCrdential.user!.uid)
          .set({
        'name': username,
        'email': email,
      });
    } on FirebaseAuthException catch (e) {
      if (e.code == 'email-already-in-use') {}
      ScaffoldMessenger.of(context).clearSnackBars();
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text(e.message ?? 'Authentication Failed. '),
        ),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(),
      body: Form(
        key: _formkey,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            TextFormField(
              validator: (value) {
                if (value == null || value.isEmpty) {
                  return 'Email is required';
                } else if (!RegExp(r'^[\w-\.]+@([\w-]+\.)+[\w-]{2,4}$')
                    .hasMatch(value)) {
                  return 'Enter a valid email address';
                }
                return null;
              },
              controller: _emailcontroller,
              decoration: const InputDecoration(
                label: Text('Email'),
              ),
            ),
            TextFormField(
              validator: (value) {
                if (value == null || value.isEmpty) {
                  return 'Username is required';
                } else if (value.length < 3 || value.length > 30) {
                  return 'Username must be between 3 and 30 characters';
                } else if (!RegExp(r'^[a-zA-Z0-9._]+$').hasMatch(value)) {
                  return 'Username can only contain letters, numbers, underscores, and periods';
                } else if (value.startsWith('.') || value.endsWith('.')) {
                  return 'Username cannot start or end with a period';
                } else if (value.contains('..')) {
                  return 'Username cannot contain consecutive periods';
                }
                return null;
              },
              controller: _enteredUsername,
              decoration: const InputDecoration(
                label: Text('Username'),
              ),
            ),
            TextFormField(
              validator: (value) {
                if (value == null || value.isEmpty) {
                  return 'Password is required';
                } else if (value.length < 8) {
                  return 'Password must be at least 8 characters';
                } else if (!RegExp(r'(?=.*[A-Z])').hasMatch(value)) {
                  return 'Password must contain at least one uppercase letter';
                } else if (!RegExp(r'(?=.*[a-z])').hasMatch(value)) {
                  return 'Password must contain at least one lowercase letter';
                } else if (!RegExp(r'(?=.*\d)').hasMatch(value)) {
                  return 'Password must contain at least one digit';
                } else if (!RegExp(r'(?=.*[@$!%*?&])').hasMatch(value)) {
                  return 'Password must contain at least one special character';
                }
                return null;
              },
              controller: _enteredPassword,
              decoration: const InputDecoration(
                label: Text('Password'),
              ),
            ),
            const SizedBox(
              height: 10,
            ),
            ElevatedButton(
              onPressed: _onsubmit,
              child: const Text('Login'),
            ),
            TextButton(
              onPressed: () {
                Navigator.of(context).push(
                  MaterialPageRoute(
                    builder: (context) => const SignIn(),
                  ),
                );
              },
              child: const Text('Already have an account'),
            ),
          ],
        ),
      ),
    );
  }
}
