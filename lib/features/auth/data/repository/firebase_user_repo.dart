import 'dart:developer';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:quikhyr/models/user_model.dart';

class FirebaseUserRepo {
  final FirebaseAuth _firebaseAuth;
  final usersCollection = FirebaseFirestore.instance.collection('users');

  FirebaseUserRepo({
    FirebaseAuth? firebaseAuth,
  }) : _firebaseAuth = firebaseAuth ?? FirebaseAuth.instance;

  Stream<User?> get user {
    return _firebaseAuth.authStateChanges().map((firebaseUser) {
      return firebaseUser;
    });
  }

  Future<void> signIn(String email, String password) async {
    
    try {
      await _firebaseAuth.signInWithEmailAndPassword(
        email: email, 
        password: password
      );
    } catch (e) {
      log(e.toString());
      rethrow;
    }
  }

  Future<UserModel> signUp(UserModel userModel, String password) async {
  try {
    UserCredential userCredential = await _firebaseAuth.createUserWithEmailAndPassword(
      email: userModel.email, 
      password: password
    );

    UserModel newUser = userModel.copyWith(
      id: userCredential.user!.uid,
    );

    return newUser;
  } catch (e) {
    log(e.toString());
    rethrow;
  }
}

  Future<void> setUserData(UserModel user) async {
  try {
    await usersCollection
      .doc(user.id)
      .set(user.toMap());
  } catch (e) {
    log(e.toString());
    rethrow;
  }
}

  Future<void> logOut() async {
    await _firebaseAuth.signOut();
  }
}