import 'package:flutter/material.dart';
import 'app.dart';
import 'shared/services/tema.service.dart';

/// Punto de entrada principal de la aplicación AgroVision AI
/// Inicializa los servicios necesarios y lanza la aplicación
Future<void> main() async {
  /// Asegura que el binding de Flutter esté inicializado
  /// Necesario para usar servicios nativos de la plataforma
  WidgetsFlutterBinding.ensureInitialized();
  
  /// Carga la configuración de tema de la aplicación
  /// (colores, estilos, preferencias de visual)
  await TemaService.instance.cargar();
  
  /// Inicia la aplicación con el widget raíz
  runApp(const MyApp());
}

/// Widget raíz de la aplicación
/// Configura el MaterialApp con temas y rutas
class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      /// Título de la aplicación mostrado en la barra del sistema
      title: 'AgroVision AI',
      
      /// Configuración del tema visual de la aplicación
      theme: ThemeData(
        /// Esquema de colores derivado del color verde primario (0xFF55A820)
        colorScheme: ColorScheme.fromSeed(seedColor: const Color(0xFF55A820)),
      ),
      
      /// Ruta inicial al iniciar la aplicación
      /// Dirige directamente a la pantalla de login
      initialRoute: AppRoutes.login,
      
      /// Mapa de todas las rutas disponibles en la aplicación
      /// Permite la navegación entre pantallas
      routes: AppRoutes.routes,
    );
  }
}

