import 'package:flutter/material.dart';
import 'title.dart';
import 'footer.dart';

class DevFound extends StatefulWidget {
  @override
  _DevFoundState createState() => _DevFoundState();
}

class _DevFoundState extends State<DevFound> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: <Widget>[
            TitleWidget(),
            DesignedWidget(),
            LoveMakingWidget(),
          ],
        ),
        backgroundColor: Colors.black87);
  }
}
