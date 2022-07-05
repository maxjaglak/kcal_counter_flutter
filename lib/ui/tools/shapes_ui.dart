import 'dart:ui';

import 'package:flutter/cupertino.dart';

class ShapesUI {

  static Widget smallColorCircle(Color color) => colorCircle(color, 11);

  static Widget colorCircle(Color color, double size) {
    return Container(
        width: size,
        height: size,
        decoration: BoxDecoration(shape: BoxShape.circle, color: color)
    );
  }

}