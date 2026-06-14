// ═══════════════════════════════════════════════════════════════════════════
// IMPORTACIONES
// ═══════════════════════════════════════════════════════════════════════════
import 'package:flutter/material.dart'; // Framework de Flutter
import '../../environments/datos-alertas-simuladas.dart'; // Modelo de datos de alertas
import '../../styles/agricultor-styles/alertas-styles/alerta-sensores.dart'; // Estilos para alertas de sensores

// ═══════════════════════════════════════════════════════════════════════════
// WIDGET: AlertaDht22 - Banner de alerta para sensor de temperatura y humedad
// ═══════════════════════════════════════════════════════════════════════════
/// Widget que muestra una alerta cuando hay problemas con el sensor DHT22
/// (sensor de temperatura y humedad ambiental). Muestra un banner rojo con 
/// icono de termómetro, título, descripción y botón para cerrar la alerta.
/// 
/// El DHT22 es un sensor digital que mide:
/// - Temperatura ambiente (-40°C a 80°C)
/// - Humedad relativa del aire (0-100%)
class AlertaDht22 extends StatefulWidget {
  final AlertaSensorData alerta; // Datos de la alerta (título, descripción, fecha)
  final VoidCallback onCerrar; // Callback para cerrar/ocultar la alerta

  /// Constructor del widget de alerta del sensor DHT22
  /// @param alerta: Objeto con datos de la alerta (AlertaSensorData)
  /// @param onCerrar: Función a ejecutar al cerrar la alerta
  const AlertaDht22({
    super.key,
    required this.alerta,
    required this.onCerrar,
  });

  @override
  State<AlertaDht22> createState() => _AlertaDht22State();
}

// ═══════════════════════════════════════════════════════════════════════════
// ESTADO: _AlertaDht22State - Maneja la UI del banner de alerta del sensor DHT22
// ═══════════════════════════════════════════════════════════════════════════
class _AlertaDht22State extends State<AlertaDht22> {
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
          // ICONO DE ALERTA DE SENSOR DE TEMPERATURA/HUMEDAD
          // ─────────────────────────────────────────────────────────────────
          Container(
            width: 36,
            height: 36,
            decoration: AlertaSensorStyles.iconDecoration, // Círculo con fondo
            child: const Icon(
              Icons.thermostat, // Icono de termómetro de Material Icons
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
                // Título de la alerta (ej: "Sensor DHT22 desconectado")
                Text(
                  widget.alerta.titulo,
                  style: AlertaSensorStyles.tituloStyle,
                ),
                const SizedBox(height: 4),
                // Descripción corta de la alerta (ej: "Temperatura y humedad no disponibles")
                Text(
                  widget.alerta.descripcionCorta,
                  style: AlertaSensorStyles.descripcionStyle,
                ),
                const SizedBox(height: 6),
                // Fecha y hora de la alerta (ej: "12/06/2026 - 14:30")
                Text(
                  widget.alerta.fechaHora,
                  style: AlertaSensorStyles.fechaStyle,
                ),
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
              child: const Icon(
                Icons.close,
                color: AlertaSensorStyles.alertRed,
                size: 16,
              ),
            ),
          ),
        ],
      ),
    );
  }
}
