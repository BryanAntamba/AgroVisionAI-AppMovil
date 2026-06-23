import 'package:flutter/material.dart';
import '../panel-admin.dart';

/// Clase que centraliza todos los estilos, colores, tipografía y decoraciones
/// utilizados en el modal de editar usuario
class EditarUsuarioStyles {
  
  // ============ COLORES ============
  /// Definición de la paleta de colores para el modal
  
  /// Color del overlay/backdrop - oscuridad de fondo detrás del modal
  static const Color overlayColor = Color.fromRGBO(7, 61, 43, 0.45);
  
  /// Color rojo para errores - usado en validaciones
  static const Color errorColor = Color(0xFFD32F2F);
  
  /// Color rojo para bordes de error - usado en bordes de campos con error
  static const Color errorBorderColor = Color(0xFFE57373);

  // ============ CONTENEDOR MODAL ============
  /// Estilos específicos para el contenedor del modal
  
  /// Ancho máximo del modal
  static const double maxWidth = 760;
  
  /// Margen alrededor del modal
  static const EdgeInsets modalMargin = EdgeInsets.all(24);
  
  /// Decoración del modal - borde, sombra y esquinas redondeadas
  static final BoxDecoration modalDecoration = BoxDecoration(
    color: Colors.white, // Fondo blanco
    border: Border.all(color: PanelAdminStyles.borderGrey), // Borde gris
    borderRadius: BorderRadius.circular(8), // Esquinas redondeadas
    boxShadow: const [
      BoxShadow(
        color: Color.fromRGBO(7, 61, 43, 0.2), // Sombra oscura
        blurRadius: 48,
        offset: Offset(0, 24),
      ),
    ],
  );

  // ============ ENCABEZADO ============
  /// Estilos específicos para el encabezado del modal
  
  /// Padding para el encabezado
  static const EdgeInsets headerPadding = EdgeInsets.fromLTRB(28, 28, 28, 0);
  
  /// Estilo para el título - texto pequeño y negrita
  static const TextStyle titleText = TextStyle(
    color: PanelAdminStyles.darkGreen,
    fontSize: 20,
    fontWeight: FontWeight.w800,
  );

  // ============ BOTÓN CERRAR ============
  /// Estilos específicos para el botón cerrar (X)
  
  /// Tamaño del botón cerrar
  static const double closeButtonSize = 40;
  
  /// Decoración del botón cerrar - fondo claro con esquinas redondeadas
  static final BoxDecoration closeButtonDecoration = BoxDecoration(
    color: PanelAdminStyles.backgroundPage, // Fondo claro
    borderRadius: BorderRadius.circular(8), // Esquinas redondeadas
  );
  
  /// Color del ícono cerrar
  static const Color closeIconColor = PanelAdminStyles.darkGreen;
  
  /// Tamaño del ícono cerrar
  static const double closeIconSize = 18;

  // ============ FORMULARIO ============
  /// Estilos específicos para el formulario
  
  /// Padding del formulario
  static const EdgeInsets formPadding = EdgeInsets.symmetric(horizontal: 28);
  
  /// Espaciado entre campos
  static const double fieldSpacing = 18;
  
  /// Espaciado entre columnas
  static const double columnSpacing = 16;

  // ============ CAMPO DE TEXTO ============
  /// Estilos específicos para campos de entrada de texto
  
  /// Altura mínima de campo
  static const double minFieldHeight = 103;
  
  /// Estilo para labels de campos - texto pequeño y negrita
  static const TextStyle labelText = TextStyle(
    fontSize: 13,
    fontWeight: FontWeight.w800,
    color: PanelAdminStyles.darkGreen,
  );
  
  /// Espaciado entre label e input
  static const double labelSpacing = 8;
  
  /// Altura del input
  static const double inputHeight = 54;
  
  /// Decoración para inputs - borde gris con fondo claro
  /// - focused: Si true, agrega resplandor verde y borde verde
  static BoxDecoration inputDecoration({bool focused = false}) {
    return BoxDecoration(
      color: PanelAdminStyles.backgroundInput, // Fondo claro
      border: Border.all(color: focused ? PanelAdminStyles.primaryGreen : PanelAdminStyles.borderGrey), // Borde verde si está enfocado
      borderRadius: BorderRadius.circular(8), // Esquinas redondeadas
      boxShadow: focused
          ? [
              const BoxShadow(
                color: Color.fromRGBO(85, 168, 32, 0.13),
                blurRadius: 0,
                spreadRadius: 4,
              ),
            ]
          : null,
    );
  }
  
  /// Decoración para inputs con error - borde rojo
  static BoxDecoration inputErrorDecoration = BoxDecoration(
    color: PanelAdminStyles.backgroundInput,
    border: Border.all(color: errorBorderColor, width: 1.5), // Borde rojo más grueso
    borderRadius: BorderRadius.circular(8),
  );
  
  /// Ancho del contenedor de ícono dentro del input
  static const double iconContainerWidth = 48;
  
  /// Color del ícono dentro del input
  static const Color iconColor = PanelAdminStyles.primaryGreen;
  
  /// Tamaño del ícono dentro del input
  static const double iconSize = 16;
  
  /// Estilo para texto dentro del input
  static const TextStyle inputTextStyle = TextStyle(
    color: PanelAdminStyles.darkGreen,
    fontSize: 14,
  );
  
  /// Padding del contenido del input
  static const EdgeInsets inputContentPadding = EdgeInsets.symmetric(vertical: 16);

  // ============ TEXTO DE ERROR ============
  /// Estilos específicos para mensajes de error
  
  /// Espaciado del texto de error
  static const double errorSpacing = 6;
  
  /// Estilo para texto de error - texto rojo pequeño
  static const TextStyle errorText = TextStyle(
    color: errorColor,
    fontSize: 12,
    fontWeight: FontWeight.w600,
  );

  // ============ CAMPO DE CONTRASEÑA ============
  /// Estilos específicos para campo de contraseña
  
  /// Ancho del toggle de visibilidad
  static const double passwordToggleWidth = 46;
  
  /// Tamaño del ícono de visibilidad
  static const double passwordIconSize = 16;

  // ============ CAMPO DE ROL ============
  /// Estilos específicos para selección de rol
  
  /// Estilo para label de rol - texto pequeño y negrita
  static const TextStyle rolLabelText = TextStyle(
    fontSize: 14,
    fontWeight: FontWeight.w700,
    color: PanelAdminStyles.darkGreen,
  );
  
  /// Espaciado del rol
  static const double rolSpacing = 12;
  
  /// Decoración para opciones de rol - borde gris con fondo claro
  static final BoxDecoration rolOptionDecoration = BoxDecoration(
    color: PanelAdminStyles.backgroundInput,
    border: Border.all(color: PanelAdminStyles.borderGrey),
    borderRadius: BorderRadius.circular(8),
  );
  
  /// Decoración para opciones de rol con error - borde rojo
  static BoxDecoration rolOptionErrorDecoration = BoxDecoration(
    color: PanelAdminStyles.backgroundInput,
    border: Border.all(color: errorBorderColor, width: 1.5),
    borderRadius: BorderRadius.circular(8),
  );
  
  /// Altura de cada opción de rol
  static const double rolOptionHeight = 54;
  
  /// Padding para opciones de rol
  static const EdgeInsets rolOptionPadding = EdgeInsets.symmetric(horizontal: 16);
  
  /// Color del radio activo - verde
  static const Color radioActiveColor = PanelAdminStyles.primaryGreen;
  
  /// Espaciado del radio
  static const double radioSpacing = 4;
  
  /// Estilo para texto de opción de rol
  static const TextStyle rolOptionText = TextStyle(
    fontSize: 14,
    fontWeight: FontWeight.w700,
    color: PanelAdminStyles.darkGreen,
  );

  // ============ FOOTER/ACCIONES ============
  /// Estilos específicos para el footer con botones
  
  /// Padding del footer
  static const EdgeInsets footerPadding = EdgeInsets.fromLTRB(28, 16, 28, 24);
  
  /// Espaciado entre botones
  static const double buttonSpacing = 10;
  
  /// Altura mínima de botones
  static const double minButtonHeight = 54;

  // ============ BOTÓN CANCELAR ============
  /// Estilos específicos para botón cancelar
  
  /// Padding del botón cancelar
  static const EdgeInsets cancelButtonPadding = EdgeInsets.symmetric(horizontal: 18);
  
  /// Decoración del botón cancelar - fondo claro con borde
  static final BoxDecoration cancelButtonDecoration = BoxDecoration(
    color: PanelAdminStyles.backgroundInput,
    border: Border.all(color: PanelAdminStyles.borderGrey),
    borderRadius: BorderRadius.circular(8),
  );
  
  /// Estilo para texto del botón cancelar
  static const TextStyle cancelButtonText = TextStyle(
    color: PanelAdminStyles.darkGreen,
    fontSize: 16,
    fontWeight: FontWeight.w800,
  );

  // ============ BOTÓN GUARDAR ============
  /// Estilos específicos para botón enviar/guardar
  
  /// Padding del botón guardar
  static const EdgeInsets submitButtonPadding = EdgeInsets.symmetric(horizontal: 22);
  
  /// Decoración del botón guardar - usa estilos del panel admin
  static final BoxDecoration submitButtonDecoration = PanelAdminStyles.createBtnDecoration;
  
  /// Estilo para texto del botón guardar - blanco negrita
  static const TextStyle submitButtonText = TextStyle(
    color: Colors.white,
    fontSize: 16,
    fontWeight: FontWeight.w800,
  );

  // ============ RESPONSIVE ============
  /// Configuración de breakpoints para diseño responsive
  
  /// Breakpoint para dispositivos móviles
  static const double mobileBreakpoint = 700;
}
