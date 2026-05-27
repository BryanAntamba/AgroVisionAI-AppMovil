import 'package:flutter/material.dart';
import 'app_colors.dart';
import 'formulario_autenticacion_style.dart';

/// Estilos del componente login (login.css).
class LoginStyle {
  LoginStyle._();

  static const double brandLogoWidth = 150;
  static const double brandLogoWidthMobile = 136;
  static const double loginPanelPaddingH = 52;
  static const double loginPanelPaddingV = 42;
  static const double cardMaxWidth = 430;
  static const double breakpointCarousel = 900;

  static BoxDecoration pageBackground = const BoxDecoration(
    color: AppColors.pageBackground,
  );

  static BoxDecoration loginPanelDecoration = BoxDecoration(
    color: AppColors.cardBackground,
    boxShadow: [
      BoxShadow(
        color: AppColors.primaryDark.withValues(alpha: 0.12),
        blurRadius: 42,
        offset: const Offset(-22, 0),
      ),
    ],
    gradient: RadialGradient(
      center: Alignment.topRight,
      radius: 0.34,
      colors: [
        AppColors.primaryGreen.withValues(alpha: 0.18),
        Colors.transparent,
      ],
    ),
  );

  static BoxDecoration carouselPanelDecoration = const BoxDecoration(
    color: AppColors.primaryDark,
  );

  static TextStyle title = AuthFormStyle.fieldTitle.copyWith(
    fontSize: 31,
  );
}
