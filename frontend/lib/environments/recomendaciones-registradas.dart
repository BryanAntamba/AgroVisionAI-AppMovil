// ═══════════════════════════════════════════════════════════════════════════
// RECOMENDACIONES REGISTRADAS - DATOS INICIALES DEL SISTEMA
// ═══════════════════════════════════════════════════════════════════════════
// Define las recomendaciones predeterminadas que se mostrarán en el
// panel de administración al iniciar la aplicación.
// ═══════════════════════════════════════════════════════════════════════════

import 'modales-recomendacion.dart'; // Importa la clase RecomendacionRegistrada y enums

/// Lista de recomendaciones simuladas para el sistema AgroVision AI
/// Estas se mostrarán como recomendaciones por defecto en el panel de administración
/// Cada recomendación incluye título, descripción, acción sugerida, prioridad y color
final List<RecomendacionRegistrada> recomendacionesSimuladas = [
  // Recomendación 1: Condiciones óptimas - Prioridad baja
  RecomendacionRegistrada(
    id: 1,                                                                    // Identificador único
    titulo: 'Temperatura y luz en condiciones ideales',                      // Título descriptivo de la situación
    descripcion: '22 °C y 52 000 lux están dentro del rango óptimo para el tomate.', // Detalles de las mediciones
    accion: 'No se requiere intervención de clima en este momento.',         // Acción recomendada (ninguna en este caso)
    prioridad: PrioridadRecomendacion.baja,                                  // Baja prioridad (todo está bien)
    color: ColorRecomendacion.verde,                                         // Color verde (situación positiva)
    fechaRegistro: '2026-05-15T10:00:00.000Z',                               // Fecha ISO 8601 del registro
  ),
  // Recomendación 2: Amarillamiento detectado - Prioridad alta
  RecomendacionRegistrada(
    id: 2,                                                                    // Identificador único
    titulo: 'Leve amarillamiento detectado (2.1 %)',                         // Título con porcentaje específico
    descripcion: 'Dentro del rango normal, pero monitoree. Si supera el 5 %, revise nutrición.', // Umbral de alerta
    accion: 'Revise el nivel de nitrógeno y aumente la frecuencia de riego si es necesario.', // Acciones correctivas
    prioridad: PrioridadRecomendacion.alta,                                  // Alta prioridad (requiere atención)
    color: ColorRecomendacion.amarillo,                                      // Color amarillo (advertencia)
    fechaRegistro: '2026-05-15T10:05:00.000Z',                               // 5 minutos después de la primera
  ),
  // Recomendación 3: Humedad foliar baja - Prioridad media
  RecomendacionRegistrada(
    id: 3,                                                                    // Identificador único
    titulo: 'Humedad foliar por debajo del óptimo',                          // Título del problema
    descripcion: 'La humedad estimada se encuentra por debajo del rango recomendado para el cultivo (15 %).', // Medición específica
    accion: 'Verifique el sistema de riego y aumente la frecuencia de monitoreo.', // Revisión y ajuste
    prioridad: PrioridadRecomendacion.media,                                 // Prioridad media (atención moderada)
    color: ColorRecomendacion.naranja,                                       // Color naranja (precaución)
    fechaRegistro: '2026-05-15T10:10:00.000Z',                               // 10 minutos después de la primera
  ),
  // Recomendación 4: Estado saludable general - Prioridad baja
  RecomendacionRegistrada(
    id: 4,                                                                    // Identificador único
    titulo: 'Cultivo en buen estado',                                        // Título positivo
    descripcion: 'No se detectaron enfermedades activas. Mantenga el riego programado y el monitoreo semanal de hojas.', // Confirmación de salud
    accion: 'Continúe con el plan de monitoreo habitual.',                   // Mantener rutina actual
    prioridad: PrioridadRecomendacion.baja,                                  // Baja prioridad (todo funciona)
    color: ColorRecomendacion.verde,                                         // Color verde (positivo)
    fechaRegistro: '2026-05-15T10:15:00.000Z',                               // 15 minutos después de la primera
  ),
];
