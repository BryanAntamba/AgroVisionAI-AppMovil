import 'package:flutter/material.dart';

class HistorialStyles {
  // Colores principales
  static const Color darkGreen = Color(0xFF073D2B);
  static const Color primaryGreen = Color(0xFF55A820);
  static const Color textGreen = Color(0xFF456657);
  static const Color linkGreen = Color(0xFF0B5A3D);
  static const Color backgroundLight = Color(0xFFF5FAF3);
  static const Color cardBackground = Color(0xFFFFFFFF);
  static const Color borderGrey = Color(0xFFD7E4DC);
  static const Color inputBackground = Color(0xFFFBFDF9);

  // Colores de estado
  static const Color sanoText = Color(0xFF23730F);
  static const Color sanoBg = Color(0xFFEAF7E5);
  static const Color alertaText = Color(0xFF174C7C);
  static const Color alertaBg = Color(0xFFE9F2FF);
  static const Color criticoText = Color(0xFF9A2424);
  static const Color criticoBg = Color(0xFFF5EEEE);

  // Tipografía
  static const TextStyle eyebrowText = TextStyle(
    color: primaryGreen,
    fontSize: 13,
    fontWeight: FontWeight.w800,
    letterSpacing: 1.0,
  );

  static const TextStyle headerText = TextStyle(
    color: darkGreen,
    fontSize: 34,
    fontWeight: FontWeight.w800,
    height: 1.15,
  );

  static const TextStyle headerDescription = TextStyle(
    color: textGreen,
    fontSize: 16,
    height: 1.4,
  );

  static const TextStyle labelText = TextStyle(
    color: darkGreen,
    fontSize: 13,
    fontWeight: FontWeight.w800,
  );

  static const TextStyle summaryNumber = TextStyle(
    color: linkGreen,
    fontSize: 26,
    fontWeight: FontWeight.w800,
  );

  static const TextStyle summaryLabel = TextStyle(
    color: darkGreen,
    fontSize: 14,
    fontWeight: FontWeight.w700,
  );

  static const TextStyle cardTitle = TextStyle(
    color: darkGreen,
    fontSize: 18,
    fontWeight: FontWeight.w800,
  );

  static const TextStyle cardSubtitle = TextStyle(
    color: Color(0xFF597268),
    fontSize: 14,
  );

  static const TextStyle dtText = TextStyle(
    color: Color(0xFF6B8177),
    fontSize: 12,
    fontWeight: FontWeight.w800,
  );

  static const TextStyle ddText = TextStyle(
    color: darkGreen,
    fontSize: 14,
    fontWeight: FontWeight.w700,
  );

  // Decoraciones
  static BoxDecoration containerDecoration = BoxDecoration(
    color: cardBackground,
    border: Border.all(color: borderGrey),
    borderRadius: BorderRadius.circular(8),
  );

  static BoxDecoration inputDecoration(bool isFocused) {
    return BoxDecoration(
      color: isFocused ? Colors.white : inputBackground,
      border: Border.all(color: isFocused ? primaryGreen : const Color(0xFFC8D8CE)),
      borderRadius: BorderRadius.circular(8),
      boxShadow: isFocused
          ? [
              BoxShadow(
                color: primaryGreen.withValues(alpha: 0.13),
                blurRadius: 0,
                spreadRadius: 4,
              )
            ]
          : null,
    );
  }
}
