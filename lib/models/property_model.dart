import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

class PropertyModel {
  String id;
  String title;
  String address;
  String description;
  String imageUrl;

  PropertyModel({
    @required this.id,
    @required this.title,
    @required this.address,
    @required this.description,
    this.imageUrl,
  });

  PropertyModel.fromFirebase(DocumentSnapshot document) {
    id = document.id;
    title = document.data()['title'];
    address = document.data()['address'];
    description = document.data()['description'];
    imageUrl = document.data()['imageUrl'];
  }
}
