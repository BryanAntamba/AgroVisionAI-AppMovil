import 'package:flutter/material.dart';
import '../styles/autenticacion-styles/login.dart';

/// Layout responsivo compartido por todas las pantallas de autenticación.
class AuthLayout extends StatelessWidget {
  final Widget child;

  const AuthLayout({super.key, required this.child});

  @override
  Widget build(BuildContext context) {
    final screenWidth = MediaQuery.of(context).size.width;

    final bool isMobile = screenWidth < 600;
    final bool isTabletPortrait = screenWidth >= 600 && screenWidth < 900;
    final bool isTabletLandscape = screenWidth >= 900 && screenWidth < 1200;

    double loginPanelWidth;
    if (isMobile) {
      loginPanelWidth = screenWidth;
    } else if (isTabletPortrait) {
      loginPanelWidth = screenWidth;
    } else if (isTabletLandscape) {
      loginPanelWidth = 540;
    } else {
      loginPanelWidth = screenWidth > 1440 ? 540 : 440;
    }

    double horizontalPadding;
    double verticalPadding;

    if (isMobile) {
      horizontalPadding = 24;
      verticalPadding = 32;
    } else if (isTabletPortrait) {
      horizontalPadding = 48;
      verticalPadding = 48;
    } else if (isTabletLandscape) {
      horizontalPadding = 40;
      verticalPadding = 8;
    } else {
      horizontalPadding = 64;
      verticalPadding = 64;
    }

    return Scaffold(
      backgroundColor: LoginStyles.backgroundLight,
      body: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          Container(
            width: loginPanelWidth,
            decoration: LoginStyles.loginPanelDecoration,
            padding: EdgeInsets.symmetric(
              horizontal: horizontalPadding,
              vertical: verticalPadding,
            ),
            child: Center(
              child: SingleChildScrollView(
                child: ConstrainedBox(
                  constraints: BoxConstraints(
                    maxWidth: isTabletLandscape ? 360 : 430,
                  ),
                  child: child,
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
