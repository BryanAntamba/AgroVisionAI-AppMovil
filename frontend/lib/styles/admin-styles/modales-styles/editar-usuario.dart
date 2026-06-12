import 'package:flutter/material.dart';
import '../panel-admin.dart';

class EditarUsuarioStyles {
  // Colores
  static const Color overlayColor = Color.fromRGBO(7, 61, 43, 0.45);
  static const Color errorColor = Color(0xFFD32F2F);
  static const Color errorBorderColor = Color(0xFFE57373);

  // Modal container
  static const double maxWidth = 760;
  static const EdgeInsets modalMargin = EdgeInsets.all(24);
  static final BoxDecoration modalDecoration = BoxDecoration(
    color: Colors.white,
    border: Border.all(color: PanelAdminStyles.borderGrey),
    borderRadius: BorderRadius.circular(8),
    boxShadow: const [
      BoxShadow(
        color: Color.fromRGBO(7, 61, 43, 0.2),
        blurRadius: 48,
        offset: Offset(0, 24),
      ),
    ],
  );

  // Header
  static const EdgeInsets headerPadding = EdgeInsets.fromLTRB(28, 28, 28, 0);
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

  // Form
  static const EdgeInsets formPadding = EdgeInsets.symmetric(horizontal: 28);
  static const double fieldSpacing = 18;
  static const double columnSpacing = 16;

  // Text field
  static const double minFieldHeight = 103;
  static const TextStyle labelText = TextStyle(
    fontSize: 13,
    fontWeight: FontWeight.w800,
    color: PanelAdminStyles.darkGreen,
  );
  static const double labelSpacing = 8;
  static const double inputHeight = 54;
  static final BoxDecoration inputDecoration = BoxDecoration(
    color: PanelAdminStyles.backgroundInput,
    border: Border.all(color: PanelAdminStyles.borderGrey),
    borderRadius: BorderRadius.circular(8),
  );
  static BoxDecoration inputErrorDecoration = BoxDecoration(
    color: PanelAdminStyles.backgroundInput,
    border: Border.all(color: errorBorderColor, width: 1.5),
    borderRadius: BorderRadius.circular(8),
  );
  static const double iconContainerWidth = 48;
  static const Color iconColor = PanelAdminStyles.primaryGreen;
  static const double iconSize = 16;
  static const TextStyle inputTextStyle = TextStyle(
    color: PanelAdminStyles.darkGreen,
    fontSize: 14,
  );
  static const EdgeInsets inputContentPadding = EdgeInsets.symmetric(vertical: 16);

  // Error text
  static const double errorSpacing = 6;
  static const TextStyle errorText = TextStyle(
    color: errorColor,
    fontSize: 12,
    fontWeight: FontWeight.w600,
  );

  // Password field
  static const double passwordToggleWidth = 46;
  static const double passwordIconSize = 16;

  // Rol field
  static const TextStyle rolLabelText = TextStyle(
    fontSize: 14,
    fontWeight: FontWeight.w700,
    color: PanelAdminStyles.darkGreen,
  );
  static const double rolSpacing = 12;
  static final BoxDecoration rolOptionDecoration = BoxDecoration(
    color: PanelAdminStyles.backgroundInput,
    border: Border.all(color: PanelAdminStyles.borderGrey),
    borderRadius: BorderRadius.circular(8),
  );
  static BoxDecoration rolOptionErrorDecoration = BoxDecoration(
    color: PanelAdminStyles.backgroundInput,
    border: Border.all(color: errorBorderColor, width: 1.5),
    borderRadius: BorderRadius.circular(8),
  );
  static const double rolOptionHeight = 54;
  static const EdgeInsets rolOptionPadding = EdgeInsets.symmetric(horizontal: 16);
  static const Color radioActiveColor = PanelAdminStyles.primaryGreen;
  static const double radioSpacing = 4;
  static const TextStyle rolOptionText = TextStyle(
    fontSize: 14,
    fontWeight: FontWeight.w700,
    color: PanelAdminStyles.darkGreen,
  );

  // Footer
  static const EdgeInsets footerPadding = EdgeInsets.fromLTRB(28, 16, 28, 24);
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

  // Submit button
  static const EdgeInsets submitButtonPadding = EdgeInsets.symmetric(horizontal: 22);
  static final BoxDecoration submitButtonDecoration = PanelAdminStyles.createBtnDecoration;
  static const TextStyle submitButtonText = TextStyle(
    color: Colors.white,
    fontSize: 16,
    fontWeight: FontWeight.w800,
  );

  // Responsive
  static const double mobileBreakpoint = 700;
}
