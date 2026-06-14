// ════════════════════════════════════════════════════════════════════════════════
// ESTILOS PARA MODAL DE REPORTE DE DIAGNÓSTICO
// ════════════════════════════════════════════════════════════════════════════════
// Define la paleta de colores, tipografía y decoraciones para el modal que muestra
// el reporte completo de diagnóstico. Incluye 3 niveles de severidad (OK, WARNING,
// CRITICAL) con colores específicos, métricas grandes y secciones organizadas.
// ════════════════════════════════════════════════════════════════════════════════

import 'package:flutter/material.dart';

/// Clase que contiene todos los estilos estáticos para el modal de reporte
/// Incluye sistema de colores por severidad y decoraciones para tarjetas
class ModalReporteStyles {
  // ══════════════════════════════════════════════════════════════════════════════
  // COLORES PRINCIPALES
  // ══════════════════════════════════════════════════════════════════════════════
  
  /// Verde oscuro principal (RGB: 7, 61, 43) - Para títulos y encabezados
  static const Color darkGreen = Color(0xFF073D2B);
  
  /// Verde brillante primario (RGB: 85, 168, 32) - Para gradientes de botones
  static const Color primaryGreen = Color(0xFF55A820);
  
  /// Verde medio para textos (RGB: 89, 114, 104) - Para etiquetas y descripciones
  static const Color textGreen = Color(0xFF597268);
  
  /// Color de fondo claro (RGB: 245, 250, 243) - Para contenedores principales
  static const Color backgroundLight = Color(0xFFF5FAF3);
  
  /// Blanco puro para tarjetas (RGB: 255, 255, 255) - Para items de grids
  static const Color cardBackground = Color(0xFFFFFFFF);
  
  /// Gris verdoso para bordes (RGB: 215, 228, 220) - Para líneas divisorias
  static const Color borderGrey = Color(0xFFD7E4DC);
  
  // ══════════════════════════════════════════════════════════════════════════════
  // COLORES PARA NIVEL OK (SALUDABLE / SIN PROBLEMAS)
  // ══════════════════════════════════════════════════════════════════════════════
  
  /// Fondo verde claro para estado OK (RGB: 234, 247, 229)
  static const Color okBg = Color(0xFFEAF7E5);
  
  /// Borde verde medio para estado OK (RGB: 200, 230, 201)
  static const Color okBorder = Color(0xFFC8E6C9);
  
  /// Texto verde oscuro para estado OK (RGB: 35, 115, 15)
  static const Color okText = Color(0xFF23730F);
  
  /// Texto de acción verde muy oscuro para estado OK (RGB: 26, 92, 10)
  static const Color okActionText = Color(0xFF1A5C0A);
  
  // ══════════════════════════════════════════════════════════════════════════════
  // COLORES PARA NIVEL WARNING (ADVERTENCIA / PRECAUCIÓN)
  // ══════════════════════════════════════════════════════════════════════════════
  
  /// Fondo amarillo claro para advertencia (RGB: 255, 249, 230)
  static const Color warnBg = Color(0xFFFFF9E6);
  
  /// Borde naranja claro para advertencia (RGB: 255, 224, 178)
  static const Color warnBorder = Color(0xFFFFE0B2);
  
  /// Texto naranja para advertencia (RGB: 181, 108, 7)
  static const Color warnText = Color(0xFFB56C07);
  
  /// Texto de acción naranja oscuro para advertencia (RGB: 99, 56, 6)
  static const Color warnActionText = Color(0xFF633806);
  
  // ══════════════════════════════════════════════════════════════════════════════
  // COLORES PARA NIVEL CRITICAL (CRÍTICO / URGENTE)
  // ══════════════════════════════════════════════════════════════════════════════
  
  /// Fondo rojo claro para crítico (RGB: 255, 235, 238)
  static const Color critBg = Color(0xFFFFEBEE);
  
  /// Borde rojo claro para crítico (RGB: 255, 205, 210)
  static const Color critBorder = Color(0xFFFFCDD2);
  
  /// Texto rojo para crítico (RGB: 198, 40, 40)
  static const Color critText = Color(0xFFC62828);
  
  /// Texto de acción rojo oscuro para crítico (RGB: 121, 31, 31)
  static const Color critActionText = Color(0xFF791F1F);

  // ══════════════════════════════════════════════════════════════════════════════
  // TIPOGRAFÍA
  // ══════════════════════════════════════════════════════════════════════════════
  
  /// Estilo para el encabezado principal del modal "Reporte de Diagnóstico"
  /// - Color: verde oscuro
  /// - Tamaño: 28px
  /// - Peso: 800 (extra bold)
  /// - Line height: 1.15 (compacto)
  static const TextStyle headerText = TextStyle(
    color: darkGreen, // Verde oscuro para máximo contraste
    fontSize: 28, // Tamaño grande para encabezado principal
    fontWeight: FontWeight.w800, // Extra bold para jerarquía
    height: 1.15, // Line height compacto
  );

  /// Estilo para títulos de sección ("Datos del Cultivo", "Recomendaciones", etc.)
  /// - Color: verde oscuro
  /// - Tamaño: 15px
  /// - Peso: 800 (extra bold)
  static const TextStyle sectionTitle = TextStyle(
    color: darkGreen, // Verde oscuro para claridad
    fontSize: 15, // Tamaño estándar para subtítulos
    fontWeight: FontWeight.w800, // Extra bold para destacar
  );

  /// Estilo para etiquetas de métricas ("Temperatura", "Humedad", etc.)
  /// - Color: verde medio
  /// - Tamaño: 13px
  /// - Peso: 800 (extra bold)
  static const TextStyle metricaLabel = TextStyle(
    color: textGreen, // Verde medio para etiquetas secundarias
    fontSize: 13, // Tamaño pequeño para etiquetas
    fontWeight: FontWeight.w800, // Extra bold para claridad
  );

  /// Estilo para valores de métricas (números grandes: "25°C", "65%", etc.)
  /// - Color: verde oscuro
  /// - Tamaño: 32px (muy grande)
  /// - Peso: 800 (extra bold)
  static const TextStyle metricaValor = TextStyle(
    color: darkGreen, // Verde oscuro para máximo contraste
    fontSize: 32, // Tamaño extra grande para valores destacados
    fontWeight: FontWeight.w800, // Extra bold para énfasis
  );

  // ══════════════════════════════════════════════════════════════════════════════
  // DECORACIONES DE COMPONENTES
  // ══════════════════════════════════════════════════════════════════════════════
  
  /// Decoración del botón de cerrar (X) en la esquina superior derecha
  /// - Fondo: backgroundLight (crema claro)
  /// - Border radius: 8px
  static BoxDecoration closeButtonDecoration = BoxDecoration(
    color: backgroundLight, // Fondo claro para contraste suave
    borderRadius: BorderRadius.circular(8), // Esquinas redondeadas
  );

  /// Decoración de las secciones principales del modal (contenedores de información)
  /// - Fondo: crema muy claro (RGB: 251, 253, 249)
  /// - Borde: borderGrey de 1px
  /// - Border radius: 8px
  static BoxDecoration sectionDecoration = BoxDecoration(
    color: const Color(0xFFFBFDF9), // Crema muy claro para secciones
    border: Border.all(color: borderGrey), // Borde gris verdoso
    borderRadius: BorderRadius.circular(8), // Esquinas redondeadas
  );
  
  /// Decoración de items de grid (tarjetas individuales de datos)
  /// - Fondo: blanco puro
  /// - Borde: borderGrey de 1px
  /// - Border radius: 8px
  static BoxDecoration gridItemDecoration = BoxDecoration(
    color: cardBackground, // Blanco puro para tarjetas
    border: Border.all(color: borderGrey), // Borde gris verdoso
    borderRadius: BorderRadius.circular(8), // Esquinas redondeadas
  );

  /// Decoración del botón "Guardar reporte" con gradiente verde
  /// - Gradiente: verde oscuro → verde brillante (diagonal)
  /// - Border radius: 8px
  /// - Sombra: verde oscuro 24% opacidad, desplazada 16px hacia abajo
  static BoxDecoration submitButtonDecoration = BoxDecoration(
    gradient: const LinearGradient(
      colors: [darkGreen, primaryGreen], // Gradiente de oscuro a brillante
      begin: Alignment.topLeft, // Inicia en esquina superior izquierda
      end: Alignment.bottomRight, // Termina en esquina inferior derecha
    ),
    borderRadius: BorderRadius.circular(8), // Esquinas redondeadas
    boxShadow: const [
      BoxShadow(
        color: Color.fromRGBO(7, 61, 43, 0.24), // Verde oscuro con 24% opacidad
        blurRadius: 28, // Desenfoque pronunciado
        offset: Offset(0, 16), // Desplazamiento vertical (sombra hacia abajo)
      )
    ],
  );
}
