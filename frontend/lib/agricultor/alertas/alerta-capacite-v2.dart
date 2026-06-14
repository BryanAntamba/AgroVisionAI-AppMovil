import 'package:flutter/material.dart';
import '../../environments/datos-alertas-simuladas.dart';
import '../../styles/agricultor-styles/alertas-styles/alerta-sensores.dart';

class AlertaCapaciteV2 extends StatefulWidget {
  final AlertaSensorData alerta;
  final VoidCallback onCerrar;

  const AlertaCapaciteV2({
    super.key,
    required this.alerta,
    required this.onCerrar,
  });

  @override
  State<AlertaCapaciteV2> createState() => _AlertaCapaciteV2State();
}

class _AlertaCapaciteV2State extends State<AlertaCapaciteV2> {
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
              Icons.grass,
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
