import 'package:flutter/material.dart';
import 'package:flutter1appfirebase/services/auth.dart';

class SignIn extends StatefulWidget {
  const SignIn({Key? key}) : super(key: key);

  @override
  State<SignIn> createState() => _SignInState();
}

class _SignInState extends State<SignIn> {
  final AuthService _authService = AuthService();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.brown[100],
      appBar: AppBar(
        backgroundColor: Colors.brown[400],
        elevation: 0.0,
        title: const Text("Sign in"),
      ),
      body: Container(
        padding: const EdgeInsets.symmetric(horizontal: 50.0, vertical: 20.0),
        child: ElevatedButton(
          onPressed: () async {
            dynamic result = await _authService.signInAnon();
            if (result == null) {
              print('Error Sign in');
            } else {
              print('sign in');
              print(result.uid);
            }
          },
          child: const Text('Sign in anon'),
        ),
      ),
    );
  }
}