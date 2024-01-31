import 'dart:ui';

import '../../constants.dart';
import 'package:flame/components.dart';

class BackgroundComponent extends PositionComponent {
  @override
  void render(Canvas canvas) {
    canvas.drawColor(lightColor, BlendMode.src);
  }
}
