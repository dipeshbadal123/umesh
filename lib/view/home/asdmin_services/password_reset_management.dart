import 'package:flutter/material.dart';

class UserPasswordManagement extends StatefulWidget {
  const UserPasswordManagement({Key? key}) : super(key: key);

  @override
  State<UserPasswordManagement> createState() => _UserPasswordManagementState();
}

class _UserPasswordManagementState extends State<UserPasswordManagement> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        elevation: 1,
        backgroundColor: Colors.white,
        automaticallyImplyLeading: false,
        title: const Text("Password Management"),
      ),
    );
  }
}
