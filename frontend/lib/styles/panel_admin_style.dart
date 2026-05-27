import 'package:flutter/material.dart';
import 'app_colors.dart';
import 'formulario_autenticacion_style.dart';

/// Estilos de panel-admin (panel-admin.css).
class PanelAdminStyle {
  PanelAdminStyle._();

  static const double maxContentWidth = 1220;
  static const double navbarOffset = 72;

  static BoxDecoration dashboardBackground = const BoxDecoration(
    color: AppColors.dashboardBackground,
  );

  static TextStyle eyebrow = const TextStyle(
    fontFamily: AuthFormStyle.fontFamily,
    fontSize: 13,
    fontWeight: FontWeight.w800,
    color: AppColors.primaryGreen,
  );

  static TextStyle pageTitle = const TextStyle(
    fontFamily: AuthFormStyle.fontFamily,
    fontSize: 34,
    height: 1.15,
    fontWeight: FontWeight.w700,
    color: AppColors.primaryDark,
  );

  static TextStyle subtitle = const TextStyle(
    fontFamily: AuthFormStyle.fontFamily,
    color: AppColors.textMuted,
  );

  static BoxDecoration filterBar = BoxDecoration(
    color: AppColors.cardBackground,
    borderRadius: BorderRadius.circular(8),
    border: Border.all(color: AppColors.borderLight),
  );

  static BoxDecoration summaryCard = filterBar;

  static BoxDecoration userCard = filterBar;

  static BoxDecoration avatar = const BoxDecoration(
    color: AppColors.primaryDark,
    borderRadius: BorderRadius.all(Radius.circular(8)),
  );

  static TextStyle avatarText = const TextStyle(
    color: Colors.white,
    fontWeight: FontWeight.w800,
  );

  static TextStyle cardTitle = const TextStyle(
    fontFamily: AuthFormStyle.fontFamily,
    fontSize: 18,
    fontWeight: FontWeight.w700,
    color: AppColors.primaryDark,
  );

  static TextStyle cardEmail = const TextStyle(
    fontFamily: AuthFormStyle.fontFamily,
    fontSize: 14,
    color: AppColors.textSoft,
  );

  static TextStyle detailLabel = const TextStyle(
    fontFamily: AuthFormStyle.fontFamily,
    fontSize: 12,
    fontWeight: FontWeight.w800,
    color: AppColors.labelMuted,
  );

  static TextStyle detailValue = const TextStyle(
    fontFamily: AuthFormStyle.fontFamily,
    fontSize: 14,
    fontWeight: FontWeight.w700,
    color: AppColors.primaryDark,
  );

  static BoxDecoration modalBackdrop = const BoxDecoration(
    color: AppColors.modalBackdrop,
  );

  static BoxDecoration modalCard = BoxDecoration(
    color: AppColors.cardBackground,
    borderRadius: BorderRadius.circular(8),
    border: Border.all(color: AppColors.borderLight),
    boxShadow: [
      BoxShadow(
        color: AppColors.primaryDark.withValues(alpha: 0.2),
        blurRadius: 48,
        offset: const Offset(0, 24),
      ),
    ],
  );

  static TextStyle modalTitle = const TextStyle(
    fontFamily: AuthFormStyle.fontFamily,
    fontSize: 28,
    height: 1.15,
    fontWeight: FontWeight.w700,
    color: AppColors.primaryDark,
  );

  static BoxDecoration modalCloseButton = BoxDecoration(
    color: AppColors.dashboardBackground,
    borderRadius: BorderRadius.circular(8),
  );

  static TextStyle confirmMessage = const TextStyle(
    fontFamily: AuthFormStyle.fontFamily,
    fontSize: 15,
    height: 1.5,
    color: AppColors.textMuted,
  );

  static TextStyle confirmWarning = const TextStyle(
    fontFamily: AuthFormStyle.fontFamily,
    fontSize: 13,
    fontWeight: FontWeight.w700,
    color: AppColors.danger,
  );

  static BoxDecoration deleteButton = BoxDecoration(
    color: AppColors.danger,
    borderRadius: BorderRadius.circular(8),
    boxShadow: [
      BoxShadow(
        color: AppColors.danger.withValues(alpha: 0.24),
        blurRadius: 24,
        offset: const Offset(0, 12),
      ),
    ],
  );

  static BadgeStyle badgeRole = BadgeStyle(
    background: AppColors.badgeRoleBg,
    foreground: AppColors.badgeRoleText,
  );

  static BadgeStyle badgeActive = BadgeStyle(
    background: AppColors.badgeActiveBg,
    foreground: AppColors.badgeActiveText,
  );

  static BadgeStyle badgeInactive = BadgeStyle(
    background: AppColors.badgeInactiveBg,
    foreground: AppColors.badgeInactiveText,
  );
}

class BadgeStyle {
  const BadgeStyle({required this.background, required this.foreground});

  final Color background;
  final Color foreground;
}
