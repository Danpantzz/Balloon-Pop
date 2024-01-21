import 'dart:async';
import 'dart:math';

import 'package:daniel_mcerlean_project_3/game/components/visual_score.dart';
import 'package:flame_audio/flame_audio.dart';
import 'package:flame/components.dart';
import 'package:flame/events.dart';
import 'package:flutter/services.dart';

import '../balloon_pop.dart';

///
/// Balloons contains all the neccessary code for each balloon.
/// Used as a base template for each specific balloon so as to reduce code repetition
///
class Balloons extends SpriteComponent
    with HasGameRef<BalloonPop>, TapCallbacks {
  // Balloon variables
  int tapped = 0;
  bool multiTap = false;
  bool evil = false;
  int? score = 1;
  int? requiredTaps = 1;
  double? speed = 1;

  late double volume;

  // list of sound files to pick one at random later
  final sounds = ['pop1.wav', 'pop2.wav', 'pop3.wav'];

  //
  //  onLoad()
  //  initializes balloon variables
  //
  @override
  FutureOr<void> onLoad() async {
    anchor = Anchor.center;
    height = gameRef.size.y / 6;
    width = gameRef.size.y / 13;
    position = Vector2(
      (Random().nextDouble() * (gameRef.size.x - width)) + width / 2,
      gameRef.size.y + height,
    );
    volume = gameRef.settingsManager.vfxVolume;
  }

  //
  //  move()
  //  called every frame to move the balloon up the screen
  //
  void move(Vector2 delta) {
    position.add(delta);
  }

  //
  //  update()
  //  used to move balloons, and check if they're out of bounds
  //
  @override
  void update(double dt) {
    // move every time update is called
    move(Vector2(0, -speed! * dt));

    // when the balloon leaves the top of the screen
    if (position.y < -height) {
      // remove life if its a normal balloon (evil ones can pass safely)
      if (!evil) {
        gameRef.gameManager.decreaseLife();
      }

      // destroy
      removeFromParent();
    }
  }

  //
  //  onTapDown()
  //  called when a balloon is tapped
  //
  @override
  void onTapDown(TapDownEvent event) {
    super.onTapDown(event);

    // vibrates phone for every tap
    if (gameRef.settingsManager.vibration) {
      HapticFeedback.lightImpact();
    }

    // variable specific for when balloon should be destroyed
    bool destroyed = false;

    if (evil) {
      // remove a life
      gameRef.gameManager.decreaseLife();

      // play pop animation and sound
      FlameAudio.play('explosion.wav', volume: volume);

      // destroy
      destroyed = true;
    }

    // if the balloon requires mutliple taps
    if (multiTap) {
      tapped++;

      // if tapped the required amount
      if (tapped >= requiredTaps!) {
        destroyed = true;
      } else {
        // play bouncing sound when not popped
        FlameAudio.play('bounce2.wav', volume: volume);
      }
    } else {
      // single tap balloons pop right away
      destroyed = true;
    }

    // added variable to prevent code repetition.
    // if balloon has been popped...
    if (destroyed) {
      if (!evil) {
        int sound = Random().nextInt(sounds.length);
        FlameAudio.play(sounds[sound], volume: volume);
      }

      // add the score of this balloon to the screen
      gameRef.add(
        VisualScore(
          text: score! >= 0 ? "+${score.toString()}" : score.toString(),
          position: Vector2(position.x, position.y),
        ),
      );

      // increase score by this balloons score (decreases for evil balloons)
      gameRef.gameManager.increaseScore(score!);

      // remove this balloon
      removeFromParent();
    }
  }
}
