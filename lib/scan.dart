import 'dart:developer';

import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:hide_n_seek/main.dart';
import 'package:hide_n_seek/notification.dart';
import 'alerthistory.dart';
import 'title.dart';
import 'footer.dart';
import 'package:flutter_blue/flutter_blue.dart';
import 'alertset.dart';
import 'database.dart';
import 'devices.dart';

class Scan extends StatefulWidget {
  final FirebaseUser user;
  //final FlutterBlue flutterBlue = FlutterBlue.instance;
  Scan(this.user);
  @override
  _ScanState createState() => _ScanState(user);
}

class _ScanState extends State<Scan> {
  FirebaseUser user;
  //FlutterBlue flutterBlue;

  _ScanState(this.user);
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: Column(
          children: <Widget>[
            Expanded(
                child: Padding(
                    padding: const EdgeInsets.all(20.0), child: TitleWidget())),
            UserWidget(user),
            RadarStill(user),
            Expanded(
                child: Padding(
              padding: const EdgeInsets.all(20.0),
              child: AlertSection(user),
            )),
            DesignedWidget(),
            LoveMakingWidget(),
          ],
        ),
        backgroundColor: Colors.black);
  }
}

class RadarStill extends StatefulWidget {
  final List<BluetoothDevice> devices = new List<BluetoothDevice>();
  //final FlutterBlue flutterBlue;
  final FirebaseUser user;

  RadarStill(this.user);

  @override
  _RadarStillState createState() => _RadarStillState(user);
}

class _RadarStillState extends State<RadarStill> {
  final FirebaseUser user;
  _RadarStillState(this.user);

  @override
  void setState(fn) {
    if (mounted) {
      super.setState(fn);
    }
  }

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
    Navigator.push(
        context,
        MaterialPageRoute(
            builder: (context) => MyAppLoading(widget.devices, user)));
  }

  Future<void> checkForNotis() async {
    int notiId = 0;
    final List<DeviceAlert> devicesInAlert = new List<DeviceAlert>();
    final FlutterBlue flutterBlue = FlutterBlue.instance;

    while (true) {
      final List<Device> devicesScanned = new List<Device>();
      final List<BluetoothDevice> devicesToList = new List<BluetoothDevice>();

      //adds scanned devices to devicesScanned
      flutterBlue.scanResults.listen((results) {
        for (ScanResult result in results) {
          if (!devicesScanned.contains(result)) {
            setState(() {
              devicesScanned.add(Device(
                  result.device.id.toString(),
                  result.device.name.toString(),
                  result.device.type.toString()));
              log(result.device.id.toString());
              devicesToList.add(result.device);
            });
          }
        }
      });
      await Future.delayed(Duration(seconds: 5));
      log(devicesScanned.length.toString());

      //adds newly scanned device to devicesInAlert if it is new
      await getAllAlerts(widget.user).then((deviceAlerts) {
        for (Map<String, dynamic> alert in deviceAlerts) {
          for (Device deviceScanned in devicesScanned) {
            if (deviceScanned.id != alert['id']) {
              //fix unnecessary overpopulation
              devicesInAlert.add(DeviceAlert(
                  alert['id'], alert['name'], alert['alert'], false, true));
              log(alert['type']);
            }
          }
        }
      });

      log(devicesInAlert.length.toString());

      //sets all devicesInAlert isInRange to True
      for (DeviceAlert deviceInAlert in devicesInAlert) {
        for (Device deviceScanned in devicesScanned) {
          if (deviceInAlert.id == deviceScanned.id) {
            deviceInAlert.isInRange = true;
          }
        }
      }

      //sends notifications according to devicesInAlert attributes
      for (DeviceAlert deviceInAlert in devicesInAlert) {
        if (deviceInAlert.alertType == 'seek' &&
            deviceInAlert.wasInRange == false &&
            deviceInAlert.isInRange == true) {
          await scheduleAlarm(deviceInAlert.id.toString(), notiId);
          await saveAlert(deviceInAlert.id, widget.user);
          ++notiId;
          deviceInAlert.wasInRange = true;
        } else if (deviceInAlert.alertType == 'hide' &&
            deviceInAlert.wasInRange == true &&
            deviceInAlert.isInRange == false) {
          await scheduleAlarm(deviceInAlert.id.toString(), notiId);
          await saveAlert(deviceInAlert.id, widget.user);
          ++notiId;
          deviceInAlert.wasInRange = false;
        }
      }

      actualdevicesToList = List.from(devicesToList);

      flutterBlue.startScan(timeout: Duration(seconds: 4));

      await Future.delayed(Duration(seconds: 2));
      log('9 Fim_________________________');
    }
  }

  @override
  void initState() {
    //todo: implement initState

    super.initState();
    /*
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
    */
    checkForNotis();
  }

  @override
  Widget build(BuildContext context) {
    return Material(
      child: GestureDetector(
        onTap: this.click,
        child: Container(
          child: Image.asset('assets/radar.png'),
          height: 200,
          width: 200,
          color: Colors.black,
        ),
      ),
    );
  }
}

class AlertSection extends StatefulWidget {
  //final FlutterBlue flutterBlue;
  final FirebaseUser user;

  AlertSection(this.user);
  @override
  _AlertSectionState createState() => _AlertSectionState();
}

class _AlertSectionState extends State<AlertSection> {
  click(BuildContext context) {
    //widget.flutterBlue.stopScan();
    Navigator.push(context,
        MaterialPageRoute(builder: (context) => AlertsSetHistory(widget.user)));
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
            Navigator.push(
                context,
                MaterialPageRoute(
                    builder: (context) => AlertHistory(widget.user)));
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

/*Future<void> checkForNotis() async {
    int notiId = 0;
    final List<DeviceAlert> devicesInAlert = new List<DeviceAlert>();
    final FlutterBlue flutterBlue = FlutterBlue.instance;

    while (true) {
      final List<Device> devicesScanned = new List<Device>();
      final List<BluetoothDevice> devicesToList = new List<BluetoothDevice>();

      flutterBlue.startScan(timeout: Duration(seconds: 4));

      //adds scanned devices to devicesScanned
      flutterBlue.scanResults.listen((results) {
        for (ScanResult result in results) {
          if (!devicesScanned.contains(device)) {
            setState(() {
              devicesScanned.add(Device(result.device.id.toString(),
                  result.device.name.toString(), result.device.type.toString()));
              log(result.device.id.toString());
              devicesToList.add(result.device);
            });
          }
        }
      });

      //adds newly scanned device to devicesInAlert if it is new
      await getAllAlerts().then((deviceAlerts) {
        for (Map<String, dynamic> alert in deviceAlerts) {
          for (DeviceAlert deviceAlert in devicesInAlert) {
            if (deviceAlert.id != alert['id']) {
              devicesInAlert.add(DeviceAlert(
                  alert['id'], alert['name'], alert['type'], false, true));
            }
          }
        }
      });

      //sets all devicesInAlert isInRange to True
      for (DeviceAlert deviceInAlert in devicesInAlert) {
        for (Device deviceScanned in devicesScanned) {
          if (deviceInAlert.id == deviceScanned.id) {
            deviceInAlert.isInRange = true;
          }
        }
      }

      //sends notifications according to devicesInAlert attributes
      for (DeviceAlert deviceInAlert in devicesInAlert) {
        if (deviceInAlert.alertType == 'seek' &&
            deviceInAlert.wasInRange == false &&
            deviceInAlert.isInRange == true) {
          await scheduleAlarm(deviceInAlert.id.toString(), notiId);
          await saveAlert(deviceInAlert.id);
          ++notiId;
          deviceInAlert.wasInRange = true;
        } else if (deviceInAlert.alertType == 'hide' &&
            deviceInAlert.wasInRange == true &&
            deviceInAlert.isInRange == false) {
          await scheduleAlarm(deviceInAlert.id.toString(), notiId);
          await saveAlert(deviceInAlert.id);
          ++notiId;
          deviceInAlert.wasInRange = false;
        }
      }

      actualdevicesToList = List.from(devicesToList);

      await flutterBlue.stopScan();

      await Future.delayed(Duration(seconds: 90));
      log('9 Fim_________________________');
    }
  }*/
