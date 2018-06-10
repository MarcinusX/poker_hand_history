import 'package:flutter/material.dart';

enum Suit {
  SPADES,
  HEARTS,
  CLUBS,
  DIAMONDS,
}

enum Rank {
  TWO,
  THREE,
  FOUR,
  FIVE,
  SIX,
  SEVEN,
  EIGHT,
  NINE,
  TEN,
  JACK,
  QUEEN,
  KING,
  ACE,
}

String rankToSymbol(Rank rank) {
  switch (rank) {
    case Rank.TWO:
      return '2';
    case Rank.THREE:
      return '3';
    case Rank.FOUR:
      return '4';
    case Rank.FIVE:
      return '5';
    case Rank.SIX:
      return '6';
    case Rank.SEVEN:
      return '7';
    case Rank.EIGHT:
      return '8';
    case Rank.NINE:
      return '9';
    case Rank.TEN:
      return '10';
    case Rank.JACK:
      return 'J';
    case Rank.QUEEN:
      return 'Q';
    case Rank.KING:
      return 'K';
    case Rank.ACE:
      return 'A';
    default:
      return '';
  }
}

Color suitToColor(Suit suit) {
  if (suit == null) {
    return Colors.black54;
  }
  return suit == Suit.HEARTS || suit == Suit.DIAMONDS
      ? Colors.red
      : Colors.black;
}

class PlayingCard {
  final Suit suit;
  final Rank rank;

  PlayingCard(this.rank, this.suit);

  Map<String, String> toMap() =>
      {
        "rank": rank.toString(),
        "suit": suit.toString(),
      };

  PlayingCard.fromMap(Map<String, dynamic> map)
      : rank = Rank.values.singleWhere((r) => r.toString() == map["rank"]),
        suit = Suit.values.singleWhere((s) => s.toString() == map["suit"]);

}
