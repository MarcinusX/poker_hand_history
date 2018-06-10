import 'package:poker_hand_history/model/card.dart';

class Hand {
  PlayingCard leftCard;
  PlayingCard rightCard;
  num stack;

  Hand(this.leftCard, this.rightCard, this.stack);

  Map<String, dynamic> toMap() {
    return {
      "left": leftCard.toMap(),
      "right": rightCard.toMap(),
      "stack": stack,
    };
  }

  Hand.fromMap(Map<String, dynamic> map)
      : leftCard = new PlayingCard.fromMap(map["left"]),
        rightCard = new PlayingCard.fromMap(map["right"]),
        stack = map["stack"];
}
