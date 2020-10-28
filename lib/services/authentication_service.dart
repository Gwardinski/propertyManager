import 'dart:async';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:property_manager/models/user_model.dart';
import 'package:rxdart/rxdart.dart';

class AuthenticationService {
  final FirebaseAuth _auth = FirebaseAuth.instance;
  final CollectionReference _usersCollection = FirebaseFirestore.instance.collection('users');
  String authId;

  Stream<User> _authStream;
  Stream<UserModel> userStream;
  UserModel userModel;

  AuthenticationService() {
    _authStream = _auth.authStateChanges();
    userStream = _authStream.switchMap((User fbUser) {
      if (fbUser != null) {
        return _usersCollection.doc(fbUser.uid).snapshots().map((user) {
          userModel = UserModel.fromFirebase(user);
          return userModel;
        });
      } else {
        userModel = null;
        return null;
      }
    });
  }

  Future signOut() async {
    try {
      return await _auth.signOut();
    } catch (e) {
      print(e);
      return null;
    }
  }

  Future<void> registerWithEmailAndPassword({
    String email,
    String password,
    String displayName,
  }) async {
    try {
      UserCredential res = await _auth.createUserWithEmailAndPassword(
        email: email,
        password: password,
      );
      UserModel newUser = UserModel.registerNewUser(
        email: email,
        name: displayName,
        uid: res.user.uid,
      );
      updateUserDataOnFirebase(newUser);
    } catch (e) {
      print(e);
      throw Exception();
    }
  }

  Future<void> signInWithEmailAndPassword({
    String email,
    String password,
  }) async {
    try {
      await _auth.signInWithEmailAndPassword(
        email: email,
        password: password,
      );
    } catch (e) {
      print(e);
      throw Exception();
    }
  }

  Future<DocumentSnapshot> getUserFromUsersCollectionUsingUID(uid) async {
    try {
      return await _usersCollection.doc(uid).get();
    } catch (e) {
      print(e);
      return null;
    }
  }

  Future updateUserDataOnFirebase(UserModel userModel) async {
    return await _usersCollection.doc(userModel.uid).set({
      "uid": userModel.uid,
      "name": userModel.name,
      "email": userModel.email,
      "savedProperties": userModel.savedProperties,
    });
  }

  Future<void> addRemoveProperty(String id) async {
    UserModel updatedUserModel = userModel;
    List<String> propertyIds = updatedUserModel.savedProperties;
    propertyIds.contains(id) ? propertyIds.remove(id) : propertyIds.add(id);
    updatedUserModel.savedProperties = propertyIds;
    return updateUserDataOnFirebase(updatedUserModel);
  }
}
