// ═══════════════════════════════════════════════════════════════════════════
// DATOS IOT SIMULADOS - DATOS COMPLETOS DEL SISTEMA IOT
// ═══════════════════════════════════════════════════════════════════════════
// Define todas las clases y datos simulados del sistema IoT de AgroVision AI
// Incluye sensores, diagnósticos, métricas, imágenes y configuración
// ═══════════════════════════════════════════════════════════════════════════

/// Clase que contiene metadatos generales del sistema IoT
/// Información sobre el título y timestamp de la captura
class MetaIOT {
  final String titulo;         // Nombre del sistema ("AgroVision AI")
  final String fechaCaptura;   // Fecha y hora de la captura en formato legible

  /// Constructor const para crear instancia inmutable
  const MetaIOT({
    required this.titulo,        // Título obligatorio
    required this.fechaCaptura,  // Fecha obligatoria
  });
}

/// Clase que contiene configuración de captura automática
/// Define qué planta se está monitoreando y el intervalo de actualización
class CapturaIOT {
  final int numeroPlanta;              // Número identificador de la planta monitoreada
  final int intervaloNuevaCapturaMs;   // Intervalo en milisegundos para siguiente captura

  /// Constructor const para crear instancia inmutable
  const CapturaIOT({
    required this.numeroPlanta,              // Número de planta obligatorio
    required this.intervaloNuevaCapturaMs,   // Intervalo obligatorio
  });
}

/// Clase que contiene todas las lecturas en tiempo real de los sensores
/// Incluye temperatura, humedad (aire y suelo), luz y rangos óptimos
class SensoresTiempoRealIOT {
  final bool esp32;                  // Estado de conexión del ESP32 (true = conectado)
  final double temperaturaAireC;     // Temperatura del aire en grados Celsius
  final int temperaturaOptimaMin;    // Temperatura mínima óptima para el cultivo (°C)
  final int temperaturaOptimaMax;    // Temperatura máxima óptima para el cultivo (°C)
  final int temperaturaSensorMin;    // Límite mínimo del sensor DHT22 (°C)
  final int temperaturaSensorMax;    // Límite máximo del sensor DHT22 (°C)
  final int humedadAirePct;          // Humedad relativa del aire en porcentaje
  final int humedadAireOptimaMin;    // Humedad del aire mínima óptima (%)
  final int humedadAireOptimaMax;    // Humedad del aire máxima óptima (%)
  final int alertaHumedad;           // Umbral de alerta de humedad alta (%)
  final int humedadSueloPct;         // Humedad del suelo en porcentaje
  final int riegoMinimo;             // Umbral mínimo de humedad para activar riego (%)
  final int intensidadLuzLux;        // Intensidad de luz en lux
  final int luzOptimaMin;            // Luz mínima óptima para fotosíntesis (lux)
  final int luzOptimaMax;            // Luz máxima óptima sin estrés (lux)
  final String ciclo;                // Ciclo del día: 'diurno' o 'nocturno'

  /// Constructor const para crear instancia inmutable con todos los parámetros
  const SensoresTiempoRealIOT({
    required this.esp32,                    // Estado ESP32 obligatorio
    required this.temperaturaAireC,         // Temperatura obligatoria
    required this.temperaturaOptimaMin,     // Temp mínima obligatoria
    required this.temperaturaOptimaMax,     // Temp máxima obligatoria
    required this.temperaturaSensorMin,     // Límite sensor mínimo obligatorio
    required this.temperaturaSensorMax,     // Límite sensor máximo obligatorio
    required this.humedadAirePct,           // Humedad aire obligatoria
    required this.humedadAireOptimaMin,     // Humedad aire mínima obligatoria
    required this.humedadAireOptimaMax,     // Humedad aire máxima obligatoria
    required this.alertaHumedad,            // Alerta humedad obligatoria
    required this.humedadSueloPct,          // Humedad suelo obligatoria
    required this.riegoMinimo,              // Riego mínimo obligatorio
    required this.intensidadLuzLux,         // Intensidad luz obligatoria
    required this.luzOptimaMin,             // Luz mínima obligatoria
    required this.luzOptimaMax,             // Luz máxima obligatoria
    required this.ciclo,                    // Ciclo obligatorio
  });
}

/// Clase que contiene lecturas de sensores complementarios adicionales
/// Sensores menos críticos pero útiles para análisis avanzado
class SensoresComplementariosIOT {
  final double humedadHojaPct;        // Humedad estimada de la hoja en porcentaje
  final int humedadHojaOptimaMin;     // Humedad foliar mínima óptima (%)
  final int humedadHojaOptimaMax;     // Humedad foliar máxima óptima (%)
  final double flujoAireMs;           // Velocidad del flujo de aire en m/s
  final double flujoAireRefMin;       // Flujo de aire mínimo recomendado (m/s)
  final double flujoAireRefMax;       // Flujo de aire máximo recomendado (m/s)

  /// Constructor const para crear instancia inmutable
  const SensoresComplementariosIOT({
    required this.humedadHojaPct,         // Humedad hoja obligatoria
    required this.humedadHojaOptimaMin,   // Humedad hoja mínima obligatoria
    required this.humedadHojaOptimaMax,   // Humedad hoja máxima obligatoria
    required this.flujoAireMs,            // Flujo aire obligatorio
    required this.flujoAireRefMin,        // Flujo mínimo obligatorio
    required this.flujoAireRefMax,        // Flujo máximo obligatorio
  });
}

/// Clase que representa un componente individual del índice de salud
/// Cada componente contribuye a la evaluación general
class ComponenteIndiceSalud {
  final String etiqueta;  // Nombre del componente (ej: "Detección IA", "Área sana")
  final int valor;        // Valor del componente (0-100)

  /// Constructor const para crear instancia inmutable
  const ComponenteIndiceSalud({
    required this.etiqueta,  // Etiqueta obligatoria
    required this.valor,     // Valor obligatorio
  });
}

/// Clase que contiene el índice de salud general de la planta
/// Agrega múltiples componentes en una evaluación unificada
class IndiceSaludIOT {
  final int valor;                           // Índice de salud general (0-100)
  final String estado;                       // Estado descriptivo (ej: "Bueno", "Regular")
  final String descripcion;                  // Descripción detallada de la salud
  final List<ComponenteIndiceSalud> componentes; // Lista de componentes que contribuyen

  /// Constructor const para crear instancia inmutable
  const IndiceSaludIOT({
    required this.valor,          // Valor del índice obligatorio
    required this.estado,         // Estado obligatorio
    required this.descripcion,    // Descripción obligatoria
    required this.componentes,    // Lista de componentes obligatoria
  });
}

/// Clase que contiene las probabilidades de predicción del modelo IA
/// Cada campo representa la probabilidad de una condición específica
class PrediccionesIOT {
  final double healthy;       // Probabilidad de planta sana (%)
  final double earlyBlight;   // Probabilidad de tizón temprano (%)
  final double lateBlight;    // Probabilidad de tizón tardío (%)
  final double leafMold;      // Probabilidad de moho foliar (%)
  final double septoria;      // Probabilidad de mancha séptica (%)

  /// Constructor const para crear instancia inmutable
  const PrediccionesIOT({
    required this.healthy,       // Healthy obligatorio
    required this.earlyBlight,   // Early blight obligatorio
    required this.lateBlight,    // Late blight obligatorio
    required this.leafMold,      // Leaf mold obligatorio
    required this.septoria,      // Septoria obligatorio
  });
}

/// Clase que contiene el diagnóstico final del modelo IA
/// Incluye predicciones, confianza y descripción del resultado
class DiagnosticoFinalIOT {
  final PrediccionesIOT predicciones;  // Objeto con todas las predicciones del modelo
  final double confianzaFinal;         // Confianza del diagnóstico final (0-100%)
  final String diagnosticoFinal;       // Etiqueta del diagnóstico (ej: "Tomato_healthy")
  final String descripcion;            // Descripción detallada del diagnóstico
  final String otrasCondiciones;       // Información sobre otras condiciones analizadas

  /// Constructor const para crear instancia inmutable
  const DiagnosticoFinalIOT({
    required this.predicciones,       // Predicciones obligatorias
    required this.confianzaFinal,     // Confianza obligatoria
    required this.diagnosticoFinal,   // Diagnóstico obligatorio
    required this.descripcion,        // Descripción obligatoria
    required this.otrasCondiciones,   // Otras condiciones obligatorias
  });
}

/// Clase que contiene métricas de análisis de lesiones en la hoja
/// Cuantifica áreas afectadas por color y número de manchas
class MetricasLesionIOT {
  final double areaAfectadaPct;  // Porcentaje de área total afectada por lesiones
  final double areaAmarillaPct;  // Porcentaje de área con coloración amarilla
  final double areaMarronPct;    // Porcentaje de área con coloración marrón
  final int manchasDetectadas;   // Número de manchas o lesiones individuales detectadas

  /// Constructor const para crear instancia inmutable
  const MetricasLesionIOT({
    required this.areaAfectadaPct,     // Área afectada obligatoria
    required this.areaAmarillaPct,     // Área amarilla obligatoria
    required this.areaMarronPct,       // Área marrón obligatoria
    required this.manchasDetectadas,   // Manchas detectadas obligatorias
  });
}

/// Clase que contiene las rutas de las imágenes capturadas
/// Incluye imagen original y segmentada con estado de captura
class ImagenesIOT {
  final String original;       // Ruta de la imagen original capturada
  final String segmentada;     // Ruta de la imagen segmentada por el modelo
  final bool tieneCaptura;     // Indica si hay una imagen real capturada (true) o es placeholder (false)

  /// Constructor const para crear instancia inmutable
  const ImagenesIOT({
    required this.original,       // Ruta original obligatoria
    required this.segmentada,     // Ruta segmentada obligatoria
    required this.tieneCaptura,   // Estado de captura obligatorio
  });
}

/// Clase que contiene configuración del proceso de reconexión IoT
/// Define cuántos intentos se necesitan para establecer conexión exitosa
class ReconexionIOT {
  final int intentosParaExito;  // Número de intentos necesarios para reconectar

  /// Constructor const para crear instancia inmutable
  const ReconexionIOT({
    required this.intentosParaExito,  // Intentos obligatorios
  });
}

/// Clase principal que agrupa todos los datos del sistema IoT
/// Contiene toda la información de sensores, diagnóstico, imágenes y configuración
class DatosIOTSimulados {
  final MetaIOT meta;                                // Metadatos del sistema
  final CapturaIOT captura;                          // Configuración de captura
  final SensoresTiempoRealIOT sensoresTiempoReal;    // Lecturas de sensores principales
  final SensoresComplementariosIOT sensoresComplementarios; // Lecturas de sensores adicionales
  final IndiceSaludIOT indiceSalud;                  // Índice de salud general
  final DiagnosticoFinalIOT diagnosticoFinal;        // Diagnóstico del modelo IA
  final double accuracySistema;                      // Precisión general del sistema (%)
  final MetricasLesionIOT metricasLesion;            // Métricas de análisis de lesiones
  final ImagenesIOT imagenes;                        // Rutas de imágenes
  final ReconexionIOT reconexion;                    // Configuración de reconexión

  /// Constructor const para crear instancia inmutable con todos los componentes
  const DatosIOTSimulados({
    required this.meta,                        // Meta obligatoria
    required this.captura,                     // Captura obligatoria
    required this.sensoresTiempoReal,          // Sensores tiempo real obligatorios
    required this.sensoresComplementarios,     // Sensores complementarios obligatorios
    required this.indiceSalud,                 // Índice salud obligatorio
    required this.diagnosticoFinal,            // Diagnóstico final obligatorio
    required this.accuracySistema,             // Accuracy obligatorio
    required this.metricasLesion,              // Métricas lesión obligatorias
    required this.imagenes,                    // Imágenes obligatorias
    required this.reconexion,                  // Reconexión obligatoria
  });
}

/// Instancia const con todos los datos IoT simulados para pruebas
/// Representa un escenario típico con planta sana y condiciones óptimas
const datosIOTSimulados = DatosIOTSimulados(
  // ═══════════════════════════════════════════════════════════════════════════
  // METADATOS DEL SISTEMA
  // ═══════════════════════════════════════════════════════════════════════════
  meta: MetaIOT(
    titulo: 'AgroVision AI',           // Nombre del sistema
    fechaCaptura: '31 may 2026 · 10:24 am', // Timestamp de la captura
  ),
  // ═══════════════════════════════════════════════════════════════════════════
  // CONFIGURACIÓN DE CAPTURA
  // ═══════════════════════════════════════════════════════════════════════════
  captura: CapturaIOT(
    numeroPlanta: 1,                   // Monitoreando planta número 1
    intervaloNuevaCapturaMs: 45000,    // Nueva captura cada 45 segundos
  ),
  // ═══════════════════════════════════════════════════════════════════════════
  // SENSORES EN TIEMPO REAL
  // ═══════════════════════════════════════════════════════════════════════════
  sensoresTiempoReal: SensoresTiempoRealIOT(
    esp32: true,                       // ESP32 conectado
    temperaturaAireC: 22.0,            // 22°C (dentro del rango óptimo)
    temperaturaOptimaMin: 20,          // Temperatura mínima óptima: 20°C
    temperaturaOptimaMax: 27,          // Temperatura máxima óptima: 27°C
    temperaturaSensorMin: 5,           // Límite inferior del sensor DHT22
    temperaturaSensorMax: 45,          // Límite superior del sensor DHT22
    humedadAirePct: 65,                // 65% de humedad relativa (óptimo)
    humedadAireOptimaMin: 60,          // Humedad mínima óptima: 60%
    humedadAireOptimaMax: 80,          // Humedad máxima óptima: 80%
    alertaHumedad: 85,                 // Alerta si supera 85%
    humedadSueloPct: 75,               // 75% de humedad en suelo (bien hidratado)
    riegoMinimo: 40,                   // Activar riego si cae por debajo de 40%
    intensidadLuzLux: 52000,           // 52,000 lux (excelente para fotosíntesis)
    luzOptimaMin: 40000,               // Luz mínima óptima: 40,000 lux
    luzOptimaMax: 70000,               // Luz máxima óptima: 70,000 lux
    ciclo: 'diurno',                   // Ciclo diurno (día)
  ),
  // ═══════════════════════════════════════════════════════════════════════════
  // SENSORES COMPLEMENTARIOS
  // ═══════════════════════════════════════════════════════════════════════════
  sensoresComplementarios: SensoresComplementariosIOT(
    humedadHojaPct: 15.0,              // 15% de humedad foliar (baja)
    humedadHojaOptimaMin: 55,          // Humedad foliar mínima óptima: 55%
    humedadHojaOptimaMax: 85,          // Humedad foliar máxima óptima: 85%
    flujoAireMs: 0.8,                  // Flujo de aire: 0.8 m/s (buena ventilación)
    flujoAireRefMin: 0.3,              // Flujo mínimo recomendado: 0.3 m/s
    flujoAireRefMax: 1.5,              // Flujo máximo recomendado: 1.5 m/s
  ),
  // ═══════════════════════════════════════════════════════════════════════════
  // ÍNDICE DE SALUD GENERAL
  // ═══════════════════════════════════════════════════════════════════════════
  indiceSalud: IndiceSaludIOT(
    valor: 82,                         // Índice de salud: 82/100 (bueno)
    estado: 'Bueno — monitoreo regular', // Estado descriptivo
    descripcion: 'La planta muestra signos saludables. Se detectó leve amarillamiento (2.1 %). Revise la humedad del suelo esta tarde.', // Recomendación
    componentes: [
      ComponenteIndiceSalud(etiqueta: 'Detección IA', valor: 92),    // IA detectó 92% de salud
      ComponenteIndiceSalud(etiqueta: 'Área sana', valor: 79),       // 79% de área foliar sana
      ComponenteIndiceSalud(etiqueta: 'Color', valor: 80),           // 80% de color adecuado
    ],
  ),
  // ═══════════════════════════════════════════════════════════════════════════
  // DIAGNÓSTICO FINAL DEL MODELO IA
  // ═══════════════════════════════════════════════════════════════════════════
  diagnosticoFinal: DiagnosticoFinalIOT(
    predicciones: PrediccionesIOT(
      healthy: 92.4,                   // 92.4% probabilidad de planta sana
      earlyBlight: 4.2,                // 4.2% probabilidad de tizón temprano
      lateBlight: 1.9,                 // 1.9% probabilidad de tizón tardío
      leafMold: 0.9,                   // 0.9% probabilidad de moho foliar
      septoria: 0.5,                   // 0.5% probabilidad de mancha séptica
    ),
    confianzaFinal: 92.4,              // Confianza del modelo: 92.4%
    diagnosticoFinal: 'Tomato_healthy', // Diagnóstico: tomate sano
    descripcion: 'No se detectaron enfermedades activas. Las características de color, textura y morfología están dentro del rango normal.', // Descripción detallada
    otrasCondiciones: 'Otras 9 condiciones analizadas: < 0.1 % cada una', // Otras enfermedades descartadas
  ),
  accuracySistema: 94.16,              // Precisión general del sistema: 94.16%
  // ═══════════════════════════════════════════════════════════════════════════
  // MÉTRICAS DE ANÁLISIS DE LESIONES
  // ═══════════════════════════════════════════════════════════════════════════
  metricasLesion: MetricasLesionIOT(
    areaAfectadaPct: 0.0,              // 0% de área con lesiones activas
    areaAmarillaPct: 2.1,              // 2.1% de área con amarillamiento
    areaMarronPct: 1.4,                // 1.4% de área con coloración marrón
    manchasDetectadas: 0,              // 0 manchas o lesiones detectadas
  ),
  // ═══════════════════════════════════════════════════════════════════════════
  // IMÁGENES CAPTURADAS
  // ═══════════════════════════════════════════════════════════════════════════
  imagenes: ImagenesIOT(
    original: 'assets/imagenes/tomato-original.jpg',     // Ruta de imagen original
    segmentada: 'assets/imagenes/tomato-segmentada.jpg', // Ruta de imagen segmentada
    tieneCaptura: false,               // false = usando imágenes de placeholder
  ),
  // ═══════════════════════════════════════════════════════════════════════════
  // CONFIGURACIÓN DE RECONEXIÓN
  // ═══════════════════════════════════════════════════════════════════════════
  reconexion: ReconexionIOT(
    intentosParaExito: 2,              // Requiere 2 intentos para reconectar exitosamente
  ),
);
