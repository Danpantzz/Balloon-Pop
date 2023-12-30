import 'dart:async';

import 'package:flame/components.dart';
import 'balloons.dart';

///
/// BalloonGreen extends Balloons
/// sets up the variables for a green balloon.
/// Uses all functions from Balloons.
///
class BalloonGreen extends Balloons {
  @override
  FutureOr<void> onLoad() async {
    super.onLoad();
    score = 1;
    speed = 80;

    sprite = Sprite(game.images.fromCache('balloon_green.png'));
  }
}
