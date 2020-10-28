import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

class UserModel {
  String uid;
  String email;
  String name;
  List<String> savedProperties;

  UserModel({
    @required this.uid,
    @required this.email,
    @required this.name,
    this.savedProperties,
  });

  UserModel.fromFirebase(DocumentSnapshot document) {
    uid = document.data()['uid'];
    email = document.data()['email'];
    name = document.data()['name'];
    savedProperties = List<String>();
    if (document.data()['savedProperties'] != null) {
      document.data()['savedProperties'].forEach((id) {
        savedProperties.add(id);
      });
    }
  }

  UserModel.registerNewUser({
    @required this.uid,
    @required this.email,
    @required this.name,
  }) {
    savedProperties = List<String>();
  }
}
