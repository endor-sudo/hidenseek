import 'package:flutter/material.dart';
import 'title.dart';
import 'footer.dart';
import 'devfound.dart';
import 'package:flutter_blue/flutter_blue.dart';

class Scan extends StatefulWidget {
  @override
  _ScanState createState() => _ScanState();
}

class _ScanState extends State<Scan> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: Column(
          children: <Widget>[
            Expanded(
                child: Padding(
                    padding: const EdgeInsets.all(20.0), child: TitleWidget())),
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
  final FlutterBlue flutterBlue = FlutterBlue.instance;
  final List<BluetoothDevice> devices = new List<BluetoothDevice>();

  @override
  _RadarStillState createState() => _RadarStillState();
}

class _RadarStillState extends State<RadarStill> {
  _addDeviceTolist(final BluetoothDevice device) {
    if (!widget.devices.contains(device)) {
      setState(() {
        widget.devices.add(device);
      });
    }
  }

  click() {
    /*
    // Start scanning
    flutterBlue.startScan(timeout: Duration(seconds: 4));

    // Listen to scan results
    StreamSubscription<List<ScanResult>> subscription =
        flutterBlue.scanResults.listen((results) {
      // do something with scan results
      for (ScanResult r in results) {
        print('==================>${r.device.name} found! rssi: ${r.rssi}');
      }
      devices = results;
    });

    // Stop scanning
    flutterBlue.stopScan();
    //sleep(const Duration(seconds: 10));
    */
    widget.flutterBlue.stopScan();
    Navigator.push(context,
        MaterialPageRoute(builder: (context) => DevFound(widget.devices)));
  }

  @override
  void initState() {
    //todo: implement initState
    super.initState();
    widget.flutterBlue.connectedDevices
        .asStream()
        .listen((List<BluetoothDevice> devices) {
      for (BluetoothDevice device in devices) {
        _addDeviceTolist(device);
      }
    });
    widget.flutterBlue.scanResults.listen((List<ScanResult> results) {
      for (ScanResult result in results) {
        _addDeviceTolist(result.device);
      }
    });
    widget.flutterBlue.startScan();
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
        RaisedButton(
          child: Text('Alert History'),
          color: Colors.green,
          onPressed: () {/** */},
        ),
        RaisedButton(
          child: Text('Alerts Set'),
          color: Colors.green,
          onPressed: () {/** */},
        ),
      ],
      alignment: MainAxisAlignment.center,
    );
  }
}
