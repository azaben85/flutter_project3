import 'dart:developer';

import 'package:firebase_auth/firebase_auth.dart';

class AuthHelper {
  AuthHelper._();
  static AuthHelper authHelper = AuthHelper._();
  FirebaseAuth firebaseAuth = FirebaseAuth.instance;

  Future<String?> signUp(String email, String password) async {
    try {
      UserCredential userCredential = await firebaseAuth
          .createUserWithEmailAndPassword(email: email, password: password);
      return userCredential.user?.uid;
      // return true;
    } on Exception catch (error) {
      log(error.toString());
    }
  }

  Future<String?> signIn(String email, String password) async {
    try {
      UserCredential userCredential = await firebaseAuth
          .signInWithEmailAndPassword(email: email, password: password);
      log('Sign In Success');
      return userCredential.user?.uid;
    } on Exception catch (error) {
      log(error.toString());
    }
  }

  String? getUser() {
    User? user = firebaseAuth.currentUser;

    return user?.uid;
  }

  User? getLoggedUser() {
    User? user = firebaseAuth.currentUser;

    return user;
  }

  signOut() async {
    await firebaseAuth.signOut();
  }

  resetPassword(String email) async {}
  verifyEmail(String email) async {}
}
