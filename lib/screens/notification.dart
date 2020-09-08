import 'package:flutter/material.dart';
import 'package:post_player/screens/drawer_screen.dart';

class NotificationPage extends StatelessWidget {
  static const String routeName = '/NotificationPage';

  @override
  Widget build(BuildContext context) {
    return new Scaffold(
        appBar: AppBar(
          title: Text("Contacts"),
        ),
        drawer: DrawerScreen(),
        body: Center(child: Text("This is contacts page")));
  }
}