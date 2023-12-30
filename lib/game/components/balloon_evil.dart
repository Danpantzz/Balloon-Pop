import 'dart:async';

import 'package:flame/components.dart';
import 'balloons.dart';

///
/// BalloonEvil extends Balloons
/// sets up the variables for a evil balloon.
/// Uses all functions from Balloons.
///
class BalloonEvil extends Balloons {
  @override
  FutureOr<void> onLoad() async {
    super.onLoad();
    score = -10;
    speed = 250;
    evil = true;
    
    sprite = Sprite(game.images.fromCache('balloon_evil.png'));
  }
}