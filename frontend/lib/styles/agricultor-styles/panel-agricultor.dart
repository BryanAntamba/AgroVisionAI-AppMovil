// ════════════════════════════════════════════════════════════════════════════════
// ESTILOS PARA PANEL DEL AGRICULTOR
// ════════════════════════════════════════════════════════════════════════════════
// Define la paleta de colores, tipografía y decoraciones para el dashboard principal
// del agricultor. Incluye 4 estados de salud (sano, advertencia, crítico, estadística)
// con sistema de colores completo, decoraciones de secciones y botones de conectividad.
// ════════════════════════════════════════════════════════════════════════════════

import 'package:flutter/material.dart';

/// Clase que contiene todos los estilos estáticos para el panel del agricultor
/// Incluye sistema de colores por estado de salud y decoraciones para secciones
class PanelAgricultorStyles {
  // ══════════════════════════════════════════════════════════════════════════════
  // COLORES PRINCIPALES
  // ══════════════════════════════════════════════════════════════════════════════
  
  /// Verde oscuro principal (RGB: 7, 61, 43) - Para títulos y encabezados
  static const Color darkGreen = Color(0xFF073D2B);
  
  /// Verde brillante primario (RGB: 85, 168, 32) - Para gradientes de botones
  static const Color primaryGreen = Color(0xFF55A820);
  
  /// Verde medio para textos (RGB: 89, 114, 104) - Para descripciones y etiquetas
  static const Color textGreen = Color(0xFF597268);
  
  /// Color de fondo claro (RGB: 245, 250, 243) - Para fondo del panel
  static const Color backgroundLight = Color(0xFFF5FAF3);
  
  /// Blanco puro para tarjetas (RGB: 255, 255, 255) - Para secciones y tarjetas
  static const Color cardBackground = Color(0xFFFFFFFF);
  
  /// Gris verdoso para bordes (RGB: 215, 228, 220) - Para líneas divisorias
  static const Color borderGrey = Color(0xFFD7E4DC);
  
  // ══════════════════════════════════════════════════════════════════════════════
  // COLORES DE ESTADO (4 categorías de salud)
  // ══════════════════════════════════════════════════════════════════════════════
  
  /// Fondo verde claro para estado SANO (RGB: 234, 247, 229)
  static const Color sanoBg = Color(0xFFEAF7E5);
  
  /// Texto verde oscuro para estado SANO (RGB: 35, 115, 15)
  static const Color sanoText = Color(0xFF23730F);
  
  /// Fondo amarillo claro para ADVERTENCIA (RGB: 253, 245, 231)
  static const Color warnBg = Color(0xFFFDF5E7);
  
  /// Texto naranja para ADVERTENCIA (RGB: 181, 108, 7)
  static const Color warnText = Color(0xFFB56C07);
  
  /// Fondo rojo claro para estado CRÍTICO (RGB: 253, 236, 234)
  static const Color critBg = Color(0xFFFDECEA);
  
  /// Texto rojo para estado CRÍTICO (RGB: 198, 40, 40)
  static const Color critText = Color(0xFFC62828);
  
  /// Fondo azul claro para ESTADÍSTICAS (RGB: 233, 242, 255)
  static const Color estBg = Color(0xFFE9F2FF);
  
  /// Texto azul para ESTADÍSTICAS (RGB: 23, 76, 124)
  static const Color estText = Color(0xFF174C7C);

  // ══════════════════════════════════════════════════════════════════════════════
  // TIPOGRAFÍA
  // ══════════════════════════════════════════════════════════════════════════════
  
  /// Estilo para el título principal del dashboard "Panel del Agricultor"
  /// - Color: verde oscuro
  /// - Tamaño: 17px
  /// - Peso: 800 (extra bold)
  /// - Line height: 1.2
  static const TextStyle dashTitle = TextStyle(
    color: darkGreen, // Verde oscuro para máximo contraste
    fontSize: 17, // Tamaño para título principal
    fontWeight: FontWeight.w800, // Extra bold para jerarquía
    height: 1.2, // Line height compacto
  );

  /// Estilo para títulos de sección/encabezados secundarios
  /// - Color: verde oscuro
  /// - Tamaño: 15px
  /// - Peso: 800 (extra bold)
  static const TextStyle secHeadTitle = TextStyle(
    color: darkGreen, // Verde oscuro para claridad
    fontSize: 15, // Tamaño estándar para subtítulos
    fontWeight: FontWeight.w800, // Extra bold para destacar
  );

  // ══════════════════════════════════════════════════════════════════════════════
  // DECORACIONES DE BOTONES
  // ══════════════════════════════════════════════════════════════════════════════
  
  /// Decoración del botón "Guardar reporte" con gradiente verde
  /// - Gradiente: verde oscuro → verde brillante (diagonal)
  /// - Border radius: 8px
  /// - Sombra: verde oscuro 15% opacidad, desplazada 8px hacia abajo (más suave que modales)
  static BoxDecoration btnGuardarDecoration = BoxDecoration(
    gradient: const LinearGradient(
      colors: [darkGreen, primaryGreen], // Gradiente de oscuro a brillante
      begin: Alignment.topLeft, // Inicia en esquina superior izquierda
      end: Alignment.bottomRight, // Termina en esquina inferior derecha
    ),
    borderRadius: BorderRadius.circular(8), // Esquinas redondeadas
    boxShadow: const [
      BoxShadow(
        color: Color.fromRGBO(7, 61, 43, 0.15), // Verde oscuro con 15% opacidad (sombra suave)
        blurRadius: 20, // Desenfoque moderado
        offset: Offset(0, 8), // Desplazamiento vertical de 8px (sombra menos elevada)
      )
    ],
  );

  // ══════════════════════════════════════════════════════════════════════════════
  // DECORACIONES DE SECCIONES Y CONTENEDORES
  // ══════════════════════════════════════════════════════════════════════════════
  
  /// Decoración genérica para secciones principales del panel
  /// - Fondo: blanco puro
  /// - Borde: borderGrey de 1px
  /// - Border radius: 8px
  /// - Sombra: verde oscuro 5% opacidad, desplazada 10px hacia abajo (sombra sutil)
  static BoxDecoration secDecoration = BoxDecoration(
    color: cardBackground, // Blanco puro para secciones
    border: Border.all(color: borderGrey), // Borde gris verdoso
    borderRadius: BorderRadius.circular(8), // Esquinas redondeadas
    boxShadow: const [
      BoxShadow(color: Color.fromRGBO(7, 61, 43, 0.05), blurRadius: 24, offset: Offset(0, 10)) // Sombra muy sutil
    ]
  );
  
  /// Decoración para placeholder de imagen (área de carga de imagen)
  /// - Fondo: crema muy claro (RGB: 251, 253, 249)
  /// - Borde: borderGrey sólido de 1px (simula borde punteado con línea continua)
  /// - Border radius: 8px
  /// Nota: Bordes punteados nativos requieren custom painters
  static BoxDecoration imgPlaceholderDecoration = BoxDecoration(
    color: const Color(0xFFFBFDF9), // Crema muy claro para contraste suave
    // Simula borde punteado con línea continua (bordes punteados nativos requieren custom painters)
    border: Border.all(color: borderGrey, style: BorderStyle.solid), // Borde sólido como fallback
    borderRadius: BorderRadius.circular(8), // Esquinas redondeadas
  );

  /// Decoración para contenedores secundarios (sub-cards)
  /// - Fondo: crema muy claro (RGB: 251, 253, 249)
  /// - Borde: borderGrey de 1px
  /// - Border radius: 8px
  static BoxDecoration scDecoration = BoxDecoration(
    color: const Color(0xFFFBFDF9), // Crema muy claro para diferenciación
    border: Border.all(color: borderGrey), // Borde gris verdoso
    borderRadius: BorderRadius.circular(8), // Esquinas redondeadas
  );

  // ══════════════════════════════════════════════════════════════════════════════
  // BOTONES DE CONECTIVIDAD (ACCIONES SOBRE DISPOSITIVO IoT)
  // ══════════════════════════════════════════════════════════════════════════════
  
  /// Decoración del botón "Apagar dispositivo" (acción destructiva)
  /// - Fondo: blanco puro
  /// - Borde: rojo claro (RGB: 224, 180, 180) de 1px
  /// - Border radius: 8px
  static BoxDecoration btnApagarDecoration = BoxDecoration(
    color: Colors.white, // Fondo blanco para contraste
    border: Border.all(color: const Color(0xFFE0B4B4)), // Borde rojo claro para indicar peligro
    borderRadius: BorderRadius.circular(8), // Esquinas redondeadas
  );

  /// Decoración del botón "Reconectar dispositivo" (acción de advertencia)
  /// - Fondo: blanco puro
  /// - Borde: naranja claro (RGB: 255, 224, 178) de 1px
  /// - Border radius: 8px
  static BoxDecoration btnReconectarDecoration = BoxDecoration(
    color: Colors.white, // Fondo blanco para contraste
    border: Border.all(color: const Color(0xFFFFE0B2)), // Borde naranja claro para indicar precaución
    borderRadius: BorderRadius.circular(8), // Esquinas redondeadas
  );
}
