import 'package:flutter/material.dart';

class BarraAdminStyles {
  // Colores base
  static const Color darkGreen = Color(0xFF073D2B);
  static const Color primaryGreen = Color(0xFF55A820);
  static const Color linkNormal = Color(0xFF456657);
  static const Color linkHover = Color(0xFF55A820);
  static const Color borderColor = Color(0xFFD7E4DC);

  // Tipografía
  // Dimensiones
  static const double navbarHeight = 80.0; // Altura mínima del navbar
  static const double navbarPaddingVertical = 20.0; // Padding vertical

  static const TextStyle brandText = TextStyle(
    color: darkGreen,
    fontSize: 20,
    fontWeight: FontWeight.w800,
  );

  static const TextStyle navLinkText = TextStyle(
    color: linkNormal,
    fontSize: 15,
    fontWeight: FontWeight.w700,
  );

  // Decoraciones
  static BoxDecoration navbarDecoration = const BoxDecoration(
    color: Colors.white,
    border: Border(
      bottom: BorderSide(color: borderColor, width: 1),
    ),
    boxShadow: [
      BoxShadow(
        color: Color.fromRGBO(7, 61, 43, 0.12),
        blurRadius: 24,
        offset: Offset(0, 10),
      )
    ],
    // Simulando radial-gradient(circle at top right, rgba(85, 168, 32, 0.2), transparent 34%), #ffffff
    gradient: RadialGradient(
      center: Alignment.topRight,
      radius: 1.5,
      colors: [
        Color.fromRGBO(85, 168, 32, 0.05), // Opacidad suave
        Colors.white,
      ],
      stops: [0.0, 0.34],
    ),
  );

  static BoxDecoration logoutButtonDecoration = BoxDecoration(
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
