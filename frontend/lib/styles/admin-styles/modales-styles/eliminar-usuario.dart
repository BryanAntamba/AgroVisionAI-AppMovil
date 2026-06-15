// ════════════════════════════════════════════════════════════════════════════════
// ESTILOS PARA MODAL DE ELIMINAR USUARIO
// ════════════════════════════════════════════════════════════════════════════════
// Define estilos para el modal de confirmación destructiva para eliminar un usuario.
// Modal compacto (480px) con mensaje de advertencia en rojo y botón destructivo.
// Incluye nombre del usuario en negrita y warning sobre irreversibilidad de la acción.
// ════════════════════════════════════════════════════════════════════════════════

import 'package:flutter/material.dart';
import '../panel-admin.dart';

/// Clase que contiene todos los estilos estáticos para el modal de eliminar usuario
/// Hereda colores principales de PanelAdminStyles para consistencia visual
class EliminarUsuarioStyles {
  // ══════════════════════════════════════════════════════════════════════════════
  // PALETA DE COLORES
  // ══════════════════════════════════════════════════════════════════════════════
  
  /// Color del overlay de fondo (verde oscuro con 45% de opacidad)
  static const Color overlayColor = Color.fromRGBO(7, 61, 43, 0.45);
  
  /// Color verde medio para texto principal (RGB: 69, 102, 87)
  static const Color textPrimaryColor = Color(0xFF456657);
  
  /// Color verde oscuro para texto enfatizado (RGB: 7, 61, 43)
  static const Color textDarkColor = Color(0xFF073d2b);
  
  /// Color rojo de advertencia para texto (RGB: 163, 38, 38)
  static const Color warningColor = Color(0xFFA32626);
  
  /// Color rojo destructivo para botón eliminar (RGB: 163, 38, 38)
  static const Color deleteButtonColor = Color(0xFFA32626);
  
  /// Sombra roja para botón destructivo (163, 38, 38 con 24% opacidad)
  static const Color deleteButtonShadowColor = Color.fromRGBO(163, 38, 38, 0.24);

  // ══════════════════════════════════════════════════════════════════════════════
  // CONSTANTES DE DISEÑO Y DIMENSIONES
  // ══════════════════════════════════════════════════════════════════════════════
  
  /// Ancho máximo del modal en píxeles (480px para modal compacto)
  static const double maxWidth = 480;
  
  /// Margen exterior del modal (24px en todos los lados)
  static const EdgeInsets modalMargin = EdgeInsets.all(24);
  
  /// Padding interno del modal (28px horizontal, 28px arriba, 24px abajo)
  static const EdgeInsets modalPadding = EdgeInsets.fromLTRB(28, 28, 28, 24);
  
  /// Decoración del contenedor del modal (usa decoración estándar de PanelAdminStyles)
  static final BoxDecoration modalDecoration = PanelAdminStyles.cardDecoration;

  // ══════════════════════════════════════════════════════════════════════════════
  // HEADER - TÍTULO DEL MODAL
  // ══════════════════════════════════════════════════════════════════════════════
  
  /// Estilo del texto del título principal ("Eliminar Usuario")
  /// - Color: Verde oscuro principal (darkGreen)
  /// - Tamaño: 20px para dar jerarquía visual
  /// - Peso: 800 (extra bold) para énfasis en acción destructiva
  static const TextStyle titleText = TextStyle(
    color: PanelAdminStyles.darkGreen,
    fontSize: 20,
    fontWeight: FontWeight.w800,
  );

  // ══════════════════════════════════════════════════════════════════════════════
  // BOTÓN DE CERRAR (X) - ESQUINA SUPERIOR DERECHA
  // ══════════════════════════════════════════════════════════════════════════════
  
  /// Tamaño del botón de cerrar (40x40px) - área de clic cómoda
  static const double closeButtonSize = 40;
  
  /// Decoración del botón de cerrar con fondo y bordes redondeados
  /// - Fondo: Color de página (backgroundPage) para contraste sutil
  /// - Radio: 8px para consistencia con otros elementos del modal
  static final BoxDecoration closeButtonDecoration = BoxDecoration(
    color: PanelAdminStyles.backgroundPage,
    borderRadius: BorderRadius.circular(8),
  );
  
  /// Color del icono X (verde oscuro para contraste con fondo claro)
  static const Color closeIconColor = PanelAdminStyles.darkGreen;
  
  /// Tamaño del icono X (18px - proporcionado al botón de 40px)
  static const double closeIconSize = 18;

  // ══════════════════════════════════════════════════════════════════════════════
  // CONTENIDO - MENSAJE DE CONFIRMACIÓN
  // ══════════════════════════════════════════════════════════════════════════════
  
  /// Espaciado vertical entre el mensaje y el warning (14px)
  static const double contentSpacing = 14;
  
  /// Estilo del texto del cuerpo del mensaje de confirmación
  /// - Color: Verde medio (textPrimaryColor) para texto regular
  /// - Tamaño: 15px para legibilidad óptima
  /// - Altura de línea: 1.5 para espaciado cómodo en texto multilinea
  /// - Fuente: Arial para claridad
  static const TextStyle bodyText = TextStyle(
    color: textPrimaryColor,
    fontSize: 15,
    height: 1.5,
    fontFamily: 'Arial',
  );
  
  /// Estilo para texto en negrita (nombre del usuario a eliminar)
  /// - Color: Verde oscuro (textDarkColor) para mayor énfasis
  /// - Peso: Bold para destacar el nombre del usuario
  static const TextStyle boldText = TextStyle(
    color: textDarkColor,
    fontWeight: FontWeight.bold,
  );

  // ══════════════════════════════════════════════════════════════════════════════
  // TEXTO DE ADVERTENCIA - MENSAJE DE IRREVERSIBILIDAD
  // ══════════════════════════════════════════════════════════════════════════════
  
  /// Espaciado antes del mensaje de advertencia (12px)
  static const double warningSpacing = 12;
  
  /// Estilo del texto de advertencia en rojo
  /// - Color: Rojo de advertencia (warningColor) para llamar la atención
  /// - Tamaño: 13px (ligeramente menor que el cuerpo)
  /// - Peso: 700 (bold) para enfatizar la advertencia
  static const TextStyle warningText = TextStyle(
    color: warningColor,
    fontSize: 13,
    fontWeight: FontWeight.w700,
  );

  // ══════════════════════════════════════════════════════════════════════════════
  // FOOTER - ÁREA DE BOTONES DE ACCIÓN
  // ══════════════════════════════════════════════════════════════════════════════
  
  /// Espaciado superior antes del footer (24px para separación clara)
  static const double footerSpacing = 24;
  
  /// Espaciado horizontal entre botones (10px)
  static const double buttonSpacing = 10;
  
  /// Altura mínima de los botones (54px para área de toque confortable)
  static const double minButtonHeight = 54;

  // ══════════════════════════════════════════════════════════════════════════════
  // BOTÓN CANCELAR - ACCIÓN SECUNDARIA
  // ══════════════════════════════════════════════════════════════════════════════
  
  /// Padding horizontal del botón cancelar (18px en cada lado)
  static const EdgeInsets cancelButtonPadding = EdgeInsets.symmetric(horizontal: 18);
  
  /// Decoración del botón cancelar (estilo secundario neutral)
  /// - Fondo: Color de input (backgroundInput) para apariencia suave
  /// - Borde: Gris claro (borderGrey) para definir límites
  /// - Radio: 8px para consistencia visual
  static final BoxDecoration cancelButtonDecoration = BoxDecoration(
    color: PanelAdminStyles.backgroundInput,
    border: Border.all(color: PanelAdminStyles.borderGrey),
    borderRadius: BorderRadius.circular(8),
  );
  
  /// Estilo del texto del botón cancelar
  /// - Color: Verde oscuro (darkGreen) para contraste con fondo claro
  /// - Tamaño: 16px para legibilidad
  /// - Peso: 800 (extra bold) para claridad en la acción
  static const TextStyle cancelButtonText = TextStyle(
    color: PanelAdminStyles.darkGreen,
    fontSize: 16,
    fontWeight: FontWeight.w800,
  );

  // ══════════════════════════════════════════════════════════════════════════════
  // BOTÓN ELIMINAR - ACCIÓN DESTRUCTIVA PRIMARIA
  // ══════════════════════════════════════════════════════════════════════════════
  
  /// Padding horizontal del botón eliminar (22px en cada lado - más padding que cancelar)
  static const EdgeInsets deleteButtonPadding = EdgeInsets.symmetric(horizontal: 22);
  
  /// Decoración del botón eliminar (estilo destructivo)
  /// - Fondo: Rojo destructivo (deleteButtonColor)
  /// - Radio: 8px para consistencia
  static final BoxDecoration deleteButtonDecoration = BoxDecoration(
    color: deleteButtonColor,
    borderRadius: BorderRadius.circular(8),
  );
  
  /// Estilo del texto del botón eliminar
  /// - Color: Blanco para máximo contraste con fondo rojo
  /// - Tamaño: 16px para legibilidad
  /// - Peso: 800 (extra bold) para enfatizar acción crítica
  static const TextStyle deleteButtonText = TextStyle(
    color: Colors.white,
    fontSize: 16,
    fontWeight: FontWeight.w800,
  );
  
  /// Tamaño del icono de eliminar (16px - proporcional al texto)
  static const double deleteIconSize = 16;
  
  /// Espaciado entre el icono y el texto del botón (8px)
  static const double iconTextSpacing = 8;
}
