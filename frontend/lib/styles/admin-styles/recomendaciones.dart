import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import '../../environments/modales-recomendacion.dart';

class RecomendacionesStyles {
  // ─── Colores principales ──────────────────────────────────────────────────
  static const Color darkGreen       = Color(0xFF073D2B);
  static const Color primaryGreen    = Color(0xFF55A820);
  static const Color textGreen       = Color(0xFF456657);
  static const Color subtext         = Color(0xFF597268);
  static const Color backgroundPage  = Color(0xFFF5FAF3);
  static const Color backgroundWhite = Color(0xFFFFFFFF);
  static const Color backgroundInput = Color(0xFFFBFDF9);
  static const Color borderGrey      = Color(0xFFD7E4DC);
  static const Color borderInput     = Color(0xFFC8D8CE);

  // ─── Colores por tipo de recomendación ───────────────────────────────────
  // Verde (ok)
  static const Color verdeBg     = Color(0xFFEAF7E5);
  static const Color verdeBorder = Color(0xFFC0DD97);
  static const Color verdeText   = Color(0xFF23730F);

  // Amarillo (warn)
  static const Color amarilloBg     = Color(0xFFFDF5E7);
  static const Color amarilloBorder = Color(0xFFFAC775);
  static const Color amarilloText   = Color(0xFFB56C07);

  // Naranja (alta)
  static const Color naranjaBg     = Color(0xFFFFF3E0);
  static const Color naranjaBorder = Color(0xFFFFCC80);
  static const Color naranjaText   = Color(0xFFE65100);

  // Rojo (crit)
  static const Color rojoBg     = Color(0xFFFDECEA);
  static const Color rojoBorder = Color(0xFFF7C1C1);
  static const Color rojoText   = Color(0xFFC62828);

  // ─── Botón peligro ────────────────────────────────────────────────────────
  static const Color dangerBorder = Color(0xFFF7C1C1);
  static const Color dangerText   = Color(0xFFC62828);

  // ─── Tipografía ──────────────────────────────────────────────────────────
  static const TextStyle eyebrowText = TextStyle(
    color: primaryGreen,
    fontSize: 13,
    fontWeight: FontWeight.w800,
    letterSpacing: 1.0,
  );

  static const TextStyle h1Text = TextStyle(
    color: darkGreen,
    fontSize: 34,
    fontWeight: FontWeight.w800,
    height: 1.15,
  );

  static const TextStyle headerDesc = TextStyle(
    color: textGreen,
    fontSize: 15,
    height: 1.4,
  );

  static const TextStyle labelText = TextStyle(
    color: darkGreen,
    fontSize: 13,
    fontWeight: FontWeight.w800,
  );

  static const TextStyle sectionTitle = TextStyle(
    color: darkGreen,
    fontSize: 18,
    fontWeight: FontWeight.w800,
  );

  static const TextStyle cardTitle = TextStyle(
    color: darkGreen,
    fontSize: 16,
    fontWeight: FontWeight.w800,
  );

  static const TextStyle cardDesc = TextStyle(
    color: Color(0xFF597268),
    fontSize: 13,
    height: 1.5,
  );

  static const TextStyle accionLabel = TextStyle(
    color: darkGreen,
    fontSize: 12,
    fontWeight: FontWeight.w800,
    letterSpacing: 0.3,
  );

  static const TextStyle accionText = TextStyle(
    color: Color(0xFF597268),
    fontSize: 13,
    height: 1.5,
  );

  static const TextStyle badgeText = TextStyle(
    fontSize: 10,
    fontWeight: FontWeight.w800,
    letterSpacing: 0.5,
  );

  static const TextStyle emptyText = TextStyle(
    color: Color(0xFF597268),
    fontSize: 14,
  );

  // ─── Decoraciones ─────────────────────────────────────────────────────────
  static BoxDecoration get filterBarDecoration => BoxDecoration(
    color: backgroundWhite,
    border: Border.all(color: borderGrey),
    borderRadius: BorderRadius.circular(8),
  );

  static BoxDecoration get sectionDecoration => BoxDecoration(
    color: backgroundWhite,
    border: Border.all(color: borderGrey),
    borderRadius: BorderRadius.circular(8),
  );

  static BoxDecoration inputDecoration({bool focused = false}) => BoxDecoration(
    color: focused ? backgroundWhite : backgroundInput,
    border: Border.all(color: focused ? primaryGreen : borderInput),
    borderRadius: BorderRadius.circular(8),
    boxShadow: focused
        ? [BoxShadow(color: primaryGreen.withValues(alpha: 0.13), blurRadius: 0, spreadRadius: 4)]
        : null,
  );

  static BoxDecoration get createBtnDecoration => BoxDecoration(
    gradient: const LinearGradient(
      colors: [darkGreen, primaryGreen],
      begin: Alignment.topLeft,
      end: Alignment.bottomRight,
    ),
    borderRadius: BorderRadius.circular(8),
  );

  static BoxDecoration iconBtnDecoration({bool danger = false}) => BoxDecoration(
    color: backgroundWhite,
    border: Border.all(color: danger ? dangerBorder : borderGrey),
    borderRadius: BorderRadius.circular(8),
  );

  // ─── Helpers de color por recomendación ──────────────────────────────────

  static Color cardBg(ColorRecomendacion c) {
    switch (c) {
      case ColorRecomendacion.verde:    return verdeBg;
      case ColorRecomendacion.amarillo: return amarilloBg;
      case ColorRecomendacion.naranja:  return naranjaBg;
      case ColorRecomendacion.rojo:     return rojoBg;
    }
  }

  static Color cardBorder(ColorRecomendacion c) {
    switch (c) {
      case ColorRecomendacion.verde:    return verdeBorder;
      case ColorRecomendacion.amarillo: return amarilloBorder;
      case ColorRecomendacion.naranja:  return naranjaBorder;
      case ColorRecomendacion.rojo:     return rojoBorder;
    }
  }

  static Color prioridadBg(PrioridadRecomendacion p) {
    switch (p) {
      case PrioridadRecomendacion.baja:    return verdeBg;
      case PrioridadRecomendacion.media:   return amarilloBg;
      case PrioridadRecomendacion.alta:    return naranjaBg;
      case PrioridadRecomendacion.critica: return rojoBg;
    }
  }

  static Color prioridadText(PrioridadRecomendacion p) {
    switch (p) {
      case PrioridadRecomendacion.baja:    return verdeText;
      case PrioridadRecomendacion.media:   return amarilloText;
      case PrioridadRecomendacion.alta:    return naranjaText;
      case PrioridadRecomendacion.critica: return rojoText;
    }
  }

  static FaIconData prioridadIcon(ColorRecomendacion c) {
    switch (c) {
      case ColorRecomendacion.verde:    return FontAwesomeIcons.circleCheck;
      case ColorRecomendacion.amarillo: return FontAwesomeIcons.circleExclamation;
      case ColorRecomendacion.naranja:  return FontAwesomeIcons.triangleExclamation;
      case ColorRecomendacion.rojo:     return FontAwesomeIcons.circleXmark;
    }
  }
}
