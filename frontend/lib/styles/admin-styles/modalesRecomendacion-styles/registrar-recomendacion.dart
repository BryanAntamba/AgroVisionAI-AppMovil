import 'package:flutter/material.dart';

class RegistrarRecomendacionStyles {
  static const Color darkGreen       = Color(0xFF073D2B);
  static const Color primaryGreen    = Color(0xFF55A820);
  static const Color backgroundPage  = Color(0xFFF5FAF3);
  static const Color backgroundInput = Color(0xFFFBFDF9);
  static const Color borderGrey      = Color(0xFFD7E4DC);
  static const Color borderInput     = Color(0xFFC8D8CE);

  static const TextStyle h1Text = TextStyle(
    color: darkGreen,
    fontSize: 34,
    fontWeight: FontWeight.w800,
    height: 1.15,
  );

  static const TextStyle labelText = TextStyle(
    color: darkGreen,
    fontSize: 13,
    fontWeight: FontWeight.w800,
  );

  static BoxDecoration inputDecoration() => BoxDecoration(
    color: backgroundInput,
    border: Border.all(color: borderInput),
    borderRadius: BorderRadius.circular(8),
  );

  static BoxDecoration get createBtnDecoration => BoxDecoration(
    gradient: const LinearGradient(
      colors: [darkGreen, primaryGreen],
      begin: Alignment.topLeft,
      end: Alignment.bottomRight,
    ),
    borderRadius: BorderRadius.circular(8),
  );
}
