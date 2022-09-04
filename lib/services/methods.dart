// ignore_for_file: avoid_print

import 'package:chat_app/view/Auth/login_page.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

Future<User?> createAccount(
    String name, String email, String password, String country) async {
  FirebaseAuth auth = FirebaseAuth.instance;
  FirebaseFirestore firebaseFirestore = FirebaseFirestore.instance;
  try {
    User? user = (await auth.createUserWithEmailAndPassword(
            email: email, password: password))
        .user;
    if (user != null) {
      await firebaseFirestore
          .collection('users')
          .doc(auth.currentUser!.uid)
          .set({
        "name": name,
        "email": email,
        "country": country,
        "status": 'unavailable',
      });
      print('Account Created Sucessfully');
      return user;
    } else {
      print('Something went wrong');
      return user;
    }
  } catch (e) {
    print(e.toString());
  }
  return null;
}

Future<User?> logIn(String email, String password) async {
  FirebaseAuth auth = FirebaseAuth.instance;
  try {
    User? user = (await auth.signInWithEmailAndPassword(
            email: email, password: password))
        .user;
    print(user);
    if (user != null) {
      print('Login successfull');
      print(user);
      return user;
    } else {}
  } catch (e) {
    print(e.toString());
  }
  return null;
}

Future logOut(BuildContext context) async {
  FirebaseAuth auth = FirebaseAuth.instance;
  try {
    await auth.signOut().then((value) {
      Navigator.push(context, MaterialPageRoute(builder: (context) {
        return const AuthPage();
      }));
    });
  } catch (e) {
    print(e.toString());
  }
}
