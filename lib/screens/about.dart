import 'package:flutter/material.dart';
import 'package:post_player/screens/drawer_screen.dart';

class AboutPage extends StatelessWidget {



  final GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey<ScaffoldState>();

  static const String routeName = '/AboutPage';



  void _openDrawer() {
    _scaffoldKey.currentState.openDrawer();
  }

  @override
  Widget build(BuildContext context) {
    return new Scaffold(
      drawer: DrawerScreen(),
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
        body: Center(child: Text("This is About us page")));
  }
}
