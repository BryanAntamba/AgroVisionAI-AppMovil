import 'package:flutter/material.dart';

class AlertaSensorStyles {
  // ─── Colores ───────────────────────────────────────────────────────────────
  static const Color darkGreen       = Color(0xFF073D2B);
  static const Color primaryGreen    = Color(0xFF55A820);
  static const Color textGreen       = Color(0xFF456657);
  static const Color borderGrey      = Color(0xFFD7E4DC);
  static const Color backgroundLight = Color(0xFFF5FAF3);
  static const Color backgroundHover = Color(0xFFEDF5E9);

  // ─── Banner ────────────────────────────────────────────────────────────────
  static BoxDecoration bannerDecoration = BoxDecoration(
    color: Colors.white,
    border: Border.all(color: borderGrey),
    borderRadius: BorderRadius.circular(10),
    boxShadow: const [
      BoxShadow(
        color: Color.fromRGBO(7, 61, 43, 0.08),
        blurRadius: 18,
        offset: Offset(0, 6),
      ),
    ],
  );

  // ─── Icono ─────────────────────────────────────────────────────────────────
  static BoxDecoration iconDecoration = BoxDecoration(
    color: backgroundLight,
    borderRadius: BorderRadius.circular(10),
  );

  // ─── Tipografía ────────────────────────────────────────────────────────────
  static const TextStyle tituloStyle = TextStyle(
    color: darkGreen,
    fontSize: 15,
    fontWeight: FontWeight.w800,
    height: 1.2,
  );

  static const TextStyle descripcionStyle = TextStyle(
    color: textGreen,
    fontSize: 13,
    fontWeight: FontWeight.w400,
    height: 1.5,
  );

  static const TextStyle fechaStyle = TextStyle(
    color: Color(0xFF8AA89A),
    fontSize: 12,
    fontWeight: FontWeight.w400,
  );

  // ─── Botón cerrar ──────────────────────────────────────────────────────────
  static BoxDecoration closeBtnDecoration = BoxDecoration(
    color: backgroundLight,
    borderRadius: BorderRadius.circular(8),
  );
}
