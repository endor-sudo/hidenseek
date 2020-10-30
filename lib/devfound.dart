import 'package:flutter/material.dart';
import 'package:flutter_blue/flutter_blue.dart';
import 'title.dart';
import 'footer.dart';

class DevFound extends StatefulWidget {
  final List<BluetoothDevice> devices;

  DevFound(this.devices);

  @override
  _DevFoundState createState() => _DevFoundState();
}

class _DevFoundState extends State<DevFound> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: Column(children: <Widget>[
          Expanded(
              child: Padding(
                  padding: const EdgeInsets.all(20.0), child: TitleWidget())),
          Expanded(child: DevList(widget.devices)),
          DesignedWidget(),
          LoveMakingWidget()
        ]),
        backgroundColor: Colors.black87);
  }
}

class DevList extends StatefulWidget {
  final List<BluetoothDevice> devices;
  DevList(this.devices);
  @override
  _DevListState createState() => _DevListState();
}

class _DevListState extends State<DevList> {
  @override
  Widget build(BuildContext context) {
    return _buildListViewOfDevices(widget.devices);
  }
}

ListView _buildListViewOfDevices(final List<BluetoothDevice> devices) {
  List<Container> containers = new List<Container>();
  for (BluetoothDevice device in devices) {
    containers.add(
      Container(
        height: 50,
        child: Row(
          children: <Widget>[
            Expanded(
              child: Column(
                children: <Widget>[
                  Text(device.name == '' ? '(unknown device)' : device.name,
                      style: TextStyle(color: Colors.green)),
                  Text(device.id.toString(),
                      style: TextStyle(color: Colors.green)),
                ],
              ),
            ),
            FlatButton(
              color: Colors.green,
              child: Text(
                'Alert',
                style: TextStyle(color: Colors.white),
              ),
              onPressed: () {},
            ),
          ],
        ),
      ),
    );
  }

  return ListView(
    padding: const EdgeInsets.all(8),
    children: <Widget>[
      ...containers,
    ],
  );
}
