import 'package:flutter/material.dart';
import 'title.dart';
import 'footer.dart';
import 'database.dart';

class AlertHistory extends StatefulWidget {
  @override
  _AlertHistoryState createState() => _AlertHistoryState();
}

class _AlertHistoryState extends State<AlertHistory> {
  List<Container> containers = new List<Container>();

  void loadAlerts() {
    getAllAlertsHistory().then((deviceAlerts) {
      for (Map<String, dynamic> alert in deviceAlerts) {
        this.setState(() {
          containers.add(Container(
            child: ExpansionTile(
              title: Row(
                children: <Widget>[
                  Expanded(
                    child: Column(
                      children: <Widget>[
                        Text(alert['id'],
                            style: TextStyle(color: Colors.green)),
                        Text(alert['time'],
                            style: TextStyle(color: Colors.green)),
                      ],
                    ),
                  ),
                ],
              ),
              //children: ,
            ),
          ));
        });
      }
      //log(containers.length.toString());
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
          Expanded(child: HistoryAlertsSetList(containers)),
          DesignedWidget(),
          LoveMakingWidget()
        ]),
        backgroundColor: Colors.black);
  }
}

class HistoryAlertsSetList extends StatefulWidget {
  final List<Container> containers;

  HistoryAlertsSetList(this.containers);

  @override
  _HistoryAlertsSetListState createState() =>
      _HistoryAlertsSetListState(containers);
}

class _HistoryAlertsSetListState extends State<HistoryAlertsSetList> {
  List<Container> containers;
  _HistoryAlertsSetListState(this.containers);
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
