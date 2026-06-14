import 'package:flutter/material.dart';

/// Clase que centraliza todos los estilos, colores, tipografía y decoraciones
/// utilizados en la pantalla de historial del panel del agricultor
class HistorialStyles {
  
  // ============ COLORES PRINCIPALES ============
  /// Definición de la paleta de colores base para la pantalla de historial
  
  /// Color verde oscuro - usado en textos principales y títulos
  static const Color darkGreen = Color(0xFF073D2B);
  
  /// Color verde primario - usado en elementos destacados y controles
  static const Color primaryGreen = Color(0xFF55A820);
  
  /// Color verde de texto - usado en descripciones y texto secundario
  static const Color textGreen = Color(0xFF456657);
  
  /// Color verde para links - usado en elementos interactivos
  static const Color linkGreen = Color(0xFF0B5A3D);
  
  /// Color de fondo claro - usado como fondo general de la pantalla
  static const Color backgroundLight = Color(0xFFF5FAF3);
  
  /// Color de fondo para tarjetas - blanco puro para contraste
  static const Color cardBackground = Color(0xFFFFFFFF);
  
  /// Color gris para bordes - usado en los bordes de elementos
  static const Color borderGrey = Color(0xFFD7E4DC);
  
  /// Color de fondo de inputs - usado en campos de entrada
  static const Color inputBackground = Color(0xFFFBFDF9);
  
  /// Color de texto hint/placeholder - usado en textos sugeridos
  static const Color hintTextColor = Color(0xFF8FA69C);
  
  /// Color de borde alternativo - usado en elementos especiales
  static const Color borderColor = Color(0xFFAAC0B3);

  // ============ COLORES DE ESTADO ============
  /// Paleta de colores para indicar diferentes estados de salud/alarma
  
  /// Texto para estado "Sano" - verde oscuro indicando normalidad
  static const Color sanoText = Color(0xFF23730F);
  
  /// Fondo para estado "Sano" - verde claro como fondo de badge
  static const Color sanoBg = Color(0xFFEAF7E5);
  
  /// Texto para estado "Alerta" - azul oscuro indicando precaución
  static const Color alertaText = Color(0xFF174C7C);
  
  /// Fondo para estado "Alerta" - azul claro como fondo de badge
  static const Color alertaBg = Color(0xFFE9F2FF);
  
  /// Texto para estado "Crítico" - rojo oscuro indicando peligro
  static const Color criticoText = Color(0xFF9A2424);
  
  /// Fondo para estado "Crítico" - rojo muy claro como fondo de badge
  static const Color criticoBg = Color(0xFFF5EEEE);

  // ============ TIPOGRAFÍA ============
  /// Definición de estilos de texto reutilizables para consistencia
  
  /// Estilo eyebrow - pequeño texto destacado en verde
  static const TextStyle eyebrowText = TextStyle(
    color: primaryGreen,
    fontSize: 13,
    fontWeight: FontWeight.w800,
    letterSpacing: 1.0,
  );

  /// Estilo para encabezado principal - texto grande y negrita
  static const TextStyle headerText = TextStyle(
    color: darkGreen,
    fontSize: 34,
    fontWeight: FontWeight.w800,
    height: 1.15,
  );

  /// Estilo para descripción de encabezado - texto de apoyo
  static const TextStyle headerDescription = TextStyle(
    color: textGreen,
    fontSize: 16,
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

  /// Estilo para labels en resumen - texto de apoyo
  static const TextStyle summaryLabel = TextStyle(
    color: darkGreen,
    fontSize: 14,
    fontWeight: FontWeight.w700,
  );

  /// Estilo para título de tarjeta - texto destacado
  static const TextStyle cardTitle = TextStyle(
    color: darkGreen,
    fontSize: 18,
    fontWeight: FontWeight.w800,
  );

  /// Estilo para subtítulo de tarjeta - texto secundario
  static const TextStyle cardSubtitle = TextStyle(
    color: Color(0xFF597268),
    fontSize: 14,
  );

  /// Estilo para término de definición (dt) - etiqueta de información
  static const TextStyle dtText = TextStyle(
    color: Color(0xFF6B8177),
    fontSize: 12,
    fontWeight: FontWeight.w800,
  );

  /// Estilo para definición (dd) - valor de información
  static const TextStyle ddText = TextStyle(
    color: darkGreen,
    fontSize: 14,
    fontWeight: FontWeight.w700,
  );

  // ============ ESTILOS DE INPUTS Y FORMULARIOS ============
  /// Estilos específicos para elementos de entrada de datos
  
  /// Estilo para campo de búsqueda - texto de entrada
  static const TextStyle searchInputStyle = TextStyle(
    color: darkGreen,
    fontSize: 14,
    fontWeight: FontWeight.w700,
  );

  /// Estilo para texto hint/placeholder - texto sugerido
  static const TextStyle hintStyle = TextStyle(
    color: hintTextColor,
    fontSize: 13,
  );

  /// Estilo para opciones en dropdown - texto seleccionable
  static const TextStyle dropdownStyle = TextStyle(
    color: darkGreen,
    fontSize: 14,
    fontWeight: FontWeight.w700,
  );

  /// Estilo para fecha en date picker - texto de fecha
  static const TextStyle datePickerStyle = TextStyle(
    fontSize: 13,
    fontWeight: FontWeight.w700,
  );

  /// Estilo para separador de fecha (/) - barra divisora de fecha
  static const TextStyle dateSeparatorStyle = TextStyle(
    color: textGreen,
    fontWeight: FontWeight.bold,
  );

  /// Estilo para estado vacío - mensaje cuando no hay datos
  static const TextStyle emptyStateStyle = TextStyle(
    color: Color(0xFF597268),
    fontSize: 14,
    fontWeight: FontWeight.w700,
  );

  /// Estilo para chip de estado - etiqueta de estado
  static const TextStyle stateChipStyle = TextStyle(
    fontSize: 12,
    fontWeight: FontWeight.w800,
  );

  /// Estilo para etiqueta de botón - texto de botones
  static const TextStyle buttonLabelStyle = TextStyle(
    color: darkGreen,
    fontWeight: FontWeight.w800,
    fontSize: 13,
  );

  // ============ PADDINGS Y MÁRGENES COMUNES ============
  /// Definición de espacios reutilizables para consistencia
  
  /// Padding estándar para contenedores
  static const EdgeInsets containerPadding = EdgeInsets.all(18);
  
  /// Padding grande para contenedores principales
  static const EdgeInsets containerPaddingLarge = EdgeInsets.all(26);
  
  /// Padding para tarjetas de contenido
  static const EdgeInsets cardPadding = EdgeInsets.all(20);
  
  /// Padding para icono de búsqueda
  static const EdgeInsets searchIconPadding = EdgeInsets.symmetric(horizontal: 12);
  
  /// Padding vertical para contenido de inputs
  static const EdgeInsets inputContentPadding = EdgeInsets.symmetric(vertical: 12);
  
  /// Padding horizontal para inputs
  static const EdgeInsets inputHorizontalPadding = EdgeInsets.symmetric(horizontal: 12);
  
  /// Padding para date picker
  static const EdgeInsets datePickerPadding = EdgeInsets.symmetric(horizontal: 10);
  
  /// Padding para separador de fecha
  static const EdgeInsets dateSeparatorPadding = EdgeInsets.symmetric(horizontal: 6);
  
  /// Padding para chips de estado
  static const EdgeInsets stateChipPadding = EdgeInsets.symmetric(horizontal: 10, vertical: 4);
  
  /// Padding para botones
  static const EdgeInsets buttonPadding = EdgeInsets.symmetric(vertical: 12);

  // ============ DECORACIONES ============
  /// Definición de decoraciones complejas de widgets
  
  /// Decoración para contenedores - borde gris con fondo blanco
  static BoxDecoration containerDecoration = BoxDecoration(
    color: cardBackground,
    border: Border.all(color: borderGrey),
    borderRadius: BorderRadius.circular(8),
  );

  /// Decoración dinámica para inputs según estado de enfoque
  /// Cambia color de borde y fondo cuando está enfocado
  static BoxDecoration inputDecoration(bool isFocused) {
    return BoxDecoration(
      color: isFocused ? Colors.white : inputBackground, // Fondo blanco si está enfocado
      border: Border.all(color: isFocused ? primaryGreen : const Color(0xFFC8D8CE)), // Borde verde si está enfocado
      borderRadius: BorderRadius.circular(8), // Bordes redondeados
      boxShadow: isFocused
          ? [
              BoxShadow(
                color: primaryGreen.withValues(alpha: 0.13), // Sombra glow verde
                blurRadius: 0,
                spreadRadius: 4,
              )
            ]
          : null,
    );
  }

  /// Decoración para estado vacío - cuando no hay registros
  static BoxDecoration emptyStateDecoration = BoxDecoration(
    color: Colors.white,
    border: Border.all(color: borderColor, width: 1),
    borderRadius: BorderRadius.circular(8),
  );

  /// Decoración para contenedor de icono - fondo verde oscuro
  static BoxDecoration iconContainerDecoration = BoxDecoration(
    color: darkGreen,
    borderRadius: BorderRadius.circular(8),
  );

  /// Decoración dinámica para chip de estado - recibe color dinámicamente
  /// Usado para mostrar estados (sano, alerta, crítico)
  static BoxDecoration stateChipDecoration(Color bgColor) {
    return BoxDecoration(
      color: bgColor, // Color del estado
      borderRadius: BorderRadius.circular(8), // Bordes redondeados
    );
  }

  // ============ BORDER RADIUS ============
  /// Definición de radio de bordes redondeados estándar
  
  /// Border radius por defecto - 8 píxeles en todas las esquinas
  static const BorderRadius defaultBorderRadius = BorderRadius.all(Radius.circular(8));
}
