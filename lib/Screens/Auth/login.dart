import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

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
    void _submitForm() {
      if (_formKey.currentState!.validate()) {
        _formKey.currentState!.save();
        // Perform log-in action here with the collected data
        print('Email: $_email');
        print('Password: $_password');
      }
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
                  decoration: InputDecoration(labelText: 'Email'),
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
                  decoration: InputDecoration(labelText: 'Password'),
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
                    child: Text('Log In'),
                  ),
                ),

                // Sign Up Text Button
                TextButton(
                  onPressed: () {
                    // Navigate to Sign-Up page or perform some action
                    print('Navigate to Sign-Up Page');
                  },
                  child: Text('Don’t have an account? Sign Up'),
                ),
              ],
            ),
          ),
        ));
  }
}
