import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import '../../environments/modales-recomendacion.dart';

/// Clase que centraliza todos los estilos, colores, tipografía y decoraciones
/// utilizados en la pantalla de recomendaciones del administrador
class RecomendacionesStyles {
  
  // ============ COLORES PRINCIPALES ============
  /// Definición de la paleta de colores base
  
  /// Color verde oscuro - usado en textos principales y títulos
  static const Color darkGreen       = Color(0xFF073D2B);
  
  /// Color verde primario - usado en botones y elementos destacados
  static const Color primaryGreen    = Color(0xFF55A820);
  
  /// Color verde de texto - usado en descripciones
  static const Color textGreen       = Color(0xFF456657);
  
  /// Color de subtexto - usado en textos secundarios
  static const Color subtext         = Color(0xFF597268);
  
  /// Color de fondo de página - usado como fondo general
  static const Color backgroundPage  = Color(0xFFF5FAF3);
  
  /// Color blanco - usado en tarjetas y elementos principales
  static const Color backgroundWhite = Color(0xFFFFFFFF);
  
  /// Color de fondo para inputs - usado en campos de entrada
  static const Color backgroundInput = Color(0xFFFBFDF9);
  
  /// Color gris para bordes - usado en bordes de elementos
  static const Color borderGrey      = Color(0xFFD7E4DC);
  
  /// Color gris para bordes de inputs - usado en bordes de campos
  static const Color borderInput     = Color(0xFFC8D8CE);

  // ============ COLORES POR TIPO DE RECOMENDACIÓN ============
  /// Paleta de colores para diferentes estados/tipos de recomendaciones
  
  // ─ Verde (ok / estado normal) ─
  /// Fondo para recomendaciones verdes
  static const Color verdeBg     = Color(0xFFEAF7E5);
  
  /// Borde para recomendaciones verdes
  static const Color verdeBorder = Color(0xFFC0DD97);
  
  /// Texto para recomendaciones verdes
  static const Color verdeText   = Color(0xFF23730F);

  // ─ Amarillo (warn / precaución) ─
  /// Fondo para recomendaciones amarillas
  static const Color amarilloBg     = Color(0xFFFDF5E7);
  
  /// Borde para recomendaciones amarillas
  static const Color amarilloBorder = Color(0xFFFAC775);
  
  /// Texto para recomendaciones amarillas
  static const Color amarilloText   = Color(0xFFB56C07);

  // ─ Naranja (alta / peligro medio) ─
  /// Fondo para recomendaciones naranjas
  static const Color naranjaBg     = Color(0xFFFFF3E0);
  
  /// Borde para recomendaciones naranjas
  static const Color naranjaBorder = Color(0xFFFFCC80);
  
  /// Texto para recomendaciones naranjas
  static const Color naranjaText   = Color(0xFFE65100);

  // ─ Rojo (crit / crítico) ─
  /// Fondo para recomendaciones rojas
  static const Color rojoBg     = Color(0xFFFDECEA);
  
  /// Borde para recomendaciones rojas
  static const Color rojoBorder = Color(0xFFF7C1C1);
  
  /// Texto para recomendaciones rojas
  static const Color rojoText   = Color(0xFFC62828);

  // ============ COLORES DE BOTÓN PELIGRO ============
  /// Colores específicos para elementos destructivos
  
  /// Borde para botones peligro
  static const Color dangerBorder = Color(0xFFF7C1C1);
  
  /// Texto para botones peligro
  static const Color dangerText   = Color(0xFFC62828);

  // ============ TIPOGRAFÍA ============
  /// Definición de estilos de texto reutilizables
  
  /// Estilo eyebrow - pequeño texto destacado en verde
  static const TextStyle eyebrowText = TextStyle(
    color: primaryGreen,
    fontSize: 13,
    fontWeight: FontWeight.w800,
    letterSpacing: 1.0,
  );

  /// Estilo para encabezado H1 - texto muy grande y negrita
  static const TextStyle h1Text = TextStyle(
    color: darkGreen,
    fontSize: 34,
    fontWeight: FontWeight.w800,
    height: 1.15,
  );

  /// Estilo para descripción de encabezado - texto de apoyo
  static const TextStyle headerDesc = TextStyle(
    color: textGreen,
    fontSize: 15,
    height: 1.4,
  );

  /// Estilo para labels - texto pequeño y negrita
  static const TextStyle labelText = TextStyle(
    color: darkGreen,
    fontSize: 13,
    fontWeight: FontWeight.w800,
  );

  /// Estilo para título de sección - texto destacado
  static const TextStyle sectionTitle = TextStyle(
    color: darkGreen,
    fontSize: 18,
    fontWeight: FontWeight.w800,
  );

  /// Estilo para título de tarjeta - texto medio y negrita
  static const TextStyle cardTitle = TextStyle(
    color: darkGreen,
    fontSize: 16,
    fontWeight: FontWeight.w800,
  );

  /// Estilo para descripción en tarjeta - texto gris
  static const TextStyle cardDesc = TextStyle(
    color: Color(0xFF597268),
    fontSize: 13,
    height: 1.5,
  );

  /// Estilo para label de acción - texto muy pequeño y negrita
  static const TextStyle accionLabel = TextStyle(
    color: darkGreen,
    fontSize: 12,
    fontWeight: FontWeight.w800,
    letterSpacing: 0.3,
  );

  /// Estilo para texto de acción - descripción de acción
  static const TextStyle accionText = TextStyle(
    color: Color(0xFF597268),
    fontSize: 13,
    height: 1.5,
  );

  /// Estilo para texto de badge - muy pequeño y negrita
  static const TextStyle badgeText = TextStyle(
    fontSize: 10,
    fontWeight: FontWeight.w800,
    letterSpacing: 0.5,
  );

  /// Estilo para estado vacío - texto descriptivo
  static const TextStyle emptyText = TextStyle(
    color: Color(0xFF597268),
    fontSize: 14,
  );

  // ============ DECORACIONES ============
  /// Estilos específicos para elementos visuales
  
  /// Decoración para barra de filtros - borde gris con fondo blanco
  static BoxDecoration get filterBarDecoration => BoxDecoration(
    color: backgroundWhite, // Fondo blanco
    border: Border.all(color: borderGrey), // Borde gris
    borderRadius: BorderRadius.circular(8), // Esquinas redondeadas
  );

  /// Decoración para sección - similar a barra de filtros
  static BoxDecoration get sectionDecoration => BoxDecoration(
    color: backgroundWhite,
    border: Border.all(color: borderGrey),
    borderRadius: BorderRadius.circular(8),
  );

  /// Decoración dinámica para inputs según estado de enfoque
  /// Cambia color de fondo y borde cuando está enfocado
  static BoxDecoration inputDecoration({bool focused = false}) => BoxDecoration(
    color: focused ? backgroundWhite : backgroundInput, // Fondo blanco si está enfocado
    border: Border.all(color: focused ? primaryGreen : borderInput), // Borde verde si está enfocado
    borderRadius: BorderRadius.circular(8), // Esquinas redondeadas
    boxShadow: focused
        ? [BoxShadow(color: primaryGreen.withValues(alpha: 0.13), blurRadius: 0, spreadRadius: 4)] // Sombra glow
        : null,
  );

  /// Decoración para botón crear - gradiente verde
  static BoxDecoration get createBtnDecoration => BoxDecoration(
    gradient: const LinearGradient(
      colors: [darkGreen, primaryGreen], // Gradiente verde
      begin: Alignment.topLeft,
      end: Alignment.bottomRight,
    ),
    borderRadius: BorderRadius.circular(8), // Esquinas redondeadas
  );

  /// Decoración dinámica para botones de icono según tipo
  /// Cambia el color del borde si es un botón peligro
  static BoxDecoration iconBtnDecoration({bool danger = false}) => BoxDecoration(
    color: backgroundWhite, // Fondo blanco
    border: Border.all(color: danger ? dangerBorder : borderGrey), // Borde rojo si es peligro
    borderRadius: BorderRadius.circular(8), // Esquinas redondeadas
  );

  // ============ HELPERS DE COLOR POR RECOMENDACIÓN ============
  /// Funciones que devuelven colores según el tipo de recomendación
  
  /// Retorna el color de fondo según el tipo de recomendación
  static Color cardBg(ColorRecomendacion c) {
    switch (c) {
      case ColorRecomendacion.verde:    return verdeBg;
      case ColorRecomendacion.amarillo: return amarilloBg;
      case ColorRecomendacion.naranja:  return naranjaBg;
      case ColorRecomendacion.rojo:     return rojoBg;
    }
  }

  /// Retorna el color de borde según el tipo de recomendación
  static Color cardBorder(ColorRecomendacion c) {
    switch (c) {
      case ColorRecomendacion.verde:    return verdeBorder;
      case ColorRecomendacion.amarillo: return amarilloBorder;
      case ColorRecomendacion.naranja:  return naranjaBorder;
      case ColorRecomendacion.rojo:     return rojoBorder;
    }
  }

  /// Retorna el color de fondo según la prioridad de recomendación
  static Color prioridadBg(PrioridadRecomendacion p) {
    switch (p) {
      case PrioridadRecomendacion.baja:    return verdeBg;
      case PrioridadRecomendacion.media:   return amarilloBg;
      case PrioridadRecomendacion.alta:    return naranjaBg;
      case PrioridadRecomendacion.critica: return rojoBg;
    }
  }

  /// Retorna el color de texto según la prioridad de recomendación
  static Color prioridadText(PrioridadRecomendacion p) {
    switch (p) {
      case PrioridadRecomendacion.baja:    return verdeText;
      case PrioridadRecomendacion.media:   return amarilloText;
      case PrioridadRecomendacion.alta:    return naranjaText;
      case PrioridadRecomendacion.critica: return rojoText;
    }
  }

  /// Retorna el ícono FontAwesome según el tipo de recomendación
  static FaIconData prioridadIcon(ColorRecomendacion c) {
    switch (c) {
      case ColorRecomendacion.verde:    return FontAwesomeIcons.circleCheck; // Checkmark para OK
      case ColorRecomendacion.amarillo: return FontAwesomeIcons.circleExclamation; // Exclamación para warning
      case ColorRecomendacion.naranja:  return FontAwesomeIcons.triangleExclamation; // Triángulo para alta
      case ColorRecomendacion.rojo:     return FontAwesomeIcons.circleXmark; // X para crítico
    }
  }
}
