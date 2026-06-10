import 'package:flutter/material.dart';

class AlertaSensorStyles {
  // Colores
  static const Color bannerBorder = Color(0xFFF7C1C1);
  static const Color bannerBorderLeft = Color(0xFFC62828);
  static const Color bannerBackground = Color(0xFFFDECEA);
  static const Color iconColor = Color(0xFFC62828);
  static const Color titleColor = Color(0xFF791F1F);
  static const Color descriptionColor = Color(0xFF633806);
  static const Color dateColor = Color(0xFF8FA69C);
  
  // Sombras
  static List<BoxShadow> bannerShadow = [
    const BoxShadow(
      color: Color.fromRGBO(198, 40, 40, 0.08),
      blurRadius: 20,
      offset: Offset(0, 8),
    )
  ];

  // Tipografía
  static const TextStyle titleText = TextStyle(
    fontSize: 14,
    fontWeight: FontWeight.w800,
    color: titleColor,
    height: 1.2,
  );

  static const TextStyle descriptionText = TextStyle(
    fontSize: 12,
    height: 1.45,
    color: descriptionColor,
  );

  static const TextStyle dateText = TextStyle(
    fontSize: 11,
    color: dateColor,
    fontWeight: FontWeight.w700,
  );

  // Decoraciones
  static BoxDecoration bannerDecoration = BoxDecoration(
    color: bannerBackground,
    border: Border(
      top: const BorderSide(color: bannerBorder),
      right: const BorderSide(color: bannerBorder),
      bottom: const BorderSide(color: bannerBorder),
      left: const BorderSide(color: bannerBorderLeft, width: 4),
    ),
    borderRadius: BorderRadius.circular(8),
    boxShadow: bannerShadow,
  );

  static BoxDecoration iconDecoration = BoxDecoration(
    color: Colors.white,
    borderRadius: BorderRadius.circular(8),
  );
}
