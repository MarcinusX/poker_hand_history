import 'package:flutter/material.dart';

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
            onTap: () {
              _animationController.reverse();
            },
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
            onTap: () {
              _animationController.forward();
            },
          ),
        ),
      ),
    );
  }
}

class CardView extends StatefulWidget {
  final Function onTap;

  const CardView({Key key, this.onTap}) : super(key: key);

  @override
  _CardViewState createState() => _CardViewState();
}

class _CardViewState extends State<CardView> {
  @override
  Widget build(BuildContext context) {
    return new GestureDetector(
      onTap: widget.onTap,
      child: Container(
        decoration: new BoxDecoration(
          color: const Color(0xFFFFFFCC),
          borderRadius: new BorderRadius.circular(16.0),
          border: new Border.all(
            color: const Color(0xFFEEEECC),
          ),
        ),
      ),
    );
  }
}
