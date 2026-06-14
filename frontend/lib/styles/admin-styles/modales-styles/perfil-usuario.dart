// ════════════════════════════════════════════════════════════════════════════════
// ESTILOS PARA MODAL DE PERFIL DE USUARIO
// ════════════════════════════════════════════════════════════════════════════════
// Define estilos para el modal de visualización de perfil de usuario en modo solo lectura.
// Modal grande (760px) con todos los campos deshabilitados mostrando datos del usuario.
// Incluye 6 campos de información: nombres, apellidos, email, teléfono, CI, y rol.
// Todos los campos son de solo visualización sin capacidad de edición.
// ════════════════════════════════════════════════════════════════════════════════

import 'package:flutter/material.dart';
import '../panel-admin.dart';

/// Clase que contiene todos los estilos estáticos para el modal de perfil de usuario
/// Modal de solo lectura para visualizar información completa del usuario seleccionado
class PerfilUsuarioStyles {
  // ══════════════════════════════════════════════════════════════════════════════
  // PALETA DE COLORES
  // ══════════════════════════════════════════════════════════════════════════════
  
  /// Color del overlay de fondo semitransparente (verde oscuro con 45% de opacidad)
  /// Oscurece el contenido detrás del modal para dar enfoque
  /// Color del overlay de fondo semitransparente (verde oscuro con 45% de opacidad)
  /// Oscurece el contenido detrás del modal para dar enfoque
  static const Color overlayColor = Color.fromRGBO(7, 61, 43, 0.45);

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
  /// - Sombra: Verde oscuro (20% opacidad) con blur de 48px y offset de 24px para profundidad
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
  /// Sin padding inferior para que el formulario quede pegado
  static const EdgeInsets headerPadding = EdgeInsets.fromLTRB(28, 28, 28, 0);
  
  /// Estilo del texto del título principal ("Perfil de Usuario")
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
  /// - Radio: 8px para consistencia con otros elementos
  static final BoxDecoration closeButtonDecoration = BoxDecoration(
    color: PanelAdminStyles.backgroundPage,
    borderRadius: BorderRadius.circular(8),
  );
  
  /// Color del icono X (verde oscuro para contraste con fondo claro)
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
  // CAMPOS DE TEXTO - SOLO LECTURA
  // ══════════════════════════════════════════════════════════════════════════════
  
  /// Altura mínima de cada campo incluyendo label y error space (103px)
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
  
  /// Decoración del contenedor del input (solo lectura)
  /// - Fondo: Color de input (backgroundInput) para indicar campo deshabilitado
  /// - Borde: Gris claro (borderGrey)
  /// - Radio: 8px para esquinas redondeadas
  static final BoxDecoration inputDecoration = BoxDecoration(
    color: PanelAdminStyles.backgroundInput,
    border: Border.all(color: PanelAdminStyles.borderGrey),
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
  
  /// Valor mostrado cuando el campo está vacío ('---')
  static const String emptyValue = '---';

  // ══════════════════════════════════════════════════════════════════════════════
  // CAMPO DE ROL - OPCIONES DE RADIO (SOLO LECTURA)
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
  
  /// Decoración de cada opción de rol (Administrador/Agricultor)
  /// - Fondo: Color de input (backgroundInput) para modo deshabilitado
  /// - Borde: Gris claro (borderGrey)
  /// - Radio: 8px para consistencia
  static final BoxDecoration rolOptionDecoration = BoxDecoration(
    color: PanelAdminStyles.backgroundInput,
    border: Border.all(color: PanelAdminStyles.borderGrey),
    borderRadius: BorderRadius.circular(8),
  );
  
  /// Altura de cada opción de rol (54px para área de toque confortable)
  static const double rolOptionHeight = 54;
  
  /// Padding interno de cada opción de rol (16px horizontal)
  static const EdgeInsets rolOptionPadding = EdgeInsets.symmetric(horizontal: 16);
  
  /// Color del radio button activo (verde principal)
  static const Color radioActiveColor = PanelAdminStyles.primaryGreen;
  
  /// Opacidad del radio button (0.92 para efecto sutil)
  static const double radioOpacity = 0.92;
  
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
  // FOOTER - BOTÓN DE CERRAR
  // ══════════════════════════════════════════════════════════════════════════════
  
  /// Padding del footer (28px horizontal, 16px arriba, 24px abajo)
  static const EdgeInsets footerPadding = EdgeInsets.fromLTRB(28, 16, 28, 24);
  
  /// Altura mínima del botón de cerrar (54px para área de toque confortable)
  static const double minButtonHeight = 54;

  // ══════════════════════════════════════════════════════════════════════════════
  // BOTÓN CERRAR - ACCIÓN PRIMARIA
  // ══════════════════════════════════════════════════════════════════════════════
  
  /// Decoración del botón cerrar (usa decoración de botón crear de PanelAdminStyles)
  /// Fondo verde principal con sombra para indicar que es la única acción disponible
  static final BoxDecoration closeFooterButtonDecoration = PanelAdminStyles.createBtnDecoration;
  
  /// Estilo del texto del botón cerrar
  /// - Color: Blanco para contraste con fondo verde
  /// - Tamaño: 16px para legibilidad
  /// - Peso: 800 (extra bold) para énfasis
  static const TextStyle closeFooterButtonText = TextStyle(
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
