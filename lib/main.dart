import 'package:flutter/material.dart';
import 'login.dart';
import 'package:splashscreen/splashscreen.dart';

void main() {
  runApp(new MaterialApp(
      title: 'Hide&Seek',
      theme: ThemeData(
        primarySwatch: Colors.green,
        visualDensity: VisualDensity.adaptivePlatformDensity,
      ),
      home: MyAppLoading()));
}

class MyAppLoading extends StatefulWidget {
  @override
  _MyAppStateLoading createState() => new _MyAppStateLoading();
}

class _MyAppStateLoading extends State<MyAppLoading> {
  @override
  Widget build(BuildContext context) {
    return new SplashScreen(
        seconds: 8,
        navigateAfterSeconds: new MyApp(),
        title: new Text(
          'HideNSeek',
          style: new TextStyle(fontWeight: FontWeight.bold, fontSize: 20.0),
        ),
        image: new Image.asset('assets/radar.png'),
        backgroundColor: Colors.black,
        styleTextUnderTheLoader: new TextStyle(),
        photoSize: 100.0,
        loaderColor: Colors.green);
  }
}

class MyApp extends StatelessWidget {
// This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MyHomePage();
  }
}
