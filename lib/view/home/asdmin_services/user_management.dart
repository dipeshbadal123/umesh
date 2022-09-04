import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

class UserManagement extends StatefulWidget {
  const UserManagement({Key? key}) : super(key: key);

  @override
  State<UserManagement> createState() => _UserManagementState();
}

class _UserManagementState extends State<UserManagement> {
  final _formKey = GlobalKey<FormState>();
  final TextEditingController _passwordController = TextEditingController();
  List usersData = [];
  FirebaseAuth auth = FirebaseAuth.instance;
  FirebaseFirestore firebaseFirestore = FirebaseFirestore.instance;
  CollectionReference collectionRef =
      FirebaseFirestore.instance.collection('users');
  Future<void> getData() async {
    QuerySnapshot querySnapshot = await collectionRef.get();
    var allData = querySnapshot.docs.map((doc) => doc.data()).toList();
    setState(() {
      usersData = allData;
    });
    print(usersData);
  }

  bool boolean = true;
  @override
  void initState() {
    getData();
    super.initState();
  }

  bool isShow = true;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        elevation: 1,
        backgroundColor: Colors.white,
        title: const Text("User Management"),
        actions: [IconButton(onPressed: () {}, icon: const Icon(Icons.search))],
      ),
      body: usersData.isNotEmpty
          ? SizedBox(
              height: MediaQuery.of(context).size.height,
              child: ListView.separated(
                  itemBuilder: (context, index) {
                    return InkWell(
                      onTap: () {},
                      child: SizedBox(
                        height: boolean
                            ? 70.0
                            : 0.0, // this line for hiding specific cell...
                        width: MediaQuery.of(context).size.width,
                        child: Column(
                          mainAxisSize: MainAxisSize.max,
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: <Widget>[
                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              mainAxisSize: MainAxisSize.max,
                              children: <Widget>[
                                Padding(
                                    padding: const EdgeInsets.all(8.0),
                                    child: Column(
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                      children: [
                                        Text(
                                          usersData[index]['name'],
                                          style: const TextStyle(
                                              fontWeight: FontWeight.bold,
                                              fontSize: 18),
                                        ),
                                        Text(usersData[index]['email']),
                                      ],
                                    )),
                                Row(
                                  children: [
                                    IconButton(
                                        onPressed: () {
                                          showModalBottomSheet(
                                              isDismissible: false,
                                              enableDrag: false,
                                              context: context,
                                              builder: (context) {
                                                return StatefulBuilder(builder:
                                                    (BuildContext context,
                                                        StateSetter
                                                            setState /*You can rename this!*/) {
                                                  return SizedBox(
                                                    height:
                                                        MediaQuery.of(context)
                                                                .size
                                                                .height *
                                                            .8,
                                                    child: Form(
                                                      key: _formKey,
                                                      child: Column(
                                                        crossAxisAlignment:
                                                            CrossAxisAlignment
                                                                .center,
                                                        children: [
                                                          Padding(
                                                            padding:
                                                                const EdgeInsets
                                                                    .all(8.0),
                                                            child: Text(
                                                              "Reset Password for ${usersData[index]['email']}",
                                                              textAlign:
                                                                  TextAlign
                                                                      .center,
                                                              style: const TextStyle(
                                                                  color: Colors
                                                                      .blueAccent,
                                                                  fontWeight:
                                                                      FontWeight
                                                                          .bold,
                                                                  fontSize: 20),
                                                            ),
                                                          ),
                                                          Align(
                                                            alignment: Alignment
                                                                .topRight,
                                                            child: Padding(
                                                              padding:
                                                                  const EdgeInsets
                                                                      .all(10),
                                                              child: IconButton(
                                                                  onPressed:
                                                                      () {
                                                                    Navigator.pop(
                                                                        context);
                                                                    _passwordController
                                                                        .clear();
                                                                  },
                                                                  icon: const Icon(
                                                                      Icons
                                                                          .close)),
                                                            ),
                                                          ),
                                                          Padding(
                                                            padding:
                                                                const EdgeInsets
                                                                    .all(18),
                                                            child:
                                                                TextFormField(
                                                              controller:
                                                                  _passwordController,
                                                              validator:
                                                                  (value) {
                                                                if (value!
                                                                    .isEmpty) {
                                                                  return "Password can't be empty";
                                                                }
                                                                if (value
                                                                        .length <
                                                                    8) {
                                                                  return "Password can't be less than 8 character";
                                                                }
                                                                return null;
                                                              },
                                                              obscureText:
                                                                  isShow,
                                                              obscuringCharacter:
                                                                  '*',
                                                              decoration: InputDecoration(
                                                                  prefixIcon: const Icon(Icons.lock),
                                                                  suffixIcon: IconButton(
                                                                      onPressed: () {
                                                                        setState(
                                                                            () {
                                                                          isShow =
                                                                              !isShow;
                                                                        });
                                                                      },
                                                                      icon: isShow ? const Icon(Icons.visibility_off) : const Icon(Icons.visibility)),
                                                                  hintText: 'Password',
                                                                  labelText: 'Password',
                                                                  border: OutlineInputBorder(
                                                                    borderRadius:
                                                                        BorderRadius.circular(
                                                                            15),
                                                                  )),
                                                            ),
                                                          ),
                                                          Center(
                                                            child:
                                                                MaterialButton(
                                                              color: Colors
                                                                  .deepOrange,
                                                              onPressed: () {
                                                                if (_formKey
                                                                    .currentState!
                                                                    .validate()) {
                                                                  Navigator.of(
                                                                          context)
                                                                      .pop();

                                                                  showDialog(
                                                                    context:
                                                                        context,
                                                                    builder:
                                                                        (ctx) =>
                                                                            AlertDialog(
                                                                      title: const Text(
                                                                          "Succss!"),
                                                                      content: Text(
                                                                          "Password has been updated successfully for ${usersData[index]['email']}"),
                                                                      actions: <
                                                                          Widget>[
                                                                        MaterialButton(
                                                                          onPressed:
                                                                              () {
                                                                            Navigator.of(ctx).pop();
                                                                            _passwordController.clear();
                                                                          },
                                                                          child:
                                                                              const Text("Ok"),
                                                                        ),
                                                                      ],
                                                                    ),
                                                                  );
                                                                }
                                                              },
                                                              child: const Text(
                                                                "Reset Password",
                                                                style: TextStyle(
                                                                    color: Colors
                                                                        .white),
                                                              ),
                                                            ),
                                                          )
                                                        ],
                                                      ),
                                                    ),
                                                  );
                                                });
                                              });
                                        },
                                        icon: const Icon(Icons.lock)),
                                    const SizedBox(
                                      width: 10,
                                    ),
                                  ],
                                ),
                              ],
                            )
                          ],
                        ),
                      ),
                    );
                  },
                  separatorBuilder: (context, index) {
                    return boolean
                        ? const Divider()
                        : Container(); // this line hide the devider for specific cell..
                  },
                  itemCount: usersData.length))
          : const Center(
              child: Text(
              "Looking for new users...",
              style: TextStyle(fontWeight: FontWeight.bold),
            )),
    );
  }
}
