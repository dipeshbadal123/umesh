import 'dart:math';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_share/flutter_share.dart';
import 'package:video_player/video_player.dart';

class VideoDetails extends StatefulWidget {
  const VideoDetails({Key? key}) : super(key: key);

  @override
  State<VideoDetails> createState() => _VideoDetailsState();
}

class _VideoDetailsState extends State<VideoDetails> {
  final TextEditingController _commentsController = TextEditingController();
  late VideoPlayerController _controller;
  late Future<void> _initializeVideoPlayerFuture;
  List comments = [];
  FirebaseAuth auth = FirebaseAuth.instance;
  FirebaseFirestore firebaseFirestore = FirebaseFirestore.instance;
  CollectionReference collectionRef =
      FirebaseFirestore.instance.collection('video');
  Future<void> getData() async {
    QuerySnapshot querySnapshot = await collectionRef.get();
    var allData = querySnapshot.docs.map((doc) => doc.data()).toList();
    setState(() {
      comments = allData;
    });
  }

  @override
  void initState() {
    getData();
    super.initState();

    _controller = VideoPlayerController.network(
      'https://flutter.github.io/assets-for-api-docs/assets/videos/butterfly.mp4',
    );
    _initializeVideoPlayerFuture = _controller.initialize();
    _controller.setLooping(true);
  }

  @override
  void dispose() {
    // Ensure disposing of the VideoPlayerController to free up resources.
    _controller.dispose();

    super.dispose();
  }

  Future<void> share() async {
    await FlutterShare.share(
      title: 'Argentina vs Germany',
      text: 'I am sharing this Argentina vs Germany game.',
      linkUrl:
          'https://flutter.github.io/assets-for-api-docs/assets/videos/butterfly.mp4',
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        elevation: 0,
        backgroundColor: Colors.white,
        iconTheme: const IconThemeData(color: Colors.black),
        title: const Text(
          "Argentina vs Germany",
          style: TextStyle(color: Colors.black),
        ),
        actions: [
          IconButton(
              onPressed: () {
                share();
              },
              icon: const Icon(Icons.share))
        ],
      ),
      body: SingleChildScrollView(
        child: Column(
          children: [
            Container(
              color: Colors.black,
              height: MediaQuery.of(context).size.height / 2,
              width: MediaQuery.of(context).size.width,
              child: FutureBuilder(
                future: _initializeVideoPlayerFuture,
                builder: (context, snapshot) {
                  if (snapshot.connectionState == ConnectionState.done) {
                    // If the VideoPlayerController has finished initialization, use
                    // the data it provides to limit the aspect ratio of the video.
                    return AspectRatio(
                      aspectRatio: _controller.value.aspectRatio.sign,
                      // Use the VideoPlayer widget to display the video.
                      child: VideoPlayer(_controller),
                    );
                  } else {
                    // If the VideoPlayerController is still initializing, show a
                    // loading spinner.
                    return const Center(
                      child: CircularProgressIndicator(),
                    );
                  }
                },
              ),
            ),
            const ListTile(
              title: Text("Description"),
              subtitle: Text(
                "This is a football match between Argentina and Germany. Please click here to watch live broadcast.",
                textAlign: TextAlign.justify,
              ),
            ),
            const SizedBox(
              height: 10,
            ),
            ListTile(
              title: const Text("Comments"),
              subtitle: ListView.builder(
                  shrinkWrap: true,
                  itemCount: comments.length,
                  physics: const NeverScrollableScrollPhysics(),
                  itemBuilder: (context, index) {
                    return Padding(
                      padding: const EdgeInsets.only(top: 8.0),
                      child: Text(comments[0]['comments'].toString() != 'null'
                          ? comments[index]['comments'].toString()
                          : "No comments found."),
                    );
                  }),
            ),
            const SizedBox(
              height: 100,
            )
          ],
        ),
      ),
      bottomSheet: Container(
        color: Colors.white,
        child: Padding(
          padding: const EdgeInsets.all(10),
          child: TextFormField(
            controller: _commentsController,
            decoration: InputDecoration(
                border: const OutlineInputBorder(),
                suffixIcon: IconButton(
                    onPressed: () async {
                      FirebaseFirestore firebaseFirestore =
                          FirebaseFirestore.instance;
                      await firebaseFirestore
                          .collection('video')
                          .doc(Random.secure().nextInt(100000).toString())
                          .set({
                        "comments": _commentsController.text.trim(),
                      }).then((value) {
                        setState(() {
                          _commentsController.clear();
                          getData();
                        });

                        ScaffoldMessenger.of(context).showSnackBar(
                            const SnackBar(
                                content: Text(
                                    "Comments has been posted successfully.")));
                      });
                    },
                    icon: const Icon(Icons.send)),
                labelText: 'Comments',
                hintText: 'Write a comment'),
          ),
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          setState(() {
            if (_controller.value.isPlaying) {
              _controller.pause();
            } else {
              _controller.play();
            }
          });
        },
        // Display the correct icon depending on the state of the player.
        child: Icon(
          _controller.value.isPlaying ? Icons.pause : Icons.play_arrow,
          color: Colors.white,
        ),
      ),
    );
  }
}
