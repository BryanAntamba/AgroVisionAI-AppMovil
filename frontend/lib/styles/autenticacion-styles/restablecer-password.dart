// ════════════════════════════════════════════════════════════════════════════════
// ESTILOS PARA PANTALLA DE RESTABLECER CONTRASEÑA
// ════════════════════════════════════════════════════════════════════════════════
// Define la paleta de colores, tipografía, decoraciones y animaciones para la
// pantalla donde el usuario solicita restablecer su contraseña ingresando su email.
// Primera pantalla del flujo de recuperación (antes del código de verificación).
// ════════════════════════════════════════════════════════════════════════════════

import 'package:flutter/material.dart';

/// Clase que contiene todos los estilos estáticos para la pantalla de restablecer contraseña
/// Incluye validación específica para correos Gmail únicamente
class RestablecerPasswordStyles {
  // ══════════════════════════════════════════════════════════════════════════════
  // PALETA DE COLORES
  // ══════════════════════════════════════════════════════════════════════════════
  
  /// Verde brillante primario (RGB: 85, 168, 32) - Para acentos y gradientes
  static const Color primaryGreen = Color(0xFF55A820);
  
  /// Verde oscuro principal (RGB: 7, 61, 43) - Para títulos y botones
  static const Color darkGreen = Color(0xFF073D2B);
  
  /// Rojo para errores (RGB: 201, 43, 43) - Para mensajes de validación
  static const Color errorRed = Color(0xFFC92B2B);
  
  /// Gris verdoso para bordes (RGB: 200, 216, 206) - Para bordes de inputs
  static const Color borderGrey = Color(0xFFC8D8CE);
  
  /// Color de fondo crema claro (RGB: 251, 253, 249) - Para inputs sin foco
  static const Color cardBackground = Color(0xFFFBFDF9);
  
  /// Gris para placeholders (RGB: 125, 145, 134) - Para textos de ayuda
  static const Color placeholderGrey = Color(0xFF7D9186);

  // ══════════════════════════════════════════════════════════════════════════════
  // TIPOGRAFÍA
  // ══════════════════════════════════════════════════════════════════════════════
  
  /// Estilo para el título principal "Restablecer contraseña"
  static const TextStyle heading1 = TextStyle(
    color: darkGreen,
    fontSize: 31,
    fontWeight: FontWeight.bold, // Bold para máximo énfasis
    height: 1.15, // Line height compacto
  );

  /// Estilo para la descripción/instrucciones
  static const TextStyle description = TextStyle(
    color: Color(0xFF0B5A3D), // Verde medio (linkGreen)
    fontSize: 15,
    fontWeight: FontWeight.w700,
    height: 1.45,
  );

  /// Estilo para las etiquetas de campos de formulario
  static const TextStyle label = TextStyle(
    color: darkGreen,
    fontSize: 14,
    fontWeight: FontWeight.w700,
  );

  /// Estilo para mensajes de error de validación
  static const TextStyle errorText = TextStyle(
    color: errorRed,
    fontSize: 13,
    fontWeight: FontWeight.w800,
  );

  /// Estilo para el enlace "Volver al login" o similar
  static const TextStyle resetLink = TextStyle(
    color: Color(0xFF0B5A3D), // Verde medio (linkGreen)
    fontSize: 16,
    fontWeight: FontWeight.w800,
  );

  // ══════════════════════════════════════════════════════════════════════════════
  // DECORACIONES DE COMPONENTES
  // ══════════════════════════════════════════════════════════════════════════════
  
  /// Decoración dinámica para el campo de email que cambia según el estado de foco
  static BoxDecoration inputDecoration(bool isFocused) {
    return BoxDecoration(
      color: isFocused ? Colors.white : cardBackground,
      border: Border.all(
        color: isFocused ? primaryGreen : borderGrey,
      ),
      borderRadius: BorderRadius.circular(8),
      boxShadow: isFocused
          ? [
              BoxShadow(
                color: primaryGreen.withValues(alpha: 0.13),
                blurRadius: 0,
                spreadRadius: 4,
              )
            ]
          : null,
    );
  }

  /// Decoración del botón "Enviar código" con gradiente y sombra
  static BoxDecoration buttonDecoration = BoxDecoration(
    gradient: const LinearGradient(
      colors: [darkGreen, primaryGreen],
      begin: Alignment.topLeft,
      end: Alignment.bottomRight,
    ),
    borderRadius: BorderRadius.circular(8),
    boxShadow: const [
      BoxShadow(
        color: Color.fromRGBO(7, 61, 43, 0.24),
        blurRadius: 28,
        offset: Offset(0, 16),
      )
    ],
  );

  // ══════════════════════════════════════════════════════════════════════════════
  // CONFIGURACIÓN DE ANIMACIONES
  // ══════════════════════════════════════════════════════════════════════════════
  
  /// Duración de la animación fadeUp (720ms para entrada suave)
  static const Duration fadeUpDuration = Duration(milliseconds: 720);
  
  /// Duración de transiciones rápidas (200ms para respuesta inmediata)
  static const Duration transitionDuration = Duration(milliseconds: 200);
  
  /// Delays escalonados para animar 6 elementos secuencialmente
  /// [0]=título, [1]=descripción, [2]=campo email, [3]=botón enviar, [4]=separador, [5]=enlace volver
  static const List<int> animationDelays = [90, 190, 290, 390, 490, 590];
}
