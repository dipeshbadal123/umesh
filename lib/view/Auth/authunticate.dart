// ignore_for_file: must_be_immutable

import 'package:chat_app/view/Auth/login_page.dart';
import 'package:chat_app/view/home/home_page.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

class Authunticate extends StatelessWidget {
  FirebaseAuth firebaseAuth = FirebaseAuth.instance;

  Authunticate({Key? key}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    if (firebaseAuth.currentUser != null) {
      return const HomeScreen();
    } else {
      return const AuthPage();
    }
  }
}
