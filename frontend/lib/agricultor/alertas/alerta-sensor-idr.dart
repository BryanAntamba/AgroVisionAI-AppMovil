import 'package:flutter/material.dart';
import '../../environments/datos-alertas-simuladas.dart';
import 'alerta-sensor-banner.dart';

class AlertaSensorLdr extends StatelessWidget {
  final AlertaSensorData alerta;
  final VoidCallback onCerrar;

  const AlertaSensorLdr({
    super.key,
    required this.alerta,
    required this.onCerrar,
  });

  @override
  Widget build(BuildContext context) {
    return AlertaSensorBanner(
      alerta: alerta,
      icono: Icons.wb_sunny,
      onCerrar: onCerrar,
    );
  }
}
