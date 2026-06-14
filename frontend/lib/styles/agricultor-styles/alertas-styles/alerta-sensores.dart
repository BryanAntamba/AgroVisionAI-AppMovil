import 'package:flutter/material.dart';

/// Clase que centraliza todos los estilos, colores, tipografía y decoraciones
/// utilizados en el componente de alerta de sensor (banner de error rojo)
/// Este componente se utiliza para mostrar errores o problemas con sensores
class AlertaSensorStyles {
  
  // ============ COLORES ============
  /// Definición de la paleta de colores para alertas de error
  
  /// Color rojo alerta - usado para elementos principales de alerta
  static const Color alertRed = Color(0xFFC62828);
  
  /// Color rojo oscuro - usado en títulos y textos destacados
  static const Color darkRed = Color(0xFF791F1F);
  
  /// Color marrón para texto - usado en descripciones
  static const Color brownText = Color(0xFF633806);
  
  /// Color gris para texto - usado en información secundaria como fecha
  static const Color greyText = Color(0xFF8FA69C);
  
  /// Color rojo claro para bordes - usado en los bordes del banner
  static const Color borderRed = Color(0xFFF7C1C1);
  
  /// Color de fondo rojo muy claro - usado como fondo del banner
  static const Color backgroundRed = Color(0xFFFDECEA);
  
  /// Color blanco para icono - usado como fondo del contenedor de icono
  static const Color iconBackground = Color(0xFFFFFFFF);

  // ============ DECORACIONES DEL BANNER ============
  /// Estilos específicos para el banner de alerta
  
  /// Decoración del banner principal - fondo rojo claro con borde rojo
  static BoxDecoration bannerDecoration = BoxDecoration(
    color: backgroundRed, // Fondo rojo muy claro
    border: Border.all(color: alertRed, width: 2), // Borde rojo de 2px
    borderRadius: BorderRadius.circular(8), // Esquinas redondeadas
  );

  // ============ DECORACIONES DEL ICONO ============
  /// Estilos específicos para el contenedor del icono
  
  /// Decoración del icono - cuadrado blanco con esquinas redondeadas
  static BoxDecoration iconDecoration = BoxDecoration(
    color: iconBackground, // Fondo blanco
    borderRadius: BorderRadius.circular(8), // Esquinas redondeadas
  );

  // ============ TIPOGRAFÍA ============
  /// Definición de estilos de texto para diferentes elementos
  
  /// Estilo para título de alerta - texto rojo oscuro y negrita
  static const TextStyle tituloStyle = TextStyle(
    color: darkRed, // Rojo oscuro para contraste
    fontSize: 14, // Tamaño medio-grande
    fontWeight: FontWeight.w800, // Muy negrita para destacar
  );

  /// Estilo para descripción de alerta - texto marrón
  static const TextStyle descripcionStyle = TextStyle(
    color: brownText, // Marrón para texto de apoyo
    fontSize: 12, // Tamaño pequeño
    fontWeight: FontWeight.w400, // Peso normal
  );

  /// Estilo para fecha/hora de alerta - texto gris
  static const TextStyle fechaStyle = TextStyle(
    color: greyText, // Gris para información secundaria
    fontSize: 11, // Muy pequeño
    fontWeight: FontWeight.w700, // Negrita para legibilidad
  );

  // ============ DECORACIONES DEL BOTÓN CERRAR ============
  /// Estilos específicos para el botón de cierre del banner
  
  /// Decoración del botón cerrar en estado normal - fondo blanco
  static BoxDecoration closeBtnDecoration = BoxDecoration(
    color: Colors.white, // Fondo blanco
    borderRadius: BorderRadius.circular(8), // Esquinas redondeadas
  );
  
  /// Decoración del botón cerrar en estado hover/presionado - con tinta roja
  static BoxDecoration closeBtnHoverDecoration = BoxDecoration(
    color: const Color(0x1AC62828), // Rojo semitransparente como overlay
    borderRadius: BorderRadius.circular(8), // Esquinas redondeadas
  );
}
