// ════════════════════════════════════════════════════════════════════════════════
// ESTILOS PARA MODAL COMPLETO DE REPORTE DE DIAGNÓSTICO
// ════════════════════════════════════════════════════════════════════════════════
// Define todos los estilos para el modal grande (760px) de reporte completo.
// Incluye 7 secciones: información de planta, diagnóstico principal, métricas
// ambientales (4 valores), predicciones con porcentajes, datos de sensores,
// análisis de lesión y recomendaciones con 3 niveles (OK, WARNING, CRITICAL).
// ════════════════════════════════════════════════════════════════════════════════

import 'package:flutter/material.dart';

/// Clase que contiene todos los estilos estáticos para el modal de reporte completo
/// Incluye sistema completo de colores por severidad y decoraciones específicas
class ModalReporteStyles {
  // ══════════════════════════════════════════════════════════════════════════════
  // CONSTANTES DE DISEÑO
  // ══════════════════════════════════════════════════════════════════════════════
  
  /// Ancho máximo del modal en píxeles (760px para modal grande)
  static const double maxWidth = 760.0;
  
  // ══════════════════════════════════════════════════════════════════════════════
  // COLORES PRINCIPALES
  // ══════════════════════════════════════════════════════════════════════════════
  
  /// Color del overlay de fondo (verde oscuro con 45% de opacidad)
  static const Color overlayColor = Color.fromRGBO(7, 61, 43, 0.45);
  
  /// Fondo blanco puro del modal
  static const Color backgroundColor = Colors.white;
  
  /// Color de bordes gris verdoso (RGB: 215, 228, 220)
  static const Color borderColor = Color(0xFFd7e4dc);
  
  /// Color verde oscuro para títulos (RGB: 7, 61, 43)
  static const Color titleColor = Color(0xFF073d2b);
  
  /// Color verde claro para textos (RGB: 89, 114, 104)
  static const Color textLightColor = Color(0xFF597268);
  
  /// Color verde medio para textos (RGB: 69, 102, 87)
  static const Color textDarkColor = Color(0xFF456657);
  
  /// Fondo verde claro para botón cerrar (RGB: 245, 250, 243)
  static const Color closeBtnBg = Color(0xFFf5faf3);
  
  /// Color verde oscuro para ícono de cerrar (RGB: 7, 61, 43)
  static const Color closeBtnColor = Color(0xFF073d2b);

  // ══════════════════════════════════════════════════════════════════════════════
  // DECORACIONES PRINCIPALES
  // ══════════════════════════════════════════════════════════════════════════════
  
  /// Decoración del contenedor del modal
  static BoxDecoration modalDecoration = BoxDecoration(
    color: backgroundColor,
    border: Border.all(color: borderColor),
    borderRadius: BorderRadius.circular(8),
    boxShadow: const [
      BoxShadow(
        color: Color.fromRGBO(7, 61, 43, 0.2),
        blurRadius: 48,
        offset: Offset(0, 24),
      ),
    ],
  );

  /// Decoración del botón cerrar (X)
  static BoxDecoration closeBtnDecoration = BoxDecoration(
    color: closeBtnBg,
    borderRadius: BorderRadius.circular(8),
  );

  /// Estilo para el encabezado principal
  static const TextStyle headerStyle = TextStyle(
    color: titleColor,
    fontSize: 28,
    fontWeight: FontWeight.w800,
    height: 1.15,
  );

  // ══════════════════════════════════════════════════════════════════════════════
  // SECCIÓN: INFORMACIÓN DE PLANTA
  // ══════════════════════════════════════════════════════════════════════════════

  /// Decoración para sección de información de planta
  static BoxDecoration plantaInfoDecoration = BoxDecoration(
    color: const Color(0xFFf5faf3),
    borderRadius: BorderRadius.circular(8),
  );
  
  /// Estilo para texto de información de planta
  static const TextStyle plantaInfoStyle = TextStyle(
    color: textDarkColor,
    fontSize: 14,
    fontWeight: FontWeight.w700,
  );

  // ══════════════════════════════════════════════════════════════════════════════
  // SECCIÓN: DIAGNÓSTICO PRINCIPAL
  // ══════════════════════════════════════════════════════════════════════════════

  /// Decoración para sección de diagnóstico
  static BoxDecoration diagnosticoDecoration = BoxDecoration(
    color: const Color(0xFFfbfdf9),
    border: Border.all(color: borderColor),
    borderRadius: BorderRadius.circular(8),
  );

  /// Estilo para títulos de sección
  static const TextStyle sectionTitleStyle = TextStyle(
    color: titleColor,
    fontSize: 15,
    fontWeight: FontWeight.w800,
  );
  
  /// Estilo para título del diagnóstico (más grande)
  static const TextStyle diagnosticoTitleStyle = TextStyle(
    color: titleColor,
    fontSize: 20,
    fontWeight: FontWeight.w800,
  );

  /// Estilo para mensaje del diagnóstico
  static const TextStyle diagnosticoMessageStyle = TextStyle(
    color: textLightColor,
    fontSize: 14,
  );

  // ══════════════════════════════════════════════════════════════════════════════
  // SECCIÓN: MÉTRICAS AMBIENTALES (Grid de 4 valores)
  // ══════════════════════════════════════════════════════════════════════════════

  /// Decoración para cada tarjeta de métrica
  static BoxDecoration metricaDecoration = BoxDecoration(
    color: backgroundColor,
    border: Border.all(color: borderColor),
    borderRadius: BorderRadius.circular(8),
  );

  /// Estilo para etiqueta de métrica ("Temperatura", "Humedad")
  static const TextStyle metricaLabelStyle = TextStyle(
    color: textLightColor,
    fontSize: 13,
    fontWeight: FontWeight.w800,
  );

  /// Estilo para valor de métrica (número grande: "25°C")
  static const TextStyle metricaValorStyle = TextStyle(
    color: titleColor,
    fontSize: 32,
    fontWeight: FontWeight.w800,
  );

  // ══════════════════════════════════════════════════════════════════════════════
  // SECCIÓN: PREDICCIONES CON PORCENTAJES
  // ══════════════════════════════════════════════════════════════════════════════

  /// Decoración para sección de predicciones
  static BoxDecoration prediccionesDecoration = BoxDecoration(
    color: const Color(0xFFfbfdf9),
    border: Border.all(color: borderColor),
    borderRadius: BorderRadius.circular(8),
  );

  /// Decoración para cada item de predicción
  static const BoxDecoration prediccionItemDecoration = BoxDecoration(
    border: Border(bottom: BorderSide(color: Color(0xFFedf5e9))),
  );

  /// Estilo para nombre de la enfermedad predicha
  static const TextStyle prediccionNombreStyle = TextStyle(
    color: titleColor,
    fontSize: 14,
    fontWeight: FontWeight.w700,
  );

  /// Estilo para porcentaje de predicción (verde)
  static const TextStyle prediccionValorStyle = TextStyle(
    color: Color(0xFF55a820),
    fontSize: 14,
    fontWeight: FontWeight.w800,
  );

  /// Estilo para texto de otras condiciones
  static const TextStyle otrasCondicionesStyle = TextStyle(
    color: Color(0xFF6b8177),
    fontSize: 12,
    fontStyle: FontStyle.italic,
  );

  // ══════════════════════════════════════════════════════════════════════════════
  // SECCIONES: DATOS DE SENSORES Y ANÁLISIS DE LESIÓN
  // ══════════════════════════════════════════════════════════════════════════════

  /// Decoración para tarjetas de sensores y lesión
  static BoxDecoration sensorLesionDecoration = BoxDecoration(
    color: backgroundColor,
    border: Border.all(color: borderColor),
    borderRadius: BorderRadius.circular(8),
  );

  /// Estilo para etiquetas de sensor/lesión
  static const TextStyle sensorLesionLabelStyle = TextStyle(
    color: textLightColor,
    fontSize: 12,
    fontWeight: FontWeight.w800,
  );

  /// Estilo para valores de sensor/lesión
  static const TextStyle sensorLesionValorStyle = TextStyle(
    color: titleColor,
    fontSize: 18,
    fontWeight: FontWeight.w800,
  );

  // ══════════════════════════════════════════════════════════════════════════════
  // SECCIÓN: RECOMENDACIONES CON 3 NIVELES DE SEVERIDAD
  // ══════════════════════════════════════════════════════════════════════════════

  /// Decoración para recomendación OK (verde - todo bien)
  static BoxDecoration recomendacionOkDecoration = BoxDecoration(
    color: const Color(0xFFeaf7e5),
    border: Border.all(color: const Color(0xFFc8e6c9)),
    borderRadius: BorderRadius.circular(8),
  );

  /// Decoración para recomendación WARNING (amarillo - advertencia)
  static BoxDecoration recomendacionWarnDecoration = BoxDecoration(
    color: const Color(0xFFfff9e6),
    border: Border.all(color: const Color(0xFFffe0b2)),
    borderRadius: BorderRadius.circular(8),
  );

  /// Decoración para recomendación CRITICAL (rojo - crítico)
  static BoxDecoration recomendacionCritDecoration = BoxDecoration(
    color: const Color(0xFFffebee),
    border: Border.all(color: const Color(0xFFffcdd2)),
    borderRadius: BorderRadius.circular(8),
  );

  /// Colores de íconos según severidad
  static const Color iconOkColor = Color(0xFF55a820);
  static const Color iconWarnColor = Color(0xFFb56c07);
  static const Color iconCritColor = Color(0xFFc62828);

  /// Estilo para encabezado de recomendación
  static const TextStyle recHeaderStyle = TextStyle(
    color: titleColor,
    fontSize: 16,
    fontWeight: FontWeight.w800,
  );

  /// Estilo para mensaje de recomendación
  static const TextStyle recMessageStyle = TextStyle(
    color: textDarkColor,
    fontSize: 14,
    height: 1.5,
  );

  /// Decoración para sección de acción recomendada
  static const BoxDecoration recAccionDecoration = BoxDecoration(
    border: Border(top: BorderSide(color: Color.fromRGBO(7, 61, 43, 0.1))),
  );

  /// Estilo para título de acción
  static const TextStyle recAccionTitleStyle = TextStyle(
    color: titleColor,
    fontSize: 13,
    fontWeight: FontWeight.w800,
  );

  /// Decoración para mensaje "Sin recomendaciones" (borde punteado simulado)
  static BoxDecoration sinRecomendacionesDecoration = BoxDecoration(
    border: Border.all(color: const Color(0xFFaac0b3), style: BorderStyle.solid), // dashed no soportado, usa solid como fallback
    borderRadius: BorderRadius.circular(8),
  );

  // ══════════════════════════════════════════════════════════════════════════════
  // SECCIÓN: ACCIONES DEL MODAL (Footer con botón guardar)
  // ══════════════════════════════════════════════════════════════════════════════

  /// Decoración para el footer del modal
  static const BoxDecoration modalActionsDecoration = BoxDecoration(
    border: Border(top: BorderSide(color: borderColor)),
  );

  /// Decoración del botón "Guardar reporte" con gradiente
  static BoxDecoration submitBtnDecoration = BoxDecoration(
    gradient: const LinearGradient(
      begin: Alignment.topLeft,
      end: Alignment.bottomRight,
      colors: [Color(0xFF073d2b), Color(0xFF55a820)],
    ),
    borderRadius: BorderRadius.circular(8),
    boxShadow: const [
      BoxShadow(
        color: Color.fromRGBO(7, 61, 43, 0.24),
        blurRadius: 28,
        offset: Offset(0, 16),
      ),
    ],
  );

  /// Estilo para texto del botón guardar
  static const TextStyle submitBtnStyle = TextStyle(
    color: Colors.white,
    fontSize: 16,
    fontWeight: FontWeight.w800,
  );
}
