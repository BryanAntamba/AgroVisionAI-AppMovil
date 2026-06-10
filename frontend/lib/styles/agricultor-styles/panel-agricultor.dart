import 'package:flutter/material.dart';

class PanelAgricultorStyles {
  // Colores principales
  static const Color darkGreen = Color(0xFF073D2B);
  static const Color primaryGreen = Color(0xFF55A820);
  static const Color textGreen = Color(0xFF597268);
  static const Color backgroundLight = Color(0xFFF5FAF3);
  static const Color cardBackground = Color(0xFFFFFFFF);
  static const Color borderGrey = Color(0xFFD7E4DC);
  
  // Colores de estado
  static const Color sanoBg = Color(0xFFEAF7E5);
  static const Color sanoText = Color(0xFF23730F);
  static const Color warnBg = Color(0xFFFDF5E7);
  static const Color warnText = Color(0xFFB56C07);
  static const Color critBg = Color(0xFFFDECEA);
  static const Color critText = Color(0xFFC62828);
  static const Color estBg = Color(0xFFE9F2FF);
  static const Color estText = Color(0xFF174C7C);

  // Tipografía
  static const TextStyle dashTitle = TextStyle(
    color: darkGreen,
    fontSize: 17,
    fontWeight: FontWeight.w800,
    height: 1.2,
  );

  static const TextStyle secHeadTitle = TextStyle(
    color: darkGreen,
    fontSize: 15,
    fontWeight: FontWeight.w800,
  );

  // Botón Guardar
  static BoxDecoration btnGuardarDecoration = BoxDecoration(
    gradient: const LinearGradient(
      colors: [darkGreen, primaryGreen],
      begin: Alignment.topLeft,
      end: Alignment.bottomRight,
    ),
    borderRadius: BorderRadius.circular(8),
    boxShadow: const [
      BoxShadow(
        color: Color.fromRGBO(7, 61, 43, 0.15),
        blurRadius: 20,
        offset: Offset(0, 8),
      )
    ],
  );

  // Decoraciones genéricas de sección
  static BoxDecoration secDecoration = BoxDecoration(
    color: cardBackground,
    border: Border.all(color: borderGrey),
    borderRadius: BorderRadius.circular(8),
    boxShadow: const [
      BoxShadow(color: Color.fromRGBO(7, 61, 43, 0.05), blurRadius: 24, offset: Offset(0, 10))
    ]
  );
  
  static BoxDecoration imgPlaceholderDecoration = BoxDecoration(
    color: const Color(0xFFFBFDF9),
    // Simulate dashed border with continuous line, as native dashed borders require custom painters
    border: Border.all(color: borderGrey, style: BorderStyle.solid), 
    borderRadius: BorderRadius.circular(8),
  );

  static BoxDecoration scDecoration = BoxDecoration(
    color: const Color(0xFFFBFDF9),
    border: Border.all(color: borderGrey),
    borderRadius: BorderRadius.circular(8),
  );

  // Botones conectividad
  static BoxDecoration btnApagarDecoration = BoxDecoration(
    color: Colors.white,
    border: Border.all(color: const Color(0xFFE0B4B4)),
    borderRadius: BorderRadius.circular(8),
  );

  static BoxDecoration btnReconectarDecoration = BoxDecoration(
    color: Colors.white,
    border: Border.all(color: const Color(0xFFFFE0B2)),
    borderRadius: BorderRadius.circular(8),
  );
}
