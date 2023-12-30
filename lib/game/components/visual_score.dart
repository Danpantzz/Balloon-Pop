import 'dart:async';

import 'package:flame/components.dart';
import 'package:flame/effects.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

// changes the style for this text component
final style = GoogleFonts.rubikBubbles(
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
class VisualScore extends TextComponent with HasPaint {
  VisualScore({super.text, super.position});

  //
  //  onLoad()
  //  sets size, textRenderer, opacity, and adds fadeOut effect
  //
  @override
  FutureOr<void> onLoad() {
    size = Vector2(10, 10);
    textRenderer = regular;
    opacity = 1.0;

    // fade for 3 seconds, then remove self
    add(OpacityEffect.fadeOut(EffectController(duration: 3),
        onComplete: removeFromParent));
  }

  //
  //  update()
  //  used for moving the text position
  //
  @override
  void update(double dt) {
    // move the text up while it's on screen
    position.add(Vector2(0, -.5));
  }
}
