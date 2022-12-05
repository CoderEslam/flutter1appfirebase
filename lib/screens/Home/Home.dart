import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter1appfirebase/Model/User.dart';
import 'package:flutter1appfirebase/Model/brew.dart';
import 'package:flutter1appfirebase/screens/Home/BrewList.dart';
import 'package:flutter1appfirebase/services/auth.dart';
import 'package:flutter1appfirebase/services/database.dart';
import 'package:provider/provider.dart';

class Home extends StatelessWidget {
  Home({Key? key}) : super(key: key);

  final AuthService _authService = AuthService();

  @override
  Widget build(BuildContext context) {
    final user = Provider.of<UserModel>(context);
    return StreamProvider<QuerySnapshot?>.value(
      value: DatabaseService(uid: user.uid).data,
      initialData: null,
      child: Scaffold(
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
        body: const BrewList(),
      ),
    );
  }
}
