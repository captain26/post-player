import 'package:flutter/material.dart';
import 'package:post_player/screens/drawer_screen.dart';

class AddBannerPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return new Scaffold(
        appBar: AppBar(
          title: Text("Add Banner Photo"),
        ),
        drawer: DrawerScreen(),
        body: Center(child: Text("This is Add banner page")));
  }
}
