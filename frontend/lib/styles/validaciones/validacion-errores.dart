import 'package:flutter/material.dart';

class ValidacionErroresStyles {
  static const Color errorColor = Color(0xFFC92B2B);

  static const EdgeInsets errorPadding = EdgeInsets.only(top: 7);

  static const TextStyle errorText = TextStyle(
    color: errorColor,
    fontSize: 13,
    fontWeight: FontWeight.w700,
  );

  static const TextStyle modalErrorText = errorText;

  static const Duration inputTransitionDuration = Duration(milliseconds: 180);
  static const Curve inputTransitionCurve = Curves.ease;

  static Widget errorMessage(String? message) {
    if (message == null || message.isEmpty) {
      return const SizedBox.shrink();
    }

    return Padding(
      padding: errorPadding,
      child: Text(message, style: errorText),
    );
  }

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
