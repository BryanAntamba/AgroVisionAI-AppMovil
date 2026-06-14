import 'package:flutter/material.dart';
import '../../environments/datos-alertas-simuladas.dart';
import 'alerta-sensor-banner.dart';

class AlertaDht22 extends StatelessWidget {
  final AlertaSensorData alerta;
  final VoidCallback onCerrar;

  const AlertaDht22({
    super.key,
    required this.alerta,
    required this.onCerrar,
  });

  @override
  Widget build(BuildContext context) {
    return AlertaSensorBanner(
      alerta: alerta,
      icono: Icons.thermostat,
      onCerrar: onCerrar,
    );
  }
}
