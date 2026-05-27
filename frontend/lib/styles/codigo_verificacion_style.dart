import 'package:flutter/material.dart';
import 'formulario_autenticacion_style.dart';
import 'restablecer_password_style.dart';

/// Estilos de codigo-verificacion (codigo-verificacion.css).
class CodigoVerificacionStyle {
  CodigoVerificacionStyle._();

  static const double logoWidth = 156;

  static BoxDecoration pageBackground = RestablecerPasswordStyle.pageBackground;

  static TextStyle title = AuthFormStyle.fieldTitle;

  static TextStyle description = RestablecerPasswordStyle.description;

  static TextStyle codeInput = const TextStyle(
    fontFamily: AuthFormStyle.fontFamily,
    fontSize: 24,
    fontWeight: FontWeight.w800,
    color: Color(0xFF073D2B),
  );
}
