import 'package:flutter/material.dart';

/// Clase que centraliza todos los estilos, colores, tipografía y decoraciones
/// utilizados en el modal de eliminar recomendación (confirmación destructiva)
class EliminarRecomendacionStyles {
  
  // ============ COLORES ============
  /// Definición de la paleta de colores para el modal de eliminación
  
  /// Color verde oscuro - usado en títulos y elementos normales
  static const Color darkGreen = Color(0xFF073D2B);
  
  /// Color para texto descriptivo - usado en mensajes informativos
  static const Color descriptiveText = Color(0xFF456657);
  
  /// Color rojo/peligro para texto - usado en advertencias
  static const Color dangerText = Color(0xFFA32626);
  
  /// Color rojo más oscuro para hover - usado en estado de hover del botón peligro
  static const Color dangerHover = Color(0xFF8B1F1F);
  
  /// Color de fondo de página - usado como fondo general
  static const Color backgroundPage = Color(0xFFF5FAF3);
  
  /// Color gris para bordes - usado en bordes de elementos
  static const Color borderGrey = Color(0xFFD7E4DC);
  
  /// Color verde primario - usado en elementos no críticos
  static const Color primaryGreen = Color(0xFF55A820);
  
  /// Color del backdrop/overlay - oscuridad de fondo detrás del modal
  static const Color backdropColor = Color.fromRGBO(7, 61, 43, 0.45);

  // ============ DECORACIONES ============
  /// Estilos específicos para elementos visuales
  
  /// Decoración de la tarjeta modal - borde, sombra y esquinas redondeadas
  static final BoxDecoration cardDecoration = BoxDecoration(
    color: Colors.white, // Fondo blanco
    border: Border.all(color: borderGrey), // Borde gris
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
    fontWeight: FontWeight.w800,
    height: 1.15,
  );

  /// Estilo para mensaje de confirmación - texto descriptivo
  static const TextStyle confirmMessage = TextStyle(
    color: descriptiveText,
    fontSize: 15,
    height: 1.5,
  );

  /// Estilo para mensaje de confirmación negrita - énfasis
  static const TextStyle confirmMessageBold = TextStyle(
    color: darkGreen,
    fontSize: 15,
    fontWeight: FontWeight.bold,
    height: 1.5,
  );

  /// Estilo para advertencia - texto en rojo
  static const TextStyle confirmWarning = TextStyle(
    color: dangerText,
    fontSize: 13,
    fontWeight: FontWeight.w700,
  );

  /// Decoración del botón cancelar - fondo claro con borde gris
  static final BoxDecoration cancelBtnDecoration = BoxDecoration(
    color: const Color(0xFFFBFDF9), // Fondo muy claro
    border: Border.all(color: borderGrey), // Borde gris
    borderRadius: BorderRadius.circular(8), // Esquinas redondeadas
  );

  /// Estilo para texto del botón cancelar - verde oscuro negrita
  static const TextStyle cancelBtnStyle = TextStyle(
    color: darkGreen,
    fontSize: 16,
    fontWeight: FontWeight.w800,
  );

  /// Decoración del botón eliminar - fondo rojo sin sombra
  static final BoxDecoration deleteBtnDecoration = BoxDecoration(
    color: dangerText, // Fondo rojo peligro
    borderRadius: BorderRadius.circular(8), // Esquinas redondeadas
  );

  /// Estilo para texto del botón eliminar - texto blanco negrita
  static const TextStyle deleteBtnStyle = TextStyle(
    color: Colors.white,
    fontSize: 16,
    fontWeight: FontWeight.w800,
  );
}
