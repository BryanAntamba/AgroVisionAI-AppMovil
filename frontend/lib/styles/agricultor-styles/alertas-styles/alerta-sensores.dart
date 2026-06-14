import 'package:flutter/material.dart';

/// Estilos para el componente de alerta de sensor (banner de error rojo)
class AlertaSensorStyles {
  // ─── Colores ───────────────────────────────────────────────────────────────
  static const Color alertRed = Color(0xFFC62828);
  static const Color darkRed = Color(0xFF791F1F);
  static const Color brownText = Color(0xFF633806);
  static const Color greyText = Color(0xFF8FA69C);
  static const Color borderRed = Color(0xFFF7C1C1);
  static const Color backgroundRed = Color(0xFFFDECEA);
  static const Color iconBackground = Color(0xFFFFFFFF);

  // ─── Banner (estilo alerta roja) ───────────────────────────────────────────
  static BoxDecoration bannerDecoration = BoxDecoration(
    color: backgroundRed,
    border: Border.all(color: alertRed, width: 2),
    borderRadius: BorderRadius.circular(8),
  );

  // ─── Icono (recuadro blanco) ───────────────────────────────────────────────
  static BoxDecoration iconDecoration = BoxDecoration(
    color: iconBackground,
    borderRadius: BorderRadius.circular(8),
  );

  // ─── Tipografía ────────────────────────────────────────────────────────────
  static const TextStyle tituloStyle = TextStyle(
    color: darkRed,
    fontSize: 14,
    fontWeight: FontWeight.w800,
  );

  static const TextStyle descripcionStyle = TextStyle(
    color: brownText,
    fontSize: 12,
    fontWeight: FontWeight.w400,
  );

  static const TextStyle fechaStyle = TextStyle(
    color: greyText,
    fontSize: 11,
    fontWeight: FontWeight.w700,
  );

  // ─── Botón cerrar (transparente con hover) ─────────────────────────────────
  static BoxDecoration closeBtnDecoration = BoxDecoration(
    color: Colors.white,
    borderRadius: BorderRadius.circular(8),
  );
  
  static BoxDecoration closeBtnHoverDecoration = BoxDecoration(
    color: const Color(0x1AC62828),
    borderRadius: BorderRadius.circular(8),
  );
}
