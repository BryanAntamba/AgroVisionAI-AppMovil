import 'package:flutter/material.dart';
import '../../environments/datos-alertas-simuladas.dart';
import '../../styles/agricultor-styles/alertas-styles/alerta-sensores.dart';

class AlertaSensorLdr extends StatefulWidget {
  final AlertaSensorData alerta;
  final VoidCallback onCerrar;

  const AlertaSensorLdr({
    super.key,
    required this.alerta,
    required this.onCerrar,
  });

  @override
  State<AlertaSensorLdr> createState() => _AlertaSensorLdrState();
}

class _AlertaSensorLdrState extends State<AlertaSensorLdr> {
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
              Icons.wb_sunny,
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
