import 'package:flutter/material.dart';
import 'package:post_player/screens/drawer_screen.dart';
import 'package:post_player/screens/photo_page.dart';
import 'package:post_player/screens/video_page.dart';
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
        elevation: 0,
        backgroundColor: Colors.white,

        leading: FlatButton(
          onPressed: _openDrawer,
          child: Icon(
            Icons.menu,
            color: Color(0xff072ac8),
          ),
        ),
        title: Center(
            child: Text(
          'Post Player',
          style: TextStyle(color: Color(0xff072ac8)),
        )),
        actions: [
          FlatButton(
            child: Text(
              'LIVE',
              style: TextStyle(color: Color(0xff072ac8), fontSize: 15.0),
            ),
            onPressed: () async{
              final auth = Provider.of<AuthBase>(context,listen: false);
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
                fontFamily: 'SourceSansPro',
                fontWeight: FontWeight.w700),
            unselectedLabelStyle:
                TextStyle(fontSize: 20, fontFamily: 'SourceSansPro'),
            tabs: [
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: Text('Photos'),
              ),
              Text('Videos'),
            ],
            controller: _tabController,
          ),
          Expanded(
            child: TabBarView(
              children: [
                PhotosPage(),
                VideoPage(),
              ],
              controller: _tabController,
            ),
          ),
        ],
      ),
    );
  }
}
