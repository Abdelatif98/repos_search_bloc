import 'package:flutter/material.dart';
import 'package:repos_search_bloc/pages/repos.page.dart';
import 'package:splashscreen/splashscreen.dart';

class SplachPage extends StatelessWidget {

  @override
  Widget build(BuildContext context) {
    return new SplashScreen(
        seconds: 1,
        navigateAfterSeconds: new ReposPage(),
        title: new Text('Welcome To The App'),
        image: new Image.asset('assets/Github_logo.png'),
        backgroundColor: Colors.white,
        styleTextUnderTheLoader: new TextStyle(),
        photoSize: 100.0,
        loaderColor: Colors.blueAccent
    );
  }
}
