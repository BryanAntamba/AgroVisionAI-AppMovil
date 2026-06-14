import 'package:flutter/material.dart';

/// Estilos compartidos para mensajes de error de validación
/// Usado en todos los formularios de la aplicación (autenticación, modales admin, etc.)
/// 
/// Especificaciones CSS originales:
/// - Color: #c92b2b
/// - Font-size: 13px
/// - Font-weight: 700
/// - Margin-top: 7px
/// - Transiciones: border-color, box-shadow, background 180ms ease
class ValidacionErroresStyles {
  // Color de error (equivalente CSS: color: #c92b2b)
  static const Color errorColor = Color(0xFFC92B2B);

  // Espaciado superior del mensaje (equivalente CSS: margin-top: 7px)
  static const EdgeInsets errorPadding = EdgeInsets.only(top: 7);

  // Estilo de texto para mensajes de error en formularios de autenticación
  // Equivalente CSS: small { font-size: 13px; font-weight: 700; color: #c92b2b; }
  static const TextStyle errorText = TextStyle(
    color: errorColor,
    fontSize: 13,
    fontWeight: FontWeight.w700,
  );

  // Estilo de texto para mensajes de error en modales de admin
  // Equivalente CSS: .modal-fields small { font-size: 13px; font-weight: 700; color: #c92b2b; }
  static const TextStyle modalErrorText = errorText;

  // Duración y curva de transición para inputs
  // Equivalente CSS: transition: border-color 180ms ease, box-shadow 180ms ease, background 180ms ease
  static const Duration inputTransitionDuration = Duration(milliseconds: 180);
  static const Curve inputTransitionCurve = Curves.ease;

  /// Widget helper para mostrar mensaje de error
  /// Retorna un widget vacío si el mensaje es null o vacío
  static Widget errorMessage(String? message) {
    if (message == null || message.isEmpty) {
      return const SizedBox.shrink();
    }

    return Padding(
      padding: errorPadding,
      child: Text(message, style: errorText),
    );
  }

  /// Decoración para inputs con transición de focus
  /// Equivalente CSS: .input-shell con transitions
  /// Aplica border-color, box-shadow y background con transición de 180ms ease
  static BoxDecoration inputShellDecoration({
    required bool focused,
    Color backgroundColor = Colors.white,
    Color borderColor = const Color(0xFFD7E4DC),
    Color focusColor = const Color(0xFF55A820),
  }) {
    final activeColor = focused ? focusColor : borderColor;

    return BoxDecoration(
      color: backgroundColor,
      borderRadius: BorderRadius.circular(8),
      border: Border.all(color: activeColor),
      boxShadow: focused
          ? [
              BoxShadow(
                color: focusColor.withValues(alpha: 0.18),
                blurRadius: 12,
                offset: const Offset(0, 4),
              ),
            ]
          : null,
    );
  }

  /// Widget animado para input shell con transiciones
  /// Equivalente CSS: .input-shell y .modal-input-shell con transitions
  /// Anima border-color, box-shadow y background cuando cambia el estado de focus
  static Widget animatedInputShell({
    required Widget child,
    required bool focused,
    Color backgroundColor = Colors.white,
    Color borderColor = const Color(0xFFD7E4DC),
    Color focusColor = const Color(0xFF55A820),
  }) {
    return AnimatedContainer(
      duration: inputTransitionDuration,
      curve: inputTransitionCurve,
      decoration: inputShellDecoration(
        focused: focused,
        backgroundColor: backgroundColor,
        borderColor: borderColor,
        focusColor: focusColor,
      ),
      child: child,
    );
  }
}
