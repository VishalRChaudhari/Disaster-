import 'package:disastermanagement/Screens/Auth/login.dart';
import 'package:disastermanagement/Screens/home.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class SignIn extends StatefulWidget {
  const SignIn({super.key});

  @override
  State<SignIn> createState() => _SignInState();
}

class _SignInState extends State<SignIn> {
  final _formKey = GlobalKey<FormState>();
  String _username = '';
  String _email = '';
  String _password = '';
  DateTime _dob = DateTime.now();
  String _homeAddress = '';

  @override
  Widget build(BuildContext context) {
    Future<void> _selectDate() async {
      final DateTime? picked = await showDatePicker(
        context: context,
        initialDate: _dob,
        firstDate: DateTime(1900),
        lastDate: DateTime.now(),
      );
      if (picked != null && picked != _dob) {
        setState(() {
          _dob = picked;
        });
      }
    }

    // Submit Form Method
    void _submitForm() {
      if (_formKey.currentState!.validate()) {
        _formKey.currentState!.save();
        // Perform sign-in action here with the collected data
        print('Username: $_username');
        print('Email: $_email');
        print('Password: $_password');
        print('Date of Birth: $_dob');
        print('Home Address: $_homeAddress');

        Navigator.of(context)
            .push(MaterialPageRoute(builder: (ctx) => HomePage()));
      }
    }

    return Scaffold(
      appBar: AppBar(
        title: Text('Sign In'),
        elevation: 1.0,
      ),
      body: Center(
        child: Padding(
          padding: const EdgeInsets.only(left: 12, right: 12, bottom: 12),
          child: Form(
            key: _formKey,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                // Username Field
                TextFormField(
                  decoration: const InputDecoration(labelText: 'Username'),
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return 'Please enter your username';
                    }
                    return null;
                  },
                  onSaved: (value) {
                    _username = value!;
                  },
                ),

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

                // Date of Birth Field with DatePicker
                ListTile(
                  title: Text("Date of Birth: ${_dob.toLocal()}".split(' ')[0]),
                  trailing: Icon(Icons.calendar_today),
                  onTap: _selectDate,
                ),

                // Home Address (Optional)
                TextFormField(
                  decoration:
                      InputDecoration(labelText: 'Home Address (Optional)'),
                  onSaved: (value) {
                    _homeAddress = value ?? '';
                  },
                ),

                // Sign In Button (Cupertino Style)
                Padding(
                  padding: const EdgeInsets.symmetric(vertical: 16.0),
                  child: CupertinoButton(
                    color: Colors.blue,
                    onPressed: _submitForm,
                    child: Text('Sign In'),
                  ),
                ),

                // Log In Text Button
                TextButton(
                  onPressed: () {
                    // Navigate to Log In page or perform some action
                    Navigator.of(context).push(MaterialPageRoute(
                      builder: (context) => const LogIN(),
                    ));
                  },
                  child: const Text('Already have an account? Log In'),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
