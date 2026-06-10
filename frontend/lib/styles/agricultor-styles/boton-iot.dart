import 'package:flutter/material.dart';

class BotonIotStyles {
  // Colores principales
  static const Color darkGreen = Color(0xFF073D2B);
  static const Color primaryGreen = Color(0xFF55A820);
  static const Color textGreen = Color(0xFF456657);
  static const Color errorRed = Color(0xFFC62828);
  static const Color errorTextRed = Color(0xFFC92B2B);
  static const Color orange = Color(0xFFFF9800);
  static const Color orangeDark = Color(0xFFF57C00);

  // Tipografía
  static const TextStyle titleText = TextStyle(
    color: darkGreen,
    fontSize: 48,
    fontWeight: FontWeight.w800,
    height: 1.0,
    letterSpacing: -0.5,
  );

  static const TextStyle descriptionText = TextStyle(
    fontSize: 16,
    color: textGreen,
    fontWeight: FontWeight.w700,
    height: 1.5,
  );

  static const TextStyle descriptionErrorText = TextStyle(
    fontSize: 16,
    color: errorTextRed,
    fontWeight: FontWeight.w800,
    height: 1.5,
  );
  
  static const TextStyle indicatorText = TextStyle(
    color: darkGreen,
    fontWeight: FontWeight.w800,
    fontSize: 13,
  );
}
