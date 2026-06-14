import 'package:flutter/material.dart';

class GuardarReporteStyles {
  // Constantes de diseño
  static const double maxWidth = 400.0;
  
  // Colores base
  static const Color overlayColor = Color.fromRGBO(7, 61, 43, 0.45);
  static const Color backgroundColor = Colors.white;
  static const Color borderColor = Color(0xFFd7e4dc);
  static const Color iconBackgroundColor = Color(0xFFeaf7e5);
  static const Color iconColor = Color(0xFF55a820);
  static const Color titleColor = Color(0xFF073d2b);
  static const Color textColor = Color(0xFF597268);
  static const Color btnTextColor = Colors.white;

  // Decoraciones
  static BoxDecoration modalDecoration = BoxDecoration(
    color: backgroundColor,
    border: Border.all(color: borderColor),
    borderRadius: BorderRadius.circular(12),
    boxShadow: const [
      BoxShadow(
        color: Color.fromRGBO(7, 61, 43, 0.15),
        blurRadius: 60,
        offset: Offset(0, 20),
      ),
    ],
  );

  static const BoxDecoration iconDecoration = BoxDecoration(
    shape: BoxShape.circle,
    color: iconBackgroundColor,
  );

  static BoxDecoration btnDecoration = BoxDecoration(
    gradient: const LinearGradient(
      begin: Alignment.topLeft,
      end: Alignment.bottomRight,
      colors: [Color(0xFF073d2b), Color(0xFF55a820)],
    ),
    borderRadius: BorderRadius.circular(8),
  );

  // Estilos de texto
  static const TextStyle titleStyle = TextStyle(
    color: titleColor,
    fontSize: 20,
    fontWeight: FontWeight.w800,
  );

  static const TextStyle messageStyle = TextStyle(
    color: textColor,
    fontSize: 14,
    height: 1.5,
  );

  static const TextStyle btnStyle = TextStyle(
    color: btnTextColor,
    fontSize: 15,
    fontWeight: FontWeight.w800,
  );
}
