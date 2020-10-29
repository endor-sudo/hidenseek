import 'package:flutter/material.dart';
import 'package:hide_n_seek/devfound.dart';
import 'title.dart';
import 'footer.dart';
import 'devfound.dart';

class Scan extends StatefulWidget {
  @override
  _ScanState createState() => _ScanState();
}

class _ScanState extends State<Scan> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: <Widget>[
            TitleWidget(),
            RadarStill(),
            AlertHistory(),
            DesignedWidget(),
            LoveMakingWidget(),
          ],
        ),
        backgroundColor: Colors.black87);
  }
}

class RadarStill extends StatefulWidget {
  @override
  _RadarStillState createState() => _RadarStillState();
}

class _RadarStillState extends State<RadarStill> {
  click() {
    //FlutterBlue flutterBlue = FlutterBlue.instance;

    Navigator.push(
        context, MaterialPageRoute(builder: (context) => DevFound()));
  }

  @override
  Widget build(BuildContext context) {
    return Material(
      child: GestureDetector(
        onTap: this.click,
        child: Container(
          child: Image.asset('assets/images/radar.jpg'),
        ),
      ),
    );
  }
}

class AlertHistory extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return ButtonBar(
      children: <Widget>[
        FlatButton(
          child: Text('Alert History'),
          color: Colors.blue,
          onPressed: () {/** */},
        ),
        FlatButton(
          child: Text('Alerts Set'),
          color: Colors.blue,
          onPressed: () {/** */},
        ),
      ],
      alignment: MainAxisAlignment.center,
    );
  }
}
