import 'package:flutter/material.dart';

class DesconectarDispositivoStyles {
  // Constantes de diseño
  static const double maxWidth = 480.0;
  
  // Colores base
  static const Color overlayColor = Color.fromRGBO(7, 61, 43, 0.45);
  static const Color backgroundColor = Colors.white;
  static const Color borderColor = Color(0xFFd7e4dc);
  static const Color titleColor = Color(0xFF073d2b);
  static const Color messageColor = Color(0xFF456657);
  
  static const Color closeBtnBg = Color(0xFFf5faf3);
  static const Color closeBtnColor = Color(0xFF073d2b);

  static const Color cancelBtnBg = Color(0xFFfbfdf9);
  
  static const Color destructBtnBg = Color(0xFFa32626);
  static const Color destructBtnShadow = Color.fromRGBO(163, 38, 38, 0.24);

  // Decoraciones
  static BoxDecoration modalDecoration = BoxDecoration(
    color: backgroundColor,
    border: Border.all(color: borderColor),
    borderRadius: BorderRadius.circular(8),
    boxShadow: const [
      BoxShadow(
        color: Color.fromRGBO(7, 61, 43, 0.2),
        blurRadius: 48,
        offset: Offset(0, 24),
      ),
    ],
  );

  static BoxDecoration closeBtnDecoration = BoxDecoration(
    color: closeBtnBg,
    borderRadius: BorderRadius.circular(8),
  );

  static BoxDecoration cancelBtnDecoration = BoxDecoration(
    color: cancelBtnBg,
    border: Border.all(color: borderColor),
    borderRadius: BorderRadius.circular(8),
  );

  static BoxDecoration disconnectBtnDecoration = BoxDecoration(
    color: destructBtnBg,
    borderRadius: BorderRadius.circular(8),
    boxShadow: const [
      BoxShadow(
        color: destructBtnShadow,
        blurRadius: 24,
        offset: Offset(0, 12),
      ),
    ],
  );

  // Estilos de texto
  static const TextStyle titleStyle = TextStyle(
    color: titleColor,
    fontSize: 28,
    fontWeight: FontWeight.w800,
    height: 1.15,
  );

  static const TextStyle messageStyle = TextStyle(
    color: messageColor,
    fontSize: 15,
    height: 1.5,
  );

  static const TextStyle cancelBtnStyle = TextStyle(
    color: titleColor,
    fontSize: 16,
    fontWeight: FontWeight.w800,
  );

  static const TextStyle disconnectBtnStyle = TextStyle(
    color: Colors.white,
    fontSize: 16,
    fontWeight: FontWeight.w800,
  );
}
