import 'package:chat_app/view/home/asdmin_services/new_video_add.dart';
import 'package:flutter/material.dart';

class VideoManagement extends StatefulWidget {
  const VideoManagement({Key? key}) : super(key: key);

  @override
  State<VideoManagement> createState() => _VideoManagementState();
}

class _VideoManagementState extends State<VideoManagement> {
  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        appBar: AppBar(
          elevation: 1,
          backgroundColor: Colors.white,
          title: const Text("Video Management"),
          actions: [
            TextButton(
                onPressed: () {
                  Navigator.of(context)
                      .push(MaterialPageRoute(builder: (context) {
                    return const NewVideoUpload();
                  }));
                },
                child: const Text("New Upload"))
          ],
        ),
        body: ListView.builder(
            itemCount: 1,
            itemBuilder: (context, index) {
              return SizedBox(
                height: 300,
                child: Card(
                  elevation: 5,
                  child: Column(
                    children: [
                      Container(
                        height: 220,
                        color: Colors.black,
                      ),
                      Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Row(
                          crossAxisAlignment: CrossAxisAlignment.center,
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            SizedBox(
                              width: MediaQuery.of(context).size.width * 0.8,
                              height: 30,
                              child: const Text(
                                "India vs Nepal football",
                                maxLines: 1,
                                overflow: TextOverflow.ellipsis,
                                style: TextStyle(
                                    fontWeight: FontWeight.bold, fontSize: 20),
                              ),
                            ),
                            IconButton(
                                onPressed: () {},
                                icon: const Icon(Icons.delete))
                          ],
                        ),
                      )
                    ],
                  ),
                ),
              );
            }),
      ),
    );
  }
}
