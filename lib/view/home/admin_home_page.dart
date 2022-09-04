import 'package:chat_app/view/Auth/admin_login.dart';
import 'package:chat_app/view/home/asdmin_services/user_management.dart';
import 'package:chat_app/view/home/asdmin_services/video_management.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

class AdminPanel extends StatefulWidget {
  const AdminPanel({Key? key}) : super(key: key);

  @override
  State<AdminPanel> createState() => _AdminPanelState();
}

class _AdminPanelState extends State<AdminPanel> with WidgetsBindingObserver {
  Map<String, dynamic>? userMap;
  bool isLoading = false;
  //final TextEditingController _search = TextEditingController();
  final FirebaseAuth _auth = FirebaseAuth.instance;
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;
  //final _formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    return Scaffold(
        appBar: AppBar(
          automaticallyImplyLeading: false,
          backgroundColor: Colors.white,
          elevation: 1,
          title: const Text("Fun Olympic Games"),
          actions: [
            IconButton(
                icon: const Icon(
                  Icons.logout,
                ),
                onPressed: () async {
                  ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
                      content: Text("Admin Logged out successfully")));
                  FirebaseAuth auth = FirebaseAuth.instance;
                  try {
                    await auth.signOut().then((value) {
                      Navigator.push(context,
                          MaterialPageRoute(builder: (context) {
                        return const AdminLogin();
                      }));
                    });
                  } catch (e) {
                    print(e.toString());
                  }
                })
          ],
        ),
        body: isLoading
            ? Center(
                child: SizedBox(
                  height: size.height / 20,
                  width: size.height / 20,
                  child: const CircularProgressIndicator(),
                ),
              )
            : RefreshIndicator(
                onRefresh: () async {},
                child: SingleChildScrollView(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      const Padding(
                          padding: EdgeInsets.all(10),
                          child: ListTile(
                            title: Text(
                              "Available Services",
                              style: TextStyle(
                                  fontWeight: FontWeight.bold,
                                  fontSize: 20,
                                  color: Colors.cyan),
                            ),
                          )),
                      InkWell(
                        onTap: () {
                          Navigator.of(context)
                              .push(MaterialPageRoute(builder: (context) {
                            return const UserManagement();
                          }));
                        },
                        child: Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: SizedBox(
                              height: 120,
                              width: double.infinity,
                              child: Card(
                                elevation: 5,
                                child: Row(
                                  children: const [
                                    Padding(
                                      padding: EdgeInsets.all(8.0),
                                      child: Expanded(
                                          flex: 1,
                                          child: Icon(
                                            Icons.person,
                                            size: 80,
                                          )),
                                    ),
                                    Padding(
                                      padding: EdgeInsets.all(8),
                                      child: Expanded(
                                          flex: 8,
                                          child: Text(
                                            "User Management",
                                            style: TextStyle(
                                                fontWeight: FontWeight.bold,
                                                fontSize: 18),
                                          )),
                                    )
                                  ],
                                ),
                              )),
                        ),
                      ),
                      const Padding(
                          padding: EdgeInsets.all(10),
                          child: ListTile(
                            title: Text(
                              "More Services",
                              style: TextStyle(
                                  fontWeight: FontWeight.bold,
                                  fontSize: 20,
                                  color: Colors.cyan),
                            ),
                          )),
                      InkWell(
                        onTap: () {
                          Navigator.of(context)
                              .push(MaterialPageRoute(builder: (context) {
                            return const VideoManagement();
                          }));
                        },
                        child: Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: SizedBox(
                              height: 120,
                              width: double.infinity,
                              child: Card(
                                elevation: 5,
                                child: Row(
                                  children: const [
                                    Padding(
                                      padding: EdgeInsets.all(8.0),
                                      child: Expanded(
                                          flex: 1,
                                          child: Icon(
                                            Icons.video_call,
                                            size: 80,
                                          )),
                                    ),
                                    Padding(
                                      padding: EdgeInsets.all(8.0),
                                      child: Expanded(
                                          flex: 5,
                                          child: Text(
                                            "Video Management",
                                            style: TextStyle(
                                                fontWeight: FontWeight.bold,
                                                fontSize: 18),
                                          )),
                                    )
                                  ],
                                ),
                              )),
                        ),
                      ),
                      // InkWell(
                      //   onTap: () {
                      //     Navigator.of(context)
                      //         .push(MaterialPageRoute(builder: (context) {
                      //       return const UserPasswordManagement();
                      //     }));
                      //   },
                      //   child: Padding(
                      //     padding: const EdgeInsets.all(8.0),
                      //     child: SizedBox(
                      //         height: 120,
                      //         width: double.infinity,
                      //         child: Card(
                      //           elevation: 5,
                      //           child: Row(
                      //             children: const [
                      //               Padding(
                      //                 padding: EdgeInsets.all(8.0),
                      //                 child: Expanded(
                      //                     flex: 1,
                      //                     child: Icon(
                      //                       Icons.lock,
                      //                       size: 80,
                      //                     )),
                      //               ),
                      //               Padding(
                      //                 padding: EdgeInsets.all(8.0),
                      //                 child: Expanded(
                      //                     flex: 5,
                      //                     child: Text(
                      //                       "Reset User Password",
                      //                       style: TextStyle(
                      //                           fontWeight: FontWeight.bold,
                      //                           fontSize: 18),
                      //                     )),
                      //               )
                      //             ],
                      //           ),
                      //         )),
                      //   ),
                      // ),
                    ],
                  ),
                ),
              ));
  }
}
