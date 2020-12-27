import 'package:firebase_auth/firebase_auth.dart';
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

void saveBlueDevice(BluetoothDevice bluetoothDevice, String alertType,
    BuildContext context, FirebaseUser user) {
  try {
    log(user.uid);
    databaseReference
        .child(user.uid + '/btdevices')
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

Future<void> saveAlert(String id, FirebaseUser user) async {
  try {
    databaseReference
        .child(user.uid.toString() + '/deviceAlerts')
        .push()
        .set(alertToJson(id));
  } catch (e) {
    log('------------------------------------->' + e.toString());
  }
}

Future<List<Map<String, dynamic>>> getAllAlerts(FirebaseUser user) async {
  DataSnapshot dataSnapshot =
      await databaseReference.child(user.uid + '/btdevices').once();
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

Future<List<Map<String, dynamic>>> getAllAlertsHistory(
    FirebaseUser user) async {
  DataSnapshot dataSnapshot =
      await databaseReference.child(user.uid + '/deviceAlerts').once();
  List<Map<String, dynamic>> deviceAlerts = [];
  if (dataSnapshot.value != null) {
    dataSnapshot.value.forEach((key, value) => {
          deviceAlerts.add({
            'id': value['id'],
            'time': value['time'],
          }),
          //log('>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>' + value['id']),
          //log('>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>' + value['name']),
          //log('>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>' + value['type']),
        });
  }
  //log(deviceAlerts.length.toString());
  return deviceAlerts;
}

Future<void> clearAllHistory(FirebaseUser user) async {
  await databaseReference.child(user.uid + '/deviceAlerts').remove();
}

Future<void> deleteAlert(String id, FirebaseUser user) async {
  DataSnapshot dataSnapshot =
      await databaseReference.child(user.uid + '/btdevices').once();
  dynamic entryID;
  if (dataSnapshot.value != null) {
    dataSnapshot.value.forEach((key, value) => {
          if (value['id'] == id) {entryID = key}
          //log('>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>' + value['id']),
          //log('>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>' + value['name']),
          //log('>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>' + value['type']),
        });
  }
  await databaseReference.child('btdevices/' + entryID.toString()).remove();
  //log(deviceAlerts.length.toString());
}

Future<bool> hasAlertBeenSet(FirebaseUser user, String id) async {
  DataSnapshot dataSnapshot =
      await databaseReference.child(user.uid + '/deviceAlerts').once();
  bool itHas;
  if (dataSnapshot.value != null) {
    dataSnapshot.value.forEach((key, value) => {
          if (value['id'] == id) {itHas = true},
          log('>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>' + value['id']),
          log('>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>' + id),
          //log('>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>' + value['type']),
        });
  }
  log('isHas:' + itHas.toString());
  return itHas;
}
