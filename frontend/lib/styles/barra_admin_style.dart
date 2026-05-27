import 'package:flutter/material.dart';
import 'app_colors.dart';
import 'formulario_autenticacion_style.dart';

/// Estilos de barra-admin (barra-admin.css).
class BarraAdminStyle {
  BarraAdminStyle._();

  static const double navbarHeight = 72;
  static const double brandLogoSize = 42;

  static BoxDecoration navbarDecoration = BoxDecoration(
    color: AppColors.cardBackground,
    border: const Border(bottom: BorderSide(color: AppColors.borderLight)),
    boxShadow: [
      BoxShadow(
        color: AppColors.primaryDark.withValues(alpha: 0.12),
        blurRadius: 24,
        offset: const Offset(0, 10),
      ),
    ],
    gradient: RadialGradient(
      center: Alignment.topRight,
      radius: 0.34,
      colors: [
        AppColors.primaryGreen.withValues(alpha: 0.2),
        Colors.transparent,
      ],
    ),
  );

  static TextStyle brandText = const TextStyle(
    fontFamily: AuthFormStyle.fontFamily,
    fontSize: 22,
    fontWeight: FontWeight.w800,
    color: AppColors.primaryDark,
  );

  static BoxDecoration logoutButtonDecoration = BoxDecoration(
    gradient: AppColors.primaryGradient,
    borderRadius: BorderRadius.circular(8),
    boxShadow: [
      BoxShadow(
        color: AppColors.primaryDark.withValues(alpha: 0.24),
        blurRadius: 28,
        offset: const Offset(0, 16),
      ),
    ],
  );
}
