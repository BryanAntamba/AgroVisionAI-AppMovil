import 'package:flutter/material.dart';

class LoginStyles {
  // ============ COLORES ============
  static const Color primaryGreen = Color(0xFF55A820);
  static const Color darkGreen = Color(0xFF073D2B);
  static const Color backgroundLight = Color(0xFFF7FBF5);
  static const Color cardBackground = Color(0xFFFBFDF9);
  static const Color errorRed = Color(0xFFC92B2B);
  static const Color borderGrey = Color(0xFFC8D8CE);
  static const Color placeholderGrey = Color(0xFF7D9186);
  static const Color linkGreen = Color(0xFF0B5A3D);
  static const Color white = Color(0xFFFFFFFF);

  // ============ TIPOGRAFÍA ============
  static const TextStyle heading1 = TextStyle(
    color: darkGreen,
    fontSize: 31,
    fontWeight: FontWeight.bold,
    height: 1.15,
    letterSpacing: 0,
  );

  static const TextStyle label = TextStyle(
    color: darkGreen,
    fontSize: 14,
    fontWeight: FontWeight.w700,
    letterSpacing: 0,
  );

  static const TextStyle errorText = TextStyle(
    color: errorRed,
    fontSize: 13,
    fontWeight: FontWeight.w700,
    letterSpacing: 0,
  );

  static const TextStyle forgotLink = TextStyle(
    color: linkGreen,
    fontSize: 14,
    fontWeight: FontWeight.w700,
    letterSpacing: 0,
  );

  static const TextStyle inputText = TextStyle(
    color: darkGreen,
    fontSize: 16,
    fontWeight: FontWeight.w400,
    letterSpacing: 0,
  );

  static const TextStyle inputPlaceholder = TextStyle(
    color: placeholderGrey,
    fontSize: 16,
    fontWeight: FontWeight.w400,
    letterSpacing: 0,
  );

  static const TextStyle buttonText = TextStyle(
    color: white,
    fontSize: 16,
    fontWeight: FontWeight.w800,
    letterSpacing: 0,
  );

  static const TextStyle loginError = TextStyle(
    color: errorRed,
    fontSize: 13,
    fontWeight: FontWeight.w700,
    letterSpacing: 0,
  );

  // ============ DIMENSIONES ============
  static const double logoSize = 150;
  static const double logoMarginBottom = 26;
  static const double inputHeight = 54;
  static const double passwordToggleSize = 46;
  static const double buttonHeight = 54;
  static const double fieldGap = 18;
  static const double fieldMinHeight = 103;
  static const double iconWidth = 48;
  static const double borderRadius = 8;
  static const double focusShadowSpread = 4;
  static const double formGap = 18;
  static const double forgotLinkMarginTop = 20;
  static const double carouselControlWidth = 56;

  // ============ ESPACIADOS ============
  static const double paddingSmall = 20;
  static const double paddingMedium = 32;
  static const double paddingLarge = 64;
  static const double gapBetweenFields = 18;
  static const double logoMarginVertical = 26;

  // ============ SOMBRAS ============
  static const BoxShadow loginPanelShadow = BoxShadow(
    color: Color.fromRGBO(7, 61, 43, 0.12),
    blurRadius: 42,
    offset: Offset(-22, 0),
  );

  static const BoxShadow buttonShadow = BoxShadow(
    color: Color.fromRGBO(7, 61, 43, 0.24),
    blurRadius: 28,
    offset: Offset(0, 16),
  );

  static const BoxShadow focusInputShadow = BoxShadow(
    color: Color.fromRGBO(85, 168, 32, 0.13),
    blurRadius: 0,
    spreadRadius: 4,
  );

  // ============ DECORACIONES ============
  static BoxDecoration inputDecoration(bool isFocused) {
    return BoxDecoration(
      color: isFocused ? white : cardBackground,
      border: Border.all(
        color: isFocused ? primaryGreen : borderGrey,
        width: 1,
      ),
      borderRadius: BorderRadius.circular(borderRadius),
      boxShadow: isFocused
          ? const [focusInputShadow]
          : null,
    );
  }

  static BoxDecoration buttonDecoration = BoxDecoration(
    gradient: const LinearGradient(
      colors: [darkGreen, primaryGreen],
      begin: Alignment.topLeft,
      end: Alignment.bottomRight,
      transform: GradientRotation(135 * 3.14159 / 180),
    ),
    borderRadius: BorderRadius.circular(borderRadius),
    boxShadow: const [buttonShadow],
  );

  static BoxDecoration loginPanelDecoration = const BoxDecoration(
    color: white,
    boxShadow: [loginPanelShadow],
  );

  static BoxDecoration carouselDecoration = const BoxDecoration(
    color: darkGreen,
  );

  static BoxDecoration passwordToggleDecoration = BoxDecoration(
    color: Colors.transparent,
    borderRadius: BorderRadius.circular(borderRadius),
  );

  // ============ ANIMACIONES ============
  static const Duration fadeUpDuration = Duration(milliseconds: 720);
  static const Duration transitionDuration = Duration(milliseconds: 200);
  
  static const List<int> animationDelays = [90, 190, 290, 390, 490, 590];

  // ============ BREAKPOINTS RESPONSIVE ============
  static const double mobileBreakpoint = 600;
  static const double tabletPortraitBreakpoint = 900;
  static const double tabletLandscapeBreakpoint = 1200;
  static const double desktopBreakpoint = 1200;
  static const double largeDesktopBreakpoint = 1440;
}
