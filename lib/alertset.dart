import 'package:flutter/material.dart';
import 'database.dart';
import 'title.dart';
import 'footer.dart';

class AlertsSetHistory extends StatefulWidget {
  @override
  _AlertsSetHistoryState createState() => _AlertsSetHistoryState();
}

class _AlertsSetHistoryState extends State<AlertsSetHistory> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: Column(children: <Widget>[
          Expanded(
              child: Padding(
                  padding: const EdgeInsets.all(20.0), child: TitleWidget())),
          Expanded(child: AlertsSetList()),
          DesignedWidget(),
          LoveMakingWidget()
        ]),
        backgroundColor: Colors.black);
  }
}

class AlertsSetList extends StatefulWidget {
  @override
  _AlertsSetListState createState() => _AlertsSetListState();
}

class _AlertsSetListState extends State<AlertsSetList> {
  List<Container> containers = new List<Container>();
  @override
  Widget build(BuildContext context) {
    gelAllAlerts().then((deviceAlerts) => {
          for (Map<String, dynamic> alert in deviceAlerts)
            {
              alert.forEach((k, v) => containers.add(Container(
                    child: ExpansionTile(
                      title: Row(
                        children: <Widget>[
                          Expanded(
                            child: Column(
                              children: <Widget>[
                                Text(alert['name'],
                                    style: TextStyle(color: Colors.green)),
                                Text(alert['id'],
                                    style: TextStyle(color: Colors.green)),
                                Text(alert['type'],
                                    style: TextStyle(color: Colors.green)),
                              ],
                            ),
                          ),
                        ],
                      ),
                      //children: ,
                    ),
                  )))
            },
          this.setState(() {})
        });
    return ListView(
      padding: const EdgeInsets.all(8),
      children: <Widget>[
        ...containers,
      ],
    );
  }
}
