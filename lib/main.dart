import 'package:chat_app/view/welcome/splash_screen.dart';
import 'package:flutter/material.dart';
import 'package:firebase_core/firebase_core.dart';

Future main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: "Fun Olympic",
      theme: ThemeData(
          primarySwatch: Colors.cyan,
          iconTheme: const IconThemeData(color: Colors.cyan)),
      home: const SplashScreen(),
    );
  }
}
