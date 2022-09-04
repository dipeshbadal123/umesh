// ignore_for_file: library_private_types_in_public_api, no_leading_underscores_for_local_identifiers, avoid_print

import 'dart:developer';

import 'package:chat_app/view/Auth/login_page.dart';
import 'package:chat_app/view/home/video_player.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:video_player/video_player.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({Key? key}) : super(key: key);

  @override
  _HomeScreenState createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> with WidgetsBindingObserver {
  Map<String, dynamic>? userMap;
  bool isLoading = false;
  //final TextEditingController _search = TextEditingController();
  final FirebaseAuth _auth = FirebaseAuth.instance;
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;
  //final _formKey = GlobalKey<FormState>();
  late VideoPlayerController _controller;
  late Future<void> _initializeVideoPlayerFuture;
  List videos = ['5', ''];
  @override
  void initState() {
    log(_auth.currentUser!.uid);
    print(_auth.currentUser!.uid);
    super.initState();
    _controller = VideoPlayerController.network(
      'https://flutter.github.io/assets-for-api-docs/assets/videos/butterfly.mp4',
    );

    // Initialize the controller and store the Future for later use.
    _initializeVideoPlayerFuture = _controller.initialize();

    // Use the controller to loop the video.
    _controller.setLooping(true);
  }

  List upcomingTitle = [
    'Argentina Vs Germany',
    'India Vs Pakistan',
  ];
  List upcomingDesc = [
    'This is a upcoming football match between Argentina and Germany which is happening on 21 Oct 2022 in London',
    'This is a upcoming Cricket match between India and Pakistan which is happening on 22 Oct 2022 in London',
  ];
  List upcomingImage = [
    'https://thumbs.dreamstime.com/z/football-match-schedule-germany-vs-argentina-flags-countrie-countries-soccer-ball-d-rendering-115744892.jpg',
    'https://i0.wp.com/cricketaddictor.com/wp-content/uploads/2022/08/India-vs-Pakistan.jpg?w=1200&ssl=1'
  ];

  List stremingTitle = ['Argentina vs Germany'];
  List stremingDesc = [
    'This is a football match between Argentina and Germany. Please click here to watch live broadcast.',
  ];
  List stremingVideo = [
    'http://scienceandfilm.org/uploads/videos/files/Madness_and_Genius_-_Trailer_for_the_Film.mp4'
  ];
  List sceduleTitle = [
    'Argentina vs Germany',
    'Argentina Vs Germany',
    'India Vs Pakistan',
  ];
  List sceduleDesc = ['Streming Now', '21st Oct 2022', '22nd Oct 2022'];
  @override
  void dispose() {
    // Ensure disposing of the VideoPlayerController to free up resources.
    _controller.dispose();

    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;

    return WillPopScope(
      onWillPop: () async {
        return false;
      },
      child: SafeArea(
        child: Scaffold(
            backgroundColor: Colors.white,
            appBar: AppBar(
              automaticallyImplyLeading: true,
              elevation: 1,
              iconTheme: const IconThemeData(color: Colors.cyan),
              title: const Text(
                "Fun Olympic",
                style: TextStyle(color: Colors.cyan, fontSize: 25),
              ),
              backgroundColor: Colors.white,
              actions: [
                IconButton(
                    icon: const Icon(
                      Icons.logout,
                    ),
                    onPressed: () async {
                      ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
                          content: Text("User Logged out successfully")));
                      FirebaseAuth auth = FirebaseAuth.instance;
                      try {
                        await auth.signOut().then((value) {
                          Navigator.push(context,
                              MaterialPageRoute(builder: (context) {
                            return const AuthPage();
                          }));
                        });
                      } catch (e) {
                        print(e.toString());
                      }
                    })
              ],
            ),
            drawer: Drawer(
              width: MediaQuery.of(context).size.width * 0.95,
              child: SafeArea(
                child: SingleChildScrollView(
                  child: Column(
                    children: [
                      Container(
                        padding: const EdgeInsets.only(top: 5),
                        height: 45,
                        width: MediaQuery.of(context).size.width,
                        color: Colors.deepOrangeAccent,
                        child: const Text(
                          "Game Schedule",
                          textAlign: TextAlign.center,
                          style: TextStyle(
                              fontWeight: FontWeight.bold,
                              fontSize: 25,
                              color: Colors.white),
                        ),
                      ),
                      ListView.builder(
                          physics: const NeverScrollableScrollPhysics(),
                          shrinkWrap: true,
                          itemCount: sceduleDesc.length,
                          itemBuilder: (context, index) {
                            return ListTile(
                              title: Text(sceduleTitle[index].toString()),
                              subtitle: Text(sceduleDesc[index].toString()),
                            );
                          })
                    ],
                  ),
                ),
              ),
            ),
            // floatingActionButton: FloatingActionButton(
            //   backgroundColor: Colors.deepOrange,
            //   onPressed: () {
            //     Navigator.push(context, MaterialPageRoute(builder: (context) {
            //       return const FavoritesPage();
            //     }));
            //   },
            //   child: const Icon(
            //     Icons.favorite,
            //     color: Colors.white,
            //   ),
            // ),
            body: isLoading
                ? Center(
                    child: SizedBox(
                      height: size.height / 20,
                      width: size.height / 20,
                      child: const CircularProgressIndicator(),
                    ),
                  )
                : RefreshIndicator(
                    onRefresh: () async {
                      setState(() {});
                    },
                    child: SingleChildScrollView(
                      child: Column(
                        children: [
                          SingleChildScrollView(
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              mainAxisAlignment: MainAxisAlignment.start,
                              children: [
                                const Align(
                                  alignment: Alignment.topLeft,
                                  child: Padding(
                                    padding: EdgeInsets.all(15.0),
                                    child: Text(
                                      "Streaming Now",
                                      style: TextStyle(
                                          fontWeight: FontWeight.bold,
                                          fontSize: 25,
                                          color: Colors.cyan),
                                    ),
                                  ),
                                ),
                                stremingTitle.isNotEmpty
                                    ? ListView.builder(
                                        physics:
                                            const NeverScrollableScrollPhysics(),
                                        shrinkWrap: true,
                                        itemCount: stremingTitle.length,
                                        itemBuilder: (context, index) {
                                          return InkWell(
                                            onTap: () {
                                              Navigator.of(context).push(
                                                  MaterialPageRoute(
                                                      builder: (context) {
                                                return const VideoDetails();
                                              }));
                                            },
                                            child: SizedBox(
                                              height: 300,
                                              width: double.infinity,
                                              child: Card(
                                                elevation: 5,
                                                margin:
                                                    const EdgeInsets.all(10),
                                                color: Colors.white,
                                                child: Column(
                                                  mainAxisAlignment:
                                                      MainAxisAlignment.start,
                                                  crossAxisAlignment:
                                                      CrossAxisAlignment.start,
                                                  children: [
                                                    Container(
                                                      height: 185,
                                                      width:
                                                          MediaQuery.of(context)
                                                              .size
                                                              .width,
                                                      color: Colors.black,
                                                      child: FutureBuilder(
                                                        future:
                                                            _initializeVideoPlayerFuture,
                                                        builder: (context,
                                                            snapshot) {
                                                          if (snapshot
                                                                  .connectionState ==
                                                              ConnectionState
                                                                  .done) {
                                                            // If the VideoPlayerController has finished initialization, use
                                                            // the data it provides to limit the aspect ratio of the video.
                                                            return AspectRatio(
                                                              aspectRatio:
                                                                  _controller
                                                                      .value
                                                                      .aspectRatio,
                                                              // Use the VideoPlayer widget to display the video.
                                                              child: VideoPlayer(
                                                                  _controller),
                                                            );
                                                          } else {
                                                            // If the VideoPlayerController is still initializing, show a
                                                            // loading spinner.
                                                            return const Center(
                                                              child:
                                                                  CircularProgressIndicator(),
                                                            );
                                                          }
                                                        },
                                                      ),
                                                    ),
                                                    Padding(
                                                      padding:
                                                          const EdgeInsets.only(
                                                              left: 8.0,
                                                              right: 8.0,
                                                              top: 8.0),
                                                      child: Text(
                                                        stremingTitle[index],
                                                        style: const TextStyle(
                                                            fontWeight:
                                                                FontWeight.bold,
                                                            fontSize: 18,
                                                            color: Colors.cyan),
                                                      ),
                                                    ),
                                                    Row(
                                                      children: [
                                                        Expanded(
                                                          flex: 6,
                                                          child: Padding(
                                                            padding:
                                                                const EdgeInsets
                                                                    .all(8.0),
                                                            child: Text(
                                                              stremingDesc[
                                                                  index],
                                                              overflow:
                                                                  TextOverflow
                                                                      .ellipsis,
                                                              maxLines: 3,
                                                              textAlign:
                                                                  TextAlign
                                                                      .justify,
                                                              style: const TextStyle(
                                                                  fontWeight:
                                                                      FontWeight
                                                                          .normal,
                                                                  fontSize: 12,
                                                                  color: Colors
                                                                      .black),
                                                            ),
                                                          ),
                                                        ),
                                                        Expanded(
                                                          flex: 1,
                                                          child: Padding(
                                                              padding:
                                                                  const EdgeInsets
                                                                      .all(8.0),
                                                              child: InkWell(
                                                                  onTap: () {
                                                                    Navigator.of(
                                                                            context)
                                                                        .push(MaterialPageRoute(builder:
                                                                            (context) {
                                                                      return const VideoDetails();
                                                                    }));
                                                                  },
                                                                  child: const Icon(
                                                                      Icons
                                                                          .play_arrow))),
                                                        ),
                                                      ],
                                                    )
                                                  ],
                                                ),
                                              ),
                                            ),
                                          );
                                        })
                                    : const Padding(
                                        padding: EdgeInsets.all(8.0),
                                        child: Center(
                                            child: Text(
                                          "No Games",
                                          style: TextStyle(
                                              color: Colors.red,
                                              fontSize: 16,
                                              fontWeight: FontWeight.w500,
                                              fontStyle: FontStyle.italic),
                                        )),
                                      ),
                              ],
                            ),
                          ),
                          SingleChildScrollView(
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                const Padding(
                                  padding: EdgeInsets.all(15.0),
                                  child: Text(
                                    "Upcoming Games",
                                    style: TextStyle(
                                        fontWeight: FontWeight.bold,
                                        fontSize: 25,
                                        color: Colors.cyan),
                                  ),
                                ),
                                ListView.builder(
                                    physics:
                                        const NeverScrollableScrollPhysics(),
                                    shrinkWrap: true,
                                    itemCount: upcomingTitle.length,
                                    itemBuilder: (context, index) {
                                      return InkWell(
                                        onTap: () {
                                          // Navigator.of(context).push(
                                          //     MaterialPageRoute(
                                          //         builder: (context) {
                                          //   return const VideoDetails();
                                          // }));
                                        },
                                        child: SizedBox(
                                          height: 300,
                                          width: double.infinity,
                                          child: Card(
                                            elevation: 5,
                                            margin: const EdgeInsets.all(10),
                                            color: Colors.white,
                                            child: Column(
                                              mainAxisAlignment:
                                                  MainAxisAlignment.start,
                                              crossAxisAlignment:
                                                  CrossAxisAlignment.start,
                                              children: [
                                                Container(
                                                    height: 185,
                                                    width:
                                                        MediaQuery.of(context)
                                                            .size
                                                            .width,
                                                    color: Colors.black,
                                                    child: Image.network(
                                                        upcomingImage[index])),
                                                Padding(
                                                  padding:
                                                      const EdgeInsets.only(
                                                          left: 8.0,
                                                          right: 8.0,
                                                          top: 8.0),
                                                  child: Text(
                                                    upcomingTitle[index],
                                                    style: const TextStyle(
                                                        fontWeight:
                                                            FontWeight.bold,
                                                        fontSize: 18,
                                                        color: Colors.cyan),
                                                  ),
                                                ),
                                                Row(
                                                  children: [
                                                    Expanded(
                                                      flex: 6,
                                                      child: Padding(
                                                        padding:
                                                            const EdgeInsets
                                                                .all(8.0),
                                                        child: Text(
                                                          upcomingDesc[index],
                                                          overflow: TextOverflow
                                                              .ellipsis,
                                                          maxLines: 3,
                                                          textAlign:
                                                              TextAlign.justify,
                                                          style: const TextStyle(
                                                              fontWeight:
                                                                  FontWeight
                                                                      .normal,
                                                              fontSize: 12,
                                                              color:
                                                                  Colors.black),
                                                        ),
                                                      ),
                                                    ),
                                                  ],
                                                )
                                              ],
                                            ),
                                          ),
                                        ),
                                      );
                                    }),
                              ],
                            ),
                          )
                        ],
                      ),
                    ),
                  )),
      ),
    );
  }
}
