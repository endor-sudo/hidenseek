import 'package:flutter/material.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:flutter_blue/flutter_blue.dart';
import 'dart:developer';

final databaseReference = FirebaseDatabase.instance.reference();

Map<String, dynamic> toJson(BluetoothDevice bluetoothDevice, String alertType) {
  return {
    'id': bluetoothDevice.id.toString(),
    'name': bluetoothDevice.name.toString(),
    'type': bluetoothDevice.type.toString(),
    'alert': alertType,
  };
}

void saveBlueDevice(
    BluetoothDevice bluetoothDevice, String alertType, BuildContext context) {
  try {
    databaseReference
        .child('btdevices/')
        .push()
        .set(toJson(bluetoothDevice, alertType));
    Navigator.of(context).pop();
  } catch (e) {
    log('------------------------------------->' + e.toString());
  }
}
