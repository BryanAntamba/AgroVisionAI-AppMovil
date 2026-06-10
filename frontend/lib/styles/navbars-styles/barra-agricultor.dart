import 'package:flutter/material.dart';

class BarraAgricultorStyles {
  // Colores base
  static const Color darkGreen = Color(0xFF073D2B);
  static const Color primaryGreen = Color(0xFF55A820);
  static const Color linkNormal = Color(0xFF456657);
  static const Color borderColor = Color(0xFFD7E4DC);

  // Dimensiones
  static const double navbarHeight = 70.0; // Altura mínima del navbar
  static const double navbarPaddingVertical = 16.0; // Padding vertical mayor
  static const double contentPaddingTop = 8.0; // Padding superior adicional para bajar el contenido

  // Tipografía
  static const TextStyle brandText = TextStyle(
    color: darkGreen,
    fontSize: 22,
    fontWeight: FontWeight.w800,
    letterSpacing: -0.2,
  );

  static const TextStyle navLinkText = TextStyle(
    color: linkNormal,
    fontSize: 15,
    fontWeight: FontWeight.w700,
  );

  // Navbar container (fondo blanco + sombra)
  static const BoxDecoration navbarDecoration = BoxDecoration(
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
  );

  // Gradiente radial overlay top-right (verde suave 20%)
  static const BoxDecoration radialOverlay = BoxDecoration(
    gradient: RadialGradient(
      center: Alignment(1.0, -1.0),
      radius: 1.2,
      colors: [
        Color.fromRGBO(85, 168, 32, 0.20),
        Colors.transparent,
      ],
      stops: [0.0, 0.34],
    ),
  );

  // Botón cerrar sesión
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
