import 'package:flutter/material.dart';

/// Clase que centraliza todos los estilos, colores, tipografía y decoraciones
/// utilizados en el modal de visualizar recomendación
class VisualizarRecomendacionStyles {
  
  // ============ COLORES ============
  /// Definición de la paleta de colores para el modal de visualización
  
  /// Color verde oscuro - usado en títulos y textos principales
  static const Color darkGreen = Color(0xFF073D2B);
  
  /// Color verde primario - usado en botones y elementos destacados
  static const Color primaryGreen = Color(0xFF55A820);
  
  /// Color para bordes de tarjeta - usado en los bordes del modal
  static const Color cardBorder = Color(0xFFD7E4DC);
  
  /// Color de fondo para botón cerrar - usado en el contenedor del botón X
  static const Color closeBg = Color(0xFFF5FAF3);

  /// Color del backdrop/overlay - oscuridad de fondo detrás del modal
  static const Color backdropColor = Color.fromRGBO(7, 61, 43, 0.45);

  // ============ DECORACIONES ============
  /// Estilos específicos para elementos visuales
  
  /// Decoración de la tarjeta modal - borde, sombra y esquinas redondeadas
  static final BoxDecoration cardDecoration = BoxDecoration(
    color: Colors.white, // Fondo blanco
    border: Border.all(color: cardBorder), // Borde gris
    borderRadius: BorderRadius.circular(8), // Esquinas redondeadas
    boxShadow: const [
      BoxShadow(
        color: Color.fromRGBO(7, 61, 43, 0.2), // Sombra oscura
        blurRadius: 48,
        offset: Offset(0, 24),
      ),
    ],
  );

  // ============ TIPOGRAFÍA ============
  /// Definición de estilos de texto
  
  /// Estilo para título del modal - texto grande y negrita
  static const TextStyle titleStyle = TextStyle(
    color: darkGreen,
    fontSize: 28,
    height: 1.15,
    fontWeight: FontWeight.bold,
  );

  /// Decoración del botón cerrar - fondo claro con esquinas redondeadas
  static final BoxDecoration closeBtnDecoration = BoxDecoration(
    color: closeBg,
    borderRadius: BorderRadius.circular(8),
  );

  /// Estilo para texto de formulario - texto normal
  static const TextStyle formTextStyle = TextStyle(
    color: darkGreen,
    fontSize: 16,
  );

  /// Estilo para texto de formulario negrita - texto destacado
  static const TextStyle formTextBoldStyle = TextStyle(
    color: darkGreen,
    fontSize: 16,
    fontWeight: FontWeight.bold,
  );

  /// Decoración del botón enviar - gradiente verde y sombra
  static final BoxDecoration submitBtnDecoration = BoxDecoration(
    gradient: const LinearGradient(
      colors: [darkGreen, primaryGreen], // Gradiente verde
      begin: Alignment.topLeft,
      end: Alignment.bottomRight,
    ),
    borderRadius: BorderRadius.circular(8), // Esquinas redondeadas
    boxShadow: const [
      BoxShadow(
        color: Color.fromRGBO(7, 61, 43, 0.24), // Sombra del botón
        blurRadius: 28,
        offset: Offset(0, 16),
      ),
    ],
  );

  /// Estilo para texto del botón enviar - texto blanco negrita
  static const TextStyle submitBtnStyle = TextStyle(
    color: Colors.white,
    fontSize: 16,
    fontWeight: FontWeight.w800,
  );
}
