import 'package:flutter/material.dart';

/// Clase que centraliza todos los estilos, colores, tipografía y decoraciones
/// utilizados en el modal de editar recomendación
class EditarRecomendacionStyles {
  
  // ============ COLORES BASE ============
  /// Definición de la paleta de colores para el modal de edición
  
  /// Color verde oscuro - usado en títulos y textos principales
  static const Color darkGreen = Color(0xFF073D2B);
  
  /// Color verde primario - usado en botones y elementos destacados
  static const Color primaryGreen = Color(0xFF55A820);
  
  /// Color de fondo del modal - blanco puro para contraste
  static const Color backgroundModal = Color(0xFFFFFFFF);
  
  /// Color del overlay/backdrop - oscuridad de fondo detrás del modal
  static const Color overlayColor = Color.fromRGBO(7, 61, 43, 0.45);
  
  /// Color gris para bordes generales - usado en bordes de elementos
  static const Color borderGrey = Color(0xFFD7E4DC);
  
  /// Color gris para bordes de inputs - usado en bordes de campos
  static const Color borderInput = Color(0xFFC8D8CE);
  
  /// Color de fondo para inputs - usado en campos de entrada
  static const Color backgroundInput = Color(0xFFFBFDF9);
  
  /// Color de fondo para botón cerrar - usado en el contenedor del botón X
  static const Color backgroundCloseBtn = Color(0xFFF5FAF3);
  
  /// Color para sombra de enfoque - usado cuando un input está enfocado
  static const Color focusShadow = Color.fromRGBO(85, 168, 32, 0.13);

  // ============ DECORACIONES ============
  /// Estilos específicos para elementos visuales
  
  /// Decoración del modal - borde, sombra y esquinas redondeadas
  static const BoxDecoration modalDecoration = BoxDecoration(
    color: backgroundModal, // Fondo blanco
    border: Border.fromBorderSide(BorderSide(color: borderGrey)), // Borde gris
    borderRadius: BorderRadius.all(Radius.circular(8)), // Esquinas redondeadas
    boxShadow: [
      BoxShadow(
        color: Color.fromRGBO(7, 61, 43, 0.2), // Sombra oscura
        blurRadius: 48,
        offset: Offset(0, 24),
      ),
    ],
  );

  /// Decoración del botón cerrar - fondo claro con esquinas redondeadas
  static const BoxDecoration closeBtnDecoration = BoxDecoration(
    color: backgroundCloseBtn,
    borderRadius: BorderRadius.all(Radius.circular(8)),
  );

  /// Decoración dinámica de inputs según estado de enfoque
  /// Cambia color de fondo y borde cuando está enfocado
  static BoxDecoration inputShellDecoration({bool focused = false}) {
    return BoxDecoration(
      color: focused ? backgroundModal : backgroundInput, // Fondo blanco si está enfocado
      border: Border.all(color: focused ? primaryGreen : borderInput), // Borde verde si está enfocado
      borderRadius: BorderRadius.circular(8), // Esquinas redondeadas
      boxShadow: focused
          ? [
              BoxShadow(
                color: focusShadow, // Sombra glow verde
                spreadRadius: 4,
                blurRadius: 0,
              )
            ]
          : null,
    );
  }

  /// Decoración del botón cancelar - fondo claro con borde gris
  static const BoxDecoration cancelBtnDecoration = BoxDecoration(
    color: backgroundInput, // Fondo muy claro
    border: Border.fromBorderSide(BorderSide(color: borderGrey)), // Borde gris
    borderRadius: BorderRadius.all(Radius.circular(8)), // Esquinas redondeadas
  );

  /// Decoración del botón guardar - gradiente verde con sombra
  static const BoxDecoration submitBtnDecoration = BoxDecoration(
    gradient: LinearGradient(
      colors: [darkGreen, primaryGreen], // Gradiente verde
      begin: Alignment.topLeft,
      end: Alignment.bottomRight,
    ),
    borderRadius: BorderRadius.all(Radius.circular(8)), // Esquinas redondeadas
    boxShadow: [
      BoxShadow(
        color: Color.fromRGBO(7, 61, 43, 0.24), // Sombra del botón
        blurRadius: 28,
        offset: Offset(0, 16),
      ),
    ],
  );

  // ============ TIPOGRAFÍA ============
  /// Definición de estilos de texto
  
  /// Estilo para título del modal - texto grande y negrita
  static const TextStyle titleStyle = TextStyle(
    color: darkGreen,
    fontSize: 28,
    fontWeight: FontWeight.w800,
    height: 1.15,
  );

  /// Estilo para labels de inputs - texto pequeño y negrita
  static const TextStyle labelStyle = TextStyle(
    color: darkGreen,
    fontSize: 13,
    fontWeight: FontWeight.w800,
  );

  /// Estilo para texto dentro de inputs - texto normal
  static const TextStyle inputTextStyle = TextStyle(
    color: darkGreen,
    fontSize: 14,
  );

  /// Estilo para texto del botón cancelar - verde oscuro negrita
  static const TextStyle cancelBtnStyle = TextStyle(
    color: darkGreen,
    fontSize: 16,
    fontWeight: FontWeight.w800,
  );

  /// Estilo para texto del botón guardar - blanco negrita
  static const TextStyle submitBtnStyle = TextStyle(
    color: backgroundModal, // Blanco
    fontSize: 16,
    fontWeight: FontWeight.w800,
  );
}
