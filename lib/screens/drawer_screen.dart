import 'package:flutter/material.dart';
import 'package:post_player/common/page_routes.dart';

class DrawerScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Drawer(
      child: ListView(
        padding: EdgeInsets.zero,
        children: <Widget>[
          createDrawerHeader(),
          createDrawerBodyItem(
            icon: Icons.home,
            text: 'Home',
            onTap: () => Navigator.pushReplacementNamed(context, PageRoutes.home),
          ),
          createDrawerBodyItem(
            icon: Icons.account_circle,
            text: 'Contact Us',
            onTap: () => Navigator.pushReplacementNamed(context, PageRoutes.contact),

          ),
          createDrawerBodyItem(
            icon: Icons.event_note,
            text: 'Notification',
            onTap: () => Navigator.pushReplacementNamed(context, PageRoutes.notification),

          ),
          Divider(),
          createDrawerBodyItem(
            icon: Icons.notifications_active,
            text: 'Setting',
            onTap: () => Navigator.pushReplacementNamed(context, PageRoutes.setting),

          ),
          ListTile(
            title: Text('App version 1.0.0'),
            onTap: () {},
          ),
        ],
      ),
    );
  }
}

Widget createDrawerHeader() {
  return DrawerHeader(
      margin: EdgeInsets.zero,
      padding: EdgeInsets.zero,
      decoration: BoxDecoration(
          image: DecorationImage(
              fit: BoxFit.fill, image: AssetImage('images/bg_header.jpeg'))),
      child: Stack(children: <Widget>[
        Positioned(
            bottom: 12.0,
            left: 16.0,
            child: Text("Welcome to Flutter",
                style: TextStyle(
                    color: Colors.white,
                    fontSize: 20.0,
                    fontWeight: FontWeight.w500))),
      ]));
}

Widget createDrawerBodyItem(
    {IconData icon, String text, GestureTapCallback onTap}) {
  return ListTile(
    title: Row(
      children: <Widget>[
        Icon(icon),
        Padding(
          padding: EdgeInsets.only(left: 8.0),
          child: Text(text),
        )
      ],
    ),
    onTap: onTap,
  );
}
