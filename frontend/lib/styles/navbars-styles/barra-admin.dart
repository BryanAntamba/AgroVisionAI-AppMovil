// ═══════════════════════════════════════════════════════════════════════════
// BARRA ADMIN - ESTILOS DEL NAVBAR PARA ADMINISTRADORES
// ═══════════════════════════════════════════════════════════════════════════
// Define todos los estilos visuales del navbar usado en el panel de administración
// Incluye colores, dimensiones, tipografía y decoraciones
// ═══════════════════════════════════════════════════════════════════════════

import 'package:flutter/material.dart'; // Importa el paquete de Flutter Material Design

/// Clase que contiene todos los estilos del navbar para administradores
/// Proporciona constantes estáticas para mantener consistencia visual
class BarraAdminStyles {
  // ═══════════════════════════════════════════════════════════════════════════
  // COLORES BASE
  // ═══════════════════════════════════════════════════════════════════════════
  
  static const Color darkGreen = Color(0xFF073D2B);    // Verde oscuro para elementos principales y brand
  static const Color primaryGreen = Color(0xFF55A820); // Verde brillante para elementos activos y botones
  static const Color linkNormal = Color(0xFF456657);   // Verde grisáceo para enlaces en estado normal
  static const Color borderColor = Color(0xFFD7E4DC);  // Verde muy claro para bordes y separadores

  // ═══════════════════════════════════════════════════════════════════════════
  // DIMENSIONES
  // ═══════════════════════════════════════════════════════════════════════════
  
  static const double navbarHeight = 72.0;              // Altura mínima del navbar en píxeles
  static const double navbarPaddingVertical = 6.0;      // Padding vertical inferior (reducido para bajar contenido)
  static const double contentPaddingTop = 35.0;         // Padding superior adicional para separar contenido
  static const double elevation = 0.0;                  // Sin elevación (se usa boxShadow personalizada en su lugar)

  // ═══════════════════════════════════════════════════════════════════════════
  // TIPOGRAFÍA
  // ═══════════════════════════════════════════════════════════════════════════
  
  /// Estilo para el texto del brand (nombre de la plataforma)
  static const TextStyle brandText = TextStyle(
    color: darkGreen,          // Color verde oscuro
    fontSize: 22,              // Tamaño grande para destacar
    fontWeight: FontWeight.w800, // Peso extra-bold para impacto visual
    letterSpacing: -0.2,       // Espaciado negativo para texto más compacto
  );

  /// Estilo para los enlaces de navegación
  static const TextStyle navLinkText = TextStyle(
    color: linkNormal,         // Color verde grisáceo normal
    fontSize: 15,              // Tamaño mediano legible
    fontWeight: FontWeight.w700, // Peso bold para claridad
  );

  // ═══════════════════════════════════════════════════════════════════════════
  // NAVBAR CONTAINER (fondo blanco + sombra)
  // ═══════════════════════════════════════════════════════════════════════════
  
  /// Decoración principal del container del navbar
  /// Incluye fondo blanco y borde inferior
  static const BoxDecoration navbarDecoration = BoxDecoration(
    color: Colors.white,       // Fondo blanco sólido
    border: Border(
      bottom: BorderSide(color: borderColor, width: 1), // Borde inferior de 1px verde claro
    ),
  );

  // ═══════════════════════════════════════════════════════════════════════════
  // GRADIENTE RADIAL OVERLAY (efecto decorativo top-right)
  // ═══════════════════════════════════════════════════════════════════════════
  
  /// Decoración con gradiente radial en la esquina superior derecha (deshabilitado)
  /// Sin efecto de resplandor
  static const BoxDecoration radialOverlay = BoxDecoration(
    gradient: null,
  );

  // ═══════════════════════════════════════════════════════════════════════════
  // BOTÓN CERRAR SESIÓN
  // ═══════════════════════════════════════════════════════════════════════════
  
  /// Decoración del botón de cerrar sesión
  /// Incluye gradiente verde y bordes redondeados
  static BoxDecoration logoutButtonDecoration = BoxDecoration(
    gradient: const LinearGradient(
      colors: [darkGreen, primaryGreen],  // Gradiente de verde oscuro a brillante
      begin: Alignment.topLeft,           // Inicio del gradiente en esquina superior izquierda
      end: Alignment.bottomRight,         // Fin del gradiente en esquina inferior derecha
    ),
    borderRadius: BorderRadius.circular(8), // Bordes redondeados de 8px de radio
  );
}
