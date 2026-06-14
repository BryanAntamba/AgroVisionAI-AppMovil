// ═══════════════════════════════════════════════════════════════════════════
// DATOS DE ALERTAS SIMULADAS - SISTEMA DE NOTIFICACIONES DE SENSORES
// ═══════════════════════════════════════════════════════════════════════════
// Define los tipos de alertas de sensores y el catálogo de mensajes
// para simular fallos en el sistema IoT.
// ═══════════════════════════════════════════════════════════════════════════

/// Enumeración de los tipos de sensores que pueden generar alertas
enum TipoAlertaSensor { 
  dht22,        // Sensor de temperatura y humedad del aire
  cam,          // Cámara ESP32-CAM para captura de imágenes
  capaciteV2,   // Sensor de humedad del suelo capacitivo
  antenaWifi,   // Antena WiFi para conectividad IoT
  sensorLdr     // Sensor de luz LDR (BH1750)
}

/// Clase que representa los datos de una alerta de sensor
/// Contiene información descriptiva sobre el fallo detectado
class AlertaSensorData {
  final TipoAlertaSensor id;      // Identificador único del tipo de sensor
  final String titulo;            // Título corto del problema
  final String descripcionCorta;  // Descripción detallada y recomendaciones
  final String fechaHora;         // Marca de tiempo del evento

  /// Constructor con parámetros nombrados requeridos
  const AlertaSensorData({
    required this.id,
    required this.titulo,
    required this.descripcionCorta,
    required this.fechaHora,
  });
}

/// Lista de alertas que se mostrarán activas al iniciar la aplicación
/// Modifique esta lista para simular diferentes escenarios de fallos
/// Por defecto, solo muestra alerta del sensor DHT22
const List<TipoAlertaSensor> alertasActivasAlInicio = [TipoAlertaSensor.dht22];

/// Catálogo completo de todas las alertas posibles del sistema
/// Cada tipo de sensor tiene su mensaje predefinido
const Map<TipoAlertaSensor, AlertaSensorData> catalogoAlertasSensores = {
  // Alerta del sensor DHT22 - temperatura y humedad del aire
  TipoAlertaSensor.dht22: AlertaSensorData(
    id: TipoAlertaSensor.dht22,                                              // Identificador del sensor
    titulo: 'Fallo en sensor DHT22',                                         // Título de la alerta
    descripcionCorta: 'No se reciben lecturas de temperatura y humedad del aire. Verifique cableado y alimentación.', // Descripción y solución
    fechaHora: '31 may 2026 · 10:18 am',                                     // Timestamp del evento
  ),
  // Alerta de la cámara ESP32-CAM
  TipoAlertaSensor.cam: AlertaSensorData(
    id: TipoAlertaSensor.cam,                                                // Identificador de la cámara
    titulo: 'Fallo en cámara ESP32-CAM',                                     // Título de la alerta
    descripcionCorta: 'La cámara no responde. No es posible capturar imágenes de hoja hasta restablecer la conexión.', // Impacto funcional
    fechaHora: '31 may 2026 · 10:19 am',                                     // Timestamp del evento
  ),
  // Alerta del sensor de humedad del suelo capacitivo
  TipoAlertaSensor.capaciteV2: AlertaSensorData(
    id: TipoAlertaSensor.capaciteV2,                                         // Identificador del sensor
    titulo: 'Fallo en sensor de suelo capacitivo v1.2',                      // Título con versión
    descripcionCorta: 'Lectura de humedad del suelo interrumpida. Revise el sensor en el sustrato.', // Ubicación del problema
    fechaHora: '31 may 2026 · 10:20 am',                                     // Timestamp del evento
  ),
  // Alerta de conectividad WiFi
  TipoAlertaSensor.antenaWifi: AlertaSensorData(
    id: TipoAlertaSensor.antenaWifi,                                         // Identificador de la antena
    titulo: 'Fallo en antena WiFi',                                          // Título de la alerta
    descripcionCorta: 'Señal inestable o sin conexión con el invernadero. Los datos pueden no actualizarse.', // Consecuencia del fallo
    fechaHora: '31 may 2026 · 10:21 am',                                     // Timestamp del evento
  ),
  // Alerta del sensor de luz LDR
  TipoAlertaSensor.sensorLdr: AlertaSensorData(
    id: TipoAlertaSensor.sensorLdr,                                          // Identificador del sensor
    titulo: 'Fallo en sensor LDR (BH1750)',                                  // Título con modelo del sensor
    descripcionCorta: 'No se detecta intensidad de luz. Verifique el sensor LDR y su bus I2C.', // Conexión específica a revisar
    fechaHora: '31 may 2026 · 10:22 am',                                     // Timestamp del evento
  ),
};
