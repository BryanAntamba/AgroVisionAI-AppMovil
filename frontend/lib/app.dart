import 'package:flutter/material.dart';
import 'autenticacion/login.dart';
import 'admin/panel-admin.dart';
import 'admin/recomendaciones.dart';
import 'admin/plataforma-editable.dart';
import 'agricultor/panel-agricultor.dart';
import 'agricultor/boton-iot.dart';
import 'agricultor/historial/historial.dart';

/// Clase que centraliza la definición de todas las rutas de la aplicación
/// Proporciona acceso a las rutas y un mapa de rutas para la navegación
class AppRoutes {
  
  // ============ RUTAS DE LA APLICACIÓN ============
  /// Definición de constantes para todas las rutas disponibles en la app
  
  /// Ruta para pantalla de login - acceso inicial a la aplicación
  static const String login = '/login';
  
  /// Ruta para panel principal del administrador
  static const String panelAdmin = '/panel-admin';
  
  /// Ruta para vista de recomendaciones en el panel admin
  static const String panelAdminRecomendaciones = '/panel-admin/recomendaciones';
  
  /// Ruta para editar plataforma (configuración de sistema)
  static const String panelAdminEditarPlataforma = '/panel-admin/editar-plataforma';
  
  /// Ruta para botón de IoT en pantalla completa
  static const String botonIOT = '/boton-iot';
  
  /// Ruta para panel principal del agricultor
  static const String panelAgricultor = '/panel-agricultor';
  
  /// Ruta para visualizar historial de datos
  static const String historial = '/historial';

  // ============ MAPA DE RUTAS ============
  /// Getter que retorna el mapa de rutas para navigator
  /// Asocia cada ruta con su widget correspondiente
  static Map<String, WidgetBuilder> get routes => {
        login: (context) => const LoginScreen(), // Pantalla de autenticación
        panelAdmin: (context) => const PanelAdmin(), // Panel principal admin
        panelAdminRecomendaciones: (context) => const Recomendaciones(), // Recomendaciones
        panelAdminEditarPlataforma: (context) => const PlataformaEditable(), // Configuración
        botonIOT: (context) => const BotonIOT(isFullScreen: true), // Botón IoT
        panelAgricultor: (context) => const PanelAgricultor(), // Panel agricultor
        historial: (context) => const Historial(), // Historial de datos
      };
}
