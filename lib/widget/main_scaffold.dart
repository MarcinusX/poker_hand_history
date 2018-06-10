import 'package:flutter/material.dart';
import 'package:poker_hand_history/data/database_helper.dart';
import 'package:poker_hand_history/model/hand.dart';
import 'package:poker_hand_history/widget/card_picker.dart';
import 'package:poker_hand_history/widget/hand_row.dart';

class MainScaffold extends StatefulWidget {
  @override
  MainScaffoldState createState() {
    return new MainScaffoldState();
  }
}

class MainScaffoldState extends State<MainScaffold> {
  List<Hand> hands = [];

  DatabaseHelper dbHelper = DatabaseHelper();

  @override
  void initState() {
    super.initState();
    dbHelper.getAllHands().then((res) => setState(() => hands = res));
  }

  @override
  Widget build(BuildContext context) {
    return new Builder(
      builder: (context) {
        return new Scaffold(
          body: _buildScaffoldBody(),
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
                  icon: Icon(Icons.assistant),
                  onPressed: () {
                    showDialog<bool>(
                      context: context,
                      builder: (context) {
                        return new AlertDialog(
                          title: new Text("Start new session?"),
                          content: new Text(
                              "You will loose all current data (for now)"),
                          actions: <Widget>[
                            new FlatButton(
                              onPressed: () => Navigator.of(context).pop(),
                              child: new Text("CANCEL"),
                            ),
                            new FlatButton(
                              onPressed: () => Navigator.of(context).pop(true),
                              child: new Text("PROCEED"),
                            ),
                          ],
                        );
                      },
                    ).then((clear) {
                      if (clear ?? false) {
                        dbHelper.deleteAllHands();
                        setState(() => hands = []);
                      }
                    });
                  },
                ),
              ],
            ),
          ),
          appBar: new AppBar(
            title: new Text(
              "Hands from today",
              style: new TextStyle(color: Colors.black),
            ),
            centerTitle: true,
            elevation: 0.0,
            backgroundColor: Colors.transparent,
          ),
          floatingActionButtonLocation:
              FloatingActionButtonLocation.centerDocked,
          floatingActionButton: new FloatingActionButton(
            onPressed: _onFabPressed,
            child: new Icon(Icons.add),
          ),
        );
      },
    );
  }

  ListView _buildScaffoldBody() {
    return new ListView.builder(
      itemBuilder: (context, index) {
//        if (index == 0) {
//          return _buildHandsHeader();
//        } else {
        return new HandRow(
          hand: hands[index],
        );
//        }
      },
      itemCount: hands.length,
    );
  }

  Widget _buildHandsHeader() {
    return new Padding(
      padding: const EdgeInsets.all(8.0),
      child: new Center(
        child: new Text(
          "Hands from today:",
          style: Theme
              .of(context)
              .textTheme
              .display1
              .copyWith(color: Colors.black),
        ),
      ),
    );
  }

  _onFabPressed() {
    Navigator
        .of(context)
        .push(new MaterialPageRoute<Hand>(
          builder: (context) {
            return new CardPicker(
              initialStack: hands.isEmpty ? 0.0 : hands.last.stack,
            );
          },
          fullscreenDialog: true,
        ))
        .then((hand) {
      if (hand != null) {
        dbHelper.saveHand(hand);
        setState(() {
          hands.add(hand);
        });
      }
    });
  }
}
