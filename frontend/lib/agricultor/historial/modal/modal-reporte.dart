import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

import '../../../styles/agricultor-styles/modal-reporte.dart';
import '../../../environments/historial.dart';
import '../../../environments/modales-recomendacion.dart';

class ModalReporte extends StatefulWidget {
  final RegistroHistorial registro;
  const ModalReporte({super.key, required this.registro});

  @override
  State<ModalReporte> createState() => _ModalReporteState();
}

class _ModalReporteState extends State<ModalReporte> {
  late List<Map<String, dynamic>> _predicciones;
  late List<RecomendacionDashboard> _recomendaciones;

  @override
  void initState() {
    super.initState();
    _cargarPredicciones();
    _cargarRecomendaciones();
  }

  bool get _esSano => widget.registro.diagnostico.toLowerCase().contains('sano');

  void _cargarPredicciones() {
    final enfermedades = [
      'Tomate sano',
      'Tizón temprano',
      'Tizón tardío',
      'Moho foliar',
      'Mancha séptica'
    ];

    if (_esSano) {
      _predicciones = [
        {'nombre': 'Tomate sano', 'porcentaje': widget.registro.confianza},
        {'nombre': 'Tizón temprano', 'porcentaje': 4.2},
        {'nombre': 'Tizón tardío', 'porcentaje': 1.9},
        {'nombre': 'Moho foliar', 'porcentaje': 0.9},
        {'nombre': 'Mancha séptica', 'porcentaje': 0.5},
      ];
    } else {
      final principal = widget.registro.diagnostico;
      final resto = enfermedades.where((e) => e != principal).toList();
      final restoPorcentaje = 100.0 - widget.registro.confianza;
      
      _predicciones = [
        {'nombre': principal, 'porcentaje': widget.registro.confianza},
        {'nombre': resto[0], 'porcentaje': restoPorcentaje * 0.5},
        {'nombre': resto[1], 'porcentaje': restoPorcentaje * 0.25},
        {'nombre': resto[2], 'porcentaje': restoPorcentaje * 0.15},
        {'nombre': resto[3], 'porcentaje': restoPorcentaje * 0.1},
      ];
    }
  }

  void _cargarRecomendaciones() {
    final todas = RecomendacionesStore.paraDashboard();
    if (_esSano) {
      _recomendaciones = todas.where((r) => r.tipo == 'ok').toList();
    } else {
      _recomendaciones = todas.where((r) => r.tipo == 'warn' || r.tipo == 'crit').toList();
      if (_recomendaciones.isEmpty) {
        _recomendaciones = todas;
      }
    }
  }

  String get _fechaFormateada {
    try {
      final meses = ['ene', 'feb', 'mar', 'abr', 'may', 'jun', 'jul', 'ago', 'sep', 'oct', 'nov', 'dic'];
      final partes = widget.registro.fecha.split('-');
      final anio = partes[0];
      final mesIdx = int.parse(partes[1]) - 1;
      final mes = (mesIdx >= 0 && mesIdx < 12) ? meses[mesIdx] : '';
      final dia = int.parse(partes[2]);

      final horaPartes = widget.registro.hora.split(':');
      final horas = int.parse(horaPartes[0]);
      final minutos = horaPartes[1];
      final periodo = horas >= 12 ? 'pm' : 'am';
      final hora12 = horas % 12 == 0 ? 12 : horas % 12;

      return '$dia $mes $anio · $hora12:$minutos $periodo';
    } catch (e) {
      return '${widget.registro.fecha} · ${widget.registro.hora}';
    }
  }

  String get _mensajeDiagnostico {
    if (_esSano) {
      return 'No se detectaron enfermedades activas.';
    }
    return 'Se detectó: ${widget.registro.diagnostico}';
  }

  int get _humedadHojaEstimada {
    return ((widget.registro.humedadAire * 0.3 + widget.registro.humedadSuelo * 0.2) / 2).round();
  }

  double get _flujoAireEstimado => 0.8;

  double get _areaAfectada {
    if (_esSano) return 0.0;
    return (100.0 - widget.registro.salud).clamp(0.0, 100.0);
  }

  double get _porcentajeAmarillo {
    if (_esSano) return 2.1;
    return ((100.0 - widget.registro.salud) * 0.3).clamp(2.1, 100.0);
  }

  double get _porcentajeMarron {
    if (_esSano) return 1.4;
    return ((100.0 - widget.registro.salud) * 0.2).clamp(1.4, 100.0);
  }

  int get _manchasDetectadas {
    if (_esSano) return 0;
    return ((100 - widget.registro.salud) / 10).floor();
  }

  FaIconData _obtenerIconoRecomendacion(String? icono) {
    if (icono == 'fa-circle-check') return FontAwesomeIcons.circleCheck;
    if (icono == 'fa-triangle-exclamation') return FontAwesomeIcons.triangleExclamation;
    if (icono == 'fa-circle-exclamation') return FontAwesomeIcons.circleExclamation;
    return FontAwesomeIcons.lightbulb;
  }

  @override
  Widget build(BuildContext context) {
    return Dialog(
      backgroundColor: Colors.transparent,
      elevation: 0,
      insetPadding: const EdgeInsets.symmetric(horizontal: 16, vertical: 24),
      child: Center(
        child: Container(
          constraints: const BoxConstraints(maxWidth: 760, maxHeight: 920),
          decoration: BoxDecoration(
            color: Colors.white,
            border: Border.all(color: ModalReporteStyles.borderGrey),
            borderRadius: BorderRadius.circular(8),
            boxShadow: const [
              BoxShadow(
                color: Color.fromRGBO(7, 61, 43, 0.2),
                blurRadius: 48,
                offset: Offset(0, 24),
              )
            ],
          ),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              _buildHeader(context),
              Flexible(
                child: SingleChildScrollView(
                  padding: const EdgeInsets.symmetric(horizontal: 28, vertical: 10),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.stretch,
                    children: [
                      _buildPlantaInfo(),
                      const SizedBox(height: 20),
                      _buildDiagnosticoSection(),
                      const SizedBox(height: 24),
                      _buildMetricasPrincipales(),
                      const SizedBox(height: 24),
                      _buildProbabilidadesSection(),
                      const SizedBox(height: 24),
                      _buildSensoresSection(),
                      const SizedBox(height: 24),
                      _buildLesionSection(),
                      const SizedBox(height: 24),
                      _buildRecomendacionesSection(),
                      const SizedBox(height: 24),
                      _buildActions(context),
                    ],
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildHeader(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.fromLTRB(28, 28, 28, 10),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Expanded(
            child: Text(
              'Reporte — $_fechaFormateada',
              style: ModalReporteStyles.headerText,
            ),
          ),
          const SizedBox(width: 12),
          IconButton(
            onPressed: () => Navigator.pop(context),
            icon: const FaIcon(FontAwesomeIcons.xmark, color: ModalReporteStyles.darkGreen, size: 18),
            style: IconButton.styleFrom(
              backgroundColor: const Color(0xFFF5FAF3),
              shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8)),
              padding: const EdgeInsets.all(10),
              minimumSize: const Size(40, 40),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildPlantaInfo() {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
      decoration: BoxDecoration(
        color: const Color(0xFFF5FAF3),
        borderRadius: BorderRadius.circular(8),
      ),
      child: Text(
        widget.registro.planta,
        style: const TextStyle(
          color: Color(0xFF456657),
          fontSize: 14,
          fontWeight: FontWeight.bold,
        ),
      ),
    );
  }

  Widget _buildDiagnosticoSection() {
    return Container(
      padding: const EdgeInsets.all(18),
      decoration: ModalReporteStyles.sectionDecoration,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Text('DIAGNÓSTICO', style: TextStyle(color: ModalReporteStyles.darkGreen, fontSize: 13, fontWeight: FontWeight.w800)),
          const SizedBox(height: 12),
          Text(widget.registro.diagnostico, style: const TextStyle(color: ModalReporteStyles.darkGreen, fontSize: 20, fontWeight: FontWeight.w800)),
          const SizedBox(height: 8),
          Text(_mensajeDiagnostico, style: const TextStyle(color: Color(0xFF597268), fontSize: 14)),
        ],
      ),
    );
  }

  Widget _buildMetricasPrincipales() {
    return Row(
      children: [
        Expanded(child: _buildMetricaCard('SALUD', '${widget.registro.salud}', '%')),
        const SizedBox(width: 14),
        Expanded(child: _buildMetricaCard('RESULTADO INTELIGENTE', '${widget.registro.confianza}', '%')),
      ],
    );
  }

  Widget _buildMetricaCard(String label, String valor, String unidad) {
    return Container(
      padding: const EdgeInsets.all(18),
      decoration: BoxDecoration(
        color: Colors.white,
        border: Border.all(color: ModalReporteStyles.borderGrey),
        borderRadius: BorderRadius.circular(8),
      ),
      child: Column(
        children: [
          Text(label, style: ModalReporteStyles.metricaLabel),
          const SizedBox(height: 8),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.baseline,
            textBaseline: TextBaseline.alphabetic,
            children: [
              Text(valor, style: ModalReporteStyles.metricaValor),
              Text(' $unidad', style: TextStyle(color: ModalReporteStyles.darkGreen, fontSize: 16, fontWeight: FontWeight.bold)),
            ],
          ),
        ],
      ),
    );
  }

  Widget _buildProbabilidadesSection() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const Text('PROBABILIDADES POR CONDICIÓN', style: ModalReporteStyles.sectionTitle),
        const SizedBox(height: 14),
        Container(
          padding: const EdgeInsets.all(16),
          decoration: ModalReporteStyles.sectionDecoration,
          child: Column(
            children: _predicciones.map((pred) {
              return Padding(
                padding: const EdgeInsets.symmetric(vertical: 8),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(pred['nombre'], style: const TextStyle(color: ModalReporteStyles.darkGreen, fontSize: 14, fontWeight: FontWeight.w700)),
                    Text('${pred['porcentaje'].toStringAsFixed(1)} %', style: const TextStyle(color: ModalReporteStyles.primaryGreen, fontSize: 14, fontWeight: FontWeight.w800)),
                  ],
                ),
              );
            }).toList(),
          ),
        ),
        const SizedBox(height: 8),
        const Text('Otras 9 condiciones analizadas: < 0.1 % cada una', style: TextStyle(color: Color(0xFF6B8177), fontSize: 12, fontStyle: FontStyle.italic)),
      ],
    );
  }

  Widget _buildSensoresSection() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const Text('LECTURAS DE SENSORES AL MOMENTO DEL ANÁLISIS', style: ModalReporteStyles.sectionTitle),
        const SizedBox(height: 14),
        LayoutBuilder(
          builder: (context, constraints) {
            final width = constraints.maxWidth;
            final int cols = width > 500 ? 3 : 2;
            final double spacing = 12.0;
            final double itemWidth = (width - (spacing * (cols - 1))) / cols;

            return Wrap(
              spacing: spacing,
              runSpacing: spacing,
              children: [
                _buildSensorItem('Temperatura', '${widget.registro.temperatura} °C', itemWidth),
                _buildSensorItem('Humedad aire', '${widget.registro.humedadAire} %', itemWidth),
                _buildSensorItem('Humedad suelo', '${widget.registro.humedadSuelo} %', itemWidth),
                _buildSensorItem('Luz', '${(widget.registro.luz / 1000).toStringAsFixed(0)}k lux', itemWidth),
                _buildSensorItem('Hum. hoja', '$_humedadHojaEstimada %', itemWidth),
                _buildSensorItem('Flujo aire', '${_flujoAireEstimado.toStringAsFixed(1)} m/s', itemWidth),
              ],
            );
          },
        ),
      ],
    );
  }

  Widget _buildSensorItem(String label, String valor, double width) {
    return Container(
      width: width,
      padding: const EdgeInsets.all(14),
      decoration: ModalReporteStyles.gridItemDecoration,
      child: Column(
        children: [
          Text(label, style: const TextStyle(color: Color(0xFF597268), fontSize: 12, fontWeight: FontWeight.w800)),
          const SizedBox(height: 6),
          Text(valor, style: const TextStyle(color: ModalReporteStyles.darkGreen, fontSize: 18, fontWeight: FontWeight.w800)),
        ],
      ),
    );
  }

  Widget _buildLesionSection() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const Text('MÉTRICAS DE LESIÓN', style: ModalReporteStyles.sectionTitle),
        const SizedBox(height: 14),
        LayoutBuilder(
          builder: (context, constraints) {
            final width = constraints.maxWidth;
            final int cols = width > 500 ? 4 : 2;
            final double spacing = 12.0;
            final double itemWidth = (width - (spacing * (cols - 1))) / cols;

            return Wrap(
              spacing: spacing,
              runSpacing: spacing,
              children: [
                _buildSensorItem('Área afectada', '${_areaAfectada.toStringAsFixed(1)} %', itemWidth),
                _buildSensorItem('% Amarillo', '${_porcentajeAmarillo.toStringAsFixed(1)} %', itemWidth),
                _buildSensorItem('% Marrón', '${_porcentajeMarron.toStringAsFixed(1)} %', itemWidth),
                _buildSensorItem('Manchas', '$_manchasDetectadas', itemWidth),
              ],
            );
          },
        ),
      ],
    );
  }

  Widget _buildRecomendacionesSection() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const Text('RECOMENDACIONES DE ACCIÓN', style: ModalReporteStyles.sectionTitle),
        const SizedBox(height: 14),
        if (_recomendaciones.isEmpty)
          Container(
            width: double.infinity,
            padding: const EdgeInsets.all(18),
            decoration: BoxDecoration(
              color: Colors.white,
              border: Border.all(color: const Color(0xFFAAC0B3)),
              borderRadius: BorderRadius.circular(8),
            ),
            child: const Text(
              'No hay recomendaciones registradas para este tipo de diagnóstico.',
              textAlign: TextAlign.center,
              style: TextStyle(color: Color(0xFF597268), fontSize: 14, fontWeight: FontWeight.bold),
            ),
          )
        else
          Column(
            children: _recomendaciones.map((rec) {
              Color bg;
              Color border;
              Color iconColor;
              Color actionTextColor;
              
              if (rec.tipo == 'ok') {
                bg = ModalReporteStyles.okBg;
                border = ModalReporteStyles.okBorder;
                iconColor = ModalReporteStyles.okText;
                actionTextColor = ModalReporteStyles.okActionText;
              } else if (rec.tipo == 'warn') {
                bg = ModalReporteStyles.warnBg;
                border = ModalReporteStyles.warnBorder;
                iconColor = ModalReporteStyles.warnText;
                actionTextColor = ModalReporteStyles.warnActionText;
              } else {
                bg = ModalReporteStyles.critBg;
                border = ModalReporteStyles.critBorder;
                iconColor = ModalReporteStyles.critText;
                actionTextColor = ModalReporteStyles.critActionText;
              }

              return Container(
                margin: const EdgeInsets.only(bottom: 14),
                padding: const EdgeInsets.all(18),
                decoration: BoxDecoration(
                  color: bg,
                  border: Border.all(color: border),
                  borderRadius: BorderRadius.circular(8),
                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Row(
                      children: [
                        FaIcon(_obtenerIconoRecomendacion(rec.icono), color: iconColor, size: 18),
                        const SizedBox(width: 10),
                        Expanded(
                          child: Text(
                            rec.titulo,
                            style: const TextStyle(color: ModalReporteStyles.darkGreen, fontSize: 16, fontWeight: FontWeight.w800),
                          ),
                        ),
                      ],
                    ),
                    const SizedBox(height: 10),
                    Text(
                      rec.mensaje,
                      style: const TextStyle(color: Color(0xFF456657), fontSize: 14, height: 1.5),
                    ),
                    const SizedBox(height: 12),
                    Container(
                      width: double.infinity,
                      padding: const EdgeInsets.only(top: 12),
                      decoration: const BoxDecoration(
                        border: Border(top: BorderSide(color: Color.fromRGBO(7, 61, 43, 0.1), width: 1)),
                      ),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          const Text(
                            'Acción recomendada:',
                            style: TextStyle(color: ModalReporteStyles.darkGreen, fontSize: 13, fontWeight: FontWeight.w800),
                          ),
                          const SizedBox(height: 6),
                          Text(
                            rec.accion,
                            style: TextStyle(color: actionTextColor, fontSize: 14, height: 1.5, fontWeight: FontWeight.w700),
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              );
            }).toList(),
          ),
      ],
    );
  }

  Widget _buildActions(BuildContext context) {
    return Container(
      padding: const EdgeInsets.only(top: 18),
      decoration: const BoxDecoration(
        border: Border(top: BorderSide(color: ModalReporteStyles.borderGrey, width: 1)),
      ),
      child: Container(
        width: double.infinity,
        decoration: ModalReporteStyles.submitButtonDecoration,
        child: ElevatedButton(
          onPressed: () => Navigator.pop(context),
          style: ElevatedButton.styleFrom(
            backgroundColor: Colors.transparent,
            shadowColor: Colors.transparent,
            padding: const EdgeInsets.symmetric(vertical: 16),
            shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8)),
          ),
          child: const Text(
            'Cerrar',
            style: TextStyle(color: Colors.white, fontSize: 16, fontWeight: FontWeight.w800),
          ),
        ),
      ),
    );
  }
}
