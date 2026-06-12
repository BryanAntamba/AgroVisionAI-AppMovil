import 'package:flutter/material.dart';
import '../panel-admin.dart';

class EliminarUsuarioStyles {
  // Colores
  static const Color overlayColor = Color.fromRGBO(7, 61, 43, 0.45);
  static const Color textPrimaryColor = Color(0xFF456657);
  static const Color textDarkColor = Color(0xFF073d2b);
  static const Color warningColor = Color(0xFFA32626);
  static const Color deleteButtonColor = Color(0xFFA32626);
  static const Color deleteButtonShadowColor = Color.fromRGBO(163, 38, 38, 0.24);

  // Modal container
  static const double maxWidth = 480;
  static const EdgeInsets modalMargin = EdgeInsets.all(24);
  static const EdgeInsets modalPadding = EdgeInsets.fromLTRB(28, 28, 28, 24);
  static final BoxDecoration modalDecoration = PanelAdminStyles.cardDecoration;

  // Header
  static const TextStyle titleText = TextStyle(
    color: PanelAdminStyles.darkGreen,
    fontSize: 20,
    fontWeight: FontWeight.w800,
  );

  // Close button
  static const double closeButtonSize = 40;
  static final BoxDecoration closeButtonDecoration = BoxDecoration(
    color: PanelAdminStyles.backgroundPage,
    borderRadius: BorderRadius.circular(8),
  );
  static const Color closeIconColor = PanelAdminStyles.darkGreen;
  static const double closeIconSize = 18;

  // Content
  static const double contentSpacing = 14;
  static const TextStyle bodyText = TextStyle(
    color: textPrimaryColor,
    fontSize: 15,
    height: 1.5,
    fontFamily: 'Arial',
  );
  static const TextStyle boldText = TextStyle(
    color: textDarkColor,
    fontWeight: FontWeight.bold,
  );

  // Warning text
  static const double warningSpacing = 12;
  static const TextStyle warningText = TextStyle(
    color: warningColor,
    fontSize: 13,
    fontWeight: FontWeight.w700,
  );

  // Footer
  static const double footerSpacing = 24;
  static const double buttonSpacing = 10;
  static const double minButtonHeight = 54;

  // Cancel button
  static const EdgeInsets cancelButtonPadding = EdgeInsets.symmetric(horizontal: 18);
  static final BoxDecoration cancelButtonDecoration = BoxDecoration(
    color: PanelAdminStyles.backgroundInput,
    border: Border.all(color: PanelAdminStyles.borderGrey),
    borderRadius: BorderRadius.circular(8),
  );
  static const TextStyle cancelButtonText = TextStyle(
    color: PanelAdminStyles.darkGreen,
    fontSize: 16,
    fontWeight: FontWeight.w800,
  );

  // Delete button
  static const EdgeInsets deleteButtonPadding = EdgeInsets.symmetric(horizontal: 22);
  static final BoxDecoration deleteButtonDecoration = BoxDecoration(
    color: deleteButtonColor,
    borderRadius: BorderRadius.circular(8),
    boxShadow: const [
      BoxShadow(
        color: deleteButtonShadowColor,
        blurRadius: 24,
        offset: Offset(0, 12),
      ),
    ],
  );
  static const TextStyle deleteButtonText = TextStyle(
    color: Colors.white,
    fontSize: 16,
    fontWeight: FontWeight.w800,
  );
  static const double deleteIconSize = 16;
  static const double iconTextSpacing = 8;
}
