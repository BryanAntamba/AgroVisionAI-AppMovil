import 'package:flutter/material.dart';

/// Clase que centraliza todos los estilos, colores, tipografía y decoraciones
/// utilizados en el modal de registrar/crear recomendación
class RegistrarRecomendacionStyles {
  
  // ============ COLORES ============
  /// Definición de la paleta de colores para el modal de registro
  
  /// Color verde oscuro - usado en textos principales y títulos
  static const Color darkGreen       = Color(0xFF073D2B);
  
  /// Color verde primario - usado en botones y elementos destacados
  static const Color primaryGreen    = Color(0xFF55A820);
  
  /// Color de fondo de página - usado como fondo general
  static const Color backgroundPage  = Color(0xFFF5FAF3);
  
  /// Color de fondo para inputs - usado en campos de entrada
  static const Color backgroundInput = Color(0xFFFBFDF9);
  
  /// Color gris para bordes generales - usado en bordes de elementos
  static const Color borderGrey      = Color(0xFFD7E4DC);
  
  /// Color gris para bordes de inputs - usado en bordes de campos
  static const Color borderInput     = Color(0xFFC8D8CE);

  // ============ TIPOGRAFÍA ============
  /// Definición de estilos de texto
  
  /// Estilo para encabezado H1 - texto grande y negrita
  static const TextStyle h1Text = TextStyle(
    color: darkGreen,
    fontSize: 34,
    fontWeight: FontWeight.w800,
    height: 1.15,
  );

  /// Estilo para labels de inputs - texto pequeño y negrita
  static const TextStyle labelText = TextStyle(
    color: darkGreen,
    fontSize: 13,
    fontWeight: FontWeight.w800,
  );

  // ============ DECORACIONES ============
  /// Estilos específicos para elementos visuales
  
  /// Decoración de inputs - borde gris y fondo claro
  /// Decoración de inputs - borde gris y fondo claro
  static BoxDecoration inputDecoration({bool focused = false}) => BoxDecoration(
    color: focused ? Colors.white : backgroundInput, // Fondo blanco si está enfocado
    border: Border.all(color: focused ? primaryGreen : borderInput), // Borde verde si está enfocado
    borderRadius: BorderRadius.circular(8), // Esquinas redondeadas
    boxShadow: focused
        ? const [BoxShadow(color: Color.fromRGBO(85, 168, 32, 0.13), blurRadius: 0, spreadRadius: 4)] // Sombra glow verde
        : null,
  );

  /// Decoración del botón crear - gradiente verde y sombra
  static BoxDecoration get createBtnDecoration => BoxDecoration(
    gradient: const LinearGradient(
      colors: [darkGreen, primaryGreen], // Gradiente verde
      begin: Alignment.topLeft,
      end: Alignment.bottomRight,
    ),
    borderRadius: BorderRadius.circular(8), // Esquinas redondeadas
  );
}
