import 'package:flutter/material.dart';
import 'package:post_player/screens/drawer_screen.dart';

class AddPhotoPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return new Scaffold(
        appBar: AppBar(
          title: Text("Add Photo Page"),
        ),
        drawer: DrawerScreen(),
        body: Center(child: Text("This is Add photo page")));
  }
}
