import 'package:flutter/material.dart';
import 'package:post_player/common/page_routes.dart';
import 'package:post_player/screens/about.dart';
import 'package:post_player/screens/contact.dart';
import 'package:post_player/screens/add_banner.dart';
import 'package:post_player/screens/add_photo.dart';

class DrawerScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Drawer(
      child: Column(
        children: <Widget>[
          createDrawerHeader(),
          SizedBox(
            height: 25,
          ),
          createDrawerBodyItem(
            icon: Icons.home,
            text: 'Home',
            onTap: () =>
                Navigator.pushReplacementNamed(context, PageRoutes.home),
          ),
          createDrawerBodyItem(
            icon: Icons.account_circle,
            text: 'About Us',
            onTap: () {
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => AboutPage(),
                ),
              );
            },
          ),
          createDrawerBodyItem(
            icon: Icons.contact_phone,
            text: 'Contact Us',
            onTap: () {
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => ContactPage(),
                ),
              );
            },
          ),
          Divider(),
          createDrawerBodyItem(
            icon: Icons.add,
            text: 'Add a Photo',
            onTap: () {
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => AddPhotoPage(),
                ),
              );
            },
          ),
          createDrawerBodyItem(
            icon: Icons.add,
            text: 'Add a Banner',
            onTap: () {
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => AddBannerPage(),
                ),
              );
            },
          ),
          Spacer(),
          ListTile(
            title: Align(
              alignment: Alignment.bottomCenter,
              child: Text('App version 1.0.0'),
            ),
            onTap: () {},
          ),
        ],
      ),
    );
  }
}

Widget createDrawerHeader() {
  return Container(
    width: double.infinity,
    padding: EdgeInsets.all(20),
    color: Color(0xFF394989),
    child: Center(
      child: Column(
        children: <Widget>[
          Container(
            width: 100,
            height: 100,
            margin: EdgeInsets.only(top: 40, bottom: 30),
            child: Center(
              child: Container(
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(150),
                ),
                child: Image.asset(
                  'assets/images/logo.jpg',
                  fit: BoxFit.fill,
                ),
              ),
            ),
          ),
        ],
      ),
    ),
  );
}

Widget createDrawerBodyItem(
    {IconData icon, String text, GestureTapCallback onTap}) {
  return ListTile(
    contentPadding: EdgeInsets.only(left: 20),
    title: Row(
      children: <Widget>[
        Icon(
          icon,
          size: 22,
        ),
        Padding(
          padding: EdgeInsets.only(left: 12.0),
          child: Text(
            text,
            style: TextStyle(
              fontSize: 18,
            ),
          ),
        )
      ],
    ),
    onTap: onTap,
  );
}
