// ════════════════════════════════════════════════════════════════════════════════
// ESTILOS DE LA BARRA DE NAVEGACIÓN DEL AGRICULTOR
// ════════════════════════════════════════════════════════════════════════════════
// Archivo que define todos los estilos visuales para la barra de navegación
// superior del panel del agricultor. Incluye colores, dimensiones, tipografía
// y decoraciones con sombras y gradientes para una interfaz profesional.
// ════════════════════════════════════════════════════════════════════════════════

import 'package:flutter/material.dart';

/// Clase que contiene todos los estilos estáticos para la barra de navegación del agricultor
/// Incluye paleta de colores, dimensiones, tipografía y decoraciones
class BarraAgricultorStyles {
  // ══════════════════════════════════════════════════════════════════════════════
  // COLORES BASE DEL NAVBAR
  // ══════════════════════════════════════════════════════════════════════════════
  
  /// Color verde oscuro principal (RGB: 7, 61, 43) - Usado para marca y gradientes
  static const Color darkGreen = Color(0xFF073D2B);
  
  /// Color verde primario brillante (RGB: 85, 168, 32) - Usado para acentos y gradientes
  static const Color primaryGreen = Color(0xFF55A820);
  
  /// Color verde suave para enlaces (RGB: 69, 102, 87) - Usado para texto de navegación
  static const Color linkNormal = Color(0xFF456657);
  
  /// Color gris-verde claro para bordes (RGB: 215, 228, 220) - Usado para línea divisoria inferior
  static const Color borderColor = Color(0xFFD7E4DC);

  // ══════════════════════════════════════════════════════════════════════════════
  // DIMENSIONES DEL NAVBAR
  // ══════════════════════════════════════════════════════════════════════════════
  
  /// Altura mínima del navbar en píxeles - Define la altura total de la barra
  static const double navbarHeight = 72.0;
  
  /// Padding vertical inferior del navbar - Espacio reducido para ajustar posición del contenido
  static const double navbarPaddingVertical = 6.0;
  
  /// Padding superior adicional para bajar el contenido dentro del navbar
  static const double contentPaddingTop = 35.0;
  
  /// Elevación para sombra (0 porque usamos boxShadow personalizada en lugar de elevation)
  static const double elevation = 0.0;

  // ══════════════════════════════════════════════════════════════════════════════
  // TIPOGRAFÍA
  // ══════════════════════════════════════════════════════════════════════════════
  
  /// Estilo para el texto de la marca/logo de la aplicación
  /// - Color: verde oscuro
  /// - Tamaño: 22px
  /// - Peso: extra bold (800)
  /// - Letter spacing: -0.2 (compresión ligera para look moderno)
  static const TextStyle brandText = TextStyle(
    color: darkGreen, // Verde oscuro para contraste fuerte
    fontSize: 22, // Tamaño prominente para identificación de marca
    fontWeight: FontWeight.w800, // Extra bold para destacar
    letterSpacing: -0.2, // Compresión ligera de espaciado
  );

  /// Estilo para los enlaces de navegación del navbar
  /// - Color: verde suave
  /// - Tamaño: 15px
  /// - Peso: bold (700)
  static const TextStyle navLinkText = TextStyle(
    color: linkNormal, // Verde suave para enlaces
    fontSize: 15, // Tamaño legible pero no dominante
    fontWeight: FontWeight.w700, // Bold para claridad
  );

  // ══════════════════════════════════════════════════════════════════════════════
  // DECORACIÓN DEL CONTENEDOR PRINCIPAL
  // ══════════════════════════════════════════════════════════════════════════════
  
  /// Decoración del contenedor del navbar: fondo blanco + borde inferior + sombra
  /// - Fondo: blanco puro
  /// - Borde: línea inferior de 1px en color borderColor
  /// - Sombra: desenfoque de 24px con transparencia 12% en verde oscuro
  static const BoxDecoration navbarDecoration = BoxDecoration(
    color: Colors.white, // Fondo blanco limpio
    border: Border(
      bottom: BorderSide(color: borderColor, width: 1), // Línea divisoria inferior de 1px
    ),
    boxShadow: [
      BoxShadow(
        color: Color.fromRGBO(7, 61, 43, 0.12), // Verde oscuro con 12% de opacidad
        blurRadius: 24, // Desenfoque suave de 24px
        offset: Offset(0, 10), // Desplazamiento vertical de 10px (sombra hacia abajo)
      )
    ],
  );

  // ══════════════════════════════════════════════════════════════════════════════
  // OVERLAY DECORATIVO CON GRADIENTE RADIAL
  // ══════════════════════════════════════════════════════════════════════════════
  
  /// Overlay decorativo con gradiente radial en la esquina superior derecha
  /// Crea un efecto visual sutil con verde primario al 20% de opacidad
  /// - Centro: esquina superior derecha (1.0, -1.0)
  /// - Radio: 1.2 (cubre aproximadamente 1/4 del navbar)
  /// - Colores: verde primario 20% → transparente
  /// - Stops: 0% verde, 34% transparente (transición gradual)
  static const BoxDecoration radialOverlay = BoxDecoration(
    gradient: RadialGradient(
      center: Alignment(1.0, -1.0), // Posición: esquina superior derecha
      radius: 1.2, // Radio del gradiente (1.2 unidades desde el centro)
      colors: [
        Color.fromRGBO(85, 168, 32, 0.20), // Verde primario con 20% de opacidad
        Colors.transparent, // Transparente en el borde exterior
      ],
      stops: [0.0, 0.34], // 0% = verde, 34% = transparente (transición suave)
    ),
  );

  // ══════════════════════════════════════════════════════════════════════════════
  // DECORACIÓN DEL BOTÓN CERRAR SESIÓN
  // ══════════════════════════════════════════════════════════════════════════════
  
  /// Decoración del botón de cerrar sesión con gradiente
  /// - Gradiente: verde oscuro → verde primario (diagonal superior izquierda a inferior derecha)
  /// - Border radius: 8px (esquinas redondeadas)
  static BoxDecoration logoutButtonDecoration = BoxDecoration(
    gradient: const LinearGradient(
      colors: [darkGreen, primaryGreen], // Gradiente de verde oscuro a verde brillante
      begin: Alignment.topLeft, // Inicia en la esquina superior izquierda
      end: Alignment.bottomRight, // Termina en la esquina inferior derecha
    ),
    borderRadius: BorderRadius.circular(8), // Esquinas redondeadas de 8px
  );
}
