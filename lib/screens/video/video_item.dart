

import 'package:chewie/chewie.dart';
import 'package:flutter/material.dart';
import 'package:video_player/video_player.dart';

class VideoItem extends StatefulWidget {
  VideoItem({@required this.videoPlayerController, this.lopping,this.comment});

  final VideoPlayerController videoPlayerController;
  final bool lopping;
  final String comment;

  @override
  _VideoItemState createState() => _VideoItemState();
}

class _VideoItemState extends State<VideoItem> {
  ChewieController _chewieController;

  @override
  void initState() {
    _chewieController = ChewieController(
        videoPlayerController: widget.videoPlayerController,
        aspectRatio: 3 / 2,
        autoInitialize: true,
        looping: widget.lopping,
        allowFullScreen: false,
        materialProgressColors: ChewieProgressColors(playedColor: Color(0xff072ac8),bufferedColor: Color(0xfff3f5ff),handleColor: Color(0xff072ac8)),
        showControls: true,
        errorBuilder: (context, errorMessage) {
          return Center(
            child: Text(
              errorMessage,
              style: TextStyle(
                color: Colors.white,
              ),
            ),
          );
        });
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Card(
        elevation: 2.0,
        child: Column(
          children: [
            Chewie(
              controller: _chewieController,
            ),
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: Text(
                widget.comment,
              style: TextStyle(fontSize: 15.0),),
            ),
          ],
        ),
      ),
    );
  }

  @override
  void dispose() {
    super.dispose();
  }
}
