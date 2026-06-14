import 'package:flutter/material.dart';

/// Clase que centraliza todos los estilos, colores, dimensiones y configuraciones
/// visuales utilizados en la pantalla de login de la aplicación
class LoginStyles {
  
  // ============ COLORES ============
  /// Definición de la paleta de colores corporativos para la pantalla de login
  
  /// Color verde primario principal de la marca - usado en botones y elementos principales
  static const Color primaryGreen = Color(0xFF55A820);
  
  /// Color verde oscuro - usado en textos, headings y elementos secundarios
  static const Color darkGreen = Color(0xFF073D2B);
  
  /// Color de fondo claro - usado como fondo general de la pantalla
  static const Color backgroundLight = Color(0xFFF7FBF5);
  
  /// Color de fondo para tarjetas - usado en elementos como el panel de login
  static const Color cardBackground = Color(0xFFFBFDF9);
  
  /// Color rojo para errores - usado en mensajes de validación y errores
  static const Color errorRed = Color(0xFFC92B2B);
  
  /// Color gris para bordes - usado en los bordes de inputs
  static const Color borderGrey = Color(0xFFC8D8CE);
  
  /// Color gris para placeholders - usado en textos de hint/placeholder
  static const Color placeholderGrey = Color(0xFF7D9186);
  
  /// Color verde para links - usado en el link "Olvidé mi contraseña"
  static const Color linkGreen = Color(0xFF0B5A3D);
  
  /// Color blanco - usado como color base en elementos
  static const Color white = Color(0xFFFFFFFF);

  // ============ TIPOGRAFÍA ============
  /// Definición de estilos de texto reutilizables para mantener consistencia visual
  
  /// Estilo para títulos principales - texto grande y negrita
  static const TextStyle heading1 = TextStyle(
    color: darkGreen,
    fontSize: 31,
    fontWeight: FontWeight.bold,
    height: 1.15,
    letterSpacing: 0,
  );

  /// Estilo para labels de inputs - texto pequeño y negrita
  static const TextStyle label = TextStyle(
    color: darkGreen,
    fontSize: 14,
    fontWeight: FontWeight.w700,
    letterSpacing: 0,
  );

  /// Estilo para mensajes de error - texto en rojo
  static const TextStyle errorText = TextStyle(
    color: errorRed,
    fontSize: 13,
    fontWeight: FontWeight.w700,
    letterSpacing: 0,
  );

  /// Estilo para link de "Olvidé mi contraseña" - texto en verde
  static const TextStyle forgotLink = TextStyle(
    color: linkGreen,
    fontSize: 14,
    fontWeight: FontWeight.w700,
    letterSpacing: 0,
  );

  /// Estilo para texto dentro de inputs - texto normal
  static const TextStyle inputText = TextStyle(
    color: darkGreen,
    fontSize: 16,
    fontWeight: FontWeight.w400,
    letterSpacing: 0,
  );

  /// Estilo para placeholder/hint text en inputs - texto gris
  static const TextStyle inputPlaceholder = TextStyle(
    color: placeholderGrey,
    fontSize: 16,
    fontWeight: FontWeight.w400,
    letterSpacing: 0,
  );

  /// Estilo para texto de botones - texto blanco y muy negrita
  static const TextStyle buttonText = TextStyle(
    color: white,
    fontSize: 16,
    fontWeight: FontWeight.w800,
    letterSpacing: 0,
  );

  /// Estilo para errores de login - similar a errorText pero específico del login
  static const TextStyle loginError = TextStyle(
    color: errorRed,
    fontSize: 13,
    fontWeight: FontWeight.w700,
    letterSpacing: 0,
  );

  // ============ DIMENSIONES ============
  /// Definición de tamaños específicos para los elementos de la interfaz
  
  /// Tamaño del logo de la app
  static const double logoSize = 150;
  
  /// Margen inferior del logo
  static const double logoMarginBottom = 26;
  
  /// Altura estándar de campos de input
  static const double inputHeight = 54;
  
  /// Tamaño del área del toggle de mostrar/ocultar contraseña
  static const double passwordToggleSize = 46;
  
  /// Altura del botón de login
  static const double buttonHeight = 54;
  
  /// Espacio entre campos del formulario
  static const double fieldGap = 18;
  
  /// Altura mínima para un campo con label y validación
  static const double fieldMinHeight = 103;
  
  /// Ancho del icono de visibilidad de contraseña
  static const double iconWidth = 48;
  
  /// Radio de bordes redondeados para inputs y botones
  static const double borderRadius = 8;
  
  /// Extensión de la sombra de enfoque (focus shadow spread)
  static const double focusShadowSpread = 4;
  
  /// Espacio entre elementos del formulario
  static const double formGap = 18;
  
  /// Margen superior del link "Olvidé mi contraseña"
  static const double forgotLinkMarginTop = 20;
  
  /// Ancho del control del carrusel de imágenes
  static const double carouselControlWidth = 56;

  // ============ ESPACIADOS ============
  /// Definición de paddings y márgenes reutilizables
  
  /// Padding pequeño para elementos
  static const double paddingSmall = 20;
  
  /// Padding medio para elementos
  static const double paddingMedium = 32;
  
  /// Padding grande para secciones principales
  static const double paddingLarge = 64;
  
  /// Espacio entre campos del formulario
  static const double gapBetweenFields = 18;
  
  /// Margen vertical del logo
  static const double logoMarginVertical = 26;

  // ============ SOMBRAS ============
  /// Definición de sombras para darle profundidad a los elementos
  
  /// Sombra para el panel de login - sombra lateral izquierda suave
  static const BoxShadow loginPanelShadow = BoxShadow(
    color: Color.fromRGBO(7, 61, 43, 0.12),
    blurRadius: 42,
    offset: Offset(-22, 0),
  );

  /// Sombra para botones - sombra inferior más pronunciada
  static const BoxShadow buttonShadow = BoxShadow(
    color: Color.fromRGBO(7, 61, 43, 0.24),
    blurRadius: 28,
    offset: Offset(0, 16),
  );

  /// Sombra para inputs enfocados - glow verde alrededor del input
  static const BoxShadow focusInputShadow = BoxShadow(
    color: Color.fromRGBO(85, 168, 32, 0.13),
    blurRadius: 0,
    spreadRadius: 4,
  );

  // ============ DECORACIONES ============
  /// Definición de decoraciones complejas de widgets
  
  /// Decoración dinámica para inputs según estado de enfoque
  /// Cambia el color de fondo y borde dependiendo si está enfocado
  static BoxDecoration inputDecoration(bool isFocused) {
    return BoxDecoration(
      color: isFocused ? white : cardBackground, // Fondo blanco si está enfocado
      border: Border.all(
        color: isFocused ? primaryGreen : borderGrey, // Borde verde si está enfocado
        width: 1,
      ),
      borderRadius: BorderRadius.circular(borderRadius), // Bordes redondeados
      boxShadow: isFocused
          ? const [focusInputShadow] // Sombra glow si está enfocado
          : null,
    );
  }

  /// Decoración para botón de login con gradiente y sombra
  static BoxDecoration buttonDecoration = BoxDecoration(
    gradient: const LinearGradient(
      colors: [darkGreen, primaryGreen], // Gradiente de verde oscuro a verde claro
      begin: Alignment.topLeft,
      end: Alignment.bottomRight,
      transform: GradientRotation(135 * 3.14159 / 180), // Rotación de 135 grados
    ),
    borderRadius: BorderRadius.circular(borderRadius), // Bordes redondeados
    boxShadow: const [buttonShadow], // Sombra inferior
  );

  /// Decoración para el panel principal de login
  static BoxDecoration loginPanelDecoration = const BoxDecoration(
    color: white, // Fondo blanco
    boxShadow: [loginPanelShadow], // Sombra lateral
  );

  /// Decoración para el carrusel de imágenes de fondo
  static BoxDecoration carouselDecoration = const BoxDecoration(
    color: darkGreen, // Fondo verde oscuro
  );

  /// Decoración para el botón de toggle de contraseña
  static BoxDecoration passwordToggleDecoration = BoxDecoration(
    color: Colors.transparent, // Fondo transparente
    borderRadius: BorderRadius.circular(borderRadius), // Bordes redondeados
  );

  // ============ ANIMACIONES ============
  /// Configuración de tiempos y duraciones para animaciones
  
  /// Duración de la animación de fade-up al cargar
  static const Duration fadeUpDuration = Duration(milliseconds: 720);
  
  /// Duración de transiciones suaves entre estados
  static const Duration transitionDuration = Duration(milliseconds: 200);
  
  /// Delays escalonados para animar elementos uno tras otro
  static const List<int> animationDelays = [90, 190, 290, 390, 490, 590];

  // ============ BREAKPOINTS RESPONSIVE ============
  /// Puntos de quiebre para adaptar el diseño a diferentes tamaños de pantalla
  
  /// Breakpoint para dispositivos móviles
  static const double mobileBreakpoint = 600;
  
  /// Breakpoint para tablets en orientación vertical
  static const double tabletPortraitBreakpoint = 900;
  
  /// Breakpoint para tablets en orientación horizontal
  static const double tabletLandscapeBreakpoint = 1200;
  
  /// Breakpoint para escritorio
  static const double desktopBreakpoint = 1200;
  
  /// Breakpoint para pantallas grandes/ultra ancha
  static const double largeDesktopBreakpoint = 1440;
}
