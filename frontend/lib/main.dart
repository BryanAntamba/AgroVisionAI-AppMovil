import 'package:flutter/material.dart';
import 'app.dart';
import 'shared/services/tema.service.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await TemaService.instance.cargar();
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'AgroVision AI',
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: const Color(0xFF55A820)),
      ),
      initialRoute: AppRoutes.login,
      routes: AppRoutes.routes,
    );
  }
}

