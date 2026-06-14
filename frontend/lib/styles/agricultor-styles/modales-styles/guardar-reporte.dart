// ════════════════════════════════════════════════════════════════════════════════
// ESTILOS PARA MODAL DE ÉXITO "GUARDAR REPORTE"
// ════════════════════════════════════════════════════════════════════════════════
// Define estilos para el modal de confirmación de éxito tras guardar un reporte.
// Modal compacto (400px) con ícono de check verde circular, mensaje de éxito y
// botón con gradiente verde. Diseño minimalista y celebratorio.
// ════════════════════════════════════════════════════════════════════════════════

import 'package:flutter/material.dart';

/// Clase que contiene todos los estilos estáticos para el modal de guardar reporte
/// Incluye decoración de ícono circular y botón con gradiente
class GuardarReporteStyles {
  // ══════════════════════════════════════════════════════════════════════════════
  // CONSTANTES DE DISEÑO
  // ══════════════════════════════════════════════════════════════════════════════
  
  /// Ancho máximo del modal en píxeles (400px para modal compacto de éxito)
  static const double maxWidth = 400.0;
  
  // ══════════════════════════════════════════════════════════════════════════════
  // PALETA DE COLORES
  // ══════════════════════════════════════════════════════════════════════════════
  
  /// Color del overlay de fondo (verde oscuro con 45% de opacidad)
  static const Color overlayColor = Color.fromRGBO(7, 61, 43, 0.45);
  
  /// Fondo blanco puro del modal
  static const Color backgroundColor = Colors.white;
  
  /// Color de bordes gris verdoso (RGB: 215, 228, 220)
  static const Color borderColor = Color(0xFFd7e4dc);
  
  /// Fondo verde claro para círculo del ícono (RGB: 234, 247, 229)
  static const Color iconBackgroundColor = Color(0xFFeaf7e5);
  
  /// Color verde brillante para ícono de check (RGB: 85, 168, 32)
  static const Color iconColor = Color(0xFF55a820);
  
  /// Color verde oscuro para título (RGB: 7, 61, 43)
  static const Color titleColor = Color(0xFF073d2b);
  
  /// Color verde medio para texto (RGB: 89, 114, 104)
  static const Color textColor = Color(0xFF597268);
  
  /// Color blanco para texto del botón
  static const Color btnTextColor = Colors.white;

  // ══════════════════════════════════════════════════════════════════════════════
  // DECORACIONES DE COMPONENTES
  // ══════════════════════════════════════════════════════════════════════════════
  
  /// Decoración del contenedor del modal con sombra suave
  /// - Fondo: blanco puro
  /// - Borde: gris verdoso de 1px
  /// - Border radius: 12px (más redondeado que otros modales)
  /// - Sombra: verde oscuro 15% opacidad, desplazada 20px hacia abajo
  static BoxDecoration modalDecoration = BoxDecoration(
    color: backgroundColor,
    border: Border.all(color: borderColor),
    borderRadius: BorderRadius.circular(12), // Más redondeado para look amigable
    boxShadow: const [
      BoxShadow(
        color: Color.fromRGBO(7, 61, 43, 0.15), // Sombra más suave (15%)
        blurRadius: 60, // Desenfoque amplio
        offset: Offset(0, 20), // Desplazamiento de 20px
      ),
    ],
  );

  /// Decoración del círculo del ícono de éxito
  /// - Forma: círculo perfecto
  /// - Color: verde claro de fondo
  static const BoxDecoration iconDecoration = BoxDecoration(
    shape: BoxShape.circle, // Círculo perfecto
    color: iconBackgroundColor, // Fondo verde claro
  );

  /// Decoración del botón "Aceptar" con gradiente verde
  /// - Gradiente: verde oscuro → verde brillante (diagonal)
  /// - Border radius: 8px
  static BoxDecoration btnDecoration = BoxDecoration(
    gradient: const LinearGradient(
      begin: Alignment.topLeft, // Inicia en esquina superior izquierda
      end: Alignment.bottomRight, // Termina en esquina inferior derecha
      colors: [Color(0xFF073d2b), Color(0xFF55a820)], // Verde oscuro → verde brillante
    ),
    borderRadius: BorderRadius.circular(8), // Esquinas redondeadas
  );

  // ══════════════════════════════════════════════════════════════════════════════
  // ESTILOS DE TEXTO
  // ══════════════════════════════════════════════════════════════════════════════
  
  /// Estilo para el título del modal "¡Reporte guardado!"
  /// - Color: verde oscuro
  /// - Tamaño: 20px
  /// - Peso: 800 (extra bold)
  static const TextStyle titleStyle = TextStyle(
    color: titleColor,
    fontSize: 20,
    fontWeight: FontWeight.w800,
  );

  /// Estilo para el mensaje de confirmación
  /// - Color: verde medio
  /// - Tamaño: 14px
  /// - Line height: 1.5
  static const TextStyle messageStyle = TextStyle(
    color: textColor,
    fontSize: 14,
    height: 1.5,
  );

  /// Estilo para el botón "Aceptar"
  /// - Color: blanco
  /// - Tamaño: 15px
  /// - Peso: 800 (extra bold)
  static const TextStyle btnStyle = TextStyle(
    color: btnTextColor,
    fontSize: 15,
    fontWeight: FontWeight.w800,
  );
}
