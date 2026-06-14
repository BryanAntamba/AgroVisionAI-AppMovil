// ════════════════════════════════════════════════════════════════════════════════
// ESTILOS PARA PANTALLA DE CONFIRMACIÓN DE CONTRASEÑA
// ════════════════════════════════════════════════════════════════════════════════
// Define la paleta de colores, tipografía y animaciones para la pantalla de
// confirmación exitosa tras cambiar contraseña. Pantalla minimalista con solo
// título, descripción, ícono de éxito y enlace de retorno. 4 elementos animados.
// ════════════════════════════════════════════════════════════════════════════════

import 'package:flutter/material.dart';

/// Clase que contiene todos los estilos estáticos para la pantalla de confirmación
/// Incluye solo tipografía y animaciones (sin inputs ni botones)
class PasswordConfirmacionStyles {
  // ══════════════════════════════════════════════════════════════════════════════
  // PALETA DE COLORES (simplificada - solo 3 colores)
  // ══════════════════════════════════════════════════════════════════════════════
  
  /// Verde oscuro principal (RGB: 7, 61, 43) - Para títulos
  static const Color darkGreen = Color(0xFF073D2B);
  
  /// Verde medio para enlaces (RGB: 11, 90, 61) - Para textos y enlaces
  static const Color linkGreen = Color(0xFF0B5A3D);
  
  /// Verde brillante primario (RGB: 85, 168, 32) - Para íconos de éxito
  static const Color primaryGreen = Color(0xFF55A820);

  // ══════════════════════════════════════════════════════════════════════════════
  // TIPOGRAFÍA
  // ══════════════════════════════════════════════════════════════════════════════
  
  /// Estilo para el título principal "¡Contraseña cambiada con éxito!"
  static const TextStyle heading1 = TextStyle(
    color: darkGreen,
    fontSize: 31,
    fontWeight: FontWeight.w700, // Bold 700
    height: 1.15,
  );

  /// Estilo para la descripción de confirmación
  static const TextStyle description = TextStyle(
    color: linkGreen,
    fontSize: 15,
    fontWeight: FontWeight.w800, // Extra bold para énfasis en éxito
    height: 1.45,
  );

  /// Estilo para el enlace "Iniciar sesión" o "Volver al inicio"
  static const TextStyle confirmationLink = TextStyle(
    color: linkGreen,
    fontSize: 16,
    fontWeight: FontWeight.w800,
  );

  // ══════════════════════════════════════════════════════════════════════════════
  // CONFIGURACIÓN DE ANIMACIONES
  // ══════════════════════════════════════════════════════════════════════════════
  
  /// Duración de la animación fadeUp (720ms para entrada suave)
  static const Duration fadeUpDuration = Duration(milliseconds: 720);
  
  /// Duración de transiciones rápidas (200ms para respuesta inmediata)
  static const Duration transitionDuration = Duration(milliseconds: 200);
  
  /// Delays escalonados para animar solo 4 elementos secuencialmente
  /// [0]=ícono de éxito, [1]=título, [2]=descripción, [3]=enlace
  static const List<int> animationDelays = [90, 190, 290, 390];
}
