import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

class SignIn extends StatefulWidget {
  const SignIn({super.key});

  @override
  State<SignIn> createState() => _SignInState();
}

final _firebase = FirebaseAuth.instance;

class _SignInState extends State<SignIn> {
  final _emailcontroller = TextEditingController();
  final _enteredPassword = TextEditingController();
  final _formkey = GlobalKey<FormState>();

  void _onsubmit() async {
    final email = _emailcontroller.text;
    final password = _enteredPassword.text;

    final isValid = _formkey.currentState!.validate();
    if (!isValid) {
      return;
    }
    _formkey.currentState!.save();
    try {
      await _firebase.signInWithEmailAndPassword(
          email: email, password: password);
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
              child: const Text('Create new Account'),
            ),
          ],
        ),
      ),
    );
  }
}
