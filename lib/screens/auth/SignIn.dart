import 'package:flutter/material.dart';
import 'package:flutter1appfirebase/Shared/loading.dart';
import 'package:flutter1appfirebase/services/auth.dart';

import '../../Shared/constant.dart';

class SignIn extends StatefulWidget {
  SignIn({Key? key, required this.toggleView}) : super(key: key);

  Function toggleView;

  @override
  State<SignIn> createState() => _SignInState();
}

class _SignInState extends State<SignIn> {
  final AuthService _authService = AuthService();
  final _formKey = GlobalKey<FormState>(); // use for validation

  String email = '';
  String password = '';
  String error = '';
  bool loading = false;

  @override
  Widget build(BuildContext context) {
    return loading ? Loading() : Scaffold(
      backgroundColor: Colors.brown[100],
      appBar: AppBar(
        backgroundColor: Colors.brown[400],
        elevation: 0.0,
        title: const Text("Sign in"),
        actions: [
          TextButton.icon(
              onPressed: () {
                widget.toggleView();
              },
              icon: const Icon(Icons.person),
              label: const Text('Register'))
        ],
      ),
      body: Container(
        padding: const EdgeInsets.symmetric(horizontal: 50.0, vertical: 20.0),
        child: Form(
            key: _formKey,
            child: Column(
              children: [
                const SizedBox(
                  height: 20.0,
                ),
                TextFormField(
                  decoration: textInputDecoration.copyWith(hintText: 'Email'),
                  validator: (val) {
                    return val!.isEmpty ? 'Enter an Email' : null;
                  },
                  onChanged: (val) {
                    setState(() {
                      email = val.toString();
                    });
                  },
                ),
                const SizedBox(
                  height: 20.0,
                ),
                TextFormField(
                  decoration:
                      textInputDecoration.copyWith(hintText: 'Password'),
                  validator: (val) {
                    return val!.length < 6
                        ? 'Enter an Password 6+ chars long'
                        : null;
                  },
                  obscureText: true,
                  onChanged: (val) {
                    setState(() {
                      password = val.toString();
                    });
                  },
                ),
                const SizedBox(
                  height: 20.0,
                ),
                ElevatedButton(
                    style: ButtonStyle(
                        backgroundColor:
                            MaterialStateProperty.all(Colors.pink[400]),
                        textStyle: MaterialStateProperty.all(
                            const TextStyle(color: Colors.white))),
                    onPressed: () async {
                      setState(() {
                        loading = true;
                      });
                      if (_formKey.currentState!.validate()) {
                        dynamic user =
                            await _authService.SignInWithEmailAndPassword(
                                email, password);
                        if (user == null) {
                          setState(() {
                            error = "please supply a valid email";
                            loading = false;
                          });
                        }
                      }
                    },
                    child: const Text('Sign in')),
                const SizedBox(
                  height: 20.0,
                ),
                Text(
                  error,
                  style: const TextStyle(color: Colors.red, fontSize: 14.0),
                )
              ],
            )),
      ),
    );
  }
}
