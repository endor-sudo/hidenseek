import 'package:flutter/material.dart';
import 'title.dart';
import 'footer.dart';
import 'scan.dart';

class MyHomePage extends StatefulWidget {
  @override
  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  String emailAddr = "";
  String alertText = "";

  void setEmail(String emailInput) {
    //write validation
    this.emailAddr = emailInput;
    this.setState(() {
      this.alertText = this.emailAddr + " has been submitted";
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: Column(
          children: <Widget>[
            Expanded(
                child: Padding(
                    padding: const EdgeInsets.all(20.0), child: TitleWidget())),
            EmailField(this.setEmail),
            EmailSubmitionWidget(this.alertText),
            DesignedWidget(),
            LoveMakingWidget(),
          ],
        ),
        backgroundColor: Colors.black87);
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

  Future<void> click() async {
    widget.callback(controller.text);
    controller.clear();
    await Future.delayed(Duration(seconds: 1));
    Navigator.push(context, MaterialPageRoute(builder: (context) => Scan()));
  }

  @override
  Widget build(BuildContext context) {
    return TextField(
        controller: this.controller,
        style: TextStyle(color: Colors.green),
        decoration: InputDecoration(
            prefixIcon: Icon(
              Icons.email,
              color: Colors.green,
            ),
            labelText: "Type in your recovery email",
            labelStyle: TextStyle(color: Colors.green),
            suffixIcon: IconButton(
              icon: Icon(
                Icons.send,
                color: Colors.green,
              ),
              splashColor: Colors.green, //fix splashcolor
              tooltip: "Submit",
              onPressed: this.click,
            ),
            filled: false, //fill???
            fillColor: Colors.greenAccent));
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
    return Text(
      at,
      style: TextStyle(color: Colors.amber),
    );
  }
}
