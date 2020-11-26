import 'dart:developer';

import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:hide_n_seek/notification.dart';
import 'alerthistory.dart';
import 'title.dart';
import 'footer.dart';
import 'devfound.dart';
import 'package:flutter_blue/flutter_blue.dart';
import 'alertset.dart';
import 'database.dart';

class Scan extends StatefulWidget {
  final FirebaseUser user;
  final FlutterBlue flutterBlue = FlutterBlue.instance;
  Scan(this.user);
  @override
  _ScanState createState() => _ScanState(user, flutterBlue);
}

class _ScanState extends State<Scan> {
  FirebaseUser user;
  FlutterBlue flutterBlue;

  _ScanState(this.user, this.flutterBlue);
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: Column(
          children: <Widget>[
            Expanded(
                child: Padding(
                    padding: const EdgeInsets.all(20.0), child: TitleWidget())),
            UserWidget(user),
            RadarStill(flutterBlue),
            AlertSection(flutterBlue),
            DesignedWidget(),
            LoveMakingWidget(),
          ],
        ),
        backgroundColor: Colors.black);
  }
}

class RadarStill extends StatefulWidget {
  final List<BluetoothDevice> devices = new List<BluetoothDevice>();
  final FlutterBlue flutterBlue;

  RadarStill(this.flutterBlue);

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
    //widget.flutterBlue.stopScan();
    Navigator.push(context,
        MaterialPageRoute(builder: (context) => DevFound(widget.devices)));
  }

  Future<void> checkForNotis() async {
    int notiId = 0;
    List<String> devicesAlertedLast = new List<String>();
    while (true) {
      final List<String> devicesInAlert = new List<String>();
      final List<String> devicesScanned = new List<String>();
      final List<String> devicesToAlert = new List<String>();

      await Future.delayed(Duration(seconds: 10));

      //the phone keeps getting notifications after the blutooth is turned off
      //stop scan? create another instance?
      widget.flutterBlue.scanResults.listen((List<ScanResult> results) {
        for (ScanResult result in results) {
          setState(() {
            devicesScanned.add(result.device.id.toString());
            //log('IdScanned: ' + result.device.id.toString());
          });
        }
      });

      await getAllAlerts().then((deviceAlerts) {
        for (Map<String, dynamic> alert in deviceAlerts) {
          devicesInAlert.add(alert['id']);
        }
      });
      //gotta make a class for Device
      //log(devicesScanned.length.toString());
      //log(devicesInAlert.length.toString());
      for (String Scan_id in devicesScanned) {
        for (String Alert_id in devicesInAlert) {
          //log(Scan_id + '--------' + Alert_id);
          if (Scan_id == Alert_id) {
            for (String id in devicesAlertedLast) {
              log('1 devicesAlertedLastNoIF');
              log('2 ' + id.toString() + 'IF' + Scan_id);
            }
            if (!devicesAlertedLast.contains(Scan_id)) {
              devicesToAlert.add(Scan_id);
              await scheduleAlarm(
                  Scan_id.toString() + ' == ' + Alert_id.toString(), notiId);
              await saveAlert(Alert_id);
              ++notiId;
              log('3 ' +
                  devicesAlertedLast.contains(Scan_id).toString() +
                  ' ao contrario1');
            }
          }
        }
      }
      //program when a device goes out of range and comes back again(dependent on //the phone keeps getting notifications after the blutooth is turned off //stop scan? create another instance?)
      for (String id in devicesAlertedLast) {
        log('4 devicesAlertedLastAntesDoClone');
        log('5 ' + id.toString());
      }
      devicesAlertedLast = List.from(devicesAlertedLast)
        ..addAll(devicesToAlert);
      log('6 devicesAlertedLastDepoisDoClone');
      for (String id in devicesAlertedLast) {
        log('7 ' + id.toString());
      }
      log('8 ' +
          devicesAlertedLast.contains('4A:85:46:14:08:02').toString() +
          ' ao contrario2');
      log('9 Fim_________________________');
    }
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
    //Check whether a notification should be sent
    checkForNotis();
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

class AlertSection extends StatefulWidget {
  final FlutterBlue flutterBlue;

  AlertSection(this.flutterBlue);
  @override
  _AlertSectionState createState() => _AlertSectionState();
}

class _AlertSectionState extends State<AlertSection> {
  click(BuildContext context) {
    //widget.flutterBlue.stopScan();
    Navigator.push(
        context, MaterialPageRoute(builder: (context) => AlertsSetHistory()));
  }

  @override
  Widget build(BuildContext context) {
    return ButtonBar(
      children: <Widget>[
        RaisedButton(
          child: Text('Alert History'),
          color: Colors.green,
          onPressed: () {
            //widget.flutterBlue.stopScan();
            Navigator.push(context,
                MaterialPageRoute(builder: (context) => AlertHistory()));
          },
        ),
        RaisedButton(
          child: Text('Alerts Set'),
          color: Colors.green,
          onPressed: () => click(context),
        ),
      ],
      alignment: MainAxisAlignment.center,
    );
  }
}

class UserWidget extends StatelessWidget {
  final FirebaseUser user;

  UserWidget(this.user);

  @override
  Widget build(BuildContext context) {
    return Text(
      'Welcome ' + user.displayName + '.',
      style: TextStyle(color: Colors.green),
    );
  }
}
