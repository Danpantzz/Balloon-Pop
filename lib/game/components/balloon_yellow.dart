import 'dart:async';

import 'package:flame/components.dart';
import 'balloons.dart';

///
/// BalloonYellow extends Balloons
/// sets up the variables for a yellow balloon.
/// requires multiple taps to pop.
/// Uses all functions from Balloons.
///
class BalloonYellow extends Balloons {
  @override
  FutureOr<void> onLoad() async {
    super.onLoad();
    multiTap = true;
    requiredTaps = 2;
    score = 3;
    speed = 180;

    sprite = Sprite(game.images.fromCache('balloon_yellow.png'));
  }
}
