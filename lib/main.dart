import 'package:flutter/material.dart';
import 'package:poker_hand_history/cut_corners_border.dart';
import 'package:poker_hand_history/main_scaffold.dart';

void main() => runApp(new MyApp());

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return new MaterialApp(
      title: 'Flutter Demo',
      theme: new ThemeData(
          inputDecorationTheme: InputDecorationTheme(
            border: new CutCornersBorder(),
          ),
          scaffoldBackgroundColor: Colors.green[200],
          primaryColor: Colors.green[600],
          accentColor: Colors.deepOrange[500],
          brightness: Brightness.light
      ),
      home: new MainScaffold(),
    );
  }
}
