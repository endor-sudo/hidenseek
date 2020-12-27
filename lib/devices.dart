import 'package:flutter_blue/flutter_blue.dart';

List<BluetoothDevice> actualdevicesToList = new List<BluetoothDevice>();

class Device {
  String id, name, type, alert;
  Device(String id, String name, String type, {String alert}) {
    this.id = id;
    this.name = name;
    this.type = type;
    this.alert = alert;
  }
}

class DeviceAlert {
  String id, name, alertType;
  bool wasInRange, isInRange;
  DeviceAlert(String id, name, alertType, wasInRange, isInRange) {
    this.id = id;
    this.name = name;
    this.alertType = alertType;
    this.wasInRange = wasInRange;
    this.isInRange = isInRange;
  }
}
