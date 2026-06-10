import 'package:flutter/material.dart';

class ApagarEquipoStyles {
  // ─── Colores ───────────────────────────────────────────────────────────────
  static const Color darkGreen        = Color(0xFF073D2B);
  static const Color textDescriptivo  = Color(0xFF456657);
  static const Color borderGrey       = Color(0xFFD7E4DC);
  static const Color backgroundLight  = Color(0xFFF5FAF3);
  static const Color backgroundHover  = Color(0xFFEDF5E9);
  static const Color cancelBg         = Color(0xFFFBFDF9);
  static const Color destructivoBg    = Color(0xFFA32626);
  static const Color destructivoHover = Color(0xFF8B1F1F);

  // ─── Backdrop ──────────────────────────────────────────────────────────────
  static const Color backdropColor = Color.fromRGBO(7, 61, 43, 0.45);

  // ─── Card ──────────────────────────────────────────────────────────────────
  static BoxDecoration cardDecoration = BoxDecoration(
    color: Colors.white,
    border: Border.all(color: borderGrey),
    borderRadius: BorderRadius.circular(8),
    boxShadow: const [
      BoxShadow(
        color: Color.fromRGBO(7, 61, 43, 0.2),
        blurRadius: 48,
        offset: Offset(0, 24),
      ),
    ],
  );

  // ─── Botón cerrar ──────────────────────────────────────────────────────────
  static BoxDecoration closeBtnDecoration = BoxDecoration(
    color: backgroundLight,
    borderRadius: BorderRadius.circular(8),
  );

  // ─── Botón Apagar ──────────────────────────────────────────────────────────
  static BoxDecoration apagarBtnDecoration = BoxDecoration(
    color: destructivoBg,
    borderRadius: BorderRadius.circular(8),
    boxShadow: const [
      BoxShadow(
        color: Color.fromRGBO(163, 38, 38, 0.24),
        blurRadius: 24,
        offset: Offset(0, 12),
      ),
    ],
  );

  // ─── Tipografía ────────────────────────────────────────────────────────────
  static const TextStyle tituloStyle = TextStyle(
    color: darkGreen,
    fontSize: 22,
    fontWeight: FontWeight.w800,
    height: 1.15,
  );

  static const TextStyle mensajeStyle = TextStyle(
    color: textDescriptivo,
    fontSize: 15,
    height: 1.5,
  );

  static const TextStyle cancelBtnText = TextStyle(
    color: darkGreen,
    fontSize: 16,
    fontWeight: FontWeight.w800,
  );

  static const TextStyle apagarBtnText = TextStyle(
    color: Colors.white,
    fontSize: 16,
    fontWeight: FontWeight.w800,
  );
}
