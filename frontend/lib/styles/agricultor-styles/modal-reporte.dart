import 'package:flutter/material.dart';

class ModalReporteStyles {
  // Colores principales
  static const Color darkGreen = Color(0xFF073D2B);
  static const Color primaryGreen = Color(0xFF55A820);
  static const Color textGreen = Color(0xFF597268);
  static const Color backgroundLight = Color(0xFFF5FAF3);
  static const Color cardBackground = Color(0xFFFFFFFF);
  static const Color borderGrey = Color(0xFFD7E4DC);
  
  static const Color okBg = Color(0xFFEAF7E5);
  static const Color okBorder = Color(0xFFC8E6C9);
  static const Color okText = Color(0xFF23730F);
  static const Color okActionText = Color(0xFF1A5C0A);
  
  static const Color warnBg = Color(0xFFFFF9E6);
  static const Color warnBorder = Color(0xFFFFE0B2);
  static const Color warnText = Color(0xFFB56C07);
  static const Color warnActionText = Color(0xFF633806);
  
  static const Color critBg = Color(0xFFFFEBEE);
  static const Color critBorder = Color(0xFFFFCDD2);
  static const Color critText = Color(0xFFC62828);
  static const Color critActionText = Color(0xFF791F1F);

  // Tipografía
  static const TextStyle headerText = TextStyle(
    color: darkGreen,
    fontSize: 28,
    fontWeight: FontWeight.w800,
    height: 1.15,
  );

  static const TextStyle sectionTitle = TextStyle(
    color: darkGreen,
    fontSize: 15,
    fontWeight: FontWeight.w800,
  );

  static const TextStyle metricaLabel = TextStyle(
    color: textGreen,
    fontSize: 13,
    fontWeight: FontWeight.w800,
  );

  static const TextStyle metricaValor = TextStyle(
    color: darkGreen,
    fontSize: 32,
    fontWeight: FontWeight.w800,
  );

  // Decoraciones
  static BoxDecoration closeButtonDecoration = BoxDecoration(
    color: backgroundLight,
    borderRadius: BorderRadius.circular(8),
  );

  static BoxDecoration sectionDecoration = BoxDecoration(
    color: const Color(0xFFFBFDF9),
    border: Border.all(color: borderGrey),
    borderRadius: BorderRadius.circular(8),
  );
  
  static BoxDecoration gridItemDecoration = BoxDecoration(
    color: cardBackground,
    border: Border.all(color: borderGrey),
    borderRadius: BorderRadius.circular(8),
  );

  static BoxDecoration submitButtonDecoration = BoxDecoration(
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
