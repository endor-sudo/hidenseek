import 'package:flutter/material.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
// This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Hide&Seek',
      theme: ThemeData(
        primarySwatch: Colors.pink,
        visualDensity: VisualDensity.adaptivePlatformDensity,
      ),
      home: MyHomePage(),
    );
  }
}

class MyHomePage extends StatefulWidget {
  @override
  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  String emailAddr = "";
  String alertText = "";

  void setEmail(String emailInput) {
    this.emailAddr = emailInput;
    this.setState(() {
      this.alertText = this.emailAddr + " has been submitted";
    });
  }

  @override
  Widget build(BuildContext context) {
    print(this.alertText);
    return Scaffold(
        body: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: <Widget>[
            TitleWidget(),
            EmailField(this.setEmail),
            EmailSubmitionWidget(this.alertText),
            DesignedWidget(),
            LoveMakingWidget(),
          ],
        ),
        backgroundColor: Colors.deepPurpleAccent[700]);
  }
}

class TitleWidget extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Text('Hide \'n Seek');
  }
}

class EmailSubmitionWidget extends StatelessWidget {
  final String at;

  EmailSubmitionWidget(this.at);
  //conventional constructor
  //static String at;

  //EmailSubmitionWidget(String alertText) {
  //  EmailSubmitionWidget.at = alertText;
  //}
  @override
  Widget build(BuildContext context) {
    return Text(at);
  }
}

class DesignedWidget extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Text('Designed by diletante Ideas');
  }
}

class LoveMakingWidget extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Text('Made with love in a shack');
  }
}

class EmailField extends StatefulWidget {
  final Function(String) callback;

  EmailField(this.callback);

  @override
  _EmailFieldState createState() => _EmailFieldState();
}

class _EmailFieldState extends State<EmailField> {
  final controller = TextEditingController();

  @override
  void dispose() {
    super.dispose();
    controller.dispose();
  }

  void click() {
    widget.callback(controller.text);
    controller.clear();
  }

  @override
  Widget build(BuildContext context) {
    return TextField(
        controller: this.controller,
        decoration: InputDecoration(
            prefixIcon: Icon(Icons.email),
            labelText: "Type in your recovery email",
            suffixIcon: IconButton(
              icon: Icon(Icons.send),
              splashColor: Colors.pink,
              tooltip: "Submit",
              onPressed: this.click,
            ),
            filled: true,
            fillColor: Colors.deepPurpleAccent));
  }
}
