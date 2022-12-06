import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter1appfirebase/Model/User.dart';
import 'package:flutter1appfirebase/Shared/constant.dart';
import 'package:flutter1appfirebase/services/database.dart';
import 'package:provider/provider.dart';

import '../../Shared/loading.dart';

class SettingsForm extends StatefulWidget {
  const SettingsForm({Key? key}) : super(key: key);

  @override
  State<SettingsForm> createState() => _SettingsFormState();
}

class _SettingsFormState extends State<SettingsForm> {
  List<String> sugars = ['0', '1', '2', '3', '4', '5'];
  final List<int> strengths = [100, 200, 300, 400, 500, 600, 700, 800, 900];

  final _formKey = GlobalKey<FormState>();
  String _currentName = 'something';
  String _currentSugar = '0';
  late double _currentStrength = 100;

  @override
  Widget build(BuildContext context) {
    UserModel user = Provider.of<UserModel>(context);
    dynamic val;
    return Scaffold(
      body: StreamBuilder(
          stream: FirebaseFirestore.instance
              .collection('brews')
              .doc(user.uid)
              .snapshots(),
          builder: (context, snapshot) {
            if (snapshot.hasData) {
              // UserData? userData = snapshot.data as UserData?;
              snapshot.data!.data()!.forEach((key, value) {
                val = value;
              });
              return Form(
                key: _formKey,
                child: Column(
                  children: [
                    const Text(
                      'Update your brew settings.',
                      style: TextStyle(fontSize: 18.0),
                    ),
                    const SizedBox(height: 20.0),
                    TextFormField(
                      initialValue: val!,
                      decoration: textInputDecoration,
                      validator: (val) =>
                          val!.isEmpty ? 'Please enter a name' : null,
                      onChanged: (val) => setState(() => _currentName = val),
                    ),
                    const SizedBox(height: 10.0),
                    DropdownButtonFormField(
                      value: _currentSugar,
                      decoration: textInputDecoration,
                      items: sugars.map((sugar) {
                        return DropdownMenuItem(
                          value: sugar,
                          child: Text('$sugar sugars'),
                        );
                      }).toList(),
                      onChanged: (val) => setState(() => _currentSugar = val!),
                    ),
                    const SizedBox(height: 10.0),
                    Slider(
                      value: _currentStrength,
                      activeColor: Colors.brown[_currentStrength.toInt()],
                      inactiveColor: Colors.brown[_currentStrength.toInt()],
                      min: 100.0,
                      max: 900.0,
                      divisions: 8,
                      onChanged: (val) => setState(
                          () => _currentStrength = val),
                    ),
                    ElevatedButton(
                        child: const Text(
                          'Update',
                          style: TextStyle(color: Colors.white),
                        ),
                        onPressed: () async {
                          if (_formKey.currentState!.validate()) {
                            await DatabaseService(uid: user.uid).updateUserData(
                                _currentSugar,
                                _currentName,
                                _currentStrength.toInt() ?? 100);
                            Navigator.pop(context);
                          }
                        }),
                  ],
                ),
              );
            } else {
              return const Loading();
            }
          }),
    );
  }
}
