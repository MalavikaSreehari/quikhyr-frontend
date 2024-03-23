import 'dart:developer';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:quikhyr/models/client_model.dart';

class FirebaseUserRepo {
  final FirebaseAuth _firebaseAuth;
  final usersCollection = FirebaseFirestore.instance.collection('clients');

  FirebaseUserRepo({
    FirebaseAuth? firebaseAuth,
  }) : _firebaseAuth = firebaseAuth ?? FirebaseAuth.instance;

  Stream<User?> get user {
    return _firebaseAuth.authStateChanges().map((firebaseUser) {
      return firebaseUser;
    });
  }

  Future<String> getCurrentUserId() async {
    return _firebaseAuth.currentUser?.uid ?? 'userIdNotFound';
  }

  Future<void> signIn(String email, String password) async {
    try {
      await _firebaseAuth.signInWithEmailAndPassword(
          email: email, password: password);
    } catch (e) {
      log(e.toString());
      rethrow;
    }
  }

  Future<ClientModel> signUp(ClientModel userModel, String password) async {
    try {
      UserCredential userCredential =
          await _firebaseAuth.createUserWithEmailAndPassword(
              email: userModel.email, password: password);

      ClientModel newUser = userModel.copyWith(
        id: userCredential.user!.uid,
      );

      return newUser;
    } catch (e) {
      log(e.toString());
      rethrow;
    }
  }

  Future<void> setUserData(ClientModel user) async {
    try {
      await usersCollection.doc(user.id).set(user.toMap());
    } catch (e) {
      log(e.toString());
      rethrow;
    }
  }

  Future<void> logOut() async {
    await _firebaseAuth.signOut();
  }
}
