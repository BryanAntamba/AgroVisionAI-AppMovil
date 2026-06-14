// ═══════════════════════════════════════════════════════════════════════════
// HISTORIAL SIMULADO - DATOS DE REGISTROS HISTÓRICOS DE DIAGNÓSTICOS
// ═══════════════════════════════════════════════════════════════════════════
// Define los registros históricos de diagnósticos de plantas
// para la pantalla de historial del agricultor.
// ═══════════════════════════════════════════════════════════════════════════

/// Clase que representa un registro individual en el historial
/// Contiene todos los datos de un diagnóstico realizado
class RegistroHistorial {
  final int id;                  // Identificador único del registro
  final String fecha;            // Fecha del diagnóstico (formato YYYY-MM-DD)
  final String hora;             // Hora del diagnóstico (formato HH:MM)
  final String planta;           // Identificador de la planta diagnosticada
  final String diagnostico;      // Resultado del diagnóstico (nombre de la enfermedad o estado)
  final double confianza;        // Confianza del modelo IA (0-100%)
  final int salud;               // Índice de salud general (0-100)
  final double temperatura;      // Temperatura del aire en °C
  final int humedadAire;         // Humedad del aire en %
  final int humedadSuelo;        // Humedad del suelo en %
  final int luz;                 // Intensidad de luz en lux

  /// Constructor con todos los parámetros requeridos
  const RegistroHistorial({
    required this.id,
    required this.fecha,
    required this.hora,
    required this.planta,
    required this.diagnostico,
    required this.confianza,
    required this.salud,
    required this.temperatura,
    required this.humedadAire,
    required this.humedadSuelo,
    required this.luz,
  });
}

/// Lista de registros históricos simulados para pruebas
/// Ordenados del más reciente al más antiguo
const List<RegistroHistorial> historialSimulado = [
  // Registro 1: Tomate sano reciente
  RegistroHistorial(
    id: 1,                           // Identificador único
    fecha: '2026-05-31',             // Fecha más reciente
    hora: '10:24',                   // Hora de la captura
    planta: 'Planta #04',            // Planta número 4
    diagnostico: 'Tomate sano',      // Estado saludable
    confianza: 92.4,                 // Alta confianza en el diagnóstico
    salud: 82,                       // Buen índice de salud
    temperatura: 22.0,               // Temperatura óptima
    humedadAire: 65,                 // Humedad adecuada
    humedadSuelo: 75,                // Suelo bien hidratado
    luz: 52000,                      // Luz abundante
  ),
  // Registro 2: Tizón temprano detectado
  RegistroHistorial(
    id: 2,                           // Identificador único
    fecha: '2026-05-30',             // Un día antes
    hora: '15:45',                   // Tarde
    planta: 'Planta #03',            // Planta número 3
    diagnostico: 'Tizón temprano',   // Enfermedad detectada
    confianza: 85.2,                 // Confianza moderada-alta
    salud: 65,                       // Salud comprometida
    temperatura: 25.4,               // Temperatura elevada
    humedadAire: 60,                 // Humedad baja del rango óptimo
    humedadSuelo: 68,                // Humedad del suelo aceptable
    luz: 48000,                      // Luz moderada
  ),
  // Registro 3: Tomate sano con condiciones frescas
  RegistroHistorial(
    id: 3,                           // Identificador único
    fecha: '2026-05-29',             // Dos días antes
    hora: '09:15',                   // Mañana
    planta: 'Planta #02',            // Planta número 2
    diagnostico: 'Tomate sano',      // Estado saludable
    confianza: 91.8,                 // Alta confianza
    salud: 88,                       // Muy buen índice de salud
    temperatura: 19.2,               // Temperatura fresca
    humedadAire: 82,                 // Humedad alta
    humedadSuelo: 42,                // Suelo relativamente seco
    luz: 35000,                      // Luz baja (mañana temprano)
  ),
  // Registro 4: Tizón tardío detectado
  RegistroHistorial(
    id: 4,                           // Identificador único
    fecha: '2026-05-28',             // Tres días antes
    hora: '14:30',                   // Media tarde
    planta: 'Planta #07',            // Planta número 7
    diagnostico: 'Tizón tardío',     // Enfermedad más grave
    confianza: 88.5,                 // Confianza alta
    salud: 45,                       // Salud muy comprometida
    temperatura: 23.8,               // Temperatura moderada-alta
    humedadAire: 78,                 // Humedad alta (favorece enfermedad)
    humedadSuelo: 55,                // Humedad moderada
    luz: 41000,                      // Luz moderada
  ),
  // Registro 5: Moho foliar detectado
  RegistroHistorial(
    id: 5,                           // Identificador único
    fecha: '2026-05-27',             // Cuatro días antes
    hora: '11:00',                   // Media mañana
    planta: 'Planta #01',            // Planta número 1
    diagnostico: 'Moho foliar',      // Enfermedad fúngica
    confianza: 79.3,                 // Confianza moderada
    salud: 52,                       // Salud regular
    temperatura: 21.5,               // Temperatura adecuada
    humedadAire: 85,                 // Humedad muy alta (favorece moho)
    humedadSuelo: 62,                // Humedad buena
    luz: 38000,                      // Luz moderada-baja
  ),
  // Registro 6: Tomate sano con buenas condiciones
  RegistroHistorial(
    id: 6,                           // Identificador único
    fecha: '2026-05-26',             // Cinco días antes
    hora: '08:45',                   // Mañana temprano
    planta: 'Planta #05',            // Planta número 5
    diagnostico: 'Tomate sano',      // Estado saludable
    confianza: 93.7,                 // Muy alta confianza
    salud: 90,                       // Excelente salud
    temperatura: 20.3,               // Temperatura fresca óptima
    humedadAire: 70,                 // Humedad ideal
    humedadSuelo: 58,                // Humedad moderada
    luz: 45000,                      // Luz buena (mañana)
  ),
  // Registro 7: Mancha séptica detectada
  RegistroHistorial(
    id: 7,                           // Identificador único
    fecha: '2026-05-25',             // Seis días antes
    hora: '16:20',                   // Tarde
    planta: 'Planta #06',            // Planta número 6
    diagnostico: 'Mancha séptica',   // Enfermedad bacteriana
    confianza: 76.8,                 // Confianza moderada-baja
    salud: 48,                       // Salud comprometida
    temperatura: 24.2,               // Temperatura cálida
    humedadAire: 68,                 // Humedad moderada
    humedadSuelo: 50,                // Suelo moderadamente seco
    luz: 47000,                      // Luz buena (tarde)
  ),
  // Registro 8: Tomate sano con luz abundante
  RegistroHistorial(
    id: 8,                           // Identificador único
    fecha: '2026-05-24',             // Siete días antes
    hora: '13:10',                   // Mediodía
    planta: 'Planta #08',            // Planta número 8
    diagnostico: 'Tomate sano',      // Estado saludable
    confianza: 94.2,                 // Muy alta confianza
    salud: 85,                       // Muy buena salud
    temperatura: 22.7,               // Temperatura óptima
    humedadAire: 65,                 // Humedad ideal
    humedadSuelo: 70,                // Suelo bien hidratado
    luz: 53000,                      // Luz muy abundante (mediodía)
  ),
];
