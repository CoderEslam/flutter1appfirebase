import 'package:flutter/material.dart';
import 'package:flutter1appfirebase/Model/User.dart';
import 'package:flutter1appfirebase/Shared/constant.dart';
import 'package:flutter1appfirebase/services/database.dart';
import 'package:provider/provider.dart';

class SettingsForm extends StatefulWidget {
  const SettingsForm({Key? key}) : super(key: key);

  @override
  State<SettingsForm> createState() => _SettingsFormState();
}

class _SettingsFormState extends State<SettingsForm> {
  List<String> sugars = ['0', '1', '2', '3', '4', '5'];
  final _formKey = GlobalKey<FormState>();
  String _currentName = 'something';
  String _currentSugar = '0';
  late double _currentStrength = 100;

  @override
  Widget build(BuildContext context) {
    final user = Provider.of<UserModel>(context);
    return StreamBuilder<UserData>(
      stream: DatabaseService(uid: user.uid).userData,
      builder: (context, snapshot) {
        if (snapshot.hasData) {
          UserData userData = snapshot.data!;
          return Form(
            key: _formKey,
            child: Column(
              children: [
                const Text(
                  'Update your brow settings',
                  style: TextStyle(fontSize: 18.0),
                ),
                const SizedBox(
                  height: 20.0,
                ),
                TextFormField(
                  decoration: textInputDecoration,
                  validator: (val) =>
                      val!.isEmpty ? 'Please enter a name' : null,
                  onChanged: (val) => setState(() {
                    _currentName = val;
                  }),
                ),
                const SizedBox(
                  height: 20.0,
                ),
                const SizedBox(
                  height: 20.0,
                ),
                DropdownButtonFormField(
                    value: _currentSugar ?? userData.sugars,
                    items: sugars.map((sugar) {
                      return DropdownMenuItem(
                        value: sugar,
                        child: Text('$sugar sugars'),
                      );
                    }).toList(),
                    onChanged: (val) => setState(() => _currentSugar = val!)),
                const SizedBox(height: 10.0),
                Slider(
                    value: (_currentStrength ?? 100).toDouble(),
                    activeColor: Colors.brown[_currentStrength.toInt() ?? 100],
                    inactiveColor:
                        Colors.brown[_currentStrength.toInt() ?? 100],
                    min: 100.0,
                    max: 900.0,
                    divisions: 8,
                    onChanged: (val) => setState(() {
                          _currentStrength = val;
                        })),
                ElevatedButton.icon(
                    onPressed: () {
                      print(_currentName);
                      print(_currentStrength);
                      print(_currentSugar);
                    },
                    icon: const Icon(Icons.circle),
                    label: const Text('Update'))
              ],
            ),
          );
        } else {
          return const Center(
            child: Text('Empty Data'),
          );
        }
      },
    );
  }
}
