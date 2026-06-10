import 'dart:async';
import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../navbars/barra-agricultor.dart';
import 'boton-iot.dart';
import 'modales/desconectar-dispositivo.dart';
import 'modales/guardar-reporte.dart';
import '../environments/datos-iot-simulados.dart';
import '../styles/agricultor-styles/panel-agricultor.dart';

// Simulated recommendations store since the TS code had RecomendacionesStore
const List<Map<String, dynamic>> recomendacionesSimuladas = [
  {
    'tipo': 'ok',
    'titulo': 'Continuar riego actual',
    'mensaje': 'La humedad del suelo es óptima.',
    'accion': 'Mantener plan de riego regular.',
  },
  {
    'tipo': 'warn',
    'titulo': 'Revisar intensidad de luz',
    'mensaje': 'La luz está un poco alta para la etapa actual.',
    'accion': 'Ajustar malla polisombra si es posible.',
  }
];

class PanelAgricultor extends StatefulWidget {
  const PanelAgricultor({super.key});

  @override
  State<PanelAgricultor> createState() => _PanelAgricultorState();
}

class _PanelAgricultorState extends State<PanelAgricultor> with TickerProviderStateMixin {
  bool _dispositivoConectado = false;
  bool _dispositivoDesconectado = false;
  final DatosIOTSimulados _datos = datosIOTSimulados;

  bool _isDisconnecting = false;
  bool _isReconnecting = false;
  String _errorReconexion = '';
  int _intentosReconexion = 0;
  String _fechaUltimaCaptura = '';

  Timer? _intervaloCaptura;
  late AnimationController _blinkController;

  @override
  void initState() {
    super.initState();
    _fechaUltimaCaptura = _datos.meta.fechaCaptura;
    _cargarEstadoLocal();

    _blinkController = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 1200),
    )..repeat(reverse: true);
  }

  Future<void> _cargarEstadoLocal() async {
    try {
      final prefs = await SharedPreferences.getInstance();
      setState(() {
        _dispositivoConectado = prefs.getString('dispositivoConectado') == 'true';
        _dispositivoDesconectado = prefs.getString('dispositivoDesconectado') == 'true';
      });

      if (_dispositivoConectado && !_dispositivoDesconectado) {
        _iniciarSimulacionCapturas();
      }
    } catch (e) {
      debugPrint('Error loading SharedPreferences: $e');
    }
  }

  @override
  void dispose() {
    _detenerSimulacionCapturas();
    _blinkController.dispose();
    super.dispose();
  }

  String get _etiquetaPlanta {
    final n = _datos.captura.numeroPlanta;
    return 'Planta #${n.toString().padLeft(2, '0')}';
  }

  void _guardarReporte() async {
    try {
      final ahora = DateTime.now();
      final reporte = {
        'id': ahora.millisecondsSinceEpoch,
        'fecha': ahora.toIso8601String().substring(0, 10),
        'hora': '${ahora.hour.toString().padLeft(2, '0')}:${ahora.minute.toString().padLeft(2, '0')}',
        'planta': _etiquetaPlanta,
        'diagnostico': _datos.diagnosticoFinal.diagnosticoFinal,
        'confianza': _datos.diagnosticoFinal.confianzaFinal,
        'salud': _datos.indiceSalud.valor,
      };

      final prefs = await SharedPreferences.getInstance();
      final strList = prefs.getString('agrovision_historial');
      List<dynamic> prev = strList != null ? json.decode(strList) : [];
      prev.insert(0, reporte);
      await prefs.setString('agrovision_historial', json.encode(prev));
      
      if (mounted) {
        showDialog(
          context: context,
          builder: (context) => AlertDialog(
            shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
            title: const Column(
              children: [
                FaIcon(FontAwesomeIcons.circleCheck, color: PanelAgricultorStyles.primaryGreen, size: 48),
                SizedBox(height: 16),
                Text('Reporte guardado correctamente', textAlign: TextAlign.center, style: TextStyle(fontSize: 20, fontWeight: FontWeight.w800, color: PanelAgricultorStyles.darkGreen)),
              ],
            ),
            content: const Text('El reporte se guardó con éxito y estará disponible en el historial.', textAlign: TextAlign.center, style: TextStyle(color: PanelAgricultorStyles.textGreen)),
            actions: [
              SizedBox(
                width: double.infinity,
                child: ElevatedButton(
                  onPressed: () => Navigator.pop(context),
                  style: ElevatedButton.styleFrom(
                    backgroundColor: PanelAgricultorStyles.primaryGreen,
                    padding: const EdgeInsets.symmetric(vertical: 12),
                    shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8)),
                  ),
                  child: const Text('Aceptar', style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold, fontSize: 15)),
                ),
              )
            ],
          )
        );
      }
    } catch (e) {
      debugPrint('Error guardando reporte: $e');
    }
  }

  void _onConectadoDispositivo(bool conectado) async {
    setState(() {
      _dispositivoConectado = conectado;
      _dispositivoDesconectado = false;
      _errorReconexion = '';
      _intentosReconexion = 0;
    });

    try {
      final prefs = await SharedPreferences.getInstance();
      await prefs.setString('dispositivoConectado', conectado ? 'true' : 'false');
      await prefs.setString('dispositivoDesconectado', 'false');
    } catch (e) { debugPrint('[PanelAgricultor] prefs write: $e'); }

    if (conectado) {
      _iniciarSimulacionCapturas();
    }
  }

  Future<void> _abrirModalDesconectar() async {
    final resultado = await showDialog<bool>(
      context: context,
      barrierDismissible: true,
      builder: (context) => const DesconectarDispositivo(),
    );

    if (resultado == true && mounted) {
      _desconectarDispositivo();
    }
  }

  void _desconectarDispositivo() {
    if (_isDisconnecting) return;
    setState(() => _isDisconnecting = true);
    _detenerSimulacionCapturas();
    
    Future.delayed(const Duration(seconds: 1), () async {
      if (!mounted) return;
      
      try {
        final prefs = await SharedPreferences.getInstance();
        await prefs.setString('dispositivoConectado', 'false');
        await prefs.setString('dispositivoDesconectado', 'true');
      } catch (e) { 
        debugPrint('[PanelAgricultor] prefs write: $e'); 
      }
      
      // Navegar al botón IoT
      if (mounted) {
        Navigator.pushReplacementNamed(context, '/boton-iot');
      }
    });
  }

  void _reconectarDispositivo() {
    if (_isReconnecting) return;
    setState(() {
      _isReconnecting = true;
      _errorReconexion = '';
    });

    Future.delayed(const Duration(seconds: 2), () async {
      if (!mounted) return;
      setState(() {
        _isReconnecting = false;
        _intentosReconexion++;
      });

      if (_intentosReconexion < _datos.reconexion.intentosParaExito) {
        setState(() {
          _errorReconexion = 'No se pudo conectar el dispositivo. Inténtelo de nuevo.';
        });
        return;
      }

      setState(() {
        _intentosReconexion = 0;
        _dispositivoDesconectado = false;
      });

      try {
        final prefs = await SharedPreferences.getInstance();
        await prefs.setString('dispositivoConectado', 'true');
        await prefs.setString('dispositivoDesconectado', 'false');
      } catch(e) { debugPrint('[PanelAgricultor] prefs write: $e'); }
      
      _iniciarSimulacionCapturas();
    });
  }

  void _iniciarSimulacionCapturas() {
    _detenerSimulacionCapturas();
    _intervaloCaptura = Timer.periodic(Duration(milliseconds: _datos.captura.intervaloNuevaCapturaMs), (timer) {
      if (_dispositivoDesconectado || !mounted) return;
      final ahora = DateTime.now();
      final meses = ['ene', 'feb', 'mar', 'abr', 'may', 'jun', 'jul', 'ago', 'sep', 'oct', 'nov', 'dic'];
      final dia = ahora.day;
      final mes = meses[ahora.month - 1];
      final anio = ahora.year;
      final horas = ahora.hour;
      final minutos = ahora.minute.toString().padLeft(2, '0');
      final periodo = horas >= 12 ? 'pm' : 'am';
      final hora12 = horas % 12 == 0 ? 12 : horas % 12;
      
      setState(() {
        _fechaUltimaCaptura = '$dia $mes $anio · $hora12:$minutos $periodo';
      });
    });
  }

  void _detenerSimulacionCapturas() {
    _intervaloCaptura?.cancel();
    _intervaloCaptura = null;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: PanelAgricultorStyles.backgroundLight,
      body: Column(
        children: [
          const BarraAgricultor(),
          Expanded(
            child: SingleChildScrollView(
              padding: const EdgeInsets.all(32.0),
              child: Center(
                child: ConstrainedBox(
                  constraints: const BoxConstraints(maxWidth: 1220),
                  child: _dispositivoConectado 
                    ? _buildDashboard() 
                    : SizedBox(
                        height: MediaQuery.of(context).size.height - 180,
                        child: Center(
                          child: BotonIOT(onConectado: _onConectadoDispositivo),
                        ),
                      ),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildDashboard() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: [
        _buildEncabezado(),
        const SizedBox(height: 14),
        _buildCaptura(),
        _buildSalud(),
        _buildSensores(),
        _buildDiagnostico(),
        _buildMetricas(),
        _buildRecomendaciones(),
        _buildConectividad(),
      ],
    );
  }

  Widget _buildEncabezado() {
    return Wrap(
      spacing: 12,
      runSpacing: 12,
      alignment: WrapAlignment.spaceBetween,
      crossAxisAlignment: WrapCrossAlignment.center,
      children: [
        Row(
          mainAxisSize: MainAxisSize.min,
          children: [
            FadeTransition(
              opacity: Tween<double>(begin: 1.0, end: 0.45).animate(_blinkController),
              child: Container(
                width: 9, height: 9,
                decoration: BoxDecoration(
                  shape: BoxShape.circle,
                  color: _dispositivoDesconectado ? const Color(0xFFB56C07) : PanelAgricultorStyles.primaryGreen,
                ),
              ),
            ),
            const SizedBox(width: 8),
            Text(_datos.meta.titulo, style: PanelAgricultorStyles.dashTitle),
          ],
        ),
        Wrap(
          spacing: 10,
          runSpacing: 10,
          crossAxisAlignment: WrapCrossAlignment.center,
          children: [
            InkWell(
              onTap: _dispositivoDesconectado ? null : _guardarReporte,
              child: Container(
                padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 10),
                decoration: PanelAgricultorStyles.btnGuardarDecoration.copyWith(
                  color: _dispositivoDesconectado ? Colors.grey : null,
                  gradient: _dispositivoDesconectado ? null : const LinearGradient(colors: [PanelAgricultorStyles.darkGreen, PanelAgricultorStyles.primaryGreen]),
                ),
                child: Row(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    FaIcon(FontAwesomeIcons.fileCircleCheck, color: _dispositivoDesconectado ? Colors.white54 : Colors.white, size: 14),
                    const SizedBox(width: 8),
                    Text('Guardar reporte', style: TextStyle(color: _dispositivoDesconectado ? Colors.white54 : Colors.white, fontWeight: FontWeight.bold, fontSize: 13)),
                  ],
                ),
              ),
            ),
            Container(
              padding: const EdgeInsets.symmetric(horizontal: 9, vertical: 4),
              decoration: BoxDecoration(
                color: _dispositivoDesconectado ? PanelAgricultorStyles.warnBg : PanelAgricultorStyles.sanoBg,
                borderRadius: BorderRadius.circular(99),
              ),
              child: Row(
                mainAxisSize: MainAxisSize.min,
                children: [
                  Container(
                    width: 6, height: 6,
                    decoration: BoxDecoration(
                      shape: BoxShape.circle,
                      color: _dispositivoDesconectado ? PanelAgricultorStyles.warnText : PanelAgricultorStyles.sanoText,
                    ),
                  ),
                  const SizedBox(width: 4),
                  Text(
                    _dispositivoDesconectado ? 'DISPOSITIVO DESCONECTADO' : 'DISPOSITIVO CONECTADO',
                    style: TextStyle(
                      fontSize: 10,
                      fontWeight: FontWeight.w800,
                      color: _dispositivoDesconectado ? PanelAgricultorStyles.warnText : PanelAgricultorStyles.sanoText,
                    ),
                  ),
                ],
              ),
            ),
          ],
        )
      ],
    );
  }

  Widget _buildSeccion(String titulo, dynamic icono, Widget contenido, {String? nota}) {
    return Container(
      margin: const EdgeInsets.only(bottom: 12),
      padding: const EdgeInsets.all(20),
      decoration: PanelAgricultorStyles.secDecoration,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          Row(
            children: [
              FaIcon(icono, color: PanelAgricultorStyles.primaryGreen, size: 16),
              const SizedBox(width: 7),
              Text(titulo, style: PanelAgricultorStyles.secHeadTitle),
            ],
          ),
          const SizedBox(height: 10),
          const Divider(color: PanelAgricultorStyles.borderGrey, height: 1, thickness: 1),
          const SizedBox(height: 14),
          contenido,
          if (nota != null) ...[
            const SizedBox(height: 12),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                const FaIcon(FontAwesomeIcons.circleInfo, color: Color(0xFF8FA69C), size: 10),
                const SizedBox(width: 4),
                Expanded(
                  child: Text(
                    nota,
                    textAlign: TextAlign.center,
                    style: const TextStyle(fontSize: 10, color: Color(0xFF8FA69C)),
                  ),
                ),
              ],
            )
          ]
        ],
      ),
    );
  }

  Widget _buildCaptura() {
    final tieneCaptura = _datos.imagenes.tieneCaptura;
    
    return _buildSeccion('Captura de imagen', FontAwesomeIcons.camera, Wrap(
      spacing: 10,
      runSpacing: 10,
      crossAxisAlignment: WrapCrossAlignment.center,
      children: [
        if (tieneCaptura)
          Container(
            width: 300,
            height: 200,
            decoration: BoxDecoration(
              border: Border.all(color: PanelAgricultorStyles.borderGrey),
              borderRadius: BorderRadius.circular(8),
              color: const Color(0xFFFBFDF9),
            ),
            child: Image.asset(_datos.imagenes.original, fit: BoxFit.contain),
          )
        else
          Container(
            width: 300,
            height: 140,
            decoration: PanelAgricultorStyles.imgPlaceholderDecoration,
            child: const Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                FaIcon(FontAwesomeIcons.camera, color: Color(0xFF8FA69C), size: 28),
                SizedBox(height: 6),
                Padding(
                  padding: EdgeInsets.symmetric(horizontal: 16),
                  child: Text('La imagen se capturará automáticamente con la cámara del dispositivo', textAlign: TextAlign.center, style: TextStyle(color: Color(0xFF8FA69C), fontSize: 12)),
                ),
                SizedBox(height: 4),
                Text('Esperando próxima captura...', style: TextStyle(color: PanelAgricultorStyles.primaryGreen, fontSize: 11, fontWeight: FontWeight.bold)),
              ],
            ),
          ),
        const SizedBox(width: 16),
        Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            const Text('Planta monitoreada', style: TextStyle(fontSize: 11, color: PanelAgricultorStyles.textGreen)),
            Text(_etiquetaPlanta, style: const TextStyle(fontSize: 13, fontWeight: FontWeight.bold, color: PanelAgricultorStyles.darkGreen)),
            const SizedBox(height: 16),
            const Text('Última captura', style: TextStyle(fontSize: 11, color: PanelAgricultorStyles.textGreen)),
            Text(_fechaUltimaCaptura, style: const TextStyle(fontSize: 13, fontWeight: FontWeight.bold, color: PanelAgricultorStyles.darkGreen)),
          ],
        )
      ],
    ));
  }

  Widget _buildSalud() {
    final salud = _datos.indiceSalud;
    return _buildSeccion('Índice de salud de la planta', FontAwesomeIcons.heartPulse, Wrap(
      spacing: 24,
      runSpacing: 24,
      crossAxisAlignment: WrapCrossAlignment.center,
      children: [
        Row(
          mainAxisSize: MainAxisSize.min,
          children: [
            Stack(
              alignment: Alignment.center,
              children: [
                SizedBox(
                  width: 86, height: 86,
                  child: CircularProgressIndicator(
                    value: salud.valor / 100,
                    strokeWidth: 7,
                    backgroundColor: PanelAgricultorStyles.borderGrey,
                    color: PanelAgricultorStyles.primaryGreen,
                  ),
                ),
                Column(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    Text('${salud.valor}%', style: const TextStyle(fontSize: 20, fontWeight: FontWeight.w800, color: PanelAgricultorStyles.darkGreen, height: 1)),
                    const Text('SALUD', style: TextStyle(fontSize: 10, color: PanelAgricultorStyles.textGreen, fontWeight: FontWeight.bold)),
                  ],
                )
              ],
            ),
            const SizedBox(width: 24),
            SizedBox(
              width: 160,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      const Padding(
                        padding: EdgeInsets.only(top: 2),
                        child: FaIcon(FontAwesomeIcons.circleCheck, color: Color(0xFF23730F), size: 13),
                      ),
                      const SizedBox(width: 5),
                      Expanded(
                        child: Text(salud.estado, style: const TextStyle(fontSize: 13, fontWeight: FontWeight.w800, color: Color(0xFF23730F))),
                      ),
                    ],
                  ),
                  const SizedBox(height: 5),
                  Text(salud.descripcion, style: const TextStyle(fontSize: 12, color: PanelAgricultorStyles.textGreen, height: 1.5)),
                ],
              )
            ),
          ],
        ),
        SizedBox(
          width: 240,
          child: Column(
            children: salud.componentes.map((comp) {
              return Padding(
                padding: const EdgeInsets.only(bottom: 6),
                child: Row(
                  children: [
                    SizedBox(width: 80, child: Text(comp.etiqueta, style: const TextStyle(fontSize: 11, color: PanelAgricultorStyles.textGreen))),
                    Expanded(
                      child: LinearProgressIndicator(
                        value: comp.valor / 100,
                        backgroundColor: const Color(0xFFEDF1EE),
                        color: PanelAgricultorStyles.primaryGreen,
                        minHeight: 5,
                        borderRadius: BorderRadius.circular(99),
                      ),
                    ),
                    SizedBox(width: 30, child: Text('${comp.valor}%', textAlign: TextAlign.right, style: const TextStyle(fontSize: 11, fontWeight: FontWeight.w800, color: PanelAgricultorStyles.darkGreen))),
                  ],
                ),
              );
            }).toList(),
          ),
        )
      ],
    ));
  }

  Widget _buildSensores() {
    final s = _datos.sensoresTiempoReal;
    final c = _datos.sensoresComplementarios;
    
    final tempOk = s.temperaturaAireC >= s.temperaturaOptimaMin && s.temperaturaAireC <= s.temperaturaOptimaMax;
    final humOk = s.humedadAirePct >= s.humedadAireOptimaMin && s.humedadAirePct <= s.humedadAireOptimaMax;
    final sueloOk = s.humedadSueloPct >= s.riegoMinimo;
    final luzOk = s.intensidadLuzLux >= s.luzOptimaMin && s.intensidadLuzLux <= s.luzOptimaMax;
    final hojaBaja = c.humedadHojaPct < c.humedadHojaOptimaMin;

    final tempPct = ((s.temperaturaAireC - s.temperaturaSensorMin) / (s.temperaturaSensorMax - s.temperaturaSensorMin)).clamp(0.0, 1.0);
    final humPct = (s.humedadAirePct / 100).clamp(0.0, 1.0);
    final sueloPct = ((s.humedadSueloPct - 10) / 90).clamp(0.0, 1.0);
    final luzPct = (s.intensidadLuzLux / 150000).clamp(0.0, 1.0);
    final hojaPct = (c.humedadHojaPct / 100).clamp(0.0, 1.0);
    final flujoPct = (c.flujoAireMs / 5).clamp(0.0, 1.0);

    return _buildSeccion('Lecturas de sensores', FontAwesomeIcons.towerBroadcast, LayoutBuilder(
      builder: (context, constraints) {
        int crossAxisCount = (constraints.maxWidth / 175).floor();
        if (crossAxisCount == 0) crossAxisCount = 1;
        final double spacing = 9.0;
        final double itemWidth = (constraints.maxWidth - (spacing * (crossAxisCount - 1))) / crossAxisCount;

        Widget buildSizedCard(Widget card) => SizedBox(width: itemWidth, child: card);

        return Wrap(
          spacing: spacing, runSpacing: spacing,
          children: [
            buildSizedCard(_buildSensorCard('Temperatura del aire', '${s.temperaturaAireC}', '°C', FontAwesomeIcons.temperatureHalf, tempPct, '#55a820', tempOk ? 'Óptimo' : 'Fuera de rango', tempOk ? PanelAgricultorStyles.sanoBg : PanelAgricultorStyles.warnBg, tempOk ? PanelAgricultorStyles.sanoText : PanelAgricultorStyles.warnText,
              ranges: ['${s.temperaturaSensorMin} °C', '${s.temperaturaSensorMax} °C'], optimo: 'Óptimo cultivo: ${s.temperaturaOptimaMin}–${s.temperaturaOptimaMax} °C', device: 'Rango sensor: ${s.temperaturaSensorMin}–${s.temperaturaSensorMax} °C'
            )),
            buildSizedCard(_buildSensorCard('Humedad del aire', '${s.humedadAirePct}', '%', FontAwesomeIcons.droplet, humPct, '#378ADD', humOk ? 'Normal' : 'Alerta', humOk ? PanelAgricultorStyles.sanoBg : PanelAgricultorStyles.warnBg, humOk ? PanelAgricultorStyles.sanoText : PanelAgricultorStyles.warnText,
              ranges: ['15 %', '100 %'], optimo: 'Óptimo cultivo: ${s.humedadAireOptimaMin}–${s.humedadAireOptimaMax} %', device: 'Rango sensor: 15–100 %'
            )),
            buildSizedCard(_buildSensorCard('Humedad del suelo', '${s.humedadSueloPct}', '%', FontAwesomeIcons.seedling, sueloPct, '#55a820', sueloOk ? 'Normal' : 'Riego necesario', sueloOk ? PanelAgricultorStyles.sanoBg : PanelAgricultorStyles.warnBg, sueloOk ? PanelAgricultorStyles.sanoText : PanelAgricultorStyles.warnText,
              ranges: ['10 %', '100 %'], optimo: 'Mínimo recomendado: ${s.riegoMinimo} %', device: 'Rango sensor: 10–100 %'
            )),
            buildSizedCard(_buildSensorCard('Intensidad de luz', '${(s.intensidadLuzLux / 1000).round()}k', 'lux', FontAwesomeIcons.sun, luzPct, '#b56c07', luzOk ? 'Óptimo' : 'Fuera de rango', luzOk ? PanelAgricultorStyles.sanoBg : PanelAgricultorStyles.warnBg, luzOk ? PanelAgricultorStyles.sanoText : PanelAgricultorStyles.warnText,
              ranges: ['0', '150 000 lux'], optimo: 'Óptimo cultivo: ${(s.luzOptimaMin/1000).round()}k–${(s.luzOptimaMax/1000).round()}k lux', device: 'Rango sensor: 0–150 000 lux'
            )),
            buildSizedCard(_buildSensorCard('Humedad de la hoja', '${c.humedadHojaPct}', '%', FontAwesomeIcons.leaf, hojaPct, '#b56c07', hojaBaja ? 'Bajo' : 'Normal', hojaBaja ? PanelAgricultorStyles.warnBg : PanelAgricultorStyles.sanoBg, hojaBaja ? PanelAgricultorStyles.warnText : PanelAgricultorStyles.sanoText,
              ranges: ['0 %', '100 %'], optimo: 'Óptimo cultivo: ${c.humedadHojaOptimaMin}–${c.humedadHojaOptimaMax} %', device: 'Rango sensor: 0–100 %',
              extraPillText: 'Estimado', extraPillBg: PanelAgricultorStyles.estBg, extraPillColor: PanelAgricultorStyles.estText, note: 'Sin sensor físico · calculado por IA'
            )),
            buildSizedCard(_buildSensorCard('Flujo de aire', '${c.flujoAireMs}', 'm/s', FontAwesomeIcons.wind, flujoPct, '#378ADD', 'Estimado', PanelAgricultorStyles.estBg, PanelAgricultorStyles.estText,
              ranges: ['0', '5 m/s'], optimo: 'Referencia invernadero: ${c.flujoAireRefMin}–${c.flujoAireRefMax} m/s', device: 'Rango sensor: 0–5 m/s', note: 'Sin sensor físico · calculado por IA'
            )),
          ],
        );
      }
    ));
  }

  Color _hexToColor(String code) {
    return Color(int.parse(code.substring(1, 7), radix: 16) + 0xFF000000);
  }

  Widget _buildSensorCard(String title, String val, String unit, dynamic icon, double pct, String colorHex, String pillText, Color pillBg, Color pillColor, {required List<String> ranges, required String optimo, required String device, String? extraPillText, Color? extraPillBg, Color? extraPillColor, String? note}) {
    return Container(
      padding: const EdgeInsets.all(12),
      decoration: PanelAgricultorStyles.scDecoration,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              FaIcon(icon, color: PanelAgricultorStyles.textGreen, size: 17),
              Wrap(
                spacing: 4,
                children: [
                  if (extraPillText != null && extraPillBg != null && extraPillColor != null)
                    Container(
                      padding: const EdgeInsets.symmetric(horizontal: 7, vertical: 2),
                      decoration: BoxDecoration(color: extraPillBg, borderRadius: BorderRadius.circular(99)),
                      child: Text(extraPillText, style: TextStyle(fontSize: 9, fontWeight: FontWeight.w800, color: extraPillColor)),
                    ),
                  Container(
                    padding: const EdgeInsets.symmetric(horizontal: 7, vertical: 2),
                    decoration: BoxDecoration(color: pillBg, borderRadius: BorderRadius.circular(99)),
                    child: Text(pillText, style: TextStyle(fontSize: 9, fontWeight: FontWeight.w800, color: pillColor)),
                  )
                ],
              )
            ],
          ),
          const SizedBox(height: 6),
          Text(title, style: const TextStyle(fontSize: 11, color: PanelAgricultorStyles.textGreen)),
          const SizedBox(height: 3),
          Row(
            crossAxisAlignment: CrossAxisAlignment.baseline,
            textBaseline: TextBaseline.alphabetic,
            children: [
              Text(val, style: const TextStyle(fontSize: 22, fontWeight: FontWeight.w800, color: PanelAgricultorStyles.darkGreen)),
              Text(' $unit', style: const TextStyle(fontSize: 12, color: PanelAgricultorStyles.textGreen)),
            ],
          ),
          const SizedBox(height: 7),
          LinearProgressIndicator(value: pct, color: _hexToColor(colorHex), backgroundColor: const Color(0xFFEDF1EE), minHeight: 4, borderRadius: BorderRadius.circular(99)),
          const SizedBox(height: 4),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(ranges.first, style: const TextStyle(fontSize: 9, color: Color(0xFF8FA69C))),
              Text(ranges.last, style: const TextStyle(fontSize: 9, color: Color(0xFF8FA69C))),
            ],
          ),
          const SizedBox(height: 6),
          Row(
            children: [
              const FaIcon(FontAwesomeIcons.circle, size: 6, color: Color(0xFF854F0B)),
              const SizedBox(width: 3),
              Expanded(child: Text(optimo, style: const TextStyle(fontSize: 9, color: Color(0xFF854F0B)), overflow: TextOverflow.ellipsis)),
            ],
          ),
          if (note != null) ...[
            const SizedBox(height: 4),
            Row(
              children: [
                const FaIcon(FontAwesomeIcons.circleInfo, size: 9, color: Color(0xFF174C7C)),
                const SizedBox(width: 3),
                Expanded(child: Text(note, style: const TextStyle(fontSize: 9, color: Color(0xFF174C7C)), overflow: TextOverflow.ellipsis)),
              ],
            ),
          ],
          const SizedBox(height: 6),
          const Divider(color: PanelAgricultorStyles.borderGrey, height: 1),
          const SizedBox(height: 6),
          Row(
            children: [
              const FaIcon(FontAwesomeIcons.microchip, size: 9, color: Color(0xFF8FA69C)),
              const SizedBox(width: 4),
              Expanded(child: Text(device, style: const TextStyle(fontSize: 9, color: Color(0xFF8FA69C)), overflow: TextOverflow.ellipsis)),
            ],
          )
        ],
      ),
    );
  }

  Widget _buildDiagnostico() {
    final diag = _datos.diagnosticoFinal;
    return _buildSeccion('Diagnóstico de la IA', FontAwesomeIcons.brain, Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Container(
              width: 42, height: 42,
              decoration: BoxDecoration(color: PanelAgricultorStyles.sanoBg, borderRadius: BorderRadius.circular(8)),
              child: const Center(child: FaIcon(FontAwesomeIcons.shieldHeart, color: PanelAgricultorStyles.sanoText, size: 22)),
            ),
            const SizedBox(width: 12),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(diag.diagnosticoFinal, style: const TextStyle(fontSize: 14, fontWeight: FontWeight.w800, color: PanelAgricultorStyles.darkGreen)),
                  Text(diag.descripcion, style: const TextStyle(fontSize: 12, color: PanelAgricultorStyles.textGreen, height: 1.5)),
                  const SizedBox(height: 7),
                  Row(
                    children: [
                      const Text('Resultado inteligente', style: TextStyle(fontSize: 11, color: PanelAgricultorStyles.textGreen)),
                      const SizedBox(width: 8),
                      Expanded(child: LinearProgressIndicator(value: diag.confianzaFinal / 100, color: PanelAgricultorStyles.primaryGreen, backgroundColor: const Color(0xFFEDF1EE), minHeight: 5, borderRadius: BorderRadius.circular(99))),
                      const SizedBox(width: 8),
                      Text('${diag.confianzaFinal} %', style: const TextStyle(fontSize: 11, fontWeight: FontWeight.w800, color: PanelAgricultorStyles.darkGreen)),
                    ],
                  )
                ],
              ),
            )
          ],
        )
      ],
    ));
  }

  Widget _buildMetricas() {
    final m = _datos.metricasLesion;
    return _buildSeccion('Métricas de lesión foliar', FontAwesomeIcons.microscope, Wrap(
      spacing: 9, runSpacing: 9,
      alignment: WrapAlignment.center,
      children: [
        _buildMetricaCard('% Área afectada', m.areaAfectadaPct.toString(), '%', FontAwesomeIcons.shapes, m.areaAfectadaPct, [10, 30, 100], ['0', '10', '30', '100'],
          [{'color': '#55a820', 'texto': 'Normal 0-10%'}, {'color': '#b56c07', 'texto': 'Alerta 10-30%'}, {'color': '#c62828', 'texto': 'Crítico >30%'}]),
        _buildMetricaCard('% Amarillo', m.areaAmarillaPct.toString(), '%', FontAwesomeIcons.sun, m.areaAmarillaPct, [5, 15, 100], ['0', '5', '15', '100'],
          [{'color': '#55a820', 'texto': 'Normal 0-5%'}, {'color': '#b56c07', 'texto': 'Alerta 5-15%'}, {'color': '#c62828', 'texto': 'Crítico >15%'}]),
        _buildMetricaCard('% Marrón', m.areaMarronPct.toString(), '%', FontAwesomeIcons.dropletSlash, m.areaMarronPct, [5, 20, 100], ['0', '5', '20', '100'],
          [{'color': '#55a820', 'texto': 'Normal 0-5%'}, {'color': '#b56c07', 'texto': 'Alerta 5-20%'}, {'color': '#c62828', 'texto': 'Crítico >20%'}]),
        _buildMetricaCard('Manchas', m.manchasDetectadas.toString(), '', FontAwesomeIcons.circleNodes, m.manchasDetectadas.toDouble(), [3, 10, 15], ['0', '3', '10', '15'],
          [{'color': '#55a820', 'texto': 'Normal 0-3'}, {'color': '#b56c07', 'texto': 'Alerta 4-10'}, {'color': '#c62828', 'texto': 'Crítico >10'}]),
      ],
    ), nota: 'Análisis realizado por visión artificial sobre la imagen capturada.');
  }

  Widget _buildMetricaCard(String title, String val, String unit, dynamic icon, double valor, List<double> umbralesMax, List<String> escalaLabels, List<Map<String, String>> leyenda) {
    Color pillBg = PanelAgricultorStyles.sanoBg;
    Color pillColor = PanelAgricultorStyles.sanoText;
    String pillText = 'Normal';
    
    if (valor <= umbralesMax[0]) {
      pillBg = PanelAgricultorStyles.sanoBg;
      pillColor = PanelAgricultorStyles.sanoText;
      pillText = 'Normal';
    } else if (valor <= umbralesMax[1]) {
      pillBg = PanelAgricultorStyles.warnBg;
      pillColor = PanelAgricultorStyles.warnText;
      pillText = 'Atención';
    } else {
      pillBg = PanelAgricultorStyles.critBg;
      pillColor = PanelAgricultorStyles.critText;
      pillText = 'Grave';
    }
    
    final dotLeft = (valor / umbralesMax.last).clamp(0.0, 1.0) * 100;

    return Container(
      width: 270,
      padding: const EdgeInsets.all(12),
      decoration: PanelAgricultorStyles.scDecoration,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Row(
                children: [
                  FaIcon(icon, color: PanelAgricultorStyles.primaryGreen, size: 14),
                  const SizedBox(width: 5),
                  Text(title, style: const TextStyle(fontSize: 11, fontWeight: FontWeight.w800, color: PanelAgricultorStyles.textGreen)),
                ],
              ),
              Container(
                padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 2),
                decoration: BoxDecoration(color: pillBg, borderRadius: BorderRadius.circular(99)),
                child: Text(pillText, style: TextStyle(fontSize: 9, fontWeight: FontWeight.w800, color: pillColor)),
              )
            ],
          ),
          const SizedBox(height: 7),
          Row(
            crossAxisAlignment: CrossAxisAlignment.baseline,
            textBaseline: TextBaseline.alphabetic,
            children: [
              Text(val, style: const TextStyle(fontSize: 24, fontWeight: FontWeight.w800, color: PanelAgricultorStyles.darkGreen)),
              Text(unit, style: const TextStyle(fontSize: 12, color: PanelAgricultorStyles.textGreen)),
            ],
          ),
          const SizedBox(height: 4),
          LayoutBuilder(
            builder: (context, constraints) {
              final double trackWidth = constraints.maxWidth;
              final double dotLeftPx = (trackWidth * (dotLeft / 100)) - 5.5; // -5.5 para centrar el punto de 11px
              
              return Stack(
                alignment: Alignment.centerLeft,
                clipBehavior: Clip.none,
                children: [
                  Container(
                    height: 7,
                    decoration: BoxDecoration(borderRadius: BorderRadius.circular(99)),
                    clipBehavior: Clip.antiAlias,
                    child: Row(
                      children: [
                        Expanded(child: Container(color: const Color(0xFFC0DD97))),
                        Expanded(child: Container(color: const Color(0xFFFAC775))),
                        Expanded(child: Container(color: const Color(0xFFF09595))),
                      ],
                    ),
                  ),
                  Positioned(
                    left: dotLeftPx.clamp(0.0, trackWidth - 11.0),
                    child: Container(
                      width: 11, height: 11,
                      decoration: BoxDecoration(
                        shape: BoxShape.circle,
                        color: pillColor,
                        border: Border.all(color: Colors.white, width: 2),
                      ),
                    ),
                  )
                ],
              );
            }
          ),
          const SizedBox(height: 4),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: escalaLabels.map((l) => Text(l, style: const TextStyle(fontSize: 9, color: Color(0xFF8FA69C)))).toList(),
          ),
          const SizedBox(height: 6),
          Wrap(
            spacing: 8,
            runSpacing: 4,
            children: leyenda.map((leg) => Row(
              mainAxisSize: MainAxisSize.min,
              children: [
                Container(width: 6, height: 6, decoration: BoxDecoration(shape: BoxShape.circle, color: _hexToColor(leg['color']!))),
                const SizedBox(width: 3),
                Text(leg['texto']!, style: const TextStyle(fontSize: 9, color: Color(0xFF8FA69C))),
              ],
            )).toList(),
          )
        ],
      ),
    );
  }

  Widget _buildRecomendaciones() {
    return _buildSeccion('Recomendaciones de acción', FontAwesomeIcons.clipboardList, Column(
      children: recomendacionesSimuladas.map((r) {
        return Container(
          margin: const EdgeInsets.only(bottom: 7),
          padding: const EdgeInsets.all(12),
          decoration: BoxDecoration(
            color: r['tipo'] == 'warn' ? PanelAgricultorStyles.warnBg : PanelAgricultorStyles.critBg,
            border: Border.all(color: r['tipo'] == 'warn' ? const Color(0xFFFAC775) : const Color(0xFFF7C1C1)),
            borderRadius: BorderRadius.circular(8),
          ),
          child: Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              FaIcon(r['tipo'] == 'warn' ? FontAwesomeIcons.droplet : FontAwesomeIcons.pumpMedical, color: r['tipo'] == 'warn' ? PanelAgricultorStyles.warnText : PanelAgricultorStyles.critText, size: 16),
              const SizedBox(width: 10),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(r['titulo'], style: const TextStyle(fontSize: 13, fontWeight: FontWeight.w800, color: PanelAgricultorStyles.darkGreen)),
                    Text(r['mensaje'], style: TextStyle(fontSize: 12, height: 1.5, color: r['tipo'] == 'warn' ? const Color(0xFF633806) : const Color(0xFF791F1F))),
                    const SizedBox(height: 8),
                    const Divider(color: Colors.white30, height: 1),
                    const SizedBox(height: 4),
                    Text('ACCIÓN RECOMENDADA:', style: TextStyle(fontSize: 10, fontWeight: FontWeight.w800, color: r['tipo'] == 'warn' ? const Color(0xFF854F0B) : const Color(0xFFA32626))),
                    Text(r['accion'], style: TextStyle(fontSize: 12, fontWeight: FontWeight.w600, color: r['tipo'] == 'warn' ? const Color(0xFF633806) : const Color(0xFF791F1F))),
                  ],
                ),
              )
            ],
          ),
        );
      }).toList(),
    ));
  }

  Widget _buildConectividad() {
    return _buildSeccion('Conectividad del dispositivo', FontAwesomeIcons.plug, Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          children: [
            FadeTransition(
              opacity: Tween<double>(begin: 1.0, end: 0.45).animate(_blinkController),
              child: Container(
                width: 10, height: 10,
                decoration: BoxDecoration(
                  shape: BoxShape.circle,
                  color: _dispositivoDesconectado ? const Color(0xFFB56C07) : PanelAgricultorStyles.primaryGreen,
                ),
              ),
            ),
            const SizedBox(width: 10),
            Text(_dispositivoDesconectado ? 'DISPOSITIVO DESCONECTADO' : 'DISPOSITIVO CONECTADO', style: TextStyle(fontSize: 14, fontWeight: FontWeight.w800, color: _dispositivoDesconectado ? const Color(0xFFB56C07) : const Color(0xFF23730F))),
          ],
        ),
        const SizedBox(height: 16),
        if (!_dispositivoDesconectado)
          ElevatedButton.icon(
            onPressed: _isDisconnecting ? null : _abrirModalDesconectar,
            icon: const FaIcon(FontAwesomeIcons.plug, size: 14),
            label: Text(_isDisconnecting ? 'Desconectando...' : 'Desconectar dispositivo'),
            style: ElevatedButton.styleFrom(
              backgroundColor: Colors.white,
              foregroundColor: PanelAgricultorStyles.critText,
              shadowColor: Colors.transparent,
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(8),
                side: const BorderSide(color: Color(0xFFE0B4B4)),
              ),
              padding: const EdgeInsets.symmetric(horizontal: 18, vertical: 10),
            ),
          )
        else
          ElevatedButton.icon(
            onPressed: _isReconnecting ? null : _reconectarDispositivo,
            icon: const FaIcon(FontAwesomeIcons.plug, size: 14),
            label: Text(_isReconnecting ? 'Reconectando...' : 'Reconectar Dispositivo'),
            style: ElevatedButton.styleFrom(
              backgroundColor: Colors.white,
              foregroundColor: const Color(0xFFF57F17),
              shadowColor: Colors.transparent,
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(8),
                side: const BorderSide(color: Color(0xFFFFE0B2)),
              ),
              padding: const EdgeInsets.symmetric(horizontal: 18, vertical: 10),
            ),
          ),
        if (_errorReconexion.isNotEmpty)
          Padding(
            padding: const EdgeInsets.only(top: 10),
            child: Text(_errorReconexion, style: const TextStyle(color: PanelAgricultorStyles.critText, fontSize: 13, fontWeight: FontWeight.bold)),
          )
      ],
    ));
  }
}
