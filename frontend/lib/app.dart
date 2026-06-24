import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
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

/// Centraliza la definicion de todas las rutas de la aplicacion.
class AppRoutes {
  // ============ RUTAS DE AUTENTICACION ============
  static const String login = '/login';
  static const String restablecerPassword = '/restablecer-password';
  static const String codigoVerificacion = '/codigo-verificacion';
  static const String cambiarPassword = '/cambiar-password';
  static const String passwordConfirmacion = '/password-confirmacion';

  // ============ RUTAS DE LA APLICACION ============
  static const String panelAdmin = '/panel-admin';
  static const String panelAdminRecomendaciones = '/panel-admin/recomendaciones';
  static const String botonIOT = '/boton-iot';
  static const String panelAgricultor = '/panel-agricultor';
  static const String historial = '/historial';

  /// Limpia toda la pila y deja solo el login como pantalla activa.
  static void irAlLogin(BuildContext context) {
    Navigator.pushNamedAndRemoveUntil(context, login, (route) => false);
  }

  /// Navega a restablecer contrasena recreando el formulario vacio.
  static void irARestablecerPassword(BuildContext context) {
    Navigator.pushReplacementNamed(
      context,
      restablecerPassword,
      arguments: DateTime.now().millisecondsSinceEpoch,
    );
  }

  /// Cierra la aplicacion (boton/gesto atras del sistema en login).
  static void cerrarApp() {
    SystemNavigator.pop();
  }

  /// Intercepta el boton atras del sistema y redirige al login.
  static Widget _authConRetrocesoAlLogin({
    required BuildContext context,
    required Widget child,
  }) {
    return PopScope(
      canPop: false,
      onPopInvokedWithResult: (didPop, _) {
        if (!didPop) irAlLogin(context);
      },
      child: AuthLayout(child: child),
    );
  }

  /// Intercepta el boton atras del sistema y redirige a otra ruta de auth.
  static Widget _authConRetrocesoARuta({
    required BuildContext context,
    required String ruta,
    required Widget child,
  }) {
    return PopScope(
      canPop: false,
      onPopInvokedWithResult: (didPop, _) {
        if (!didPop) {
          if (ruta == restablecerPassword) {
            irARestablecerPassword(context);
          } else {
            Navigator.pushReplacementNamed(context, ruta);
          }
        }
      },
      child: AuthLayout(child: child),
    );
  }

  static Widget _loginConRetrocesoCerrarApp() {
    return PopScope(
      canPop: false,
      onPopInvokedWithResult: (didPop, _) {
        if (!didPop) cerrarApp();
      },
      child: const LoginScreen(),
    );
  }

  static Map<String, dynamic>? _argumentosCodigo(Object? args) {
    if (args is Map<String, dynamic>) return args;
    if (args is Map) {
      return Map<String, dynamic>.from(args);
    }
    return null;
  }

  // ============ MAPA DE RUTAS ============
  static Map<String, WidgetBuilder> get routes => {
        login: (context) => _loginConRetrocesoCerrarApp(),
        restablecerPassword: (context) {
          final resetKey = ModalRoute.of(context)?.settings.arguments;
          return PopScope(
            canPop: false,
            onPopInvokedWithResult: (didPop, _) {
              if (!didPop) irAlLogin(context);
            },
            child: AuthLayout(
              child: RestablecerPassword(
                key: ValueKey('restablecer-$resetKey'),
                volverLogin: () => irAlLogin(context),
              ),
            ),
          );
        },
        codigoVerificacion: (context) {
          final args = ModalRoute.of(context)?.settings.arguments;
          final argumentos = _argumentosCodigo(args);
          final correo = argumentos?['correo'] as String? ??
              (args is String ? args : '');
          final instanciaKey = argumentos?['instancia'];
          return _authConRetrocesoARuta(
            context: context,
            ruta: restablecerPassword,
            child: CodigoVerificacion(
              key: ValueKey('codigo-$instanciaKey-$correo'),
              correo: correo,
              onCodigoVerificado: () {
                Navigator.pushReplacementNamed(
                  context,
                  cambiarPassword,
                  arguments: DateTime.now().millisecondsSinceEpoch,
                );
              },
              onReenviarCodigo: () {
                debugPrint('Reenviando codigo de verificacion a: $correo');
              },
              onCambiarCorreo: () => irARestablecerPassword(context),
              onVolverLogin: () => irAlLogin(context),
            ),
          );
        },
        cambiarPassword: (context) {
          final resetKey = ModalRoute.of(context)?.settings.arguments;
          return _authConRetrocesoAlLogin(
            context: context,
            child: CambiarPassword(
              key: ValueKey('cambiar-$resetKey'),
              onPasswordCambiado: () {
                Navigator.pushReplacementNamed(
                  context,
                  passwordConfirmacion,
                  arguments: DateTime.now().millisecondsSinceEpoch,
                );
              },
              onVolverLogin: () => irAlLogin(context),
            ),
          );
        },
        passwordConfirmacion: (context) {
          final resetKey = ModalRoute.of(context)?.settings.arguments;
          return _authConRetrocesoAlLogin(
            context: context,
            child: PasswordConfirmacion(
              key: ValueKey('confirmacion-$resetKey'),
              onVolverLogin: () => irAlLogin(context),
            ),
          );
        },
        panelAdmin: (context) => const PanelAdmin(),
        panelAdminRecomendaciones: (context) => const Recomendaciones(),
        botonIOT: (context) => const BotonIOT(isFullScreen: true),
        panelAgricultor: (context) => const PanelAgricultor(),
        historial: (context) => const Historial(),
      };
}
