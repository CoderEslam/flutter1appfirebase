
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter1appfirebase/Model/User.dart';

class AuthService {
  late final FirebaseAuth _auth = FirebaseAuth.instance;

  // create user object from firebase
  UserModel _userFromFirebase(User user) {
    if (user.uid.isNotEmpty) {
      return UserModel(uid: user.uid);
    } else {
      return UserModel(uid: '');
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

// register with email and password

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
