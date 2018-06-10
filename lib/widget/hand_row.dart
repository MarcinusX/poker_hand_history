import 'package:flutter/material.dart';
import 'package:poker_hand_history/model/card.dart';
import 'package:poker_hand_history/model/hand.dart';
import 'package:poker_hand_history/widget/suit_widget.dart';

class HandRow extends StatelessWidget {
  final Hand hand;

  const HandRow({Key key, this.hand}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return new ListTile(
      title: new Row(
        children: <Widget>[
          new Text(
            rankToSymbol(hand.leftCard.rank),
            style: new TextStyle(
                color: suitToColor(hand.leftCard.suit),
                fontWeight: FontWeight.bold),
          ),
          new Padding(
            padding: const EdgeInsets.only(right: 8.0),
            child: new SuitWidget(
              suit: hand.leftCard.suit,
              size: 20.0,
            ),
          ),
          new Text(
            rankToSymbol(hand.rightCard.rank),
            style: new TextStyle(
                color: suitToColor(hand.rightCard.suit),
                fontWeight: FontWeight.bold),
          ),
          new Padding(
            padding: const EdgeInsets.symmetric(horizontal: 0.0),
            child: new SuitWidget(
              suit: hand.rightCard.suit,
              size: 20.0,
            ),
          ),
        ],
      ),
      trailing: new Text("${hand.stack}"),
    );
  }
}
