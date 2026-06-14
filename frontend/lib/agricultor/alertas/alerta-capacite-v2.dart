import 'package:flutter/material.dart';
import '../../environments/datos-alertas-simuladas.dart';
import 'alerta-sensor-banner.dart';

class AlertaCapaciteV2 extends StatelessWidget {
  final AlertaSensorData alerta;
  final VoidCallback onCerrar;

  const AlertaCapaciteV2({
    super.key,
    required this.alerta,
    required this.onCerrar,
  });

  @override
  Widget build(BuildContext context) {
    return AlertaSensorBanner(
      alerta: alerta,
      icono: Icons.grass,
      onCerrar: onCerrar,
    );
  }
}
