class MetaIOT {
  final String titulo;
  final String fechaCaptura;

  const MetaIOT({
    required this.titulo,
    required this.fechaCaptura,
  });
}

class CapturaIOT {
  final int numeroPlanta;
  final int intervaloNuevaCapturaMs;

  const CapturaIOT({
    required this.numeroPlanta,
    required this.intervaloNuevaCapturaMs,
  });
}

class SensoresTiempoRealIOT {
  final bool esp32;
  final double temperaturaAireC;
  final int temperaturaOptimaMin;
  final int temperaturaOptimaMax;
  final int temperaturaSensorMin;
  final int temperaturaSensorMax;
  final int humedadAirePct;
  final int humedadAireOptimaMin;
  final int humedadAireOptimaMax;
  final int alertaHumedad;
  final int humedadSueloPct;
  final int riegoMinimo;
  final int intensidadLuzLux;
  final int luzOptimaMin;
  final int luzOptimaMax;
  final String ciclo;

  const SensoresTiempoRealIOT({
    required this.esp32,
    required this.temperaturaAireC,
    required this.temperaturaOptimaMin,
    required this.temperaturaOptimaMax,
    required this.temperaturaSensorMin,
    required this.temperaturaSensorMax,
    required this.humedadAirePct,
    required this.humedadAireOptimaMin,
    required this.humedadAireOptimaMax,
    required this.alertaHumedad,
    required this.humedadSueloPct,
    required this.riegoMinimo,
    required this.intensidadLuzLux,
    required this.luzOptimaMin,
    required this.luzOptimaMax,
    required this.ciclo,
  });
}

class SensoresComplementariosIOT {
  final double humedadHojaPct;
  final int humedadHojaOptimaMin;
  final int humedadHojaOptimaMax;
  final double flujoAireMs;
  final double flujoAireRefMin;
  final double flujoAireRefMax;

  const SensoresComplementariosIOT({
    required this.humedadHojaPct,
    required this.humedadHojaOptimaMin,
    required this.humedadHojaOptimaMax,
    required this.flujoAireMs,
    required this.flujoAireRefMin,
    required this.flujoAireRefMax,
  });
}

class ComponenteIndiceSalud {
  final String etiqueta;
  final int valor;

  const ComponenteIndiceSalud({
    required this.etiqueta,
    required this.valor,
  });
}

class IndiceSaludIOT {
  final int valor;
  final String estado;
  final String descripcion;
  final List<ComponenteIndiceSalud> componentes;

  const IndiceSaludIOT({
    required this.valor,
    required this.estado,
    required this.descripcion,
    required this.componentes,
  });
}

class PrediccionesIOT {
  final double healthy;
  final double earlyBlight;
  final double lateBlight;
  final double leafMold;
  final double septoria;

  const PrediccionesIOT({
    required this.healthy,
    required this.earlyBlight,
    required this.lateBlight,
    required this.leafMold,
    required this.septoria,
  });
}

class DiagnosticoFinalIOT {
  final PrediccionesIOT predicciones;
  final double confianzaFinal;
  final String diagnosticoFinal;
  final String descripcion;
  final String otrasCondiciones;

  const DiagnosticoFinalIOT({
    required this.predicciones,
    required this.confianzaFinal,
    required this.diagnosticoFinal,
    required this.descripcion,
    required this.otrasCondiciones,
  });
}

class MetricasLesionIOT {
  final double areaAfectadaPct;
  final double areaAmarillaPct;
  final double areaMarronPct;
  final int manchasDetectadas;

  const MetricasLesionIOT({
    required this.areaAfectadaPct,
    required this.areaAmarillaPct,
    required this.areaMarronPct,
    required this.manchasDetectadas,
  });
}

class ImagenesIOT {
  final String original;
  final String segmentada;
  final bool tieneCaptura;

  const ImagenesIOT({
    required this.original,
    required this.segmentada,
    required this.tieneCaptura,
  });
}

class ReconexionIOT {
  final int intentosParaExito;

  const ReconexionIOT({
    required this.intentosParaExito,
  });
}

class DatosIOTSimulados {
  final MetaIOT meta;
  final CapturaIOT captura;
  final SensoresTiempoRealIOT sensoresTiempoReal;
  final SensoresComplementariosIOT sensoresComplementarios;
  final IndiceSaludIOT indiceSalud;
  final DiagnosticoFinalIOT diagnosticoFinal;
  final double accuracySistema;
  final MetricasLesionIOT metricasLesion;
  final ImagenesIOT imagenes;
  final ReconexionIOT reconexion;

  const DatosIOTSimulados({
    required this.meta,
    required this.captura,
    required this.sensoresTiempoReal,
    required this.sensoresComplementarios,
    required this.indiceSalud,
    required this.diagnosticoFinal,
    required this.accuracySistema,
    required this.metricasLesion,
    required this.imagenes,
    required this.reconexion,
  });
}

const datosIOTSimulados = DatosIOTSimulados(
  meta: MetaIOT(
    titulo: 'AgroVision AI',
    fechaCaptura: '31 may 2026 · 10:24 am',
  ),
  captura: CapturaIOT(
    numeroPlanta: 1,
    intervaloNuevaCapturaMs: 45000,
  ),
  sensoresTiempoReal: SensoresTiempoRealIOT(
    esp32: true,
    temperaturaAireC: 22.0,
    temperaturaOptimaMin: 20,
    temperaturaOptimaMax: 27,
    temperaturaSensorMin: 5,
    temperaturaSensorMax: 45,
    humedadAirePct: 65,
    humedadAireOptimaMin: 60,
    humedadAireOptimaMax: 80,
    alertaHumedad: 85,
    humedadSueloPct: 75,
    riegoMinimo: 40,
    intensidadLuzLux: 52000,
    luzOptimaMin: 40000,
    luzOptimaMax: 70000,
    ciclo: 'diurno',
  ),
  sensoresComplementarios: SensoresComplementariosIOT(
    humedadHojaPct: 15.0,
    humedadHojaOptimaMin: 55,
    humedadHojaOptimaMax: 85,
    flujoAireMs: 0.8,
    flujoAireRefMin: 0.3,
    flujoAireRefMax: 1.5,
  ),
  indiceSalud: IndiceSaludIOT(
    valor: 82,
    estado: 'Bueno — monitoreo regular',
    descripcion: 'La planta muestra signos saludables. Se detectó leve amarillamiento (2.1 %). Revise la humedad del suelo esta tarde.',
    componentes: [
      ComponenteIndiceSalud(etiqueta: 'Detección IA', valor: 92),
      ComponenteIndiceSalud(etiqueta: 'Área sana', valor: 79),
      ComponenteIndiceSalud(etiqueta: 'Color', valor: 80),
    ],
  ),
  diagnosticoFinal: DiagnosticoFinalIOT(
    predicciones: PrediccionesIOT(
      healthy: 92.4,
      earlyBlight: 4.2,
      lateBlight: 1.9,
      leafMold: 0.9,
      septoria: 0.5,
    ),
    confianzaFinal: 92.4,
    diagnosticoFinal: 'Tomato_healthy',
    descripcion: 'No se detectaron enfermedades activas. Las características de color, textura y morfología están dentro del rango normal.',
    otrasCondiciones: 'Otras 9 condiciones analizadas: < 0.1 % cada una',
  ),
  accuracySistema: 94.16,
  metricasLesion: MetricasLesionIOT(
    areaAfectadaPct: 0.0,
    areaAmarillaPct: 2.1,
    areaMarronPct: 1.4,
    manchasDetectadas: 0,
  ),
  imagenes: ImagenesIOT(
    original: 'assets/imagenes/tomato-original.jpg',
    segmentada: 'assets/imagenes/tomato-segmentada.jpg',
    tieneCaptura: false,
  ),
  reconexion: ReconexionIOT(
    intentosParaExito: 2,
  ),
);
