import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

class Auth extends StatefulWidget {
  const Auth({super.key});

  @override
  State<Auth> createState() => _AuthState();
}

final _firebase = FirebaseAuth.instance;

class _AuthState extends State<Auth> {
  final _emailcontroller = TextEditingController();
  final _enteredUsername = TextEditingController();
  final _enteredPassword = TextEditingController();
  final _formkey = GlobalKey<FormState>();
  var isSignin = false;
  @override
  void dispose() {
    _emailcontroller.dispose();
    _enteredPassword.dispose();
    _enteredUsername.dispose();

    super.dispose();
  }

  void _onLogin() async {
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

  void _onSignIn() async {
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
      ScaffoldMessenger.of(context).clearSnackBars();
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text(e.message ?? 'Authentication Failed. '),
        ),
      );
    }
  }

  void toggleSignIn() {
    setState(() {
      _formkey.currentState?.reset();
      _emailcontroller.clear();
      _enteredPassword.clear();
      _enteredUsername.clear();
      isSignin = !isSignin;
    });
  }

  bool _isPasswordVisible = false;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(),
      body: Padding(
        padding: const EdgeInsets.all(16),
        child: Form(
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
                decoration: InputDecoration(
                  labelText: 'Email',
                  prefixIcon: const Icon(Icons.email),
                  hintText: 'Enter your email',
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(24),
                  ),
                  focusedBorder: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(24),
                    borderSide:
                        const BorderSide(color: Colors.blueAccent, width: 2.0),
                  ),
                  errorBorder: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(10.0),
                    borderSide: const BorderSide(color: Colors.red, width: 2.0),
                  ),
                  contentPadding: const EdgeInsets.symmetric(
                      vertical: 15.0, horizontal: 10.0),
                ),
                style: const TextStyle(fontSize: 16),
              ),
              if (!isSignin)
                const SizedBox(
                  height: 10,
                ),
              if (!isSignin)
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
                  decoration: InputDecoration(
                    labelText: 'Username',
                    prefixIcon: const Icon(Icons.person),
                    hintText: 'Enter your username',
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(24),
                    ),
                    focusedBorder: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(24),
                      borderSide: const BorderSide(
                          color: Colors.blueAccent, width: 2.0),
                    ),
                    errorBorder: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(10.0),
                      borderSide:
                          const BorderSide(color: Colors.red, width: 2.0),
                    ),
                    contentPadding: const EdgeInsets.symmetric(
                        vertical: 15.0, horizontal: 10.0),
                  ),
                  style: const TextStyle(fontSize: 16),
                ),
              const SizedBox(
                height: 10,
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
                obscureText: !_isPasswordVisible, // Toggle visibility
                decoration: InputDecoration(
                  labelText: 'Password',
                  prefixIcon: const Icon(Icons.lock),
                  hintText: 'Enter your password',
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(24),
                  ),
                  focusedBorder: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(24.0),
                    borderSide:
                        const BorderSide(color: Colors.blueAccent, width: 2.0),
                  ),
                  errorBorder: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(10.0),
                    borderSide: const BorderSide(color: Colors.red, width: 2.0),
                  ),
                  contentPadding: const EdgeInsets.symmetric(
                      vertical: 15.0, horizontal: 10.0),
                  suffixIcon: IconButton(
                    icon: Icon(
                      _isPasswordVisible
                          ? Icons.visibility
                          : Icons.visibility_off,
                    ),
                    onPressed: () {
                      setState(() {
                        _isPasswordVisible = !_isPasswordVisible;
                      });
                    },
                  ),
                ),
                style: const TextStyle(fontSize: 16),
              ),
              const SizedBox(
                height: 10,
              ),
              ElevatedButton(
                onPressed: isSignin ? _onSignIn : _onLogin,
                child: Text(isSignin ? 'Sign In' : 'Login'),
              ),
              TextButton(
                onPressed: toggleSignIn,
                child: Text(
                    isSignin ? 'Create an account' : 'Already have an account'),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
