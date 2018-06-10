import 'package:flutter/material.dart';
import 'package:poker_hand_history/model/card.dart';

class SuitWidget extends StatelessWidget {
  final Suit suit;
  final double size;

  const SuitWidget({
    Key key,
    this.suit,
    this.size,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return new Image.asset(
      _getAssetName(suit),
      height: size,
      width: size,
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
