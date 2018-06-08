import 'package:flutter/material.dart';
import 'package:poker_hand_history/card.dart';

class CardView extends StatefulWidget {
  final String title;
  final Function onTap;
  final Function(Rank) onRankPicked;
  final bool enabled;

  const CardView(
      {Key key,
      this.onTap,
      this.onRankPicked,
      this.enabled = false,
      this.title})
      : super(key: key);

  @override
  _CardViewState createState() => new _CardViewState();
}

class _CardViewState extends State<CardView> {
  Rank rank;

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
        _chosenRank(),
        new Text(widget.title),
      ],
    );
  }

  Widget _chosenRank() {
    if (this.rank == null) {
      return new Container();
    } else {
      return new Text(rankToSymbol(rank));
    }
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
          widget?.onRankPicked(rank);
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
}
