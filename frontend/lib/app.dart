import 'package:flutter/material.dart';
import 'autenticacion/auth_layout.dart';
import 'autenticacion/login.dart';
import 'autenticacion/restablecer-password.dart';
import 'autenticacion/codigo-verificacion.dart';
import 'autenticacion/cambiar-password.dart';
import 'autenticacion/password-confirmacion.dart';
import 'admin/panel-admin.dart';
import 'admin/recomendaciones.dart';
import 'agricultor/panel-agricultor.dart';
import 'agricultor/boton-iot.dart';
import 'agricultor/historial/historial.dart';

/// Clase que centraliza la definición de todas las rutas de la aplicación
/// Proporciona acceso a las rutas y un mapa de rutas para la navegación
class AppRoutes {
  // ============ RUTAS DE AUTENTICACIÓN ============
  static const String login = '/login';
  static const String restablecerPassword = '/restablecer-password';
  static const String codigoVerificacion = '/codigo-verificacion';
  static const String cambiarPassword = '/cambiar-password';
  static const String passwordConfirmacion = '/password-confirmacion';

  // ============ RUTAS DE LA APLICACIÓN ============
  static const String panelAdmin = '/panel-admin';
  static const String panelAdminRecomendaciones = '/panel-admin/recomendaciones';
  static const String botonIOT = '/boton-iot';
  static const String panelAgricultor = '/panel-agricultor';
  static const String historial = '/historial';

  static void _irAlLogin(BuildContext context) {
    Navigator.pushReplacementNamed(context, login);
  }

  // ============ MAPA DE RUTAS ============
  static Map<String, WidgetBuilder> get routes => {
        login: (context) => const LoginScreen(),
        restablecerPassword: (context) => AuthLayout(
              child: RestablecerPassword(
                volverLogin: () => _irAlLogin(context),
              ),
            ),
        codigoVerificacion: (context) {
          final correo = ModalRoute.of(context)?.settings.arguments as String? ?? '';
          return AuthLayout(
            child: CodigoVerificacion(
              correo: correo,
              onCodigoVerificado: () {
                Navigator.pushNamed(context, cambiarPassword);
              },
              onReenviarCodigo: () {
                debugPrint('Reenviando código de verificación a: $correo');
              },
              onCambiarCorreo: () => Navigator.pop(context),
              onVolverLogin: () => _irAlLogin(context),
            ),
          );
        },
        cambiarPassword: (context) => AuthLayout(
              child: CambiarPassword(
                onPasswordCambiado: () {
                  Navigator.pushReplacementNamed(context, passwordConfirmacion);
                },
                onVolverLogin: () => _irAlLogin(context),
              ),
            ),
        passwordConfirmacion: (context) => AuthLayout(
              child: PasswordConfirmacion(
                onVolverLogin: () => _irAlLogin(context),
              ),
            ),
        panelAdmin: (context) => const PanelAdmin(),
        panelAdminRecomendaciones: (context) => const Recomendaciones(),
        botonIOT: (context) => const BotonIOT(isFullScreen: true),
        panelAgricultor: (context) => const PanelAgricultor(),
        historial: (context) => const Historial(),
      };
}
