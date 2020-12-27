import 'package:timezone/timezone.dart' as tz;

import 'package:timezone/data/latest.dart';
import 'package:timezone/timezone.dart' as t;
import 'package:flutter_native_timezone/flutter_native_timezone.dart';

import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'main.dart';

class TimeZone {
  factory TimeZone() => _this ?? TimeZone._();

  TimeZone._() {
    initializeTimeZones();
  }
  static TimeZone _this;

  Future<String> getTimeZoneName() async =>
      FlutterNativeTimezone.getLocalTimezone();

  Future<t.Location> getLocation([String timeZoneName]) async {
    if (timeZoneName == null || timeZoneName.isEmpty) {
      timeZoneName = await getTimeZoneName();
    }
    return t.getLocation(timeZoneName);
  }
}

Future<void> scheduleAlarm(String setalert, int id) async {
  final timeZone = TimeZone();
  DateTime dateTime = DateTime.now().add(Duration(seconds: 1));
  // The device's timezone.
  String timeZoneName = await timeZone.getTimeZoneName();
  // Find the 'current location'
  final location = await timeZone.getLocation(timeZoneName);
  final scheduledDate = tz.TZDateTime.from(dateTime, location);

  var androidPlatformChannelSpecifics = AndroidNotificationDetails(
    'alarm_notif',
    'alarm_notif',
    'Channel for Alarm notification',
    icon: 'radares',
  );

  var platformChannelSpecifics =
      NotificationDetails(android: androidPlatformChannelSpecifics);
  await flutterLocalNotificationsPlugin.zonedSchedule(
    id,
    'HideNSeek',
    setalert,
    scheduledDate,
    platformChannelSpecifics,
    androidAllowWhileIdle: true,
    uiLocalNotificationDateInterpretation: null,
  );
}
