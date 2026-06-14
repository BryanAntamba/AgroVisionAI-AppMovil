import 'package:flutter/material.dart';
import '../../environments/datos-alertas-simuladas.dart';
import '../../styles/agricultor-styles/alertas-styles/alerta-sensores.dart';

class AlertaAntenaWifi extends StatefulWidget {
  final AlertaSensorData alerta;
  final VoidCallback onCerrar;

  const AlertaAntenaWifi({
    super.key,
    required this.alerta,
    required this.onCerrar,
  });

  @override
  State<AlertaAntenaWifi> createState() => _AlertaAntenaWifiState();
}

class _AlertaAntenaWifiState extends State<AlertaAntenaWifi> {
  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      padding: const EdgeInsets.all(16),
      decoration: AlertaSensorStyles.bannerDecoration,
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Container(
            width: 36,
            height: 36,
            decoration: AlertaSensorStyles.iconDecoration,
            child: const Icon(
              Icons.wifi,
              color: AlertaSensorStyles.alertRed,
              size: 18,
            ),
          ),
          const SizedBox(width: 12),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisSize: MainAxisSize.min,
              children: [
                Text(widget.alerta.titulo, style: AlertaSensorStyles.tituloStyle),
                const SizedBox(height: 4),
                Text(widget.alerta.descripcionCorta, style: AlertaSensorStyles.descripcionStyle),
                const SizedBox(height: 6),
                Text(widget.alerta.fechaHora, style: AlertaSensorStyles.fechaStyle),
              ],
            ),
          ),
          const SizedBox(width: 12),
          GestureDetector(
            onTap: widget.onCerrar,
            child: Container(
              width: 32,
              height: 32,
              decoration: AlertaSensorStyles.closeBtnDecoration,
              child: const Icon(Icons.close, color: AlertaSensorStyles.alertRed, size: 16),
            ),
          ),
        ],
      ),
    );
  }
}
