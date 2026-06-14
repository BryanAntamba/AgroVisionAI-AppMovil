// ════════════════════════════════════════════════════════════════════════════════
// ESTILOS PARA PANTALLA DE CÓDIGO DE VERIFICACIÓN
// ════════════════════════════════════════════════════════════════════════════════
// Define la paleta de colores, tipografía, decoraciones y animaciones para la
// pantalla donde el usuario ingresa el código de verificación de 6 dígitos.
// Incluye estilos especiales para input de código con espaciado de letras amplio
// y estados para botón de reenvío (habilitado/deshabilitado).
// ════════════════════════════════════════════════════════════════════════════════

import 'package:flutter/material.dart';

/// Clase que contiene todos los estilos estáticos para la pantalla de código de verificación
/// Incluye estilos específicos para campo de código (letterSpacing: 8) y feedback de reenvío
class CodigoVerificacionStyles {
  // ══════════════════════════════════════════════════════════════════════════════
  // PALETA DE COLORES
  // ══════════════════════════════════════════════════════════════════════════════
  
  /// Verde oscuro principal (RGB: 7, 61, 43) - Para títulos y botones
  static const Color darkGreen = Color(0xFF073D2B);
  
  /// Verde medio para enlaces (RGB: 11, 90, 61) - Para textos secundarios y enlaces
  static const Color linkGreen = Color(0xFF0B5A3D);
  
  /// Verde brillante primario (RGB: 85, 168, 32) - Para acentos y gradientes
  static const Color primaryGreen = Color(0xFF55A820);
  
  /// Color de fondo crema claro (RGB: 251, 253, 249) - Para inputs sin foco
  static const Color cardBackground = Color(0xFFFBFDF9);
  
  /// Gris verdoso para bordes (RGB: 200, 216, 206) - Para bordes de inputs
  static const Color borderGrey = Color(0xFFC8D8CE);
  
  /// Rojo para errores (RGB: 201, 43, 43) - Para mensajes de validación
  static const Color errorRed = Color(0xFFC92B2B);
  
  /// Gris para placeholders (RGB: 125, 145, 134) - Para textos de ayuda
  static const Color placeholderGrey = Color(0xFF7D9186);

  // ══════════════════════════════════════════════════════════════════════════════
  // TIPOGRAFÍA
  // ══════════════════════════════════════════════════════════════════════════════
  
  /// Estilo para el título principal "Código de verificación"
  static const TextStyle heading1 = TextStyle(
    color: darkGreen,
    fontSize: 31,
    fontWeight: FontWeight.bold,
    height: 1.15,
  );

  /// Estilo para la descripción/instrucciones
  static const TextStyle description = TextStyle(
    color: linkGreen,
    fontSize: 15,
    fontWeight: FontWeight.w700,
    height: 1.45,
  );

  /// Estilo para las etiquetas de campos
  static const TextStyle label = TextStyle(
    color: darkGreen,
    fontSize: 14,
    fontWeight: FontWeight.w700,
  );
  
  /// Estilo ESPECIAL para el input de código de 6 dígitos
  /// - Tamaño: 24px (grande para legibilidad)
  /// - Peso: 800 (extra bold)
  /// - Letter spacing: 8px (separa visualmente los dígitos como 1 2 3 4 5 6)
  static const TextStyle codeInput = TextStyle(
    color: darkGreen,
    fontSize: 24, // Grande para facilitar lectura
    fontWeight: FontWeight.w800, // Extra bold para números destacados
    letterSpacing: 8, // Espaciado amplio entre dígitos (efecto visual de separación)
  );

  /// Estilo para mensajes de error de validación
  static const TextStyle errorText = TextStyle(
    color: errorRed,
    fontSize: 13,
    fontWeight: FontWeight.w800,
  );

  /// Estilo para el texto de reenvío "¿No recibiste el código?"
  static const TextStyle resendText = TextStyle(
    color: linkGreen,
    fontSize: 14,
    fontWeight: FontWeight.w500, // Peso medio (no tan bold como el enlace)
  );

  /// Estilo para el enlace de reenvío "Reenviar" (estado habilitado)
  static const TextStyle resendLink = TextStyle(
    color: primaryGreen, // Verde brillante para enlace activo
    fontSize: 14,
    fontWeight: FontWeight.w700,
    decoration: TextDecoration.underline, // Subrayado para indicar interactividad
  );

  /// Estilo para el enlace de reenvío "Reenviar" (estado deshabilitado)
  /// Usado cuando se alcanza el límite de 5 reenvíos
  static const TextStyle resendLinkDisabled = TextStyle(
    color: Color(0xFFAAC0B3), // Gris verdoso claro (desaturado) para indicar inactividad
    fontSize: 14,
    fontWeight: FontWeight.w700,
    decoration: TextDecoration.underline,
  );

  /// Estilo para feedback de éxito tras reenvío "Código reenviado"
  static const TextStyle resendFeedback = TextStyle(
    color: linkGreen, // Verde medio para mensaje de éxito
    fontSize: 13,
    fontWeight: FontWeight.w800,
    height: 1.6, // Line height amplio para legibilidad
  );

  /// Estilo para feedback de error de reenvío "Has alcanzado el límite..."
  static const TextStyle resendFeedbackError = TextStyle(
    color: errorRed, // Rojo para mensaje de error
    fontSize: 13,
    fontWeight: FontWeight.w800,
    height: 1.6,
  );

  /// Estilo para el enlace "Cambiar correo electrónico"
  static const TextStyle changeEmailLink = TextStyle(
    color: linkGreen,
    fontSize: 16,
    fontWeight: FontWeight.w800,
  );

  // ══════════════════════════════════════════════════════════════════════════════
  // DECORACIONES DE COMPONENTES
  // ══════════════════════════════════════════════════════════════════════════════
  
  /// Decoración dinámica para el campo de código que cambia según el estado de foco
  /// Idéntica a cambiar-password pero aplicada al input de código de 6 dígitos
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

  /// Decoración del botón "Verificar código" con gradiente y sombra
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
  /// [0]=título, [1]=descripción, [2]=campo código, [3]=botón verificar, [4]=texto reenvío, [5]=enlace cambiar correo
  static const List<int> animationDelays = [90, 190, 290, 390, 490, 590];
}
