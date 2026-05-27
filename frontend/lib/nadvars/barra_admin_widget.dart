import 'package:flutter/material.dart';
import '../app/app.dart';
import '../styles/barra_admin_style.dart';

class BarraAdminWidget extends StatelessWidget {
  const BarraAdminWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      height: BarraAdminStyle.navbarHeight,
      padding: const EdgeInsets.symmetric(horizontal: 28, vertical: 10),
      decoration: BarraAdminStyle.navbarDecoration,
      child: Row(
        children: [
          GestureDetector(
            onTap: () =>
                Navigator.pushReplacementNamed(context, AgroVisionApp.routePanelAdmin),
            child: Row(
              children: [
                Image.asset(
                  'assets/logotipos/escudo.png',
                  width: BarraAdminStyle.brandLogoSize,
                  height: BarraAdminStyle.brandLogoSize,
                  errorBuilder: (_, __, ___) => const Icon(
                    Icons.eco,
                    color: Color(0xFF55A820),
                    size: 42,
                  ),
                ),
                const SizedBox(width: 8),
                Text('Admin', style: BarraAdminStyle.brandText),
              ],
            ),
          ),
          const Spacer(),
          DecoratedBox(
            decoration: BarraAdminStyle.logoutButtonDecoration,
            child: Material(
              color: Colors.transparent,
              child: InkWell(
                borderRadius: BorderRadius.circular(8),
                onTap: () {
                  Navigator.of(context).pushNamedAndRemoveUntil(
                    AgroVisionApp.routeLogin,
                    (route) => false,
                  );
                },
                child: const Padding(
                  padding: EdgeInsets.symmetric(horizontal: 18, vertical: 10),
                  child: Text(
                    'Cerrar Sesion',
                    style: TextStyle(
                      color: Colors.white,
                      fontWeight: FontWeight.w800,
                      fontSize: 16,
                    ),
                  ),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
