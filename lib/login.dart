import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'title.dart';
import 'footer.dart';
import 'scan.dart';
import 'auth.dart';

class MyHomePage extends StatefulWidget {
  @override
  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  String emailAddr = "";
  String alertText = "";

  @override
  void initState() {
    super.initState();
    signOutGoogle();
  }

  @override
  void dispose() {
    super.dispose();
    this.dispose();
  }

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
        body: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            mainAxisSize: MainAxisSize.min,
            children: <Widget>[
              Expanded(
                  flex: 0,
                  child: Padding(
                      padding: const EdgeInsets.all(100.0),
                      child: TitleWidget())),
              EmailField(this.setEmail),
              //EmailSubmitionWidget(this.alertText),
              DesignedWidget(),
              LoveMakingWidget(),
            ],
          ),
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
  //made irrelevant by Firebase
  //final controller = TextEditingController();
  FirebaseUser user;

  @override
  void dispose() {
    super.dispose();
    //made irrelevant by Firebase
    //controller.dispose();
  }

  Future<void> click() async {
    //made irrelevant by Firebase
    //widget.callback(controller.text);
    //controller.clear();
    await Future.delayed(Duration(seconds: 1));
    signInWithGoogle().then((user) => {
          this.user = user,
          Navigator.push(
              context, MaterialPageRoute(builder: (context) => Scan(user)))
        });
  }

  Widget googleLoginButton() {
    return OutlineButton(
        onPressed: this.click,
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(45)),
        splashColor: Colors.green,
        borderSide: BorderSide(color: Colors.grey),
        child: Padding(
            padding: EdgeInsets.fromLTRB(0, 10, 0, 10),
            child: Row(
              mainAxisSize: MainAxisSize.min,
              mainAxisAlignment: MainAxisAlignment.center,
              children: <Widget>[
                Image(image: AssetImage('assets/google_logo.png'), height: 35),
                Padding(
                  padding: EdgeInsets.only(left: 10),
                  child: Text(
                    'Sign in with Google',
                    style: TextStyle(color: Colors.green, fontSize: 25),
                  ),
                )
              ],
            )));
  }

  @override
  Widget build(BuildContext context) {
    //made irrelevant by Firebase
    /*
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
    */
    return googleLoginButton();
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
