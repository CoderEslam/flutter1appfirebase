import 'package:flutter/material.dart';
import 'package:flutter1appfirebase/Model/User.dart';
import 'package:flutter1appfirebase/screens/Home/Home.dart';
import 'package:flutter1appfirebase/screens/auth/Authantication.dart';
import 'package:provider/provider.dart';

class Wrapper extends StatelessWidget {
  const Wrapper({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    // to use data from provider or to access data from provider
    final user = Provider.of<UserModel>(context);
    print("USER => " + user.uid);
    //return either Home or Auth Widget
    if (user.uid!='') {
      return Home();
    } else {
      return Authantication();
    }
  }
}
