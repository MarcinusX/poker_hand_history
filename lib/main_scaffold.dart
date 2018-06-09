import 'package:flutter/material.dart';
import 'package:poker_hand_history/card_picker.dart';
import 'package:poker_hand_history/hand.dart';

class MainScaffold extends StatefulWidget {
  @override
  MainScaffoldState createState() {
    return new MainScaffoldState();
  }
}

class MainScaffoldState extends State<MainScaffold> {
  List<Hand> hands = [];

  @override
  Widget build(BuildContext context) {
    return new Builder(
      builder: (context) => new Scaffold(
            body: new ListView(
              children: hands
                  .map((hand) => new ListTile(
                        title: new Text(hand.toString()),
                      ))
                  .toList(),
            ),
            bottomNavigationBar: BottomAppBar(
              color: Theme.of(context).primaryColor,
              child: new Row(
                mainAxisSize: MainAxisSize.max,
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: <Widget>[
                  IconButton(
                    icon: Icon(Icons.menu),
                    onPressed: () {},
                  ),
                  IconButton(
                    icon: Icon(Icons.search),
                    onPressed: () {},
                  ),
                ],
              ),
            ),
            floatingActionButtonLocation:
                FloatingActionButtonLocation.centerDocked,
            floatingActionButton: new FloatingActionButton(
              onPressed: _onFabPressed,
              child: new Icon(Icons.add),
            ),
          ),
    );
  }

  _onFabPressed() {
    Navigator
        .of(context)
        .push(new MaterialPageRoute<Hand>(
          builder: (context) => new CardPicker(),
        ))
        .then((hand) {
      if (hand != null) {
        setState(() {
          hands.add(hand);
        });
      }
    });
  }
}
