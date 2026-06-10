import 'package:flutter/material.dart';
import '../../styles/agricultor-styles/modales-styles/alerta-sensor.dart';
import '../../environments/datos-alertas-simuladas.dart';

/// Widget genérico que renderiza el banner de alerta de sensor.
/// Cada alerta específica (WiFi, Cam, etc.) instancia este widget
/// pasando el [icono] correspondiente.
class AlertaSensorBanner extends StatelessWidget {
  final AlertaSensorData alerta;
  final IconData icono;
  final VoidCallback onCerrar;

  const AlertaSensorBanner({
    super.key,
    required this.alerta,
    required this.icono,
    required this.onCerrar,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 14),
      decoration: AlertaSensorStyles.bannerDecoration,
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // ─── Icono ───────────────────────────────────────────────────────
          Container(
            width: 44,
            height: 44,
            decoration: AlertaSensorStyles.iconDecoration,
            child: Icon(
              icono,
              color: AlertaSensorStyles.primaryGreen,
              size: 22,
            ),
          ),
          const SizedBox(width: 14),

          // ─── Contenido ───────────────────────────────────────────────────
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(alerta.titulo, style: AlertaSensorStyles.tituloStyle),
                const SizedBox(height: 4),
                Text(
                  alerta.descripcionCorta,
                  style: AlertaSensorStyles.descripcionStyle,
                ),
                const SizedBox(height: 6),
                Text(alerta.fechaHora, style: AlertaSensorStyles.fechaStyle),
              ],
            ),
          ),
          const SizedBox(width: 10),

          // ─── Botón cerrar ─────────────────────────────────────────────────
          GestureDetector(
            onTap: onCerrar,
            child: Container(
              width: 34,
              height: 34,
              decoration: AlertaSensorStyles.closeBtnDecoration,
              child: const Icon(
                Icons.close,
                color: AlertaSensorStyles.darkGreen,
                size: 17,
              ),
            ),
          ),
        ],
      ),
    );
  }
}
