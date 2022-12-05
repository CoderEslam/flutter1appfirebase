import 'package:flutter/material.dart';
import 'package:flutter1appfirebase/screens/auth/Reigster.dart';
import 'package:flutter1appfirebase/screens/auth/SignIn.dart';

class Authantication extends StatefulWidget {
  const Authantication({Key? key}) : super(key: key);

  @override
  State<Authantication> createState() => _AuthanticationState();
}

class _AuthanticationState extends State<Authantication> {
  bool showSignin = true;

  void toggleView() {
    setState(() => showSignin =
        !showSignin); // => !showSignin => this make traverse f value => عكس القيمه الموجوده
  }

  @override
  Widget build(BuildContext context) {
    if (showSignin) {
      return SignIn(toggleView: toggleView);
    } else {
      return Register(toggleView: toggleView);
    }
  }
}
