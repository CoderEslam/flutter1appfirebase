import 'dart:math';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter1appfirebase/Model/User.dart';
import 'package:flutter1appfirebase/Model/brew.dart';

class DatabaseService {
  final String uid;

  DatabaseService({required this.uid});

  // collection from firestore
  final CollectionReference<Map<String, dynamic>> reference =
      FirebaseFirestore.instance.collection('brews');

  Future<void> updateUserData(String sugars, String name, int strength) async {
    return await reference
        .doc(uid)
        .set({'name': name, 'sugars': sugars, 'strength': strength});
  }

  // Stream == LiveData
  Stream<List<Brew>> get data {
    return reference.snapshots().map((event) {
      return _brewListFromSnapShot(event);
    });
  }

// brew list? from snapshot
  List<Brew> _brewListFromSnapShot(
      QuerySnapshot<Map<String, dynamic>> querySnapshot) {
    return querySnapshot.docs.map((doc) {
      return Brew(
          name: doc.data()['name'],
          sugars: doc.data()['sugars'],
          strength: doc.data()['strength']);
    }).toList();
  }

  // get user doc stream
  Stream<UserData> get userData {
    return reference
        .doc(uid)
        .snapshots()
        .map((event) => _userDataFromSnapshot(event));
  }

  // use data from snapshot
  UserData _userDataFromSnapshot(DocumentSnapshot documentSnapshot) {
    Map<String, dynamic> map = documentSnapshot.data() as Map<String, dynamic>;
    print("_userDataFromSnapshot $map");
    UserData userData = UserData(
        uid: uid,
        name: map['name'],
        sugars: map['sugars'],
        strength: map['strength']);
    return userData;
  }
}
