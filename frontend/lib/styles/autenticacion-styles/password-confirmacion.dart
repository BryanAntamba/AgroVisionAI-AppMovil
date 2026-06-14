import 'package:flutter/material.dart';

class PasswordConfirmacionStyles {
  // Colores base
  static const Color darkGreen = Color(0xFF073D2B);
  static const Color linkGreen = Color(0xFF0B5A3D);
  static const Color primaryGreen = Color(0xFF55A820);

  // Tipografía
  static const TextStyle heading1 = TextStyle(
    color: darkGreen,
    fontSize: 31,
    fontWeight: FontWeight.w700,
    height: 1.15,
  );

  static const TextStyle description = TextStyle(
    color: linkGreen,
    fontSize: 15,
    fontWeight: FontWeight.w800,
    height: 1.45,
  );

  static const TextStyle confirmationLink = TextStyle(
    color: linkGreen,
    fontSize: 16,
    fontWeight: FontWeight.w800,
  );

  // ============ ANIMACIONES ============
  static const Duration fadeUpDuration = Duration(milliseconds: 720);
  static const Duration transitionDuration = Duration(milliseconds: 200);
  static const List<int> animationDelays = [90, 190, 290, 390];
}
