import 'package:flutter/material.dart';
import 'app_colors.dart';

/// Estilos compartidos de formularios (shell de inputs, botones, errores).
class AuthFormStyle {
  AuthFormStyle._();

  static const String fontFamily = 'Arial';

  static TextStyle label({double size = 14}) => TextStyle(
        fontFamily: fontFamily,
        fontSize: size,
        fontWeight: FontWeight.w700,
        color: AppColors.primaryDark,
      );

  static TextStyle errorText = const TextStyle(
    fontFamily: fontFamily,
    fontSize: 13,
    fontWeight: FontWeight.w700,
    color: AppColors.error,
  );

  static TextStyle fieldTitle = const TextStyle(
    fontFamily: fontFamily,
    fontSize: 31,
    height: 1.15,
    fontWeight: FontWeight.w700,
    color: AppColors.primaryDark,
  );

  static BoxDecoration inputShellDecoration({bool focused = false}) =>
      BoxDecoration(
        color: focused ? AppColors.cardBackground : AppColors.inputBackground,
        borderRadius: BorderRadius.circular(8),
        border: Border.all(
          color: focused ? AppColors.primaryGreen : AppColors.border,
        ),
        boxShadow: focused
            ? [
                BoxShadow(
                  color: AppColors.primaryGreen.withValues(alpha: 0.13),
                  blurRadius: 0,
                  spreadRadius: 4,
                ),
              ]
            : null,
      );

  static BoxDecoration submitButtonDecoration = BoxDecoration(
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

  static ButtonStyle submitButtonStyle = ElevatedButton.styleFrom(
    minimumSize: const Size.fromHeight(54),
    backgroundColor: Colors.transparent,
    shadowColor: Colors.transparent,
    foregroundColor: Colors.white,
    shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8)),
    textStyle: const TextStyle(
      fontFamily: fontFamily,
      fontSize: 16,
      fontWeight: FontWeight.w800,
    ),
  );

  static TextStyle linkButton = const TextStyle(
    fontFamily: fontFamily,
    fontWeight: FontWeight.w700,
    color: AppColors.primaryGreenDark,
  );
}

