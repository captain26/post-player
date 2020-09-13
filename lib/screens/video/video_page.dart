import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:post_player/screens/video/video_item.dart';

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
    return ListView(
      children: [
        VideoItem(
          url: 'PTm4GHbhG4M',
          comment: 'La La Land ',
        ),
      ],
    );
  }
}
