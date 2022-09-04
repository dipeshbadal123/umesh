import 'dart:io';
import 'dart:math';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:file_picker/file_picker.dart';
import 'package:flutter/material.dart';

class NewVideoUpload extends StatefulWidget {
  const NewVideoUpload({Key? key}) : super(key: key);

  @override
  State<NewVideoUpload> createState() => _NewVideoUploadState();
}

class _NewVideoUploadState extends State<NewVideoUpload> {
  final TextEditingController title = TextEditingController();
  final TextEditingController descrip = TextEditingController();
  final _formKey = GlobalKey<FormState>();
  var files;
  List usersData = [];
  FirebaseFirestore firebaseFirestore = FirebaseFirestore.instance;
  CollectionReference collectionRef =
      FirebaseFirestore.instance.collection('videos');
  Future<void> getData() async {
    QuerySnapshot querySnapshot = await collectionRef.get();
    var allData = querySnapshot.docs.map((doc) => doc.data()).toList();
    setState(() {
      usersData = allData;
    });
    print(usersData);
  }

  @override
  void initState() {
    getData();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("New Video Upload"),
        elevation: 2,
        backgroundColor: Colors.white,
      ),
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.all(5.0),
          child: Form(
            key: _formKey,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const Padding(
                  padding: EdgeInsets.all(8.0),
                  child: Text("Add New Videos"),
                ),
                Padding(
                  padding: const EdgeInsets.all(18),
                  child: TextFormField(
                    controller: title,
                    validator: (value) {
                      if (value!.isEmpty) {
                        return "Title can't be empty";
                      }
                      return null;
                    },
                    //controller: _emailController,
                    decoration: InputDecoration(
                        prefixIcon: const Icon(Icons.email),
                        hintText: 'Match Title',
                        labelText: 'Match Title',
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(15),
                        )),
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.all(18),
                  child: TextFormField(
                    controller: descrip,
                    validator: (value) {
                      if (value!.isEmpty) {
                        return "Description can't be empty";
                      }
                      return null;
                    },
                    //controller: _emailController,
                    decoration: InputDecoration(
                        prefixIcon: const Icon(Icons.email),
                        hintText: 'Description',
                        labelText: 'Description',
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(15),
                        )),
                  ),
                ),
                Padding(
                    padding: const EdgeInsets.all(18),
                    child: SizedBox(
                      width: MediaQuery.of(context).size.width,
                      height: 40,
                      child: MaterialButton(
                        color: Colors.cyan,
                        onPressed: () async {
                          FilePickerResult? result =
                              await FilePicker.platform.pickFiles(
                            type: FileType.custom,
                            allowedExtensions: ['mp4'],
                          );

                          if (result != null) {
                            File file =
                                File(result.files.single.path.toString());
                            setState(() {
                              files = file;
                            });
                          } else {
                            // User canceled the picker
                          }
                        },
                        child: const Text(
                          "Video select",
                          style: TextStyle(color: Colors.white),
                        ),
                      ),
                    )),
              ],
            ),
          ),
        ),
      ),
      bottomSheet: Padding(
          padding: const EdgeInsets.all(18),
          child: SizedBox(
            width: MediaQuery.of(context).size.width,
            height: 50,
            child: MaterialButton(
              color: Colors.cyan,
              onPressed: () async {
                if (_formKey.currentState!.validate()) {
                  FirebaseFirestore firebaseFirestore =
                      FirebaseFirestore.instance;
                  await firebaseFirestore
                      .collection('videos')
                      .doc(Random.secure().nextInt(100000).toString())
                      .set({
                    "title": title.text,
                    "desc": descrip.text,
                  }).then((value) {
                    ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
                        content: Text("Video has been Added successfully")));
                    Navigator.pop(context);
                  });
                }
              },
              child: const Text(
                "Upload",
                style: TextStyle(color: Colors.white),
              ),
            ),
          )),
    );
  }
}
