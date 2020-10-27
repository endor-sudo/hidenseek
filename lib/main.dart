import 'package:flutter/material.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
// This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Hide&Seek',
      theme: ThemeData(
        primarySwatch: Colors.purple,
        visualDensity: VisualDensity.adaptivePlatformDensity,
      ),
      home: MyHomePage(),
    );
  }
}

class MyHomePage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: Column(
          children: <Widget>[
            TitleWidget(),
            DesignedWidget(),
            LoveMakingWidget()
          ],
        ),
        backgroundColor: Colors.purple);
  }
}

class TitleWidget extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Text('Hide \'n Seek');
  }
}

class DesignedWidget extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Text('Designed by diletante Ideas');
  }
}

class LoveMakingWidget extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Text('Made with love in a shack');
  }
}
