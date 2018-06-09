import 'package:flutter/material.dart';
import 'package:poker_hand_history/card.dart';

class SuitWidget extends StatelessWidget {
  final Suit suit;
  final double height;
  final double width;

  const SuitWidget({
    Key key,
    this.suit,
    this.height,
    this.width,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
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
