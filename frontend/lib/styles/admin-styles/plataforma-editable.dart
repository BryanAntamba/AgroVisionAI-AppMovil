import 'package:flutter/material.dart';

/// Clase que centraliza todos los estilos, colores, tipografía y decoraciones
/// utilizados en la plataforma editable del administrador
class PlataformaEditableStyles {
  
  // ============ COLORES BASE ============
  /// Definición de la paleta de colores para elementos estáticos y referencias
  
  /// Color verde primario - usado en elementos destacados
  static const Color primaryGreen = Color(0xFF55A820);
  
  /// Color verde oscuro - usado en textos principales
  static const Color darkGreen = Color(0xFF073D2B);
  
  /// Color de fondo de página - usado como fondo general
  static const Color bgPage = Color(0xFFF5FAF3);
  
  /// Color de texto descriptivo - usado en subtextos
  static const Color textDesc = Color(0xFF597268);
  
  /// Color de texto de ayuda - usado en textos de apoyo
  static const Color textHelp = Color(0xFF456657);
  
  /// Color de fondo de ayuda - usado en cajas de información
  static const Color bgHelp = Color(0xFFF7FBF5);
  
  /// Color gris para bordes generales - usado en bordes
  static const Color borderGrey = Color(0xFFD7E4DC);
  
  /// Color gris para bordes de inputs - usado en bordes de campos
  static const Color borderInput = Color(0xFFC8D8CE);
  
  /// Color de fondo para inputs - usado en campos de entrada
  static const Color bgInput = Color(0xFFFBFDF9);
  
  /// Color de fondo para tarjetas - blanco puro
  static const Color bgCard = Colors.white;
  
  /// Color rojo para peligro - usado en elementos destructivos
  static const Color danger = Color(0xFFA32626);
  
  /// Color rojo más oscuro para hover - usado en estado hover
  static const Color dangerHover = Color(0xFF8B1F1F);
  
  /// Color de fondo para elementos peligro - rojo muy claro
  static const Color dangerBg = Color(0xFFFDECEA);

  // ============ TIPOGRAFÍA ============
  /// Definición de estilos de texto reutilizables
  
  /// Estilo eyebrow - pequeño texto destacado en verde
  static const TextStyle eyebrow = TextStyle(
    fontSize: 13,
    fontWeight: FontWeight.w800,
    color: primaryGreen,
    letterSpacing: 0.5,
  );

  /// Estilo para encabezado H1 - texto muy grande y negrita
  static const TextStyle h1 = TextStyle(
    fontSize: 34,
    fontWeight: FontWeight.bold,
    color: darkGreen,
    height: 1.15,
  );

  /// Estilo para descripción de página - texto de apoyo
  static const TextStyle pageDesc = TextStyle(
    fontSize: 15,
    color: textHelp,
  );

  /// Estilo para títulos de secciones - texto grande y negrita
  static const TextStyle sectionTitle = TextStyle(
    fontSize: 24,
    fontWeight: FontWeight.bold,
    color: darkGreen,
  );

  /// Estilo para descripción de secciones - texto de apoyo
  static const TextStyle sectionDesc = TextStyle(
    fontSize: 14,
    color: textDesc,
    height: 1.5,
  );

  /// Estilo para labels de configuración - texto pequeño y negrita
  static const TextStyle configLabel = TextStyle(
    fontSize: 14,
    fontWeight: FontWeight.w800,
    color: darkGreen,
  );

  /// Estilo para texto de ayuda - texto gris claro
  static const TextStyle helpText = TextStyle(
    fontSize: 13,
    color: textHelp,
    height: 1.5,
  );

  /// Estilo para texto de ayuda pequeño - muy pequeño
  static const TextStyle helpTextSmall = TextStyle(
    fontSize: 12,
    color: Color(0xFF6B8177),
  );

  // ============ DECORACIONES ============
  /// Estilos específicos para elementos visuales
  
  /// Decoración para secciones - borde gris con sombra suave
  static final BoxDecoration sectionDecoration = BoxDecoration(
    color: bgCard, // Fondo blanco
    borderRadius: BorderRadius.circular(12), // Esquinas redondeadas más grandes
    border: Border.all(color: borderGrey), // Borde gris
    boxShadow: const [
      BoxShadow(
        color: Color.fromRGBO(7, 61, 43, 0.04), // Sombra muy suave
        blurRadius: 8,
        offset: Offset(0, 2),
      ),
    ],
  );

  /// Decoración para área de carga de archivos - borde discontinuo
  static final BoxDecoration fileUploadArea = BoxDecoration(
    color: bgInput, // Fondo muy claro
    borderRadius: BorderRadius.circular(8), // Esquinas redondeadas
    border: Border.all(color: borderInput, width: 2), // Borde más grueso (simula discontinuo)
  );

  /// Decoración para caja de ayuda - borde izquierdo verde
  static final BoxDecoration helpBox = BoxDecoration(
    color: bgHelp, // Fondo verde muy claro
    borderRadius: BorderRadius.circular(4), // Esquinas ligeramente redondeadas
    border: const Border(left: BorderSide(color: primaryGreen, width: 3)), // Borde izquierdo verde
  );

  // ============ DECORACIONES DE BOTONES ============
  /// Estilos específicos para diferentes tipos de botones
  
  /// Decoración para botón primario - gradiente verde con sombra
  static final BoxDecoration primaryBtn = BoxDecoration(
    gradient: const LinearGradient(
      colors: [darkGreen, primaryGreen], // Gradiente verde
      begin: Alignment.topLeft,
      end: Alignment.bottomRight,
    ),
    borderRadius: BorderRadius.circular(8), // Esquinas redondeadas
    boxShadow: const [
      BoxShadow(
        color: Color.fromRGBO(7, 61, 43, 0.2), // Sombra oscura
        blurRadius: 12,
        offset: Offset(0, 4),
      ),
    ],
  );

  /// Decoración para botón secundario - fondo verde oscuro
  static final BoxDecoration secondaryBtn = BoxDecoration(
    color: darkGreen,
    borderRadius: BorderRadius.circular(8),
  );

  /// Decoración para botón terciario - fondo gris claro con borde
  static final BoxDecoration tertiaryBtn = BoxDecoration(
    color: const Color(0xFFEDF1EE), // Gris muy claro
    borderRadius: BorderRadius.circular(8),
    border: Border.all(color: borderInput),
  );

  /// Decoración para botón cancelar - fondo rojo muy claro con borde rojo
  static final BoxDecoration cancelBtn = BoxDecoration(
    color: const Color(0xFFF5EEEE), // Rojo muy muy claro
    borderRadius: BorderRadius.circular(8),
    border: Border.all(color: const Color(0xFFF0C8C8)), // Borde rojo claro
  );

  // ============ DECORACIONES DE INPUTS ============
  /// Estilos específicos para campos de entrada
  
  /// Decoración para inputs - borde gris con fondo claro
  static BoxDecoration inputDecoration() {
    return BoxDecoration(
      color: bgInput, // Fondo claro
      borderRadius: BorderRadius.circular(8), // Esquinas redondeadas
      border: Border.all(color: borderInput), // Borde gris
    );
  }
}
