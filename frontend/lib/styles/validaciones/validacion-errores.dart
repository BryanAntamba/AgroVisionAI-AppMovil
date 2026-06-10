import 'package:flutter/material.dart';

class ValidacionErroresStyles {
  static const Color errorColor = Color(0xFFC92B2B);

  static const TextStyle errorText = TextStyle(
    color: errorColor,
    fontSize: 13,
    fontWeight: FontWeight.w700,
  );

  // Transiciones comunes para inputs
  static const Duration inputTransitionDuration = Duration(milliseconds: 180);
  static const Curve inputTransitionCurve = Curves.ease;
}
