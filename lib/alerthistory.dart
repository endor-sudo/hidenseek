import 'package:flutter/material.dart';
import 'title.dart';
import 'footer.dart';

class AlertHistory extends StatefulWidget {
  @override
  _AlertHistoryState createState() => _AlertHistoryState();
}

class _AlertHistoryState extends State<AlertHistory> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: Column(children: <Widget>[
          Expanded(
              child: Padding(
                  padding: const EdgeInsets.all(20.0), child: TitleWidget())),
          DesignedWidget(),
          LoveMakingWidget()
        ]),
        backgroundColor: Colors.black);
  }
}
