import 'package:flutter/material.dart';

class CambiarPasswordStyles {
  // Colores base
  static const Color darkGreen = Color(0xFF073D2B);
  static const Color linkGreen = Color(0xFF0B5A3D);
  static const Color primaryGreen = Color(0xFF55A820);
  static const Color cardBackground = Color(0xFFFBFDF9);
  static const Color borderGrey = Color(0xFFC8D8CE);
  static const Color errorRed = Color(0xFFC92B2B);
  static const Color placeholderGrey = Color(0xFF7D9186);

  // Tipografía
  static const TextStyle heading1 = TextStyle(
    color: darkGreen,
    fontSize: 31,
    fontWeight: FontWeight.bold,
    height: 1.15,
  );

  static const TextStyle description = TextStyle(
    color: linkGreen,
    fontSize: 15,
    fontWeight: FontWeight.w700,
    height: 1.45,
  );

  static const TextStyle label = TextStyle(
    color: darkGreen,
    fontSize: 14,
    fontWeight: FontWeight.w700,
  );

  static const TextStyle errorText = TextStyle(
    color: errorRed,
    fontSize: 13,
    fontWeight: FontWeight.w800,
  );

  static const TextStyle changeLink = TextStyle(
    color: linkGreen,
    fontSize: 16,
    fontWeight: FontWeight.w800,
  );

  // Decoraciones
  static BoxDecoration inputDecoration(bool isFocused) {
    return BoxDecoration(
      color: isFocused ? Colors.white : cardBackground,
      border: Border.all(
        color: isFocused ? primaryGreen : borderGrey,
      ),
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

  static BoxDecoration buttonDecoration = BoxDecoration(
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
      )
    ],
  );
}
