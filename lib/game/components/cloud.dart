import 'dart:async';
import 'dart:math';

import 'package:daniel_mcerlean_project_3/game/balloon_pop.dart';
import 'package:flame/components.dart';

///
/// Cloud is used for spawning in the background cloud components
/// and removing them when they reach the end of the screen
///
class Cloud extends SpriteComponent with HasGameRef<BalloonPop> {

  double speed = 190;

  //
  //  onLoad()
  //  initializes the sprite image, achor point, height and width based on game size,
  //  and the position to spawn in based on game size
  //
  @override
  FutureOr<void> onLoad() async {
    sprite = Sprite(game.images.fromCache('cloud.png'));
    anchor = Anchor.center;
    height = gameRef.size.y / 8;
    width = gameRef.size.y / 4;
    position = Vector2(
      -width,
      (Random().nextDouble() * (gameRef.size.y - (height * 2))) + (height * 2),
    );
  }

  //
  //  update()
  //  called to continuously move clouds to the right of the screen
  //
  @override
  void update(double dt) {
    // move cloud to the right
    move(Vector2(speed * dt, 0));

    // if cloud is past the game screen, destroy it
    if (position.x > gameRef.size.x + (width)) {
      removeFromParent();
    }
  }

  //
  //  move()
  //  called for updating the position
  //
  void move(Vector2 delta) {
    position.add(delta);
  }
}
