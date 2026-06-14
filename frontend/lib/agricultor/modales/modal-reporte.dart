import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import '../../environments/historial.dart';
import '../../environments/modales-recomendacion.dart';
import '../../styles/agricultor-styles/modales-styles/modal-reporte.dart';

class ModalReporte extends StatefulWidget {
  final RegistroHistorial registro;

  const ModalReporte({
    Key? key,
    required this.registro,
  }) : super(key: key);

  @override
  State<ModalReporte> createState() => _ModalReporteState();
}

class _ModalReporteState extends State<ModalReporte> with SingleTickerProviderStateMixin {
  late List<({String nombre, double porcentaje})> predicciones = [];
  late List<RecomendacionDashboard> recomendaciones = [];

  late AnimationController _controller;
  late Animation<double> _fadeAnimation;
  late Animation<Offset> _slideAnimation;

  @override
  void initState() {
    super.initState();
    _cargarPredicciones();
    _cargarRecomendaciones();

    _controller = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 300),
    );
    
    _fadeAnimation = CurvedAnimation(
      parent: _controller,
      curve: const Interval(0.0, 0.66, curve: Curves.easeOut),
    );

    _slideAnimation = Tween<Offset>(
      begin: const Offset(0, 20),
      end: Offset.zero,
    ).animate(CurvedAnimation(
      parent: _controller,
      curve: Curves.easeOut,
    ));

    _controller.forward();
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  String get _fechaFormateada {
    final meses = ['ene', 'feb', 'mar', 'abr', 'may', 'jun', 'jul', 'ago', 'sep', 'oct', 'nov', 'dic'];
    final partes = widget.registro.fecha.split('-');
    final anio = partes[0];
    final mes = meses[int.parse(partes[1]) - 1];
    final dia = int.parse(partes[2]);

    final horaPartes = widget.registro.hora.split(':');
    final horas = int.parse(horaPartes[0]);
    final minutos = horaPartes[1];
    final periodo = horas >= 12 ? 'pm' : 'am';
    final hora12 = horas % 12 == 0 ? 12 : horas % 12;

    return '$dia $mes $anio · $hora12:$minutos $periodo';
  }

  bool get _esSano => widget.registro.diagnostico.toLowerCase().contains('sano');

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

  int get _areaAfectada {
    if (_esSano) return 0;
    return ((100 - widget.registro.salud).clamp(0, 100)).toInt();
  }

  double get _porcentajeAmarillo {
    if (_esSano) return 2.1;
    return ((100 - widget.registro.salud) * 0.3).clamp(2.1, 100);
  }

  double get _porcentajeMarron {
    if (_esSano) return 1.4;
    return ((100 - widget.registro.salud) * 0.2).clamp(1.4, 100);
  }

  int get _manchasDetectadas {
    if (_esSano) return 0;
    return ((100 - widget.registro.salud) / 10).floor();
  }

  void _cargarPredicciones() {
    final enfermedades = [
      'Tomate sano',
      'Tizón temprano',
      'Tizón tardío',
      'Moho foliar',
      'Mancha séptica'
    ];

    if (_esSano) {
      predicciones = [
        (nombre: 'Tomate sano', porcentaje: widget.registro.confianza.toDouble()),
        (nombre: 'Tizón temprano', porcentaje: 4.2),
        (nombre: 'Tizón tardío', porcentaje: 1.9),
        (nombre: 'Moho foliar', porcentaje: 0.9),
        (nombre: 'Mancha séptica', porcentaje: 0.5),
      ];
    } else {
      final principal = widget.registro.diagnostico;
      final resto = enfermedades.where((e) => e != principal).toList();
      final restoPorcentaje = 100 - widget.registro.confianza;

      predicciones = [
        (nombre: principal, porcentaje: widget.registro.confianza.toDouble()),
        (nombre: resto[0], porcentaje: restoPorcentaje * 0.5),
        (nombre: resto[1], porcentaje: restoPorcentaje * 0.25),
        (nombre: resto[2], porcentaje: restoPorcentaje * 0.15),
        (nombre: resto[3], porcentaje: restoPorcentaje * 0.1),
      ];
    }
  }

  void _cargarRecomendaciones() {
    recomendaciones = RecomendacionesStore.paraDashboard();
  }

  FaIconData _getIconData(String iconName) {
    switch (iconName) {
      case 'fa-circle-check': return FontAwesomeIcons.circleCheck;
      case 'fa-triangle-exclamation': return FontAwesomeIcons.triangleExclamation;
      case 'fa-circle-exclamation': return FontAwesomeIcons.circleExclamation;
      default: return FontAwesomeIcons.circleInfo;
    }
  }

  @override
  Widget build(BuildContext context) {
    return Material(
      type: MaterialType.transparency,
      child: AnimatedBuilder(
        animation: _controller,
        builder: (context, child) {
          return GestureDetector(
            onTap: () => Navigator.pop(context),
            child: Container(
              color: ModalReporteStyles.overlayColor.withValues(
                alpha: ModalReporteStyles.overlayColor.a * _fadeAnimation.value,
              ),
              child: Center(
                child: GestureDetector(
                  onTap: () {},
                  child: Transform.translate(
                    offset: _slideAnimation.value,
                    child: Opacity(
                      opacity: _controller.value,
                      child: Container(
                        constraints: BoxConstraints(
                          maxWidth: ModalReporteStyles.maxWidth,
                          maxHeight: MediaQuery.of(context).size.height * 0.92,
                        ),
                        margin: const EdgeInsets.symmetric(horizontal: 16, vertical: 24),
                        padding: const EdgeInsets.only(left: 28, right: 28, top: 28, bottom: 24),
                        decoration: ModalReporteStyles.modalDecoration,
                        child: SingleChildScrollView(
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            mainAxisSize: MainAxisSize.min,
                            children: [
                              Row(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Expanded(
                                    child: Text(
                                      'Reporte — $_fechaFormateada',
                                      style: ModalReporteStyles.headerStyle,
                                    ),
                                  ),
                                  const SizedBox(width: 12),
                                  GestureDetector(
                                    onTap: () => Navigator.pop(context),
                                    child: Container(
                                      width: 40,
                                      height: 40,
                                      decoration: ModalReporteStyles.closeBtnDecoration,
                                      child: const Center(
                                        child: FaIcon(
                                          FontAwesomeIcons.xmark,
                                          color: ModalReporteStyles.closeBtnColor,
                                          size: 18,
                                        ),
                                      ),
                                    ),
                                  ),
                                ],
                              ),
                              const SizedBox(height: 20),
                              Container(
                                width: double.infinity,
                                padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
                                decoration: ModalReporteStyles.plantaInfoDecoration,
                                child: Text(
                                  widget.registro.planta,
                                  style: ModalReporteStyles.plantaInfoStyle,
                                ),
                              ),
                              const SizedBox(height: 20),
                              Container(
                                padding: const EdgeInsets.all(18),
                                decoration: ModalReporteStyles.diagnosticoDecoration,
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    const Text(
                                      'DIAGNÓSTICO',
                                      style: ModalReporteStyles.sectionTitleStyle,
                                    ),
                                    const SizedBox(height: 12),
                                    Text(
                                      widget.registro.diagnostico,
                                      style: ModalReporteStyles.diagnosticoTitleStyle,
                                    ),
                                    const SizedBox(height: 8),
                                    Text(
                                      _mensajeDiagnostico,
                                      style: ModalReporteStyles.diagnosticoMessageStyle,
                                    ),
                                  ],
                                ),
                              ),
                              const SizedBox(height: 24),
                              Column(
                                children: [
                                  _buildMetricaCard('Salud', '${widget.registro.salud}%'),
                                  const SizedBox(height: 14),
                                  _buildMetricaCard('Resultado Inteligente', '${widget.registro.confianza}%'),
                                ],
                              ),
                              const SizedBox(height: 24),
                              _buildSection(
                                title: 'PROBABILIDADES POR CONDICIÓN',
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Container(
                                      padding: const EdgeInsets.all(16),
                                      decoration: ModalReporteStyles.prediccionesDecoration,
                                      child: Column(
                                        crossAxisAlignment: CrossAxisAlignment.start,
                                        children: [
                                          ...predicciones.map((pred) => _buildPrediccionItem(pred)),
                                        ],
                                      ),
                                    ),
                                    const SizedBox(height: 12),
                                    const Text(
                                      'Otras 9 condiciones analizadas: < 0.1 % cada una',
                                      style: ModalReporteStyles.otrasCondicionesStyle,
                                    ),
                                  ],
                                ),
                              ),
                              const SizedBox(height: 24),
                              _buildSection(
                                title: 'LECTURAS DE SENSORES AL MOMENTO DEL ANÁLISIS',
                                child: GridView.count(
                                  crossAxisCount: 3,
                                  mainAxisSpacing: 12,
                                  crossAxisSpacing: 12,
                                  shrinkWrap: true,
                                  physics: const NeverScrollableScrollPhysics(),
                                  children: [
                                    _buildSensorItem('Temperatura', '${widget.registro.temperatura}°C'),
                                    _buildSensorItem('Humedad aire', '${widget.registro.humedadAire}%'),
                                    _buildSensorItem('Humedad suelo', '${widget.registro.humedadSuelo}%'),
                                    _buildSensorItem('Luz', '${(widget.registro.luz / 1000).toStringAsFixed(0)}k lux'),
                                    _buildSensorItem('Hum. hoja', '$_humedadHojaEstimada%'),
                                    _buildSensorItem('Flujo aire', '${_flujoAireEstimado.toStringAsFixed(1)} m/s'),
                                  ],
                                ),
                              ),
                              const SizedBox(height: 24),
                              _buildSection(
                                title: 'MÉTRICAS DE LESIÓN',
                                child: GridView.count(
                                  crossAxisCount: 2,
                                  mainAxisSpacing: 12,
                                  crossAxisSpacing: 12,
                                  shrinkWrap: true,
                                  physics: const NeverScrollableScrollPhysics(),
                                  children: [
                                    _buildLesionItem('Área afectada', '$_areaAfectada%'),
                                    _buildLesionItem('% Amarillo', _porcentajeAmarillo.toStringAsFixed(1)),
                                    _buildLesionItem('% Marrón', _porcentajeMarron.toStringAsFixed(1)),
                                    _buildLesionItem('Manchas', '$_manchasDetectadas'),
                                  ],
                                ),
                              ),
                              const SizedBox(height: 24),
                              _buildSection(
                                title: 'RECOMENDACIONES DE ACCIÓN',
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: recomendaciones.isEmpty
                                      ? [
                                          Container(
                                            width: double.infinity,
                                            padding: const EdgeInsets.all(18),
                                            decoration: ModalReporteStyles.sinRecomendacionesDecoration,
                                            child: const Text(
                                              'No hay recomendaciones registradas para este tipo de diagnóstico.',
                                              textAlign: TextAlign.center,
                                              style: ModalReporteStyles.diagnosticoMessageStyle,
                                            ),
                                          ),
                                        ]
                                      : recomendaciones.map((rec) => _buildRecomendacionCard(rec)).toList(),
                                ),
                              ),
                              const SizedBox(height: 24),
                              SizedBox(
                                width: double.infinity,
                                height: 54,
                                child: Container(
                                  decoration: ModalReporteStyles.modalActionsDecoration,
                                  child: Material(
                                    color: Colors.transparent,
                                    child: InkWell(
                                      onTap: () => Navigator.pop(context),
                                      borderRadius: BorderRadius.circular(8),
                                      child: Container(
                                        decoration: ModalReporteStyles.submitBtnDecoration,
                                        child: const Center(
                                          child: Text(
                                            'Cerrar',
                                            style: ModalReporteStyles.submitBtnStyle,
                                          ),
                                        ),
                                      ),
                                    ),
                                  ),
                                ),
                              ),
                            ],
                          ),
                        ),
                      ),
                    ),
                  ),
                ),
              ),
            ),
          );
        },
      ),
    );
  }

  Widget _buildMetricaCard(String label, String value) {
    return Container(
      width: double.infinity,
      padding: const EdgeInsets.all(18),
      decoration: ModalReporteStyles.metricaDecoration,
      child: Column(
        children: [
          Text(
            label,
            textAlign: TextAlign.center,
            style: ModalReporteStyles.metricaLabelStyle,
          ),
          const SizedBox(height: 8),
          Text(
            value,
            textAlign: TextAlign.center,
            style: ModalReporteStyles.metricaValorStyle,
          ),
        ],
      ),
    );
  }

  Widget _buildSection({required String title, required Widget child}) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          title,
          style: ModalReporteStyles.sectionTitleStyle,
        ),
        const SizedBox(height: 14),
        child,
      ],
    );
  }

  Widget _buildPrediccionItem(({String nombre, double porcentaje}) pred) {
    return Column(
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text(
              pred.nombre,
              style: ModalReporteStyles.prediccionNombreStyle,
            ),
            Text(
              '${pred.porcentaje.toStringAsFixed(1)}%',
              style: ModalReporteStyles.prediccionValorStyle,
            ),
          ],
        ),
        if (pred != predicciones.last)
          Container(
            padding: const EdgeInsets.symmetric(vertical: 10),
            decoration: ModalReporteStyles.prediccionItemDecoration,
          )
        else
          const SizedBox(height: 10),
      ],
    );
  }

  Widget _buildSensorItem(String label, String value) {
    return Container(
      padding: const EdgeInsets.all(14),
      decoration: ModalReporteStyles.sensorLesionDecoration,
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Text(
            label,
            textAlign: TextAlign.center,
            style: ModalReporteStyles.sensorLesionLabelStyle,
          ),
          const SizedBox(height: 6),
          Text(
            value,
            textAlign: TextAlign.center,
            style: ModalReporteStyles.sensorLesionValorStyle,
          ),
        ],
      ),
    );
  }

  Widget _buildLesionItem(String label, String value) {
    return Container(
      padding: const EdgeInsets.all(14),
      decoration: ModalReporteStyles.sensorLesionDecoration,
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Text(
            label,
            textAlign: TextAlign.center,
            style: ModalReporteStyles.sensorLesionLabelStyle,
          ),
          const SizedBox(height: 6),
          Text(
            value,
            textAlign: TextAlign.center,
            style: ModalReporteStyles.sensorLesionValorStyle,
          ),
        ],
      ),
    );
  }

  Widget _buildRecomendacionCard(RecomendacionDashboard rec) {
    final backgroundColor = rec.tipo == 'ok'
        ? ModalReporteStyles.recomendacionOkDecoration.color
        : rec.tipo == 'warn'
            ? ModalReporteStyles.recomendacionWarnDecoration.color
            : ModalReporteStyles.recomendacionCritDecoration.color;

    final borderColor = rec.tipo == 'ok'
        ? ModalReporteStyles.recomendacionOkDecoration.border!.top.color
        : rec.tipo == 'warn'
            ? ModalReporteStyles.recomendacionWarnDecoration.border!.top.color
            : ModalReporteStyles.recomendacionCritDecoration.border!.top.color;

    final iconColor = rec.tipo == 'ok'
        ? ModalReporteStyles.iconOkColor
        : rec.tipo == 'warn'
            ? ModalReporteStyles.iconWarnColor
            : ModalReporteStyles.iconCritColor;

    return Container(
      margin: const EdgeInsets.only(bottom: 14),
      padding: const EdgeInsets.all(18),
      decoration: BoxDecoration(
        color: backgroundColor,
        border: Border.all(color: borderColor),
        borderRadius: BorderRadius.circular(8),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              FaIcon(_getIconData(rec.icono), color: iconColor, size: 18),
              const SizedBox(width: 10),
              Expanded(
                child: Text(
                  rec.titulo,
                  style: ModalReporteStyles.recHeaderStyle,
                ),
              ),
            ],
          ),
          const SizedBox(height: 10),
          Text(
            rec.mensaje,
            style: ModalReporteStyles.recMessageStyle,
          ),
          const SizedBox(height: 12),
          Container(
            padding: const EdgeInsets.only(top: 12),
            decoration: ModalReporteStyles.recAccionDecoration,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const Text(
                  'Acción recomendada:',
                  style: ModalReporteStyles.recAccionTitleStyle,
                ),
                const SizedBox(height: 6),
                Text(
                  rec.accion,
                  style: ModalReporteStyles.recMessageStyle,
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}