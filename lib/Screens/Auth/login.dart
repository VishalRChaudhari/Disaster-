import 'package:cloud_firestore/cloud_firestore.dart';
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
  final _formkey = GlobalKey();

  void _onsubmit() async {
    final email = _emailcontroller.text;
    final username = _enteredUsername.text;
    final password = _enteredPassword.text;

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
              onChanged: (value){
                    
              },
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
              controller: _enteredUsername,
              decoration: const InputDecoration(
                label: Text('Username'),
              ),
            ),
            TextFormField(
              controller: _enteredPassword,
              decoration: const InputDecoration(
                label: Text('Password'),
              ),
            ),
            TextButton(
              onPressed: _onsubmit,
              child: const Text('Login'),
            ),
          ],
        ),
      ),
    );
  }
}
