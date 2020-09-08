import 'package:flutter/material.dart';
import 'package:post_player/screens/drawer_screen.dart';

class ContactPage extends StatelessWidget {
  static const String routeName = '/ContactPage';

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