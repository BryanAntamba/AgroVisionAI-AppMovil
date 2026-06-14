import 'package:flutter/material.dart';
import '../../environments/datos-alertas-simuladas.dart';
import 'alerta-sensor-banner.dart';

class AlertaCam extends StatelessWidget {
  final AlertaSensorData alerta;
  final VoidCallback onCerrar;

  const AlertaCam({
    super.key,
    required this.alerta,
    required this.onCerrar,
  });

  @override
  Widget build(BuildContext context) {
    return AlertaSensorBanner(
      alerta: alerta,
      icono: Icons.camera_alt,
      onCerrar: onCerrar,
    );
  }
}
