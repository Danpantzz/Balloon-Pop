import 'dart:async';

import 'package:daniel_mcerlean_project_3/game/balloon_pop.dart';
import 'package:flame/components.dart';
import 'package:flame/effects.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

// changes the style for this text component
final style = GoogleFonts.rubikBubbles(
  fontSize: 50,
  textStyle: const TextStyle(
    shadows: [
      Shadow(
          // bottomLeft
          offset: Offset(-1.5, -1.5),
          color: Colors.black),
      Shadow(
          // bottomRight
          offset: Offset(1.5, -1.5),
          color: Colors.black),
      Shadow(
          // topRight
          offset: Offset(1.5, 1.5),
          color: Colors.black),
      Shadow(
          // topLeft
          offset: Offset(-1.5, 1.5),
          color: Colors.black),
    ],
  ),
);

final regular = TextPaint(style: style);

///
/// VisualScore displays the score of the popped balloon for 3 seconds.
/// Helps see the score of each balloon more easily
///
class GameOverText extends TextComponent with HasPaint, HasGameRef<BalloonPop> {
  GameOverText();

  //
  //  onLoad()
  //  sets size, textRenderer, opacity, and adds fadeOut effect
  //
  @override
  FutureOr<void> onLoad() {
    text = 'Game Over';
    position = Vector2(game.size.x / 2, game.size.y / 2);
    anchor = Anchor.center;
    //size = Vector2(50, 50);
    textRenderer = regular;
    opacity = 1.0;

    // fade for 3 seconds, then remove self
    add(MoveEffect.by(Vector2(0, -15), EffectController(duration: 3),
        onComplete: () {
      removeFromParent();
      game.overlays.remove('gameOverlay');
      game.overlays.add('gameOverOverlay');
    }));
  }
}
