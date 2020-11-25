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

Map<String, dynamic> alertToJson(String id) {
  return {
    'id': id,
    'time': DateTime.now().year.toString() +
        '/' +
        DateTime.now().month.toString() +
        '/' +
        DateTime.now().day.toString() +
        '@' +
        DateTime.now().hour.toString() +
        ':' +
        DateTime.now().minute.toString() +
        ':' +
        DateTime.now().second.toString(),
  };
}

void saveAlert(String id) {
  try {
    databaseReference.child('deviceAlerts/').push().set(alertToJson(id));
  } catch (e) {
    log('------------------------------------->' + e.toString());
  }
}

Future<List<Map<String, dynamic>>> getAllAlerts() async {
  DataSnapshot dataSnapshot =
      await databaseReference.child('btdevices/').once();
  List<Map<String, dynamic>> deviceAlerts = [];
  if (dataSnapshot.value != null) {
    dataSnapshot.value.forEach((key, value) => {
          deviceAlerts.add({
            'id': value['id'],
            'name': value['name'],
            'type': value['type'],
            'alert': value['alert']
          }),
          //log('>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>' + value['id']),
          //log('>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>' + value['name']),
          //log('>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>' + value['type']),
        });
  }
  //log(deviceAlerts.length.toString());
  return deviceAlerts;
}
