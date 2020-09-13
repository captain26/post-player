import 'package:flutter/material.dart';
import 'package:post_player/common/page_routes.dart';
import 'package:post_player/landing.dart';
import 'package:post_player/screens/home_page.dart';
import 'package:post_player/services/auth.dart';
import 'package:provider/provider.dart';

void main() async {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Provider<AuthBase>(
      create: (context) => Auth(),
      child: MaterialApp(
        debugShowCheckedModeBanner: false,
        home: LandingPage(),
        routes: {
          PageRoutes.home: (context) => HomePage(),
        },
      ),
    );
  }
}
