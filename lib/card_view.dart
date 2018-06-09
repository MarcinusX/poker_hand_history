import 'dart:math' as math;

import 'package:flutter/material.dart';
import 'package:poker_hand_history/card.dart';
import 'package:poker_hand_history/suit_widget.dart';

class CardView extends StatefulWidget {
  final Function onTap;
  final Function(PlayingCard) onCardPicked;
  final bool alignLeft;
  final bool enabled;

  const CardView({Key key,
    this.onTap,
    this.onCardPicked,
    this.enabled = false,
    this.alignLeft = true})
      : super(key: key);

  @override
  _CardViewState createState() => new _CardViewState();
}

class _CardViewState extends State<CardView> {
  Rank rank;
  Suit suit;

  @override
  Widget build(BuildContext context) {
    return new GestureDetector(
      onTap: widget.onTap,
      child: Container(
        child: _buildBody(),
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

  Widget _buildBody() {
    return new Stack(
      children: <Widget>[
        new Padding(
          padding: const EdgeInsets.symmetric(horizontal: 16.0, vertical: 16.0),
          child: ranks(),
        ),
        new Positioned(
          left: 0.0,
          top: 0.0,
          child: _chosenCard(),
        ),
        new Positioned(
          right: 0.0,
          bottom: 0.0,
          child: new Transform.rotate(
            angle: math.pi,
            child: _chosenCard(),
          ),
        ),
        new Align(alignment: Alignment.center, child: suits()),
      ],
    );
  }

  Widget _chosenCard() {
    Widget rankWidget = new Container();
    Widget suitWidget = new Container();
    Color color = (this.suit != null &&
        (this.suit == Suit.HEARTS || this.suit == Suit.DIAMONDS))
        ? Colors.red
        : Colors.black;
    if (this.rank != null) {
      rankWidget = new Text(
        rankToSymbol(rank),
        style: Theme
            .of(context)
            .textTheme
            .display2
            .copyWith(color: color),
      );
    }
    if (this.suit != null) {
      suitWidget = new SuitWidget(
        suit: this.suit,
        height: 26.0,
        width: 26.0,
      );
    }

    return new Padding(
      padding: const EdgeInsets.all(8.0),
      child: new Column(
        children: <Widget>[
          rankWidget,
          suitWidget,
        ],
      ),
    );
  }

  Widget suits() {
    if (!(this.rank != null && this.suit == null)) {
      return new Container();
    }
    return new Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: <Widget>[
        new Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            _suitCard(Suit.HEARTS),
            _suitCard(Suit.CLUBS),
          ],
        ),
        new Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            _suitCard(Suit.SPADES),
            _suitCard(Suit.DIAMONDS),
          ],
        ),
      ],
    );
  }

  Widget _suitCard(Suit suit) {
    return new GestureDetector(
      onTap: () => _onSuitPicked(suit),
      child: new Card(
        child: new Padding(
          padding: const EdgeInsets.all(8.0),
          child: SuitWidget(suit: suit, height: 64.0, width: 64.0),
        ),
      ),
    );
  }

  Widget ranks() {
    if (this.rank != null) {
      return new Container();
    }
    return new Column(
      children: <Widget>[
        new Container(
          height: 64.0,
          child: new Row(
            children: <Widget>[
              new Expanded(child: rankCard(Rank.TWO)),
              new Expanded(child: rankCard(Rank.THREE)),
              new Expanded(child: rankCard(Rank.FOUR)),
            ],
          ),
        ),
        new Container(
          height: 64.0,
          child: new Row(
            children: <Widget>[
              new Expanded(child: rankCard(Rank.FIVE)),
              new Expanded(child: rankCard(Rank.SIX)),
              new Expanded(child: rankCard(Rank.SEVEN)),
            ],
          ),
        ),
        new Container(
          height: 64.0,
          child: new Row(
            children: <Widget>[
              new Expanded(child: rankCard(Rank.EIGHT)),
              new Expanded(child: rankCard(Rank.NINE)),
              new Expanded(child: rankCard(Rank.TEN)),
            ],
          ),
        ),
        new Container(
          height: 64.0,
          child: new Row(
            children: <Widget>[
              new Expanded(child: rankCard(Rank.JACK)),
              new Expanded(child: rankCard(Rank.QUEEN)),
              new Expanded(child: rankCard(Rank.KING)),
            ],
          ),
        ),
        new Container(
          height: 64.0,
          child: new Row(
            children: <Widget>[
              new Expanded(child: new Container()),
              new Expanded(child: rankCard(Rank.ACE)),
              new Expanded(child: new Container()),
            ],
          ),
        ),
      ],
    );
  }

  Widget rankCard(Rank rank) {
    return new GestureDetector(
      onTap: () {
        if (widget.enabled) {
          //widget?.onCardPicked(rank);
          setState(() {
            this.rank = rank;
          });
        } else {
          widget.onTap();
        }
      },
      child: new Card(
        child: new Center(
          child: new Text(rankToSymbol(rank)),
        ),
      ),
    );
  }

  _onSuitPicked(Suit suit) {
    setState(() {
      this.suit = suit;
    });
    widget?.onCardPicked(new PlayingCard(this.rank, suit));
  }
}
