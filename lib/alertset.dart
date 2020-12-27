import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'database.dart';
import 'title.dart';
import 'footer.dart';

class AlertsSetHistory extends StatefulWidget {
  final FirebaseUser user;
  AlertsSetHistory(this.user);
  @override
  _AlertsSetHistoryState createState() => _AlertsSetHistoryState();
}

class _AlertsSetHistoryState extends State<AlertsSetHistory> {
  List<Container> containers = new List<Container>();

  void loadAlerts() {
    getAllAlerts(widget.user).then((deviceAlerts) {
      for (Map<String, dynamic> alert in deviceAlerts) {
        containers.add(Container(
          child: ExpansionTile(
            title: Row(
              children: <Widget>[
                Expanded(
                  child: Column(
                    children: <Widget>[
                      Text(alert['name'],
                          style: TextStyle(color: Colors.green)),
                      Text(alert['id'], style: TextStyle(color: Colors.green)),
                      Text(alert['type'],
                          style: TextStyle(color: Colors.green)),
                    ],
                  ),
                ),
              ],
            ),
            children: <Widget>[
              FlatButton(
                color: Colors.green,
                child: Text(
                  'Delete Alert',
                  style: TextStyle(color: Colors.white),
                ),
                onPressed: () {
                  setState(() {
                    deleteAlert(alert['id'], widget.user);
                  });
                },
              ),
            ],
          ),
        ));
      }
      //log(containers.length.toString());
      this.setState(() {});
    });
  }

  @override
  void initState() {
    super.initState();
    loadAlerts();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: Column(children: <Widget>[
          Expanded(
              child: Padding(
                  padding: const EdgeInsets.all(20.0), child: TitleWidget())),
          Expanded(child: AlertsSetList(containers)),
          DesignedWidget(),
          LoveMakingWidget()
        ]),
        backgroundColor: Colors.black);
  }
}

class AlertsSetList extends StatefulWidget {
  final List<Container> containers;

  AlertsSetList(this.containers);

  @override
  _AlertsSetListState createState() => _AlertsSetListState(containers);
}

class _AlertsSetListState extends State<AlertsSetList> {
  List<Container> containers;
  _AlertsSetListState(this.containers);
  @override
  Widget build(BuildContext context) {
    return ListView(
      padding: const EdgeInsets.all(8),
      children: <Widget>[
        ...containers,
      ],
    );
  }
}
