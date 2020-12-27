import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_blue/flutter_blue.dart';
import 'package:hide_n_seek/devfound.dart';
import 'login.dart';
import 'package:splashscreen/splashscreen.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';

final FlutterLocalNotificationsPlugin flutterLocalNotificationsPlugin =
    FlutterLocalNotificationsPlugin();

void main() async {
  WidgetsFlutterBinding.ensureInitialized();

  var initializationSettingsAndroid = AndroidInitializationSettings('radares');
  var initializationSettingsIOS = IOSInitializationSettings(
      requestAlertPermission: true,
      requestBadgePermission: true,
      requestSoundPermission: true,
      onDidReceiveLocalNotification:
          (int id, String title, String body, String payload) async {});
  var initializationSettings = InitializationSettings(
      android: initializationSettingsAndroid, iOS: initializationSettingsIOS);
  await flutterLocalNotificationsPlugin.initialize(initializationSettings,
      onSelectNotification: (String payload) async {
    if (payload != null) {
      debugPrint('notification payload: ' + payload);
    }
  });

  runApp(new MaterialApp(
      title: 'Hide&Seek',
      theme: ThemeData(
        primarySwatch: Colors.green,
        visualDensity: VisualDensity.adaptivePlatformDensity,
      ),
      home: MyApp()));
}

class MyAppLoading extends StatefulWidget {
  final List<BluetoothDevice> devices;
  final FirebaseUser user;
  MyAppLoading(this.devices, this.user);
  @override
  _MyAppStateLoading createState() => new _MyAppStateLoading(devices, user);
}

class _MyAppStateLoading extends State<MyAppLoading> {
  List<BluetoothDevice> devices;
  final FirebaseUser user;
  _MyAppStateLoading(this.devices, this.user);
  @override
  Widget build(BuildContext context) {
    return new SplashScreen(
        seconds: 7,
        navigateAfterSeconds: new DevFound(user),
        title: new Text(
          'HideNSeek',
          style: new TextStyle(fontWeight: FontWeight.bold, fontSize: 20.0),
        ),
        image: new Image.asset('assets/radar.png'),
        backgroundColor: Colors.black,
        styleTextUnderTheLoader: new TextStyle(),
        photoSize: 100.0,
        loaderColor: Colors.green);
  }
}

class MyApp extends StatelessWidget {
// This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MyHomePage();
  }
}

//fix overpopulation on devicesInAlert
//fix disables button on devices found that is arbitrary
