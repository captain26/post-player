import 'package:flutter/material.dart';
import 'package:post_player/screens/drawer_screen.dart';

class ContactPage extends StatelessWidget {
  static const String routeName = '/ContactPage';
  final GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey<ScaffoldState>();


  void _openDrawer() {
    _scaffoldKey.currentState.openDrawer();
  }

  @override
  Widget build(BuildContext context) {
    return new Scaffold(
      backgroundColor: Colors.white,
      drawer: DrawerScreen(),
      appBar:  AppBar(
      title: Text(
      'Contact Us',
      style: TextStyle(
        fontFamily: 'Montserrat',
      ),
    ),
    elevation: 0,
    centerTitle: true,
    backgroundColor: Color(0xff072ac8),
    ),
      body: ListView(
        children: [
          SizedBox(
            height: 40,
          ),
          Center(
            child: Text(
              'Let\'s connect',
              style: TextStyle(
                fontSize: 40,
                fontFamily: 'Montserrat',
                color: Colors.black,
                fontWeight: FontWeight.w600,
              ),
            ),
          ),
          Container(
            margin: EdgeInsets.all(30),
            child: Image.asset('assets/images/1.jpg'),
          ),
          SizedBox(
            height: 40,
          ),
          Container(
            margin: EdgeInsets.only(left: 20),
            child: Row(
              children: [
                Icon(
                  Icons.account_circle,
                  size: 30,
                  color: Colors.amberAccent[400],
                ),
                SizedBox(
                  width: 10,
                ),
                Expanded(
                  child: Text(
                    'Dheeraj Shrivastav',
                    style: TextStyle(
                      fontSize: 25,
                      fontFamily: 'Montserrat',
                      color: Colors.black,
                    ),
                  ),
                ),
              ],
            ),
          ),
          SizedBox(
            height: 30,
          ),
          Container(
            margin: EdgeInsets.only(left: 20),
            child: Row(
              children: [
                Icon(
                  Icons.call,
                  size: 30,
                  color: Colors.amberAccent[400],
                ),
                SizedBox(
                  width: 10,
                ),
                Text(
                  '8808972801',
                  style: TextStyle(
                    fontSize: 25,
                    fontFamily: 'Montserrat',
                    color: Colors.black,
                  ),
                ),
              ],
            ),
          ),
          SizedBox(
            height: 30,
          ),
          Container(
            margin: EdgeInsets.only(left: 20),
            child: Row(
              children: [
                Icon(
                  Icons.mail,
                  size: 30,
                  color:Colors.amberAccent[400],
                ),
                SizedBox(
                  width: 10,
                ),
                Expanded(
                  child: Text(
                    'jhansipost2016@gmail.com',
                    style: TextStyle(
                      fontSize: 22,
                      fontFamily: 'Montserrat',
                      color: Colors.black,
                    ),
                  ),
                ),
              ],
            ),
          ),
          SizedBox(
            height: 30,
          ),
          Container(
            margin: EdgeInsets.only(left: 20),
            child: Row(
              children: [
                Icon(
                  Icons.location_on,
                  size: 30,
                  color: Colors.amberAccent[400],
                ),
                SizedBox(
                  width: 10,
                ),
                Expanded(
                  child: Text(
                    'Avas Vikas, Jhansi',
                    style: TextStyle(
                      fontSize: 25,
                      fontFamily: 'Montserrat',
                      color: Colors.black,
                    ),
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
