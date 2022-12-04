import 'package:flutter/material.dart';
import 'package:flutter1appfirebase/services/auth.dart';

class Home extends StatelessWidget {
  Home({Key? key}) : super(key: key);

  final AuthService _authService = AuthService();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.brown[50],
      appBar: AppBar(
        title: Text('Home'),
        backgroundColor: Colors.brown[400],
        elevation: 0.0,
        actions: [
          TextButton.icon(
              onPressed: () async {
                await _authService.signout();
              },
              icon: const Icon(Icons.person),
              label: const Text('logout'))
        ],
      ),
    );
  }
}
