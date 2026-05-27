import 'package:flutter/material.dart';
import '../autenticacion/login.dart';
import '../autenticacion/restablecer_password.dart';
import '../autenticacion/codigo_verificacion.dart';
import '../autenticacion/cambiar_password.dart';
import '../admin/panel_admin.dart';
import '../agricultor/panel_agricultor.dart';
import '../styles/app_colors.dart';

class AgroVisionApp extends StatelessWidget {
  const AgroVisionApp({super.key});

  static const String routeLogin = '/login';
  static const String routeRestablecerPassword = '/restablecer-password';
  static const String routeCodigoVerificacion = '/codigo-verificacion';
  static const String routeCambiarPassword = '/cambiar-password';
  static const String routePanelAdmin = '/panel-admin';
  static const String routePanelAgricultor = '/panel-agricultor';

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'AgroVision AI',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        fontFamily: 'Arial',
        colorScheme: ColorScheme.fromSeed(seedColor: AppColors.primaryGreen),
        scaffoldBackgroundColor: AppColors.pageBackground,
      ),
      initialRoute: routeLogin,
      routes: {
        routeLogin: (_) => const LoginScreen(),
        routeRestablecerPassword: (_) => const RestablecerPasswordScreen(),
        routeCodigoVerificacion: (ctx) {
          final correo =
              ModalRoute.of(ctx)?.settings.arguments as String? ?? '';
          return CodigoVerificacionScreen(correo: correo);
        },
        routeCambiarPassword: (_) => const CambiarPasswordScreen(),
        routePanelAdmin: (_) => const PanelAdminScreen(),
        routePanelAgricultor: (_) => const PanelAgricultorScreen(),
      },
    );
  }
}
