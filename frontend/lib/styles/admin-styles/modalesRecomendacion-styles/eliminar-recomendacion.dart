import 'package:flutter/material.dart';

class EliminarRecomendacionStyles {
  static const Color darkGreen = Color(0xFF073D2B);
  static const Color descriptiveText = Color(0xFF456657);
  static const Color dangerText = Color(0xFFA32626);
  static const Color dangerHover = Color(0xFF8B1F1F);
  static const Color backgroundPage = Color(0xFFF5FAF3);
  static const Color borderGrey = Color(0xFFD7E4DC);
  static const Color primaryGreen = Color(0xFF55A820);
  
  static const Color backdropColor = Color.fromRGBO(7, 61, 43, 0.45);

  static final BoxDecoration cardDecoration = BoxDecoration(
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

  static const TextStyle titleStyle = TextStyle(
    color: darkGreen,
    fontSize: 28,
    fontWeight: FontWeight.w800,
    height: 1.15,
  );

  static const TextStyle confirmMessage = TextStyle(
    color: descriptiveText,
    fontSize: 15,
    height: 1.5,
  );

  static const TextStyle confirmMessageBold = TextStyle(
    color: darkGreen,
    fontSize: 15,
    fontWeight: FontWeight.bold,
    height: 1.5,
  );

  static const TextStyle confirmWarning = TextStyle(
    color: dangerText,
    fontSize: 13,
    fontWeight: FontWeight.w700,
  );

  static final BoxDecoration cancelBtnDecoration = BoxDecoration(
    color: const Color(0xFFFBFDF9),
    border: Border.all(color: borderGrey),
    borderRadius: BorderRadius.circular(8),
  );

  static const TextStyle cancelBtnStyle = TextStyle(
    color: darkGreen,
    fontSize: 16,
    fontWeight: FontWeight.w800,
  );

  static final BoxDecoration deleteBtnDecoration = BoxDecoration(
    color: dangerText,
    borderRadius: BorderRadius.circular(8),
    boxShadow: const [
      BoxShadow(
        color: Color.fromRGBO(163, 38, 38, 0.24),
        blurRadius: 24,
        offset: Offset(0, 12),
      ),
    ],
  );

  static const TextStyle deleteBtnStyle = TextStyle(
    color: Colors.white,
    fontSize: 16,
    fontWeight: FontWeight.w800,
  );
}
