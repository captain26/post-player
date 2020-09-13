import 'package:flutter/material.dart';
import 'package:post_player/screens/drawer_screen.dart';

class AboutPage extends StatelessWidget {
  static const String routeName = '/AboutPage';

  @override
  Widget build(BuildContext context) {
    return new Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        title: Text(
          'About Us',
          style: TextStyle(
            fontFamily: 'Montserrat',
          ),
        ),
        elevation: 0,
        centerTitle: true,
        backgroundColor: Color(0xff072ac8),
      ),
      drawer: DrawerScreen(),
      body: ListView(
        children: [
          Container(
            margin: EdgeInsets.all(30),
            child: Image.asset('assets/images/1.jpg'),
          ),
          Center(
            child: Container(
              margin: EdgeInsets.only(left: 20),
              child: Text(
                'Digital PRO',
                style: TextStyle(
                  fontSize: 30,
                  fontWeight: FontWeight.w700,
                  fontFamily: 'Montserrat',
                  color: Colors.black,
                ),
              ),
            ),
          ),
          SizedBox(
            height: 20,
          ),
          Container(
            margin: EdgeInsets.symmetric(
              horizontal: 15,
            ),
            child: Column(
              children: [
                Text(
                  'Welcome to Post Player, your number one source for all creative content. We\'re dedicated to give you the very best information with a main focus on Exclusive things. Founded in year 2016, PostPlayer has come a long way from its beginnings. When first started out, our passion for best quality content drove us to do tons of research. We now serve customers all over Jhansi, and are thrilled that we\'re able to turn our passion into our own application.',
                  style: TextStyle(
                    fontSize: 20,
                    fontFamily: 'Montserrat',
                    color: Colors.black,
                  ),
                  textAlign: TextAlign.justify,
                ),
                SizedBox(
                  height: 10,
                ),
                Text(
                  'We hope you enjoy our content as much as we enjoy offering them to you.',
                  style: TextStyle(
                    fontSize: 20,
                    fontFamily: 'Montserrat',
                    color: Colors.black,
                  ),
                  textAlign: TextAlign.justify,
                ),
                SizedBox(
                  height: 10,
                ),
                Text(
                  'If you have any suggestions, queries or feedback, please feel free to contact us at jhansipost2016@gmail.com',
                  style: TextStyle(
                    fontSize: 20,
                    fontFamily: 'Montserrat',
                    color: Colors.black,
                  ),
                  textAlign: TextAlign.justify,
                ),
                SizedBox(
                  height: 20,
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
