import 'package:flutter/material.dart';

class PlataformaEditableStyles {
  // Colores Base (Por defecto o referencias constantes para partes estáticas)
  static const Color primaryGreen = Color(0xFF55A820);
  static const Color darkGreen = Color(0xFF073D2B);
  static const Color bgPage = Color(0xFFF5FAF3);
  static const Color textDesc = Color(0xFF597268);
  static const Color textHelp = Color(0xFF456657);
  static const Color bgHelp = Color(0xFFF7FBF5);
  static const Color borderGrey = Color(0xFFD7E4DC);
  static const Color borderInput = Color(0xFFC8D8CE);
  static const Color bgInput = Color(0xFFFBFDF9);
  static const Color bgCard = Colors.white;
  static const Color danger = Color(0xFFA32626);
  static const Color dangerHover = Color(0xFF8B1F1F);
  static const Color dangerBg = Color(0xFFFDECEA);

  // Tipografía
  static const TextStyle eyebrow = TextStyle(
    fontSize: 13,
    fontWeight: FontWeight.w800,
    color: primaryGreen,
    letterSpacing: 0.5,
  );

  static const TextStyle h1 = TextStyle(
    fontSize: 34,
    fontWeight: FontWeight.bold,
    color: darkGreen,
    height: 1.15,
  );

  static const TextStyle pageDesc = TextStyle(
    fontSize: 15,
    color: textHelp,
  );

  static const TextStyle sectionTitle = TextStyle(
    fontSize: 24,
    fontWeight: FontWeight.bold,
    color: darkGreen,
  );

  static const TextStyle sectionDesc = TextStyle(
    fontSize: 14,
    color: textDesc,
    height: 1.5,
  );

  static const TextStyle configLabel = TextStyle(
    fontSize: 14,
    fontWeight: FontWeight.w800,
    color: darkGreen,
  );

  static const TextStyle helpText = TextStyle(
    fontSize: 13,
    color: textHelp,
    height: 1.5,
  );

  static const TextStyle helpTextSmall = TextStyle(
    fontSize: 12,
    color: Color(0xFF6B8177),
  );

  // Decoraciones
  static final BoxDecoration sectionDecoration = BoxDecoration(
    color: bgCard,
    borderRadius: BorderRadius.circular(12),
    border: Border.all(color: borderGrey),
    boxShadow: const [
      BoxShadow(
        color: Color.fromRGBO(7, 61, 43, 0.04),
        blurRadius: 8,
        offset: Offset(0, 2),
      ),
    ],
  );

  static final BoxDecoration fileUploadArea = BoxDecoration(
    color: bgInput,
    borderRadius: BorderRadius.circular(8),
    border: Border.all(color: borderInput, width: 2), // en CSS era dashed pero se simula
  );

  static final BoxDecoration helpBox = BoxDecoration(
    color: bgHelp,
    borderRadius: BorderRadius.circular(4),
    border: const Border(left: BorderSide(color: primaryGreen, width: 3)),
  );

  // Botones estáticos (algunos dinámicos los haremos in-line)
  static final BoxDecoration primaryBtn = BoxDecoration(
    gradient: const LinearGradient(
      colors: [darkGreen, primaryGreen],
      begin: Alignment.topLeft,
      end: Alignment.bottomRight,
    ),
    borderRadius: BorderRadius.circular(8),
    boxShadow: const [
      BoxShadow(
        color: Color.fromRGBO(7, 61, 43, 0.2),
        blurRadius: 12,
        offset: Offset(0, 4),
      ),
    ],
  );

  static final BoxDecoration secondaryBtn = BoxDecoration(
    color: darkGreen,
    borderRadius: BorderRadius.circular(8),
  );

  static final BoxDecoration tertiaryBtn = BoxDecoration(
    color: const Color(0xFFEDF1EE),
    borderRadius: BorderRadius.circular(8),
    border: Border.all(color: borderInput),
  );

  static final BoxDecoration cancelBtn = BoxDecoration(
    color: const Color(0xFFF5EEEE),
    borderRadius: BorderRadius.circular(8),
    border: Border.all(color: const Color(0xFFF0C8C8)),
  );

  // Inputs
  static BoxDecoration inputDecoration() {
    return BoxDecoration(
      color: bgInput,
      borderRadius: BorderRadius.circular(8),
      border: Border.all(color: borderInput),
    );
  }
}
