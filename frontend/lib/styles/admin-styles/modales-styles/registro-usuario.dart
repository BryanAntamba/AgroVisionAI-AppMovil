// ════════════════════════════════════════════════════════════════════════════════
// ESTILOS PARA MODAL DE REGISTRO DE USUARIO
// ════════════════════════════════════════════════════════════════════════════════
// Define estilos para el modal de creación de nuevo usuario con validación.
// Modal grande (760px) con formulario de 6 campos: nombres, apellidos, email, teléfono, CI, contraseña y rol.
// Incluye validaciones visuales con bordes rojos y mensajes de error.
// Campos de contraseña con toggle de visibilidad y selección de rol mediante radio buttons.
// ════════════════════════════════════════════════════════════════════════════════

import 'package:flutter/material.dart';
import '../panel-admin.dart';

/// Clase que contiene todos los estilos estáticos para el modal de registro de usuario
/// Incluye estilos para estados normales y de error en todos los campos
class RegistroUsuarioStyles {
  // ══════════════════════════════════════════════════════════════════════════════
  // PALETA DE COLORES
  // ══════════════════════════════════════════════════════════════════════════════
  
  /// Color del overlay de fondo semitransparente (verde oscuro con 45% de opacidad)
  static const Color overlayColor = Color.fromRGBO(7, 61, 43, 0.45);
  
  /// Color rojo de error principal (RGB: 211, 47, 47)
  static const Color errorColor = Color(0xFFD32F2F);
  
  /// Color rojo claro para bordes de error (RGB: 229, 115, 115)
  static const Color errorBorderColor = Color(0xFFE57373);
  
  /// Color gris para texto de hint/placeholder (RGB: 107, 129, 119)
  /// Color gris para texto de hint/placeholder (RGB: 107, 129, 119)
  static const Color hintTextColor = Color(0xFF6B8177);

  // ══════════════════════════════════════════════════════════════════════════════
  // CONTENEDOR PRINCIPAL DEL MODAL
  // ══════════════════════════════════════════════════════════════════════════════
  
  /// Ancho máximo del modal en píxeles (760px - tamaño grande para 2 columnas)
  static const double maxWidth = 760;
  
  /// Margen exterior del modal (24px en todos los lados para centrado)
  static const EdgeInsets modalMargin = EdgeInsets.all(24);
  
  /// Decoración completa del contenedor del modal
  /// - Fondo: Blanco para contenido claro
  /// - Borde: Gris claro (borderGrey) para definir límites
  /// - Radio: 8px para esquinas redondeadas
  /// - Sombra: Verde oscuro (20% opacidad) con blur de 48px y offset de 24px
  static final BoxDecoration modalDecoration = BoxDecoration(
    color: Colors.white,
    border: Border.all(color: PanelAdminStyles.borderGrey),
    borderRadius: BorderRadius.circular(8),
    boxShadow: const [
      BoxShadow(
        color: Color.fromRGBO(7, 61, 43, 0.2),
        blurRadius: 48,
        offset: Offset(0, 24),
      ),
    ],
  );

  // ══════════════════════════════════════════════════════════════════════════════
  // HEADER - TÍTULO Y BOTÓN DE CERRAR
  // ══════════════════════════════════════════════════════════════════════════════
  
  /// Padding del header (28px horizontal, 28px arriba, 0px abajo)
  static const EdgeInsets headerPadding = EdgeInsets.fromLTRB(28, 28, 28, 0);
  
  /// Estilo del texto del título principal ("Registrar Usuario")
  /// - Color: Verde oscuro principal (darkGreen)
  /// - Tamaño: 20px para jerarquía visual
  /// - Peso: 800 (extra bold) para énfasis
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
  /// - Radio: 8px para consistencia
  static final BoxDecoration closeButtonDecoration = BoxDecoration(
    color: PanelAdminStyles.backgroundPage,
    borderRadius: BorderRadius.circular(8),
  );
  
  /// Color del icono X (verde oscuro para contraste)
  static const Color closeIconColor = PanelAdminStyles.darkGreen;
  
  /// Tamaño del icono X (18px - proporcionado al botón de 40px)
  static const double closeIconSize = 18;

  // ══════════════════════════════════════════════════════════════════════════════
  // FORMULARIO - LAYOUT DE CAMPOS
  // ══════════════════════════════════════════════════════════════════════════════
  
  /// Padding lateral del formulario (28px horizontal para alineación con header)
  static const EdgeInsets formPadding = EdgeInsets.symmetric(horizontal: 28);
  
  /// Espaciado vertical entre filas de campos (18px)
  static const double fieldSpacing = 18;
  
  /// Espaciado horizontal entre columnas en desktop (16px)
  static const double columnSpacing = 16;

  // ══════════════════════════════════════════════════════════════════════════════
  // CAMPOS DE TEXTO - ESTADOS NORMAL Y ERROR
  // ══════════════════════════════════════════════════════════════════════════════
  
  /// Altura mínima de cada campo incluyendo label, input y espacio para error (103px)
  static const double minFieldHeight = 103;
  
  /// Estilo del label superior de cada campo
  /// - Tamaño: 13px (pequeño para jerarquía)
  /// - Peso: 800 (extra bold) para contraste con el input
  /// - Color: Verde oscuro (darkGreen)
  static const TextStyle labelText = TextStyle(
    fontSize: 13,
    fontWeight: FontWeight.w800,
    color: PanelAdminStyles.darkGreen,
  );
  
  /// Espaciado entre el label y el input (8px)
  static const double labelSpacing = 8;
  
  /// Altura del input (54px para área confortable)
  static const double inputHeight = 54;
  
  /// Decoración del contenedor del input en estado normal
  /// - Fondo: Color de input (backgroundInput)
  /// - Borde: Gris claro (borderGrey)
  /// - Radio: 8px para esquinas redondeadas
  static final BoxDecoration inputDecoration = BoxDecoration(
    color: PanelAdminStyles.backgroundInput,
    border: Border.all(color: PanelAdminStyles.borderGrey),
    borderRadius: BorderRadius.circular(8),
  );
  
  /// Decoración del contenedor del input en estado de error
  /// - Fondo: Igual que estado normal (backgroundInput)
  /// - Borde: Rojo claro (errorBorderColor) con grosor de 1.5px
  /// - Radio: 8px para consistencia
  static BoxDecoration inputErrorDecoration = BoxDecoration(
    color: PanelAdminStyles.backgroundInput,
    border: Border.all(color: errorBorderColor, width: 1.5),
    borderRadius: BorderRadius.circular(8),
  );
  
  /// Ancho del contenedor del icono a la izquierda del input (48px)
  static const double iconContainerWidth = 48;
  
  /// Color del icono (verde principal para consistencia)
  static const Color iconColor = PanelAdminStyles.primaryGreen;
  
  /// Tamaño del icono (16px - proporcional al input)
  static const double iconSize = 16;
  
  /// Estilo del texto dentro del input
  /// - Color: Verde oscuro (darkGreen)
  /// - Tamaño: 14px para legibilidad
  static const TextStyle inputTextStyle = TextStyle(
    color: PanelAdminStyles.darkGreen,
    fontSize: 14,
  );
  
  /// Estilo del texto del hint/placeholder
  /// - Color: Gris medio (hintTextColor) para indicar que es placeholder
  /// - Tamaño: 14px para consistencia con el texto de input
  static const TextStyle hintTextStyle = TextStyle(
    color: hintTextColor,
    fontSize: 14,
  );
  
  /// Padding interno del contenido del input (16px vertical)
  static const EdgeInsets inputContentPadding = EdgeInsets.symmetric(vertical: 16);

  // ══════════════════════════════════════════════════════════════════════════════
  // MENSAJES DE ERROR - VALIDACIÓN
  // ══════════════════════════════════════════════════════════════════════════════
  
  /// Espaciado entre el input y el mensaje de error (6px)
  static const double errorSpacing = 6;
  
  /// Estilo del texto de error mostrado debajo del campo
  /// - Color: Rojo de error (errorColor)
  /// - Tamaño: 12px (más pequeño que el input)
  /// - Peso: 600 (semi-bold) para visibilidad
  static const TextStyle errorText = TextStyle(
    color: errorColor,
    fontSize: 12,
    fontWeight: FontWeight.w600,
  );

  // ══════════════════════════════════════════════════════════════════════════════
  // CAMPO DE CONTRASEÑA - TOGGLE DE VISIBILIDAD
  // ══════════════════════════════════════════════════════════════════════════════
  
  /// Ancho del área del botón de toggle de contraseña (46px)
  static const double passwordToggleWidth = 46;
  
  /// Tamaño del icono de ojo (mostrar/ocultar contraseña) - 16px
  static const double passwordIconSize = 16;

  // ══════════════════════════════════════════════════════════════════════════════
  // CAMPO DE ROL - OPCIONES DE RADIO CON VALIDACIÓN
  // ══════════════════════════════════════════════════════════════════════════════
  
  /// Estilo del label del campo de rol
  /// - Tamaño: 14px (ligeramente más grande que otros labels)
  /// - Peso: 700 (bold) para importancia
  /// - Color: Verde oscuro (darkGreen)
  static const TextStyle rolLabelText = TextStyle(
    fontSize: 14,
    fontWeight: FontWeight.w700,
    color: PanelAdminStyles.darkGreen,
  );
  
  /// Espaciado vertical entre opciones de rol (12px)
  static const double rolSpacing = 12;
  
  /// Decoración de cada opción de rol en estado normal (Administrador/Agricultor)
  /// - Fondo: Color de input (backgroundInput)
  /// - Borde: Gris claro (borderGrey)
  /// - Radio: 8px para consistencia
  static final BoxDecoration rolOptionDecoration = BoxDecoration(
    color: PanelAdminStyles.backgroundInput,
    border: Border.all(color: PanelAdminStyles.borderGrey),
    borderRadius: BorderRadius.circular(8),
  );
  
  /// Decoración de cada opción de rol en estado de error
  /// - Fondo: Igual que estado normal (backgroundInput)
  /// - Borde: Rojo claro (errorBorderColor) con grosor de 1.5px
  /// - Radio: 8px para consistencia
  static BoxDecoration rolOptionErrorDecoration = BoxDecoration(
    color: PanelAdminStyles.backgroundInput,
    border: Border.all(color: errorBorderColor, width: 1.5),
    borderRadius: BorderRadius.circular(8),
  );
  
  /// Altura de cada opción de rol (54px para área de toque confortable)
  static const double rolOptionHeight = 54;
  
  /// Padding interno de cada opción de rol (16px horizontal)
  static const EdgeInsets rolOptionPadding = EdgeInsets.symmetric(horizontal: 16);
  
  /// Color del radio button activo (verde principal)
  static const Color radioActiveColor = PanelAdminStyles.primaryGreen;
  
  /// Espaciado entre el radio button y su label (4px)
  static const double radioSpacing = 4;
  
  /// Estilo del texto de cada opción de rol
  /// - Tamaño: 14px para legibilidad
  /// - Peso: 700 (bold) para claridad
  /// - Color: Verde oscuro (darkGreen)
  static const TextStyle rolOptionText = TextStyle(
    fontSize: 14,
    fontWeight: FontWeight.w700,
    color: PanelAdminStyles.darkGreen,
  );

  // ══════════════════════════════════════════════════════════════════════════════
  // FOOTER - BOTONES DE ACCIÓN
  // ══════════════════════════════════════════════════════════════════════════════
  
  /// Padding del footer (28px horizontal, 16px arriba, 24px abajo)
  static const EdgeInsets footerPadding = EdgeInsets.fromLTRB(28, 16, 28, 24);
  
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
  /// - Fondo: Color de input (backgroundInput)
  /// - Borde: Gris claro (borderGrey)
  /// - Radio: 8px para consistencia
  static final BoxDecoration cancelButtonDecoration = BoxDecoration(
    color: PanelAdminStyles.backgroundInput,
    border: Border.all(color: PanelAdminStyles.borderGrey),
    borderRadius: BorderRadius.circular(8),
  );
  
  /// Estilo del texto del botón cancelar
  /// - Color: Verde oscuro (darkGreen)
  /// - Tamaño: 16px para legibilidad
  /// - Peso: 800 (extra bold) para claridad
  static const TextStyle cancelButtonText = TextStyle(
    color: PanelAdminStyles.darkGreen,
    fontSize: 16,
    fontWeight: FontWeight.w800,
  );

  // ══════════════════════════════════════════════════════════════════════════════
  // BOTÓN REGISTRAR - ACCIÓN PRIMARIA
  // ══════════════════════════════════════════════════════════════════════════════
  
  /// Padding horizontal del botón registrar (22px en cada lado - más que cancelar)
  static const EdgeInsets submitButtonPadding = EdgeInsets.symmetric(horizontal: 22);
  
  /// Decoración del botón registrar (usa decoración de botón crear de PanelAdminStyles)
  /// Fondo con gradiente verde y sombra para indicar acción primaria
  static final BoxDecoration submitButtonDecoration = PanelAdminStyles.createBtnDecoration;
  
  /// Estilo del texto del botón registrar
  /// - Color: Blanco para contraste con fondo verde
  /// - Tamaño: 16px para legibilidad
  /// - Peso: 800 (extra bold) para énfasis en acción primaria
  static const TextStyle submitButtonText = TextStyle(
    color: Colors.white,
    fontSize: 16,
    fontWeight: FontWeight.w800,
  );

  // ══════════════════════════════════════════════════════════════════════════════
  // RESPONSIVE - BREAKPOINTS
  // ══════════════════════════════════════════════════════════════════════════════
  
  /// Punto de quiebre para cambiar de 2 columnas a 1 columna (700px)
  /// Por debajo de este ancho, los campos se apilan verticalmente
  static const double mobileBreakpoint = 700;
}
