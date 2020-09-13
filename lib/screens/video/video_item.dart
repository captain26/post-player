import 'package:flutter/material.dart';
import 'package:youtube_player_flutter/youtube_player_flutter.dart';

// ignore: must_be_immutable
class VideoItem extends StatefulWidget {
  VideoItem({this.comment, this.url});
  final String comment;
  final String url;
  YoutubePlayerController youtubePlayerController;
  @override
  _VideoItemState createState() => _VideoItemState();
}

class _VideoItemState extends State<VideoItem> {
  @override
  void initState() {
    widget.youtubePlayerController = YoutubePlayerController(
      initialVideoId: widget.url,
      flags: YoutubePlayerFlags(
        autoPlay: true,
        mute: false,
      ),
    );
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
            YoutubePlayer(
                controller: widget.youtubePlayerController,
                showVideoProgressIndicator: true,
                progressIndicatorColor: Color(0xff072ac8),
                progressColors: ProgressBarColors(
                    playedColor: Color(0xff072ac8),
                    bufferedColor: Color(0xfff3f5ff))),
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: Text(
                widget.comment,
                style: TextStyle(fontSize: 15.0),
              ),
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
