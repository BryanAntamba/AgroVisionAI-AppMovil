import 'package:flutter/material.dart';
import 'formulario_autenticacion_style.dart';
import 'app_colors.dart';

/// Estilos de restablecer-password (restablecer-password.css).
class RestablecerPasswordStyle {
  RestablecerPasswordStyle._();

  static const double logoWidth = 156;

  static BoxDecoration pageBackground = const BoxDecoration(
    color: AppColors.pageBackground,
    gradient: RadialGradient(
      center: Alignment.topLeft,
      radius: 1.1,
      colors: [
        Color(0xFFEAF7E5),
        AppColors.pageBackground,
      ],
    ),
  );

  static TextStyle title = AuthFormStyle.fieldTitle;

  static TextStyle description = const TextStyle(
    fontFamily: AuthFormStyle.fontFamily,
    fontSize: 15,
    fontWeight: FontWeight.w700,
    height: 1.45,
    color: Color(0xFF0B5A3D),
  );
}
