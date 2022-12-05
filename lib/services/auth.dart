import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter1appfirebase/Model/User.dart';
import 'package:flutter1appfirebase/services/database.dart';

class AuthService {
  late final FirebaseAuth _auth = FirebaseAuth.instance;

  // create user object from firebase
  UserModel _userFromFirebase(User user) {
    if (user.uid.isNotEmpty) {
      return UserModel(user.uid);
    } else {
      return UserModel('');
    }
  }

  Stream<UserModel> get userModel {
    return _auth.authStateChanges().map((user) => _userFromFirebase(user!));
  }

// sign in anon
  Future signInAnon() async {
    try {
      /*
      * it's mean wait until make sign in anon
      * In the newest version of firebase_auth, the class @{FirebaseUser} was changed to {User}, and the class @{AuthResult} was changed to @{UserCredential}.
      * */
      UserCredential result = await _auth.signInAnonymously();
      User user = result.user!;
      return _userFromFirebase(user);
    } catch (e) {
      print(e.toString());
      return null;
    }
  }

// sign in with email and password
  Future SignInWithEmailAndPassword(String email, String password) async {
    try {
      UserCredential result = await _auth.signInWithEmailAndPassword(
          email: email, password: password);
      User? user = result.user;
      return _userFromFirebase(user!);
    } catch (e) {
      print("Error $e");
      return null;
    }
  }

// register with email and password
  Future registerWithEmailAndPassword(String email, String password) async {
    try {
      UserCredential result = await _auth.createUserWithEmailAndPassword(
          email: email, password: password);
      User? user = result.user;
      await DatabaseService(uid: user!.uid).updateUserData('0', email, 100);
      return _userFromFirebase(user!);
    } catch (e) {
      print("Error $e");
      return null;
    }
  }

// sign out

  Future signout() async {
    try {
      return await _auth.signOut();
    } catch (e) {
      print(e.toString());
      return null;
    }
  }
}
