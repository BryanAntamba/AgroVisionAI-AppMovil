import 'package:flutter/material.dart';
import 'autenticacion/login.dart';
import 'admin/panel-admin.dart';
import 'admin/recomendaciones.dart';
import 'admin/plataforma-editable.dart';
import 'agricultor/panel-agricultor.dart';
import 'agricultor/boton-iot.dart';
import 'agricultor/historial/historial.dart';

class AppRoutes {
  static const String login = '/login';
  static const String panelAdmin = '/panel-admin';
  static const String panelAdminRecomendaciones = '/panel-admin/recomendaciones';
  static const String panelAdminEditarPlataforma = '/panel-admin/editar-plataforma';
  static const String botonIOT = '/boton-iot';
  static const String panelAgricultor = '/panel-agricultor';
  static const String historial = '/historial';

  static Map<String, WidgetBuilder> get routes => {
        login: (context) => const LoginScreen(),
        panelAdmin: (context) => const PanelAdmin(),
        panelAdminRecomendaciones: (context) => const Recomendaciones(),
        panelAdminEditarPlataforma: (context) => const PlataformaEditable(),
        botonIOT: (context) => const BotonIOT(isFullScreen: true),
        panelAgricultor: (context) => const PanelAgricultor(),
        historial: (context) => const Historial(),
      };
}
