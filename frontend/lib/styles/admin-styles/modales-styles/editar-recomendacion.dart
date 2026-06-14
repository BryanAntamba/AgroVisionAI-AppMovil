import 'package:flutter/material.dart';

class EditarRecomendacionStyles {
  // Colores base
  static const Color darkGreen = Color(0xFF073D2B);
  static const Color primaryGreen = Color(0xFF55A820);
  static const Color backgroundModal = Color(0xFFFFFFFF);
  static const Color overlayColor = Color.fromRGBO(7, 61, 43, 0.45);
  static const Color borderGrey = Color(0xFFD7E4DC);
  static const Color borderInput = Color(0xFFC8D8CE);
  static const Color backgroundInput = Color(0xFFFBFDF9);
  static const Color backgroundCloseBtn = Color(0xFFF5FAF3);
  static const Color focusShadow = Color.fromRGBO(85, 168, 32, 0.13);

  // Decoraciones
  static const BoxDecoration modalDecoration = BoxDecoration(
    color: backgroundModal,
    border: Border.fromBorderSide(BorderSide(color: borderGrey)),
    borderRadius: BorderRadius.all(Radius.circular(8)),
    boxShadow: [
      BoxShadow(
        color: Color.fromRGBO(7, 61, 43, 0.2),
        blurRadius: 48,
        offset: Offset(0, 24),
      ),
    ],
  );

  static const BoxDecoration closeBtnDecoration = BoxDecoration(
    color: backgroundCloseBtn,
    borderRadius: BorderRadius.all(Radius.circular(8)),
  );

  static BoxDecoration inputShellDecoration({bool focused = false}) {
    return BoxDecoration(
      color: focused ? backgroundModal : backgroundInput,
      border: Border.all(color: focused ? primaryGreen : borderInput),
      borderRadius: BorderRadius.circular(8),
      boxShadow: focused
          ? [
              BoxShadow(
                color: focusShadow,
                spreadRadius: 4,
                blurRadius: 0,
              )
            ]
          : null,
    );
  }

  static const BoxDecoration cancelBtnDecoration = BoxDecoration(
    color: backgroundInput,
    border: Border.fromBorderSide(BorderSide(color: borderGrey)),
    borderRadius: BorderRadius.all(Radius.circular(8)),
  );

  static const BoxDecoration submitBtnDecoration = BoxDecoration(
    gradient: LinearGradient(
      colors: [darkGreen, primaryGreen],
      begin: Alignment.topLeft,
      end: Alignment.bottomRight,
    ),
    borderRadius: BorderRadius.all(Radius.circular(8)),
    boxShadow: [
      BoxShadow(
        color: Color.fromRGBO(7, 61, 43, 0.24),
        blurRadius: 28,
        offset: Offset(0, 16),
      ),
    ],
  );

  // Tipografía
  static const TextStyle titleStyle = TextStyle(
    color: darkGreen,
    fontSize: 28,
    fontWeight: FontWeight.w800,
    height: 1.15,
  );

  static const TextStyle labelStyle = TextStyle(
    color: darkGreen,
    fontSize: 13,
    fontWeight: FontWeight.w800,
  );

  static const TextStyle inputTextStyle = TextStyle(
    color: darkGreen,
    fontSize: 14,
  );

  static const TextStyle cancelBtnStyle = TextStyle(
    color: darkGreen,
    fontSize: 16,
    fontWeight: FontWeight.w800,
  );

  static const TextStyle submitBtnStyle = TextStyle(
    color: backgroundModal,
    fontSize: 16,
    fontWeight: FontWeight.w800,
  );
}
