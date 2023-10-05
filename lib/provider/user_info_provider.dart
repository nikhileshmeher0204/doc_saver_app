import 'dart:ffi';

import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:flutter/material.dart';

class UserInfoProvider extends ChangeNotifier {
  String _username = "";
  String get username => _username;
  final FirebaseDatabase _firebaseDatabase = FirebaseDatabase.instance;
  User? get user => FirebaseAuth.instance.currentUser;
  getUserName() async {
    await _firebaseDatabase
        .ref()
        .child("user_info/${user!.uid}")
        .get()
        .then((value) {
      print(value.value);
      _username = (value.value as Map)["username"].toString();
      notifyListeners();
    });
  }

  updateUserName(String username, BuildContext context) async {
    await _firebaseDatabase
        .ref()
        .child("user_info/${user!.uid}").update({"username": username}).then((value) {
          _username = username;
          notifyListeners();
          Navigator.of(context).pop();
    });

  }
}
