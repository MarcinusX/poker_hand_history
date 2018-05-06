import 'package:flutter/material.dart';
import 'package:meta/meta.dart';
import 'package:poker_hand_history/card.dart';

class CardPicker extends StatefulWidget {
  CardPicker({Key key}) : super(key: key);

  @override
  _CardPickerState createState() => new _CardPickerState();
}

class _CardPickerState extends State<CardPicker> {
  PlayingCard lastCard;

  @override
  Widget build(BuildContext context) {
    return new Padding(
      padding: MediaQuery.of(context).padding,
      child: new Stack(
        alignment: Alignment.center,
        children: <Widget>[
          new Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              new Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: <Widget>[
                  new SuitWidget(suit: Suit.HEARTS),
                  new SuitWidget(suit: Suit.CLUBS),
                ],
              ),
              new Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: <Widget>[
                  new SuitWidget(suit: Suit.SPADES),
                  new SuitWidget(suit: Suit.DIAMONDS),
                ],
              ),
            ],
          ),
          new Positioned(
            top: 50.0,
            bottom: 0.0,
            left: 0.0,
            child: new Column(
              children: <Widget>[
                new RankWidget(rank: Rank.SIX, onCardProvided: _cardProvided),
                new RankWidget(rank: Rank.FIVE, onCardProvided: _cardProvided),
                new RankWidget(rank: Rank.FOUR, onCardProvided: _cardProvided),
                new RankWidget(rank: Rank.THREE, onCardProvided: _cardProvided),
                new RankWidget(rank: Rank.TWO, onCardProvided: _cardProvided),
              ],
            ),
          ),
          new Positioned(
            top: 0.0,
            right: 0.0,
            left: 0.0,
            child: new Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: <Widget>[
                new RankWidget(rank: Rank.SEVEN, onCardProvided: _cardProvided),
                new RankWidget(rank: Rank.EIGHT, onCardProvided: _cardProvided),
                new RankWidget(rank: Rank.NINE, onCardProvided: _cardProvided),
              ],
            ),
          ),
          new Positioned(
            top: 50.0,
            bottom: 0.0,
            right: 0.0,
            child: new Column(
              children: <Widget>[
                new RankWidget(rank: Rank.TEN, onCardProvided: _cardProvided),
                new RankWidget(rank: Rank.JACK, onCardProvided: _cardProvided),
                new RankWidget(rank: Rank.QUEEN, onCardProvided: _cardProvided),
                new RankWidget(rank: Rank.KING, onCardProvided: _cardProvided),
                new RankWidget(rank: Rank.ACE, onCardProvided: _cardProvided),
              ],
            ),
          ),
          new Positioned(
            bottom: 0.0,
            child: new Text("${lastCard?.rank} ${lastCard?.suit}"),
          ),
        ],
      ),
    );
  }

  _cardProvided(PlayingCard card) {
    setState(() {
      lastCard = card;
    });
  }
}

class RankWidget extends StatelessWidget {
  final Rank rank;
  final double size;
  final Function(PlayingCard) onCardProvided;

  const RankWidget({Key key, this.rank, this.onCardProvided, this.size = 80.0})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return new DragTarget(
      onWillAccept: (suit) => true,
      onAccept: (suit) => onCardProvided(new PlayingCard(rank, suit)),
      builder:
          (BuildContext context, List<Suit> candidateData, List rejectedData) {
        if (candidateData.isEmpty) {
          return new Container(
            alignment: Alignment.center,
            height: size,
            width: size,
            child: new Text(
              rankToSymbol(rank),
              style: new TextStyle(fontSize: size / 3),
            ),
          );
        } else {
          return new Container(
            color: Colors.yellow,
            alignment: Alignment.center,
            height: size,
            width: size,
            child: new Text(
              rankToSymbol(rank),
              style: new TextStyle(fontSize: size),
            ),
          );
        }
      },
    );
  }
}

class SuitWidget extends StatefulWidget {
  final Suit suit;
  final double size;

  const SuitWidget({Key key, @required this.suit, this.size = 80.0})
      : super(key: key);

  @override
  _SuitWidgetState createState() => new _SuitWidgetState();
}

class _SuitWidgetState extends State<SuitWidget> {
  @override
  Widget build(BuildContext context) {
    return new Draggable<Suit>(
      child: new Padding(
        padding: new EdgeInsets.all(0.5 * 0.3 * widget.size),
        child: icon(widget.suit,
            height: 0.7 * widget.size, width: 0.7 * widget.size),
      ),
      childWhenDragging:
          icon(widget.suit, height: widget.size, width: widget.size),
      maxSimultaneousDrags: 1,
      data: widget.suit,
      dragAnchor: DragAnchor.pointer,
      feedback: icon(widget.suit,
          height: 0.3 * widget.size, width: 0.3 * widget.size),
    );
  }

  Widget icon(Suit suit, {double height, double width}) {
    return new Image.asset(
      _getAssetName(suit),
      height: height,
      width: width,
    );
  }

  String _getAssetName(Suit suit) {
    switch (suit) {
      case Suit.CLUBS:
        return 'images/clubs.png';
      case Suit.DIAMONDS:
        return 'images/diamonds.png';
      case Suit.HEARTS:
        return 'images/hearts.png';
      case Suit.SPADES:
        return 'images/spades.png';
      default:
        return null;
    }
  }
}
