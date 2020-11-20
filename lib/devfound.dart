import 'package:flutter/material.dart';
import 'package:flutter_blue/flutter_blue.dart';
import 'title.dart';
import 'footer.dart';
import 'database.dart';

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
        backgroundColor: Colors.black);
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
    return _buildListViewOfDevices(widget.devices, context);
  }
}

ListView _buildListViewOfDevices(
    final List<BluetoothDevice> devices, BuildContext context) {
  List<Container> containers = new List<Container>();

  void popup(BluetoothDevice device, BuildContext context, String customText) {
    AlertDialog alert = AlertDialog(
      title: Text(
        "Are you sure you want to " + customText + " this device?",
        style: TextStyle(color: Colors.green),
      ),
      content: Text(device.id.toString()),
      actions: [
        FlatButton(
          color: Colors.green,
          child: Text(
            'Yes',
            style: TextStyle(color: Colors.white),
          ),
          onPressed: () => saveBlueDevice(device, customText, context),
        ),
        FlatButton(
          color: Colors.green,
          child: Text(
            'No',
            style: TextStyle(color: Colors.white),
          ),
          onPressed: () {
            Navigator.of(context).pop();
          },
        ),
      ],
      elevation: 24.9,
      backgroundColor: Colors.black,
    );
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return alert;
      },
    );
  }

  List<Widget> alertButtonsFunc(BluetoothDevice device, BuildContext context) {
    List<Widget> alertButtons = new List<Widget>();
    alertButtons.add(
      FlatButton(
        color: Colors.green,
        child: Text(
          'Hide',
          style: TextStyle(color: Colors.white),
        ),
        onPressed: () => popup(device, context, "hide"),
      ),
    );
    alertButtons.add(
      FlatButton(
        color: Colors.green,
        child: Text(
          'Seek',
          style: TextStyle(color: Colors.white),
        ),
        onPressed: () => popup(device, context, "seek"),
      ),
    );
    return alertButtons;
  }

  for (BluetoothDevice device in devices) {
    containers.add(Container(
      child: ExpansionTile(
        title: Row(
          children: <Widget>[
            Expanded(
              child: Column(
                children: <Widget>[
                  Text(device.name == '' ? '(unknown device)' : device.name,
                      style: TextStyle(color: Colors.green)),
                  Text(device.id.toString(),
                      style: TextStyle(color: Colors.green)),
                  Text(device.type.toString(),
                      style: TextStyle(color: Colors.green)),
                ],
              ),
            ),
          ],
        ),
        children: alertButtonsFunc(device, context),
      ),
    ));
  }

  return ListView(
    padding: const EdgeInsets.all(8),
    children: <Widget>[
      ...containers,
    ],
  );
}
