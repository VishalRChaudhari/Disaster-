import 'package:disastermanagement/Screens/Auth/SignIn.dart';
import 'package:disastermanagement/Screens/home.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

final _Firebase = FirebaseAuth.instance;

class LogIN extends StatefulWidget {
  const LogIN({super.key});

  @override
  State<LogIN> createState() => _LogINState();
}

class _LogINState extends State<LogIN> {
  final _formKey = GlobalKey<FormState>();
  String _email = '';
  String _password = '';

  @override
  Widget build(BuildContext context) {
    void _submitForm() async {
      final _isValid = _formKey.currentState!.validate();
      if (!_isValid) {
        return;
      }
      _formKey.currentState!.save();

      final userCredentials = await _Firebase.signInWithEmailAndPassword(
          email: _email, password: _password);
      // Perform log-in action here with the collected data
      
      
    }

    return Scaffold(
        appBar: AppBar(
          title: Text('Log'),
        ),
        body: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Form(
            key: _formKey,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                // Email Field
                TextFormField(
                  decoration: const InputDecoration(labelText: 'Email'),
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return 'Please enter your email';
                    }
                    if (!RegExp(r'^[^@]+@[^@]+\.[^@]+').hasMatch(value)) {
                      return 'Please enter a valid email address';
                    }
                    return null;
                  },
                  onSaved: (value) {
                    _email = value!;
                  },
                ),

                // Password Field
                TextFormField(
                  decoration: const InputDecoration(labelText: 'Password'),
                  obscureText: true,
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return 'Please enter your password';
                    }
                    return null;
                  },
                  onSaved: (value) {
                    _password = value!;
                  },
                ),

                // Log In Button (Cupertino Style)
                Padding(
                  padding: const EdgeInsets.symmetric(vertical: 16.0),
                  child: CupertinoButton(
                    color: Colors.blue,
                    onPressed: _submitForm,
                    child: const Text('Log In'),
                  ),
                ),

                // Sign Up Text Button
                TextButton(
                  onPressed: () {
                    // Navigate to Sign-Up page or perform some action
                    Navigator.of(context).push(MaterialPageRoute(
                      builder: (context) => SignIn(),
                    ));
                  },
                  child: const Text('Don’t have an account? Sign Up'),
                ),
              ],
            ),
          ),
        ));
  }
}
