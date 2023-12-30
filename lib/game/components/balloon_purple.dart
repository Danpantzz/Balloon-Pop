import 'dart:async';

import 'package:flame/components.dart';
import 'balloons.dart';

///
/// BalloonPurple extends Balloons
/// sets up the variables for a purple balloon.
/// requires multiple taps to pop.
/// Uses all functions from Balloons.
///
class BalloonPurple extends Balloons {
  @override
  FutureOr<void> onLoad() async {
    super.onLoad();
    multiTap = true;
    requiredTaps = 5;
    score = 20;
    speed = 40;
    height = gameRef.size.y / 3;
    width = gameRef.size.y / 7;

    sprite = Sprite(game.images.fromCache('balloon_purple.png'));
  }
}
