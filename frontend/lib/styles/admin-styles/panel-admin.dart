import 'package:flutter/material.dart';

/// Clase que centraliza todos los estilos, colores, tipografía y decoraciones
/// utilizados en el panel principal del administrador
class PanelAdminStyles {
  
  // ============ COLORES PRINCIPALES ============
  /// Definición de la paleta de colores base para el panel admin
  
  /// Color verde oscuro - usado en textos principales y títulos
  static const Color darkGreen       = Color(0xFF073D2B);
  
  /// Color verde primario - usado en botones y elementos destacados
  static const Color primaryGreen    = Color(0xFF55A820);
  
  /// Color verde de texto - usado en descripciones
  static const Color textGreen       = Color(0xFF456657);
  
  /// Color verde para links - usado en elementos interactivos
  static const Color linkGreen       = Color(0xFF0B5A3D);
  
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
  
  /// Color de subtexto - usado en textos secundarios
  static const Color subtext         = Color(0xFF597268);
  
  /// Color para etiquetas (dt) - usado en definiciones
  static const Color dtColor         = Color(0xFF6B8177);

  // ============ COLORES DE BADGES ============
  /// Colores específicos para diferentes tipos de badges/etiquetas
  
  /// Fondo para badge de rol
  static const Color roleBg      = Color(0xFFE9F2FF);
  
  /// Texto para badge de rol
  static const Color roleText    = Color(0xFF174C7C);
  
  /// Fondo para badge activo - verde claro
  static const Color activeBg    = Color(0xFFEAF7E5);
  
  /// Texto para badge activo - verde oscuro
  static const Color activeText  = Color(0xFF23730F);
  
  /// Fondo para badge inactivo - rojo muy claro
  static const Color inactiveBg  = Color(0xFFF5EEEE);
  
  /// Texto para badge inactivo - rojo
  static const Color inactiveText= Color(0xFF9A2424);
  
  /// Fondo para badge dispositivo vinculado - azul claro
  static const Color deviceLinkedBg     = Color(0xFFE0F2F7);
  
  /// Texto para badge dispositivo vinculado - azul
  static const Color deviceLinkedText   = Color(0xFF0277BD);
  
  /// Fondo para badge dispositivo desvinculado - naranja muy claro
  static const Color deviceUnlinkedBg   = Color(0xFFFFF3E0);
  
  /// Texto para badge dispositivo desvinculado - naranja
  static const Color deviceUnlinkedText = Color(0xFFE65100);

  // ============ COLORES DE BOTÓN PELIGRO ============
  /// Colores específicos para elementos destructivos
  
  /// Borde para botones peligro - rojo claro
  static const Color dangerBorder = Color(0xFFF0C8C8);
  
  /// Texto para botones peligro - rojo oscuro
  static const Color dangerText   = Color(0xFFA32626);

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

  /// Estilo para labels/etiquetas - texto pequeño y negrita
  static const TextStyle labelText = TextStyle(
    color: darkGreen,
    fontSize: 13,
    fontWeight: FontWeight.w800,
  );

  /// Estilo para números en resumen - texto grande en verde
  static const TextStyle summaryNumber = TextStyle(
    color: linkGreen,
    fontSize: 26,
    fontWeight: FontWeight.w800,
  );

  /// Estilo para labels en resumen - texto pequeño
  static const TextStyle summaryLabel = TextStyle(
    color: darkGreen,
    fontSize: 14,
    fontWeight: FontWeight.w700,
  );

  /// Estilo para nombre en tarjeta - texto destacado
  static const TextStyle cardName = TextStyle(
    color: darkGreen,
    fontSize: 18,
    fontWeight: FontWeight.w800,
  );

  /// Estilo para email en tarjeta - texto gris
  static const TextStyle cardEmail = TextStyle(
    color: subtext,
    fontSize: 14,
  );

  /// Estilo para texto de badge - pequeño y negrita
  static const TextStyle badgeText = TextStyle(
    fontSize: 12,
    fontWeight: FontWeight.w800,
  );

  /// Estilo para término de definición (dt) - etiqueta de información
  static const TextStyle dtText = TextStyle(
    color: dtColor,
    fontSize: 12,
    fontWeight: FontWeight.w800,
  );

  /// Estilo para definición (dd) - valor de información
  static const TextStyle ddText = TextStyle(
    color: darkGreen,
    fontSize: 14,
    fontWeight: FontWeight.w700,
  );

  /// Estilo para botones de acción - texto pequeño y negrita
  static const TextStyle actionBtnText = TextStyle(
    color: darkGreen,
    fontSize: 13,
    fontWeight: FontWeight.w800,
  );

  /// Estilo para estado vacío - texto descriptivo
  static const TextStyle emptyStateText = TextStyle(
    color: textGreen,
    fontSize: 15,
  );

  // ============ DECORACIONES ============
  /// Estilos específicos para elementos visuales
  
  /// Decoración para tarjetas - borde gris con fondo blanco
  static BoxDecoration cardDecoration = BoxDecoration(
    color: backgroundWhite, // Fondo blanco
    border: Border.all(color: borderGrey), // Borde gris
    borderRadius: BorderRadius.circular(8), // Esquinas redondeadas
  );

  /// Decoración para barra de filtros - similar a tarjeta
  static BoxDecoration filterBarDecoration = BoxDecoration(
    color: backgroundWhite,
    border: Border.all(color: borderGrey),
    borderRadius: BorderRadius.circular(8),
  );

  /// Decoración para tarjeta de resumen - similar a tarjeta
  static BoxDecoration summaryCardDecoration = BoxDecoration(
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

  /// Decoración para avatar - fondo verde oscuro
  static BoxDecoration avatarDecoration = const BoxDecoration(
    color: darkGreen,
    borderRadius: BorderRadius.all(Radius.circular(8)),
  );

  /// Decoración para botón crear - gradiente verde
  static BoxDecoration createBtnDecoration = BoxDecoration(
    gradient: const LinearGradient(
      colors: [darkGreen, primaryGreen], // Gradiente verde
      begin: Alignment.topLeft,
      end: Alignment.bottomRight,
    ),
    borderRadius: BorderRadius.circular(8),
  );

  /// Decoración para botón acceso panel - gradiente verde
  static BoxDecoration accessPanelDecoration = BoxDecoration(
    gradient: const LinearGradient(
      colors: [darkGreen, primaryGreen],
      begin: Alignment.topLeft,
      end: Alignment.bottomRight,
    ),
    borderRadius: BorderRadius.circular(8),
  );

  /// Decoración para botones de acción - fondo claro con borde
  static BoxDecoration actionBtnDecoration = BoxDecoration(
    color: backgroundInput,
    border: Border.all(color: borderGrey),
    borderRadius: BorderRadius.circular(8),
  );

  /// Decoración para botones peligro - fondo claro con borde rojo
  static BoxDecoration dangerBtnDecoration = BoxDecoration(
    color: backgroundInput,
    border: Border.all(color: dangerBorder),
    borderRadius: BorderRadius.circular(8),
  );
}
