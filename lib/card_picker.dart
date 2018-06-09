import 'package:flutter/material.dart';
import 'package:poker_hand_history/card.dart';
import 'package:poker_hand_history/card_view.dart';
import 'package:poker_hand_history/hand.dart';

class CardPicker extends StatefulWidget {
  final num initialStack;

  const CardPicker({Key key, this.initialStack}) : super(key: key);

  @override
  _CardPickerState createState() => _CardPickerState();
}

class _CardPickerState extends State<CardPicker>
    with SingleTickerProviderStateMixin {
  AnimationController _animationController;
  PlayingCard leftCard;
  PlayingCard rightCard;
  final leftKey = new GlobalKey();
  final rightKey = new GlobalKey();

  @override
  void initState() {
    super.initState();
    _animationController = new AnimationController(
        duration: new Duration(milliseconds: 150), vsync: this);
  }

  @override
  Widget build(BuildContext context) {
    return new Scaffold(
      appBar: new AppBar(
//        elevation: 0.0,
//        textTheme: Theme.of(context).primaryTextTheme,
//        backgroundColor: Colors.transparent,
        title: new Text(
          "Add a hand",
        ),
      ),
//      backgroundColor: Colors.green[400],
      body: new AnimatedBuilder(
        animation: _animationController,
        builder: (context, child) =>
            Stack(
              children: _buildStackChildren(),
            ),
      ),
    );
  }

  List<Widget> _buildStackChildren() {
    List<Widget> children = [];
    children.addAll(_buildCardViews());
    children.add(
      Align(
        alignment: Alignment.bottomCenter,
        child: new Column(
          mainAxisAlignment: MainAxisAlignment.end,
          children: <Widget>[
            new Padding(
              padding: const EdgeInsets.symmetric(horizontal: 32.0),
              child: new TextField(
                keyboardType: TextInputType.number,
                enabled: this.leftCard != null && this.rightCard != null,
                decoration: new InputDecoration(
                  helperText: "Stack after the hand",
                  hintText: "8000",
                ),
              ),
            ),
            new Padding(
              padding: const EdgeInsets.all(16.0),
              child: new RaisedButton(
                color: Theme
                    .of(context)
                    .accentColor,
                shape: new BeveledRectangleBorder(
                  borderRadius: BorderRadius.all(Radius.circular(8.0)),
                ),
                onPressed: this.leftCard != null && this.rightCard != null
                    ? _onAccept
                    : null,
                child: new Text("ADD"),
              ),
            ),
          ],
        ),
      ),
    );
    return children;
  }

  List<Widget> _buildCardViews() {
    List<Widget> cards = [
      _buildLeftCard(),
      _buildRightCard(),
    ];
    if (_animationController.value < 0.5) {
      cards = cards.reversed.toList();
    }

    return cards;
  }

  Positioned _buildLeftCard() {
    return new Positioned.fill(
      right: 100.0,
      bottom: 150.0,
      child: new Padding(
        padding: const EdgeInsets.all(8.0),
        child: new Transform(
          alignment: Alignment.center,
          transform: new Matrix4.identity()
            ..scale(
              1 - 0.2 * _animationController.value,
              1 - 0.2 * _animationController.value,
            ),
          child: new CardView(
            key: leftKey,
            onTap: () => _animationController.reverse(),
            onCardPicked: _onLeftCardPicked,
            enabled: _animationController.isDismissed,
          ),
        ),
      ),
    );
  }

  Positioned _buildRightCard() {
    return new Positioned.fill(
      left: 100.0,
      bottom: 150.0,
      child: new Padding(
        padding: const EdgeInsets.all(8.0),
        child: new Transform(
          alignment: Alignment.center,
          transform: new Matrix4.identity()
            ..scale(
              1 - 0.2 * (1 - _animationController.value),
              1 - 0.2 * (1 - _animationController.value),
            ),
          child: new CardView(
            key: rightKey,
            onTap: () => _animationController.forward(),
            onCardPicked: _onRightCardPicked,
            enabled: _animationController.isCompleted,
          ),
        ),
      ),
    );
  }

  _onLeftCardPicked(PlayingCard card) {
    _animationController.forward();
    setState(() {
      this.leftCard = card;
    });
  }

  _onRightCardPicked(PlayingCard card) {
    setState(() {
      this.rightCard = card;
    });
  }

  _onAccept() {
    Navigator.of(context).pop(new Hand(
      this.leftCard,
      this.rightCard,
      widget.initialStack,
    ));
  }
}
