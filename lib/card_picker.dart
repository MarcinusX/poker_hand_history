import 'package:flutter/material.dart';
import 'package:poker_hand_history/card_view.dart';

class CardPicker extends StatefulWidget {
  @override
  _CardPickerState createState() => _CardPickerState();
}

class _CardPickerState extends State<CardPicker>
    with SingleTickerProviderStateMixin {
  AnimationController _animationController;

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
        elevation: 0.0,
        backgroundColor: Colors.transparent,
        title: new Text("Add a card"),
      ),
      backgroundColor: Colors.green[800],
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
    List<Widget> cards;
    if (_animationController.value < 0.5) {
      cards = [
        _buildRightCard(),
        _buildLeftCard(),
      ];
    } else {
      cards = [
        _buildLeftCard(),
        _buildRightCard(),
      ];
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
            onTap: () => _animationController.reverse(),
            onRankPicked: (rank) => print(rank),
            enabled: _animationController.isDismissed,
            title: "left",
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
            onTap: () => _animationController.forward(),
            onRankPicked: (rank) => print(rank),
            enabled: _animationController.isCompleted,
            title: "right",
          ),
        ),
      ),
    );
  }
}
