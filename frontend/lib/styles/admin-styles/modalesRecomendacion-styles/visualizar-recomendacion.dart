import 'package:flutter/material.dart';

class VisualizarRecomendacionStyles {
  static const Color darkGreen = Color(0xFF073D2B);
  static const Color primaryGreen = Color(0xFF55A820);
  static const Color cardBorder = Color(0xFFD7E4DC);
  static const Color closeBg = Color(0xFFF5FAF3);

  static const Color backdropColor = Color.fromRGBO(7, 61, 43, 0.45);

  static final BoxDecoration cardDecoration = BoxDecoration(
    color: Colors.white,
    border: Border.all(color: cardBorder),
    borderRadius: BorderRadius.circular(8),
    boxShadow: const [
      BoxShadow(
        color: Color.fromRGBO(7, 61, 43, 0.2),
        blurRadius: 48,
        offset: Offset(0, 24),
      ),
    ],
  );

  static const TextStyle titleStyle = TextStyle(
    color: darkGreen,
    fontSize: 28,
    height: 1.15,
    fontWeight: FontWeight.bold,
  );

  static final BoxDecoration closeBtnDecoration = BoxDecoration(
    color: closeBg,
    borderRadius: BorderRadius.circular(8),
  );

  static const TextStyle formTextStyle = TextStyle(
    color: darkGreen,
    fontSize: 16,
  );

  static const TextStyle formTextBoldStyle = TextStyle(
    color: darkGreen,
    fontSize: 16,
    fontWeight: FontWeight.bold,
  );

  static final BoxDecoration submitBtnDecoration = BoxDecoration(
    gradient: const LinearGradient(
      colors: [darkGreen, primaryGreen],
      begin: Alignment.topLeft,
      end: Alignment.bottomRight,
    ),
    borderRadius: BorderRadius.circular(8),
    boxShadow: const [
      BoxShadow(
        color: Color.fromRGBO(7, 61, 43, 0.24),
        blurRadius: 28,
        offset: Offset(0, 16),
      ),
    ],
  );

  static const TextStyle submitBtnStyle = TextStyle(
    color: Colors.white,
    fontSize: 16,
    fontWeight: FontWeight.w800,
  );
}
