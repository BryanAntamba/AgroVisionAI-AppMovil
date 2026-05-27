import 'package:flutter/material.dart';
import 'app_colors.dart';
import 'formulario_autenticacion_style.dart';

/// Estilos de panel-agricultor (panel-agricultor.css).
class PanelAgricultorStyle {
  PanelAgricultorStyle._();

  static BoxDecoration pageDecoration = const BoxDecoration(
    gradient: AppColors.farmerPanelGradient,
  );

  static BoxDecoration contentCard = BoxDecoration(
    color: AppColors.cardBackground,
    borderRadius: BorderRadius.circular(8),
    border: Border.all(color: AppColors.border),
    boxShadow: [
      BoxShadow(
        color: AppColors.primaryDark.withValues(alpha: 0.16),
        blurRadius: 34,
        offset: const Offset(0, 18),
      ),
    ],
  );

  static TextStyle eyebrow = const TextStyle(
    fontFamily: AuthFormStyle.fontFamily,
    fontWeight: FontWeight.w800,
    letterSpacing: 0.08 * 16,
    color: AppColors.primaryGreen,
  );

  static TextStyle title = const TextStyle(
    fontFamily: AuthFormStyle.fontFamily,
    fontSize: 36,
    fontWeight: FontWeight.w700,
    color: AppColors.primaryDark,
  );

  static TextStyle body = const TextStyle(
    fontFamily: AuthFormStyle.fontFamily,
    fontSize: 18,
    height: 1.5,
    color: AppColors.primaryDark,
  );
}
