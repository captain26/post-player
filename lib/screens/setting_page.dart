import 'package:flutter/material.dart';
import 'package:post_player/screens/drawer_screen.dart';

class SettingPage extends StatelessWidget {
  static const String routeName = '/SettingPage';

  @override
  Widget build(BuildContext context) {
    return new Scaffold(
        appBar: AppBar(
          title: Text("My Profile"),
        ),
        drawer: DrawerScreen(),
        body: Center(child: Text("This is profile page")));
  }
}