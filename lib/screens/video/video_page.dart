import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:chewie/chewie.dart';
import 'package:post_player/screens/video/video_item.dart';
import 'package:video_player/video_player.dart';

class VideoPage extends StatefulWidget {
  @override
  _VideoPageState createState() => _VideoPageState();
}

class _VideoPageState extends State<VideoPage> {
  Future getData() async {
    QuerySnapshot qn =
        await Firestore.instance.collection('videos').getDocuments();
    return qn.documents;
  }

  @override
  Widget build(BuildContext context) {
    return FutureBuilder(
      future: getData(),
      builder: (context, snapshot) {
        if (snapshot.connectionState == ConnectionState.waiting) {
          return Center(
            child: CircularProgressIndicator(),
          );
        } else {
          return ListView.builder(
            itemCount: snapshot.data.length,
            itemBuilder: (context, index) {
              return VideoItem(
                videoPlayerController: VideoPlayerController.network(
                    snapshot.data[index].data['url']),
                comment: snapshot.data[index].data['comment'],
              );
            },
          );
        }
      },
    );
  }
}
// ListView(
// children: [
// VideoItem(
// videoPlayerController:   VideoPlayerController.network('https://file-examples-com.github.io/uploads/2017/04/file_example_MP4_1280_10MG.mp4'),
// lopping: true,
// ),
// VideoItem(
// videoPlayerController:   VideoPlayerController.network('https://file-examples-com.github.io/uploads/2017/04/file_example_MP4_1280_10MG.mp4'),
// lopping: true,
// ),
// ],
// );
