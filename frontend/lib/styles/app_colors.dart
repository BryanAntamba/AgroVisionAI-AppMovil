import 'package:flutter/material.dart';

/// Paleta compartida migrada desde los estilos CSS de Angular.
class AppColors {
  AppColors._();

  static const Color primaryDark = Color(0xFF073D2B);
  static const Color primaryGreen = Color(0xFF55A820);
  static const Color primaryGreenDark = Color(0xFF0B5A3D);
  static const Color pageBackground = Color(0xFFF7FBF5);
  static const Color dashboardBackground = Color(0xFFF5FAF3);
  static const Color cardBackground = Color(0xFFFFFFFF);
  static const Color inputBackground = Color(0xFFFBFDF9);
  static const Color border = Color(0xFFC8D8CE);
  static const Color borderLight = Color(0xFFD7E4DC);
  static const Color textMuted = Color(0xFF456657);
  static const Color textSoft = Color(0xFF597268);
  static const Color placeholder = Color(0xFF7D9186);
  static const Color labelMuted = Color(0xFF6B8177);
  static const Color error = Color(0xFFC92B2B);
  static const Color danger = Color(0xFFA32626);
  static const Color dangerDark = Color(0xFF8B1F1F);
  static const Color badgeRoleBg = Color(0xFFE9F2FF);
  static const Color badgeRoleText = Color(0xFF174C7C);
  static const Color badgeActiveBg = Color(0xFFEAF7E5);
  static const Color badgeActiveText = Color(0xFF23730F);
  static const Color badgeInactiveBg = Color(0xFFF5EEEE);
  static const Color badgeInactiveText = Color(0xFF9A2424);
  static const Color modalBackdrop = Color(0x73073D2B);

  static const LinearGradient primaryGradient = LinearGradient(
    begin: Alignment.topLeft,
    end: Alignment.bottomRight,
    colors: [primaryDark, primaryGreen],
  );

  static const LinearGradient farmerPanelGradient = LinearGradient(
    begin: Alignment.topLeft,
    end: Alignment.bottomRight,
    colors: [Color(0xFFF7FBF5), Color(0xFFDCEFCF)],
  );
}
