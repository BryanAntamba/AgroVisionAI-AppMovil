import 'package:flutter/material.dart';

class PanelAdminStyles {
  // ─── Colores ───────────────────────────────────────────────────────────────
  static const Color darkGreen       = Color(0xFF073D2B);
  static const Color primaryGreen    = Color(0xFF55A820);
  static const Color textGreen       = Color(0xFF456657);
  static const Color linkGreen       = Color(0xFF0B5A3D);
  static const Color backgroundPage  = Color(0xFFF5FAF3);
  static const Color backgroundWhite = Color(0xFFFFFFFF);
  static const Color backgroundInput = Color(0xFFFBFDF9);
  static const Color borderGrey      = Color(0xFFD7E4DC);
  static const Color borderInput     = Color(0xFFC8D8CE);
  static const Color subtext         = Color(0xFF597268);
  static const Color dtColor         = Color(0xFF6B8177);

  // Badges
  static const Color roleBg      = Color(0xFFE9F2FF);
  static const Color roleText    = Color(0xFF174C7C);
  static const Color activeBg    = Color(0xFFEAF7E5);
  static const Color activeText  = Color(0xFF23730F);
  static const Color inactiveBg  = Color(0xFFF5EEEE);
  static const Color inactiveText= Color(0xFF9A2424);
  static const Color deviceLinkedBg     = Color(0xFFE0F2F7);
  static const Color deviceLinkedText   = Color(0xFF0277BD);
  static const Color deviceUnlinkedBg   = Color(0xFFFFF3E0);
  static const Color deviceUnlinkedText = Color(0xFFE65100);

  // Botón danger
  static const Color dangerBorder = Color(0xFFF0C8C8);
  static const Color dangerText   = Color(0xFFA32626);

  // ─── Tipografía ────────────────────────────────────────────────────────────
  static const TextStyle eyebrowText = TextStyle(
    color: primaryGreen,
    fontSize: 13,
    fontWeight: FontWeight.w800,
    letterSpacing: 1.0,
  );

  static const TextStyle h1Text = TextStyle(
    color: darkGreen,
    fontSize: 34,
    fontWeight: FontWeight.w800,
    height: 1.15,
  );

  static const TextStyle headerDesc = TextStyle(
    color: textGreen,
    fontSize: 15,
    height: 1.4,
  );

  static const TextStyle labelText = TextStyle(
    color: darkGreen,
    fontSize: 13,
    fontWeight: FontWeight.w800,
  );

  static const TextStyle summaryNumber = TextStyle(
    color: linkGreen,
    fontSize: 26,
    fontWeight: FontWeight.w800,
  );

  static const TextStyle summaryLabel = TextStyle(
    color: darkGreen,
    fontSize: 14,
    fontWeight: FontWeight.w700,
  );

  static const TextStyle cardName = TextStyle(
    color: darkGreen,
    fontSize: 18,
    fontWeight: FontWeight.w800,
  );

  static const TextStyle cardEmail = TextStyle(
    color: subtext,
    fontSize: 14,
  );

  static const TextStyle badgeText = TextStyle(
    fontSize: 12,
    fontWeight: FontWeight.w800,
  );

  static const TextStyle dtText = TextStyle(
    color: dtColor,
    fontSize: 12,
    fontWeight: FontWeight.w800,
  );

  static const TextStyle ddText = TextStyle(
    color: darkGreen,
    fontSize: 14,
    fontWeight: FontWeight.w700,
  );

  static const TextStyle actionBtnText = TextStyle(
    color: darkGreen,
    fontSize: 13,
    fontWeight: FontWeight.w800,
  );

  static const TextStyle emptyStateText = TextStyle(
    color: textGreen,
    fontSize: 15,
  );

  // ─── Decoraciones ──────────────────────────────────────────────────────────
  static BoxDecoration cardDecoration = BoxDecoration(
    color: backgroundWhite,
    border: Border.all(color: borderGrey),
    borderRadius: BorderRadius.circular(8),
  );

  static BoxDecoration filterBarDecoration = BoxDecoration(
    color: backgroundWhite,
    border: Border.all(color: borderGrey),
    borderRadius: BorderRadius.circular(8),
  );

  static BoxDecoration summaryCardDecoration = BoxDecoration(
    color: backgroundWhite,
    border: Border.all(color: borderGrey),
    borderRadius: BorderRadius.circular(8),
  );

  static BoxDecoration inputDecoration({bool focused = false}) => BoxDecoration(
    color: focused ? backgroundWhite : backgroundInput,
    border: Border.all(color: focused ? primaryGreen : borderInput),
    borderRadius: BorderRadius.circular(8),
    boxShadow: focused
        ? [BoxShadow(color: primaryGreen.withValues(alpha: 0.13), blurRadius: 0, spreadRadius: 4)]
        : null,
  );

  static BoxDecoration avatarDecoration = const BoxDecoration(
    color: darkGreen,
    borderRadius: BorderRadius.all(Radius.circular(8)),
  );

  static BoxDecoration createBtnDecoration = BoxDecoration(
    gradient: const LinearGradient(
      colors: [darkGreen, primaryGreen],
      begin: Alignment.topLeft,
      end: Alignment.bottomRight,
    ),
    borderRadius: BorderRadius.circular(8),
  );

  static BoxDecoration accessPanelDecoration = BoxDecoration(
    gradient: const LinearGradient(
      colors: [darkGreen, primaryGreen],
      begin: Alignment.topLeft,
      end: Alignment.bottomRight,
    ),
    borderRadius: BorderRadius.circular(8),
  );

  static BoxDecoration actionBtnDecoration = BoxDecoration(
    color: backgroundInput,
    border: Border.all(color: borderGrey),
    borderRadius: BorderRadius.circular(8),
  );

  static BoxDecoration dangerBtnDecoration = BoxDecoration(
    color: backgroundInput,
    border: Border.all(color: dangerBorder),
    borderRadius: BorderRadius.circular(8),
  );
}
