import 'dart:ffi';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter1appfirebase/Model/brew.dart';

class DatabaseService {
  final String uid;

  DatabaseService({required this.uid});

  // collection from firestore
  final CollectionReference reference =
      FirebaseFirestore.instance.collection('brews');

  Future<void> updateUserData(String sugars, String name, int strength) async {
    return await reference
        .doc(uid)
        .set({'name': name, 'sugars': sugars, 'strength': strength});
  }

  // Stream == LiveData
  Stream<QuerySnapshot> get data {
    return reference.snapshots();
  }

// brew list? from snapshot
  List<Brew> _brewListFromSnapShot(QuerySnapshot querySnapshot) {
    return querySnapshot.docs.map((doc) {
      return Brew(
          name: doc.data().toString(),
          sugars: doc.data().toString(),
          strength: 12);
    }).toList();
  }
}
