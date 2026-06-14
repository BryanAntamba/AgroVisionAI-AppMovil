// ════════════════════════════════════════════════════════════════════════════════
// ESTILOS PARA PANTALLA DE CAMBIAR CONTRASEÑA
// ════════════════════════════════════════════════════════════════════════════════
// Define la paleta de colores, tipografía, decoraciones y animaciones para la
// pantalla donde el usuario cambia su contraseña. Incluye 6 elementos animados
// con delays escalonados para crear efecto visual de entrada gradual.
// ════════════════════════════════════════════════════════════════════════════════

import 'package:flutter/material.dart';

/// Clase que contiene todos los estilos estáticos para la pantalla de cambiar contraseña
/// Incluye colores temáticos verdes, estilos de texto y decoraciones con sombras
class CambiarPasswordStyles {
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
  
  /// Estilo para el título principal "Cambiar contraseña"
  /// - Color: verde oscuro
  /// - Tamaño: 31px
  /// - Peso: bold
  /// - Line height: 1.15 (compacto para títulos)
  static const TextStyle heading1 = TextStyle(
    color: darkGreen, // Verde oscuro para máximo contraste
    fontSize: 31, // Tamaño grande para jerarquía principal
    fontWeight: FontWeight.bold, // Bold para destacar
    height: 1.15, // Line height compacto
  );

  /// Estilo para la descripción/instrucciones debajo del título
  /// - Color: verde medio
  /// - Tamaño: 15px
  /// - Peso: 700 (bold)
  /// - Line height: 1.45 (espaciado cómodo para lectura)
  static const TextStyle description = TextStyle(
    color: linkGreen, // Verde medio más suave que el título
    fontSize: 15, // Tamaño legible para párrafos
    fontWeight: FontWeight.w700, // Bold para énfasis
    height: 1.45, // Line height espacioso para legibilidad
  );

  /// Estilo para las etiquetas de los campos de formulario
  /// - Color: verde oscuro
  /// - Tamaño: 14px
  /// - Peso: 700 (bold)
  static const TextStyle label = TextStyle(
    color: darkGreen, // Verde oscuro para claridad
    fontSize: 14, // Tamaño estándar para labels
    fontWeight: FontWeight.w700, // Bold para destacar
  );

  /// Estilo para mensajes de error de validación
  /// - Color: rojo de error
  /// - Tamaño: 13px
  /// - Peso: 800 (extra bold)
  static const TextStyle errorText = TextStyle(
    color: errorRed, // Rojo llamativo para errores
    fontSize: 13, // Tamaño pequeño pero legible
    fontWeight: FontWeight.w800, // Extra bold para urgencia
  );

  /// Estilo para el enlace "Volver al inicio" o similar
  /// - Color: verde medio
  /// - Tamaño: 16px
  /// - Peso: 800 (extra bold)
  static const TextStyle changeLink = TextStyle(
    color: linkGreen, // Verde medio para enlaces
    fontSize: 16, // Tamaño cómodo para interacción
    fontWeight: FontWeight.w800, // Extra bold para destacar acción
  );

  // ══════════════════════════════════════════════════════════════════════════════
  // DECORACIONES DE COMPONENTES
  // ══════════════════════════════════════════════════════════════════════════════
  
  /// Decoración dinámica para campos de entrada (inputs) que cambia según el estado de foco
  /// @param isFocused - true si el campo tiene foco, false si no
  /// @return BoxDecoration con estilos aplicados según estado
  /// 
  /// ESTADO SIN FOCO:
  /// - Fondo: cardBackground (crema claro)
  /// - Borde: borderGrey de 1px
  /// - Sin sombra
  /// 
  /// ESTADO CON FOCO:
  /// - Fondo: blanco puro
  /// - Borde: primaryGreen de 1px
  /// - Sombra: verde con 13% opacidad, spreadRadius de 4px (efecto glow)
  static BoxDecoration inputDecoration(bool isFocused) {
    return BoxDecoration(
      color: isFocused ? Colors.white : cardBackground, // Blanco al enfocar, crema sin foco
      border: Border.all(
        color: isFocused ? primaryGreen : borderGrey, // Verde al enfocar, gris sin foco
      ),
      borderRadius: BorderRadius.circular(8), // Esquinas redondeadas de 8px
      boxShadow: isFocused
          ? [
              BoxShadow(
                color: primaryGreen.withValues(alpha: 0.13), // Verde 13% opacidad
                blurRadius: 0, // Sin desenfoque (sombra sólida)
                spreadRadius: 4, // Expansión de 4px (efecto glow)
              )
            ]
          : null, // Sin sombra cuando no tiene foco
    );
  }

  /// Decoración del botón de "Cambiar contraseña" con gradiente y sombra elevada
  /// - Gradiente: verde oscuro → verde brillante (diagonal)
  /// - Border radius: 8px
  /// - Sombra: verde oscuro 24% opacidad, desplazada 16px hacia abajo
  static BoxDecoration buttonDecoration = BoxDecoration(
    gradient: const LinearGradient(
      colors: [darkGreen, primaryGreen], // Gradiente de oscuro a brillante
      begin: Alignment.topLeft, // Inicia en esquina superior izquierda
      end: Alignment.bottomRight, // Termina en esquina inferior derecha
    ),
    borderRadius: BorderRadius.circular(8), // Esquinas redondeadas de 8px
    boxShadow: const [
      BoxShadow(
        color: Color.fromRGBO(7, 61, 43, 0.24), // Verde oscuro con 24% opacidad
        blurRadius: 28, // Desenfoque pronunciado de 28px
        offset: Offset(0, 16), // Desplazamiento vertical de 16px (sombra hacia abajo)
      )
    ],
  );

  // ══════════════════════════════════════════════════════════════════════════════
  // CONFIGURACIÓN DE ANIMACIONES
  // ══════════════════════════════════════════════════════════════════════════════
  
  /// Duración de la animación fadeUp (desvanecimiento + deslizamiento hacia arriba)
  /// 720ms proporciona una entrada suave y elegante sin ser lenta
  static const Duration fadeUpDuration = Duration(milliseconds: 720);
  
  /// Duración de transiciones rápidas (cambios de estado, hover, etc.)
  /// 200ms proporciona respuesta inmediata sin ser abrupta
  static const Duration transitionDuration = Duration(milliseconds: 200);
  
  /// Delays escalonados para animar 6 elementos secuencialmente
  /// Cada elemento aparece 100ms después del anterior
  /// Índices: [0]=título, [1]=descripción, [2]=campo1, [3]=campo2, [4]=botón, [5]=enlace
  static const List<int> animationDelays = [90, 190, 290, 390, 490, 590];
}
