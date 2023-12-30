import 'dart:async';

import 'package:flame/components.dart';
import 'balloons.dart';

///
/// BalloonRed extends Balloons
/// sets up the variables for a red balloon.
/// Uses all functions from Balloons.
///
class BalloonRed extends Balloons {
  @override
  FutureOr<void> onLoad() async {
    super.onLoad();
    score = 5;
    speed = 350;
    
    sprite = Sprite(game.images.fromCache('balloon_red.png'));
  }
}
