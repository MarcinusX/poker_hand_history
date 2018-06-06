import 'package:flutter/material.dart';
import 'package:poker_hand_history/card_picker.dart';

void main() => runApp(new MyApp());

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return new MaterialApp(
      title: 'Flutter Demo',
      theme: new ThemeData(
        primarySwatch: Colors.green,
      ),
      home: new Builder(
        builder: (context) =>
        new Scaffold(
          body: new Container(),
          floatingActionButtonLocation: FloatingActionButtonLocation
              .centerFloat,
          floatingActionButton: new FloatingActionButton(
            onPressed: () =>
                Navigator.of(context).push(new MaterialPageRoute(
                  builder: (context) => new CardPicker(),
                )),
          ),
        ),
      ),
    );
  }
}
