// ═══════════════════════════════════════════════════════════════════════════
// IMPORTACIONES
// ═══════════════════════════════════════════════════════════════════════════
import 'package:flutter/material.dart'; // Framework de Flutter
import '../../environments/datos-alertas-simuladas.dart'; // Modelo de datos de alertas
import '../../styles/agricultor-styles/alertas-styles/alerta-sensores.dart'; // Estilos para alertas de sensores

// ═══════════════════════════════════════════════════════════════════════════
// WIDGET: AlertaSensorLdr - Banner de alerta para sensor de luz LDR
// ═══════════════════════════════════════════════════════════════════════════
/// Widget que muestra una alerta cuando hay problemas con el sensor LDR
/// (Light Dependent Resistor - Fotorresistor). Muestra un banner rojo con 
/// icono de sol, título, descripción y botón para cerrar la alerta.
/// 
/// El LDR es un sensor que mide la intensidad de luz ambiental, útil para:
/// - Determinar niveles de iluminación en cultivos
/// - Controlar sistemas de iluminación artificial
/// - Monitorear exposición solar de las plantas
class AlertaSensorLdr extends StatefulWidget {
  final AlertaSensorData alerta; // Datos de la alerta (título, descripción, fecha)
  final VoidCallback onCerrar; // Callback para cerrar/ocultar la alerta

  /// Constructor del widget de alerta del sensor LDR
  /// @param alerta: Objeto con datos de la alerta (AlertaSensorData)
  /// @param onCerrar: Función a ejecutar al cerrar la alerta
  const AlertaSensorLdr({
    super.key,
    required this.alerta,
    required this.onCerrar,
  });

  @override
  State<AlertaSensorLdr> createState() => _AlertaSensorLdrState();
}

// ═══════════════════════════════════════════════════════════════════════════
// ESTADO: _AlertaSensorLdrState - Maneja la UI del banner de alerta del sensor LDR
// ═══════════════════════════════════════════════════════════════════════════
class _AlertaSensorLdrState extends State<AlertaSensorLdr> {
  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity, // Ocupa todo el ancho disponible
      padding: const EdgeInsets.all(16), // Padding interno uniforme
      decoration: AlertaSensorStyles.bannerDecoration, // Decoración predefinida (fondo rojo claro, bordes)
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start, // Alinea elementos al inicio verticalmente
        children: [
          // ─────────────────────────────────────────────────────────────────
          // ICONO DE ALERTA DE SENSOR DE LUZ
          // ─────────────────────────────────────────────────────────────────
          Container(
            width: 36,
            height: 36,
            decoration: AlertaSensorStyles.iconDecoration, // Círculo con fondo
            child: const Icon(
              Icons.wb_sunny, // Icono de sol de Material Icons (representa luz/iluminación)
              color: AlertaSensorStyles.alertRed, // Color rojo de alerta
              size: 18,
            ),
          ),
          const SizedBox(width: 12), // Espaciado entre icono y texto
          
          // ─────────────────────────────────────────────────────────────────
          // CONTENIDO DE LA ALERTA (Título, descripción y fecha)
          // ─────────────────────────────────────────────────────────────────
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start, // Alinea texto a la izquierda
              mainAxisSize: MainAxisSize.min, // Usa solo el espacio necesario verticalmente
              children: [
                // Título de la alerta (ej: "Sensor de luz LDR sin respuesta")
                Text(widget.alerta.titulo, style: AlertaSensorStyles.tituloStyle),
                const SizedBox(height: 4),
                // Descripción corta de la alerta (ej: "Mediciones de luz no disponibles")
                Text(widget.alerta.descripcionCorta, style: AlertaSensorStyles.descripcionStyle),
                const SizedBox(height: 6),
                // Fecha y hora de la alerta (ej: "12/06/2026 - 14:30")
                Text(widget.alerta.fechaHora, style: AlertaSensorStyles.fechaStyle),
              ],
            ),
          ),
          const SizedBox(width: 12), // Espaciado entre contenido y botón cerrar
          
          // ─────────────────────────────────────────────────────────────────
          // BOTÓN CERRAR (X)
          // ─────────────────────────────────────────────────────────────────
          GestureDetector(
            onTap: widget.onCerrar, // Ejecuta callback al hacer tap
            child: Container(
              width: 32,
              height: 32,
              decoration: AlertaSensorStyles.closeBtnDecoration, // Círculo con fondo claro
              child: const Icon(Icons.close, color: AlertaSensorStyles.alertRed, size: 16),
            ),
          ),
        ],
      ),
    );
  }
}
