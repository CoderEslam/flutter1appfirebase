import 'package:flutter/material.dart';
import 'package:flutter1appfirebase/Model/User.dart';
import 'package:flutter1appfirebase/screens/wrapper.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter1appfirebase/services/auth.dart';
import 'package:provider/provider.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    FirebaseOptions firebaseOptions = const FirebaseOptions(
        apiKey: 'AIzaSyD0yGAIw0Mtx_89PnWOWjYgug0RQVsuUHA',
        appId: '1:690341637278:web:355737232020fd271cdf8f',
        messagingSenderId: '690341637278',
        projectId: 'flutter1appfirebase',
        authDomain: 'flutter1appfirebase.firebaseapp.com',
        storageBucket: 'flutter1appfirebase.appspot.com',
        measurementId: 'G-Y8KBBQF9LD');

    const firebaseOption = {
      'apiKey': "AIzaSyD0yGAIw0Mtx_89PnWOWjYgug0RQVsuUHA",
      'authDomain': "flutter1appfirebase.firebaseapp.com",
      'projectId': "flutter1appfirebase",
      'storageBucket': "flutter1appfirebase.appspot.com",
      'messagingSenderId': "690341637278",
      'appId': "1:690341637278:web:355737232020fd271cdf8f",
      'measurementId': "G-Y8KBBQF9LD"
    };

    return FutureBuilder<FirebaseApp>(
      future: Firebase.initializeApp(options: firebaseOptions),
      builder: (BuildContext context, AsyncSnapshot<FirebaseApp> snapshot) {
        return StreamProvider<UserModel>.value(
            value: AuthService().userModel,
            initialData: UserModel(''),
            child: const App());
      },
    );
  }
}

class App extends StatelessWidget {
  const App({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Firebase',
      theme: ThemeData(
        // This is the theme of your application.
        //
        // Try running your application with "flutter run". You'll see the
        // application has a blue toolbar. Then, without quitting the app, try
        // changing the primarySwatch below to Colors.green and then invoke
        // "hot reload" (press "r" in the console where you ran "flutter run",
        // or simply save your changes to "hot reload" in a Flutter IDE).
        // Notice that the counter didn't reset back to zero; the application
        // is not restarted.
        primarySwatch: Colors.blue,
      ),
      home: const Wrapper(),
    );
  }
}
