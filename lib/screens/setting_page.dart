import 'package:flutter/material.dart';
import 'package:post_player/screens/drawer_screen.dart';

class SettingPage extends StatelessWidget {
  static const String routeName = '/SettingPage';


  final GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey<ScaffoldState>();

  void _openDrawer() {
    _scaffoldKey.currentState.openDrawer();
  }

  @override
  Widget build(BuildContext context) {
    return new Scaffold(
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
        body: Center(child: Text("This is profile page")));
  }
}