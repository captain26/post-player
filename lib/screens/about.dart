import 'package:flutter/material.dart';
import 'package:post_player/screens/drawer_screen.dart';

class AboutPage extends StatelessWidget {
  static const String routeName = '/AboutPage';

  @override
  Widget build(BuildContext context) {
    return new Scaffold(
        appBar: AppBar(
          title: Text("About Us"),
        ),
        drawer: DrawerScreen(),
        body: Center(child: Text("This is About us page")));
  }
}
