// ignore: avoid_web_libraries_in_flutter
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:post_player/screens/drawer_screen.dart';
import 'package:post_player/screens/photo_page.dart';
import 'package:post_player/screens/video/screens/home_screen.dart';
import 'package:post_player/services/auth.dart';
import 'package:provider/provider.dart';

class HomePage extends StatefulWidget {
  static const String routeName = '/HomePage';

  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage>
    with SingleTickerProviderStateMixin {
  TabController _tabController;

  final GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey<ScaffoldState>();

  @override
  void initState() {
    _tabController = new TabController(length: 2, vsync: this);

    super.initState();
  }

  void _openDrawer() {
    _scaffoldKey.currentState.openDrawer();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      key: _scaffoldKey,
      drawer: DrawerScreen(),
      appBar: AppBar(
        centerTitle: true,
        elevation: 0,
        backgroundColor: Colors.white,
        leading: FlatButton(
          onPressed: _openDrawer,
          child: Icon(
            Icons.menu,
            color: Color(0xff072ac8),
          ),
        ),
        title: Text(
          'Post Player',
          style: TextStyle(color: Color(0xff072ac8), fontFamily: 'Montserrat'),
        ),
        actions: [
          FlatButton(
            child: Text(
              'LIVE',
              style: TextStyle(color: Color(0xff072ac8), fontSize: 15.0),
            ),
            onPressed: () async {
              final auth = Provider.of<AuthBase>(context, listen: false);
              await auth.signOut();
            },
          )
        ],
      ),
      body: Column(
        children: [
          TabBar(
            indicator: BoxDecoration(color: Color(0xfff3f5ff)),
            labelColor: Color(0xff072ac8),
            unselectedLabelColor: Colors.black87,
            labelStyle: TextStyle(
                fontSize: 20,
                fontFamily: 'Montserrat',
                fontWeight: FontWeight.w700),
            unselectedLabelStyle:
                TextStyle(fontSize: 20, fontFamily: 'SourceSansPro'),
            tabs: [
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: Text(
                  'Photos',
                  style: TextStyle(fontFamily: 'Montserrat'),
                ),
              ),
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: Text(
                  'Videos',
                  style: TextStyle(fontFamily: 'Montserrat'),
                ),
              ),
            ],
            controller: _tabController,
          ),
          Expanded(
            child: TabBarView(
              children: [
                PhotosPage(),
                HomeScreen(),
              ],
              controller: _tabController,
            ),
          ),
          Align(
            alignment: Alignment.bottomCenter,
            child: Container(
              height: 100,
              width: double.infinity,
              decoration: BoxDecoration(
                borderRadius: BorderRadius.only(
                    topLeft: Radius.circular(15.0),
                    topRight: Radius.circular(15.0)),
                color: Colors.white,
                boxShadow: [
                  BoxShadow(
                    color: Colors.grey,
                    offset: Offset(0.0, 1.0), //(x,y)
                    blurRadius: 6.0,
                  ),
                ],
              ),
              child: Column(
                children: [
                  SizedBox(
                    height: 5,
                  ),
                  Center(
                    child: MyBlinkingText(),
                  ),
                  SizedBox(
                    height: 5,
                  ),
                  _buildPhoto(context)
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildPhoto(BuildContext context) {
    return StreamBuilder<QuerySnapshot>(
      stream: Firestore.instance
          .collection('bannerphoto')
          .orderBy('createdOn', descending: true)
          .limit(1)
          .snapshots(),
      builder: (context, snapshot) {
        if (!snapshot.hasData) return CircularProgressIndicator();
        final photos = snapshot.data.documents;
        String photourl;
        for (var photo in photos) {
          final url = photo.data['url'];
          photourl = url;
        }
        return Container(
          height: 72,
          width: double.infinity,
          child: Image.network(
            photourl,
            fit: BoxFit.fill,
          ),
        );
      },
    );
  }
}

class MyBlinkingText extends StatefulWidget {
  @override
  _MyBlinkingTextState createState() => _MyBlinkingTextState();
}

class _MyBlinkingTextState extends State<MyBlinkingText>
    with SingleTickerProviderStateMixin {
  AnimationController _animationController;

  @override
  void initState() {
    _animationController =
        new AnimationController(vsync: this, duration: Duration(seconds: 1));
    _animationController.repeat();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return FadeTransition(
      opacity: _animationController,
      child: Text(
        "TODAY\'S EXCLUSIVE",
        style: TextStyle(
          fontSize: 15,
          fontWeight: FontWeight.w600,
          color: Colors.red,
        ),
      ),
    );
  }

  @override
  void dispose() {
    _animationController.dispose();
    super.dispose();
  }
}
