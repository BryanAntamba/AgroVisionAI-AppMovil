import 'package:flutter/material.dart';

class AnimacionesAutenticacion {
  // Duraciones
  static const Duration fadeUpDuration = Duration(milliseconds: 720);
  static const Duration swapViewDuration = Duration(milliseconds: 520);
  static const Duration hoverDuration = Duration(milliseconds: 180);
  static const Duration feedbackEntranceDuration = Duration(milliseconds: 360);
  static const Duration resendLimitShakeDuration = Duration(milliseconds: 420);

  // Delays escalonados para listas o elementos
  static Duration getDelay(int index) {
    return Duration(milliseconds: 90 + (index - 1) * 100);
  }

  // Curvas
  static const Curve defaultCurve = Curves.ease;
}
