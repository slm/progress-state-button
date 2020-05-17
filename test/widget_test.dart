// This is a basic Flutter widget test.
//
// To perform an interaction with a widget in your test, use the WidgetTester
// utility that Flutter provides. For example, you can send tap and scroll
// gestures. You can also use WidgetTester to find child widgets in the widget
// tree, read text, and verify that the values of widget properties are correct.

import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:progress_state_button/iconed_button.dart';
import 'package:progress_state_button/progress_button.dart';

void main() {
  testWidgets('State Change idle to loading', (WidgetTester tester) async {
    await tester.pumpWidget(TestApp(
      currentState: ButtonState.idle,
      nextState: ButtonState.loading,
    ));

    expect(find.text("Send"), findsOneWidget);

    await tester.tap(find.byIcon(Icons.send));
    await tester.pump();

    // Verify that our counter has incremented.
    expect(find.text('Send'), findsNothing);
    expect(find.byType(CircularProgressIndicator), findsOneWidget);
  });

  testWidgets('State Change loading to success', (WidgetTester tester) async {
    await tester.pumpWidget(TestApp(
      currentState: ButtonState.loading,
      nextState: ButtonState.success,
    ));

    expect(find.byType(CircularProgressIndicator), findsOneWidget);

    await tester.tap(find.byType(CircularProgressIndicator));
    await tester.pump();

    // Verify that our counter has incremented.
    expect(find.text('Success'), findsOneWidget);
  });

  testWidgets('State Change loading to fail', (WidgetTester tester) async {
    await tester.pumpWidget(TestApp(
      currentState: ButtonState.loading,
      nextState: ButtonState.fail,
    ));

    expect(find.byType(CircularProgressIndicator), findsOneWidget);

    await tester.tap(find.byType(CircularProgressIndicator));
    await tester.pump();

    // Verify that our counter has incremented.
    expect(find.text('Failed'), findsOneWidget);
  });

  testWidgets('State Change fail to idle', (WidgetTester tester) async {
    await tester.pumpWidget(TestApp(
      currentState: ButtonState.fail,
      nextState: ButtonState.idle,
    ));

    expect(find.text("Failed"), findsOneWidget);

    await tester.tap(find.byType(ProgressButton));
    await tester.pump();

    // Verify that our counter has incremented.
    expect(find.text('Send'), findsOneWidget);
  });
}

<<<<<<< HEAD
 class TestApp extends StatelessWidget {

  final ButtonState currentState;
  final ButtonState nextState;
=======
class TestApp extends StatelessWidget {
  ButtonState currentState;
  ButtonState nextState;
>>>>>>> 9560764fa7f05b69c2307a3b2bdce8e524caf0e7

  TestApp({Key key, this.currentState, this.nextState}) : super(key: key);

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Progress Button',
      theme: ThemeData(
        primarySwatch: Colors.blue,
        visualDensity: VisualDensity.adaptivePlatformDensity,
      ),
      home: ProgressButtonHomePage(
          currentState: currentState, nextState: nextState),
    );
  }
}

class ProgressButtonHomePage extends StatefulWidget {
  final ButtonState currentState;
  final ButtonState nextState;

  ProgressButtonHomePage({Key key, this.currentState, this.nextState})
      : super(key: key);

  @override
  _ProgressButtonHomePageState createState() => _ProgressButtonHomePageState(
      currentState: currentState, nextState: nextState);
}

class _ProgressButtonHomePageState extends State<ProgressButtonHomePage> {
  ButtonState currentState;
  ButtonState nextState;

  _ProgressButtonHomePageState({this.currentState, this.nextState}) : super();

  ButtonState state;

  @override
  void initState() {
    super.initState();
    setState(() {
      state = currentState;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(),
      body: Center(
          child: ProgressButton.icon(
              iconedButtons: {
            ButtonState.idle: IconedButton(
                text: "Send",
                icon: Icon(Icons.send, color: Colors.white),
                color: Colors.deepPurple.shade500),
            ButtonState.loading: IconedButton(
                text: "Loading", color: Colors.deepPurple.shade700),
            ButtonState.fail: IconedButton(
                text: "Failed",
                icon: Icon(Icons.cancel, color: Colors.white),
                color: Colors.red.shade300),
            ButtonState.success: IconedButton(
                text: "Success",
                icon: Icon(
                  Icons.check_circle,
                  color: Colors.white,
                ),
                color: Colors.green.shade400)
          },
              onPressed: () {
                setState(() {
                  state = nextState;
                });
              },
              state: state)),
    );
  }
}
