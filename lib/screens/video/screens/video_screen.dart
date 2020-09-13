 import 'package:flutter/material.dart';
import 'package:post_player/screens/drawer_screen.dart';
import 'package:youtube_player_flutter/youtube_player_flutter.dart';

class VideoScreen extends StatefulWidget {

  final String id;

  VideoScreen({this.id});

  @override
  _VideoScreenState createState() => _VideoScreenState();
}

class _VideoScreenState extends State<VideoScreen> {

  YoutubePlayerController _controller;

  @override
  void initState() {
    super.initState();
    _controller = YoutubePlayerController(
      initialVideoId: widget.id,
      flags: YoutubePlayerFlags(
        mute: false,
        autoPlay: true,
      ),
    );
  }
  final GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey<ScaffoldState>();


  void _openDrawer() {
    _scaffoldKey.currentState.openDrawer();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      key: _scaffoldKey,
      drawer: DrawerScreen(),
      backgroundColor: Colors.grey[200],
      appBar: AppBar(
        elevation: 0,
        backgroundColor: Colors.white,
        leading: FlatButton(
          onPressed: _openDrawer,
          child: Icon(
            Icons.menu,
            color: Color(0xff072ac8),
          ),
        ),
        title: Center(
            child: Text(
              'Post Player',
              style: TextStyle(color: Color(0xff072ac8)),
            )),
      ),
      body: SafeArea(
        child: Card(
          margin: EdgeInsets.only(top: 50.0),
          elevation: 2.0,
          shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20.0)),
          child: Padding(
            padding: const EdgeInsets.all(12.0),
            child: YoutubePlayer(
              controller: _controller,
              liveUIColor: Color(0xff072ac8),
              showVideoProgressIndicator: true,
              progressColors: ProgressBarColors(handleColor: Color(0xff072ac8),playedColor: Color(0xff072ac8)),
              onReady: () {
                print('Player is ready.');
              },
            ),
          ),
        ),
      ),
    );
  }
}