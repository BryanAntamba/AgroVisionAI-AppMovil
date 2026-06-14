// ═══════════════════════════════════════════════════════════════════════════
// IMPORTACIONES
// ═══════════════════════════════════════════════════════════════════════════
import 'package:flutter/material.dart'; // Framework de Flutter
import 'package:font_awesome_flutter/font_awesome_flutter.dart'; // Iconos de FontAwesome
import '../../environments/historial.dart'; // Modelo RegistroHistorial
import '../../environments/modales-recomendacion.dart'; // Recomendaciones dinámicas
import '../../styles/agricultor-styles/modales-styles/modal-reporte.dart'; // Estilos del modal

// ═══════════════════════════════════════════════════════════════════════════
// WIDGET: ModalReporte - Modal detallado de reporte de análisis de planta
// ═══════════════════════════════════════════════════════════════════════════
/// Modal completo que muestra todos los detalles de un análisis de planta:
/// 
/// Secciones del reporte:
/// 1. Diagnóstico principal (enfermedad detectada)
/// 2. Métricas de salud y confianza de IA
/// 3. Probabilidades de todas las condiciones analizadas
/// 4. Lecturas de sensores IoT al momento del análisis
/// 5. Métricas de lesión (área afectada, colores, manchas)
/// 6. Recomendaciones de acción según diagnóstico
/// 
/// Características:
/// - Animaciones de entrada (fade-in + slide-up)
/// - Scrollable para dispositivos pequeños
/// - Responsive (máx 700px de ancho)
/// - Datos calculados dinámicamente según salud de la planta
class ModalReporte extends StatefulWidget {
  final RegistroHistorial registro; // Datos completos del análisis
  final VoidCallback onCerrar; // Callback para cerrar el modal

  /// Constructor del modal de reporte
  /// @param registro: Objeto con todos los datos del análisis
  /// @param onCerrar: Función a ejecutar al cerrar el modal
  const ModalReporte({
    super.key,
    required this.registro,
    required this.onCerrar,
  });

  @override
  State<ModalReporte> createState() => _ModalReporteState();
}

// ═══════════════════════════════════════════════════════════════════════════
// ESTADO: _ModalReporteState - Gestiona datos calculados, animaciones y UI
// ═══════════════════════════════════════════════════════════════════════════
class _ModalReporteState extends State<ModalReporte> with SingleTickerProviderStateMixin {
  // ─── DATOS CALCULADOS ───
  late List<({String nombre, double porcentaje})> predicciones = []; // Lista de probabilidades por condición
  late List<RecomendacionDashboard> recomendaciones = []; // Recomendaciones de acción

  // ─── ANIMACIONES ───
  late AnimationController _controller; // Controlador de animaciones (300ms)
  late Animation<double> _fadeAnimation; // Fade-in del overlay
  late Animation<Offset> _slideAnimation; // Slide-up del modal

  @override
  void initState() {
    super.initState();
    _cargarPredicciones(); // Genera predicciones según diagnóstico
    _cargarRecomendaciones(); // Carga recomendaciones desde store

    // Configura animaciones
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

    _controller.forward(); // Inicia animaciones
  }

  @override
  void dispose() {
    _controller.dispose(); // Libera recursos
    super.dispose();
  }

  // ═══════════════════════════════════════════════════════════════════════════
  // GETTERS CALCULADOS - Generan datos derivados del registro
  // ═══════════════════════════════════════════════════════════════════════════
  
  /// Formatea la fecha y hora en formato legible
  /// Ejemplo: "12 jun 2026 · 2:30 pm"
  String get _fechaFormateada {
    final meses = ['ene', 'feb', 'mar', 'abr', 'may', 'jun', 'jul', 'ago', 'sep', 'oct', 'nov', 'dic'];
    final partes = widget.registro.fecha.split('-'); // [año, mes, día]
    final anio = partes[0];
    final mes = meses[int.parse(partes[1]) - 1];
    final dia = int.parse(partes[2]);

    final horaPartes = widget.registro.hora.split(':'); // [horas, minutos]
    final horas = int.parse(horaPartes[0]);
    final minutos = horaPartes[1];
    final periodo = horas >= 12 ? 'pm' : 'am';
    final hora12 = horas % 12 == 0 ? 12 : horas % 12; // Convierte a formato 12 horas

    return '$dia $mes $anio · $hora12:$minutos $periodo';
  }

  /// true = planta sana (diagnóstico contiene "sano")
  /// false = planta con enfermedad detectada
  bool get _esSano => widget.registro.diagnostico.toLowerCase().contains('sano');

  /// Mensaje descriptivo del diagnóstico
  String get _mensajeDiagnostico {
    if (_esSano) {
      return 'No se detectaron enfermedades activas.';
    }
    return 'Se detectó: ${widget.registro.diagnostico}';
  }

  /// Estima humedad de hoja basándose en humedad de aire (30%) y suelo (20%)
  /// Fórmula: (humedadAire * 0.3 + humedadSuelo * 0.2) / 2
  int get _humedadHojaEstimada {
    return ((widget.registro.humedadAire * 0.3 + widget.registro.humedadSuelo * 0.2) / 2).round();
  }

  /// Flujo de aire estimado (valor fijo simulado: 0.8 m/s)
  double get _flujoAireEstimado => 0.8;

  /// Calcula porcentaje de área afectada basándose en la salud
  /// Si sano: 0%
  /// Si enfermo: (100 - salud)%, limitado entre 0 y 100
  int get _areaAfectada {
    if (_esSano) return 0;
    return ((100 - widget.registro.salud).clamp(0, 100)).toInt();
  }

  /// Porcentaje de coloración amarilla en la hoja
  /// Si sano: 2.1% (mínimo natural)
  /// Si enfermo: proporcional al área afectada (30% del daño), mín 2.1%
  double get _porcentajeAmarillo {
    if (_esSano) return 2.1;
    return ((100 - widget.registro.salud) * 0.3).clamp(2.1, 100);
  }

  /// Porcentaje de coloración marrón en la hoja
  /// Si sano: 1.4% (mínimo natural)
  /// Si enfermo: proporcional al área afectada (20% del daño), mín 1.4%
  double get _porcentajeMarron {
    if (_esSano) return 1.4;
    return ((100 - widget.registro.salud) * 0.2).clamp(1.4, 100);
  }

  /// Número de manchas detectadas
  /// Si sano: 0
  /// Si enfermo: 1 mancha por cada 10% de daño
  int get _manchasDetectadas {
    if (_esSano) return 0;
    return ((100 - widget.registro.salud) / 10).floor();
  }

  // ═══════════════════════════════════════════════════════════════════════════
  // MÉTODOS DE CARGA DE DATOS
  // ═══════════════════════════════════════════════════════════════════════════
  
  /// Genera lista de predicciones (probabilidades) según el diagnóstico
  /// Si la planta está sana: alta probabilidad de "Tomate sano", bajas para enfermedades
  /// Si tiene enfermedad: alta probabilidad de la enfermedad detectada, resto distribuido
  void _cargarPredicciones() {
    final enfermedades = [
      'Tomate sano',
      'Tizón temprano',
      'Tizón tardío',
      'Moho foliar',
      'Mancha séptica'
    ];

    if (_esSano) {
      // Planta sana: mayoría de probabilidad en "Tomate sano"
      predicciones = [
        (nombre: 'Tomate sano', porcentaje: widget.registro.confianza.toDouble()),
        (nombre: 'Tizón temprano', porcentaje: 4.2),
        (nombre: 'Tizón tardío', porcentaje: 1.9),
        (nombre: 'Moho foliar', porcentaje: 0.9),
        (nombre: 'Mancha séptica', porcentaje: 0.5),
      ];
    } else {
      // Planta enferma: mayoría en la enfermedad detectada
      final principal = widget.registro.diagnostico;
      final resto = enfermedades.where((e) => e != principal).toList();
      final restoPorcentaje = 100 - widget.registro.confianza;

      // Distribuye el porcentaje restante entre otras enfermedades
      predicciones = [
        (nombre: principal, porcentaje: widget.registro.confianza.toDouble()),
        (nombre: resto[0], porcentaje: restoPorcentaje * 0.5),   // 50% del resto
        (nombre: resto[1], porcentaje: restoPorcentaje * 0.25),  // 25% del resto
        (nombre: resto[2], porcentaje: restoPorcentaje * 0.15),  // 15% del resto
        (nombre: resto[3], porcentaje: restoPorcentaje * 0.1),   // 10% del resto
      ];
    }
  }

  /// Carga recomendaciones de acción desde el store
  void _cargarRecomendaciones() {
    recomendaciones = RecomendacionesStore.paraDashboard();
  }

  /// Mapea nombre de icono string a FaIconData
  /// Usado para mostrar iconos en las tarjetas de recomendaciones
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
          return SizedBox.expand(
            child: GestureDetector(
              onTap: widget.onCerrar,
              child: Container(
                width: double.infinity,
                height: double.infinity,
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
                                      onTap: widget.onCerrar,
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
                                      onTap: widget.onCerrar,
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