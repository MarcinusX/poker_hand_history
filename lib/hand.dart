import 'package:poker_hand_history/card.dart';

class Hand {
  PlayingCard leftCard;
  PlayingCard rightCard;
  num stack;

  Hand(this.leftCard, this.rightCard, this.stack);
}
