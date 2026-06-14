// ════════════════════════════════════════════════════════════════════════════════
// ESTILOS PARA BOTÓN IoT (CONEXIÓN DE DISPOSITIVO)
// ════════════════════════════════════════════════════════════════════════════════
// Define la paleta de colores y tipografía para el botón de conexión IoT del
// panel del agricultor. Incluye estados de conexión (conectado, desconectado, error)
// con colores específicos: verde (éxito), rojo (error), naranja (advertencia).
// ════════════════════════════════════════════════════════════════════════════════

import 'package:flutter/material.dart';

/// Clase que contiene todos los estilos estáticos para el botón IoT
/// Incluye colores para 3 estados y tipografía para título, descripción e indicador
class BotonIotStyles {
  // ══════════════════════════════════════════════════════════════════════════════
  // PALETA DE COLORES
  // ══════════════════════════════════════════════════════════════════════════════
  
  /// Verde oscuro principal (RGB: 7, 61, 43) - Para títulos y estado conectado
  static const Color darkGreen = Color(0xFF073D2B);
  
  /// Verde brillante primario (RGB: 85, 168, 32) - Para acentos de éxito
  static const Color primaryGreen = Color(0xFF55A820);
  
  /// Verde medio para textos (RGB: 69, 102, 87) - Para descripciones normales
  static const Color textGreen = Color(0xFF456657);
  
  /// Rojo para errores oscuro (RGB: 198, 40, 40) - Para estado de error
  static const Color errorRed = Color(0xFFC62828);
  
  /// Rojo para textos de error (RGB: 201, 43, 43) - Para mensajes de error
  static const Color errorTextRed = Color(0xFFC92B2B);
  
  /// Naranja para advertencias (RGB: 255, 152, 0) - Para estado de advertencia/reconexión
  static const Color orange = Color(0xFFFF9800);
  
  /// Naranja oscuro (RGB: 245, 124, 0) - Para acentos de advertencia
  static const Color orangeDark = Color(0xFFF57C00);

  // ══════════════════════════════════════════════════════════════════════════════
  // TIPOGRAFÍA
  // ══════════════════════════════════════════════════════════════════════════════
  
  /// Estilo para el título del botón IoT (texto grande central)
  /// - Color: verde oscuro
  /// - Tamaño: 48px (muy grande para visualización a distancia)
  /// - Peso: 800 (extra bold)
  /// - Line height: 1.0 (compacto)
  /// - Letter spacing: -0.5 (compresión ligera)
  static const TextStyle titleText = TextStyle(
    color: darkGreen, // Verde oscuro para máximo contraste
    fontSize: 48, // Tamaño extra grande para destacar
    fontWeight: FontWeight.w800, // Extra bold para énfasis
    height: 1.0, // Line height compacto (sin espacio extra)
    letterSpacing: -0.5, // Compresión ligera para look moderno
  );

  /// Estilo para la descripción del estado (texto debajo del título)
  /// - Color: verde medio
  /// - Tamaño: 16px
  /// - Peso: 700 (bold)
  /// - Line height: 1.5 (espaciado cómodo)
  static const TextStyle descriptionText = TextStyle(
    fontSize: 16, // Tamaño legible para texto secundario
    color: textGreen, // Verde medio más suave
    fontWeight: FontWeight.w700, // Bold para claridad
    height: 1.5, // Line height espacioso para legibilidad
  );

  /// Estilo para descripción de ERROR (rojo llamativo)
  /// - Color: rojo de error
  /// - Tamaño: 16px
  /// - Peso: 800 (extra bold para urgencia)
  /// - Line height: 1.5
  static const TextStyle descriptionErrorText = TextStyle(
    fontSize: 16, // Mismo tamaño que descripción normal
    color: errorTextRed, // Rojo llamativo para errores
    fontWeight: FontWeight.w800, // Extra bold para urgencia
    height: 1.5, // Line height consistente
  );
  
  /// Estilo para el indicador de estado (pequeño texto inferior)
  /// - Color: verde oscuro
  /// - Tamaño: 13px
  /// - Peso: 800 (extra bold)
  static const TextStyle indicatorText = TextStyle(
    color: darkGreen, // Verde oscuro para claridad
    fontWeight: FontWeight.w800, // Extra bold para destacar
    fontSize: 13, // Tamaño pequeño para texto auxiliar
  );
}
