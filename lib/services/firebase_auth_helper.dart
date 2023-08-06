import 'dart:async';

import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:pacific_gym/services/db.dart';
import 'package:pacific_gym/utils/utils.dart';
import 'package:shared_preferences/shared_preferences.dart';

class AuthHelper {
  Stream<User?> get onAuthStateChanged {
    return FirebaseAuth.instance.authStateChanges();
  }

  void signUp(String name, String email, String password, context) async {
    try {
      UserCredential userCredential = await FirebaseAuth.instance
          .createUserWithEmailAndPassword(email: email, password: password);
      DateTime date = DateTime.now();
      await DatabaseService().addUser(name, email, password, date, context);
      SharedPreferences prefs = await SharedPreferences.getInstance();
      await prefs.setString("logged_in", email);

      // Utils().snackBar(context, "Dear " + name + ",you are signed up!");
      // Navigator.of(context).pushReplacement(
      //     MaterialPageRoute(builder: (context) => const HomePage()));
    } on FirebaseAuthException catch (e) {
      if (e.code == 'weak-password') {
        Utils().snackBar(context, 'The password provided is too weak.');
      } else if (e.code == 'email-already-in-use') {
        Utils().snackBar(context, 'The account already exists for that email.');
      }
    } catch (e) {
      print(e);
    }
  }

  void logIn(String email, String password, context) async {
    try {
      UserCredential userCredential = await FirebaseAuth.instance
          .signInWithEmailAndPassword(email: email, password: password);
      SharedPreferences prefs = await SharedPreferences.getInstance();
      await prefs.setString("logged_in", email);

      // Utils().snackBar(context, "Logged In successfully!");
      // Navigator.of(context).pushReplacement(
      //     MaterialPageRoute(builder: (context) => const HomePage()));
    } on FirebaseAuthException catch (e) {
      if (e.code == 'user-not-found') {
        Utils().snackBar(context, "No user found for that email.");
      } else if (e.code == 'wrong-password') {
        Utils().snackBar(context, 'Wrong password provided for that user.');
      }
    }
  }

  void logOut(context) async {
    await FirebaseAuth.instance.signOut();
    SharedPreferences prefs = await SharedPreferences.getInstance();
    prefs.remove('logged_in');
    // Navigator.of(context)
    //     .pushReplacement(MaterialPageRoute(builder: (context) => IntroPage()));
  }

  void switchAccount(context) async {
    // await FirebaseAuth.instance.signOut();
    // SharedPreferences prefs = await SharedPreferences.getInstance();
    AuthHelper().logIn("pacificbranch1@gmail.com", "branch1", context);
    // await prefs.setString("switch-acc", "pacificbranch1@gmail.com-branch1");
    // await prefs.setString("switch-acc", "keyur4tech123@gmail.com-keyur123");
  }
}
