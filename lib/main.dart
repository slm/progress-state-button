import 'dart:async';
import 'dart:math';

import 'package:flutter/material.dart';
import 'package:progress_button/iconed_button.dart';
import 'package:progress_button/progress_button.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Progress Button',
      theme: ThemeData(
        primarySwatch: Colors.blue,
        visualDensity: VisualDensity.adaptivePlatformDensity,
      ),
      home: ProgressButtonHomePage(title: 'Progress Button'),
    );
  }
}

class ProgressButtonHomePage extends StatefulWidget {
  ProgressButtonHomePage({Key key, this.title}) : super(key: key);

  final String title;

  @override
  _ProgressButtonHomePageState createState() => _ProgressButtonHomePageState();
}

class _ProgressButtonHomePageState extends State<ProgressButtonHomePage> {
  ButtonState stateOnlyText = ButtonState.idle;
  ButtonState stateTextWithIcon = ButtonState.idle;

  Widget buildCustomButton() {
    var progressTextButton = ProgressButton(
      stateWidgets: {
        ButtonState.idle: Text("Idle",style: TextStyle(color: Colors.white, fontWeight: FontWeight.w500),),
        ButtonState.loading: Text("Loading",style: TextStyle(color: Colors.white, fontWeight: FontWeight.w500),),
        ButtonState.fail: Text("Fail",style: TextStyle(color: Colors.white, fontWeight: FontWeight.w500),),
        ButtonState.success: Text("Success",style: TextStyle(color: Colors.white, fontWeight: FontWeight.w500),)
      },
      stateColors: {
        ButtonState.idle: Colors.grey.shade400,
        ButtonState.loading: Colors.blue.shade300,
        ButtonState.fail: Colors.red.shade300,
        ButtonState.success: Colors.green.shade400,
      },
      onPressed: onPressedCustomButton,
      state: stateOnlyText,
    );
    return progressTextButton;
  }

  Widget buildTextWithIcon() {
    return ProgressButton.iconed(iconedButtons: {
      ButtonState.idle:
          IconedButton(text: "Send", icon: Icon(Icons.send,color: Colors.white), color: Colors.deepPurple.shade500),
      ButtonState.loading:
          IconedButton(text: "Loading", color: Colors.deepPurple.shade700),
      ButtonState.fail:
          IconedButton(text: "Failed", icon: Icon(Icons.cancel,color: Colors.white), color: Colors.red.shade300),
      ButtonState.success:
          IconedButton(text: "Success", icon: Icon(Icons.check_circle,color: Colors.white,), color: Colors.green.shade400)
    }, 
    onPressed: onPressedIconWithText,
    state: stateTextWithIcon);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.title),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            buildCustomButton(),
            Padding(
              padding: EdgeInsets.all(32.0),
            ),
            buildTextWithIcon(),
          ],
        ),
      ),
    );
  }

  void onPressedCustomButton() {
    setState(() {
      switch (stateOnlyText) {
        case ButtonState.idle:
          stateOnlyText = ButtonState.loading;
          break;
        case ButtonState.loading:
          stateOnlyText = ButtonState.fail;
          break;
        case ButtonState.success:
          stateOnlyText = ButtonState.idle;
          break;
        case ButtonState.fail:
          stateOnlyText = ButtonState.success;
          break;
      }
    });
  }

  void onPressedIconWithText() {
    switch (stateTextWithIcon) {
      case ButtonState.idle:
        stateTextWithIcon = ButtonState.loading;
        Future.delayed(Duration(seconds: 1), () {
          setState(() {
            stateTextWithIcon =  Random.secure().nextBool() ? ButtonState.success : ButtonState.fail;
          });
        });

        break;
      case ButtonState.loading:
        break;
      case ButtonState.success:
        stateTextWithIcon = ButtonState.idle;
        break;
      case ButtonState.fail:
        stateTextWithIcon = ButtonState.idle;
        break;
    }
    setState(() {
      stateTextWithIcon = stateTextWithIcon;
    });
  }
}
