import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../../navbars/barra-agricultor.dart';
import '../../styles/agricultor-styles/historial-styles/historial.dart';
import '../../environments/historial.dart';
import 'modal/modal-reporte.dart';

class Historial extends StatefulWidget {
  const Historial({super.key});

  @override
  State<Historial> createState() => _HistorialState();
}

class _HistorialState extends State<Historial> {
  final TextEditingController _searchController = TextEditingController();
  String _busqueda = '';
  String _filtroEstado = 'Todos';
  DateTime? _fechaInicio;
  DateTime? _fechaFin;

  List<RegistroHistorial> _registros = [];
  bool _isLoading = true;

  final FocusNode _searchFocusNode = FocusNode();
  final FocusNode _statusFocusNode = FocusNode();
  bool _searchFocused = false;
  bool _statusFocused = false;

  @override
  void initState() {
    super.initState();
    _cargarRegistros();

    _searchFocusNode.addListener(() {
      setState(() {
        _searchFocused = _searchFocusNode.hasFocus;
      });
    });
    _statusFocusNode.addListener(() {
      setState(() {
        _statusFocused = _statusFocusNode.hasFocus;
      });
    });
  }

  @override
  void dispose() {
    _searchController.dispose();
    _searchFocusNode.dispose();
    _statusFocusNode.dispose();
    super.dispose();
  }

  Future<void> _cargarRegistros() async {
    try {
      final prefs = await SharedPreferences.getInstance();
      final historialGuardado = prefs.getString('agrovision_historial');
      if (historialGuardado != null) {
        final List<dynamic> list = json.decode(historialGuardado);
        setState(() {
          _registros = list.map((item) {
            return RegistroHistorial(
              id: item['id'] ?? 0,
              fecha: item['fecha'] ?? '',
              hora: item['hora'] ?? '',
              planta: item['planta'] ?? '',
              diagnostico: item['diagnostico'] ?? '',
              confianza: (item['confianza'] as num?)?.toDouble() ?? 0.0,
              salud: (item['salud'] as num?)?.toInt() ?? 0,
              temperatura: (item['temperatura'] as num?)?.toDouble() ?? 22.0,
              humedadAire: (item['humedadAire'] as num?)?.toInt() ?? 65,
              humedadSuelo: (item['humedadSuelo'] as num?)?.toInt() ?? 75,
              luz: (item['luz'] as num?)?.toInt() ?? 50000,
            );
          }).toList();
          _isLoading = false;
        });
      } else {
        setState(() {
          _registros = [...historialSimulado];
          _isLoading = false;
        });
      }
    } catch (e) {
      debugPrint('Error cargando historial: $e');
      setState(() {
        _registros = [...historialSimulado];
        _isLoading = false;
      });
    }
  }

  String _normalizar(String valor) {
    var str = valor.toLowerCase().trim();
    str = str.replaceAll(RegExp(r'[áàäâ]'), 'a');
    str = str.replaceAll(RegExp(r'[éèëê]'), 'e');
    str = str.replaceAll(RegExp(r'[íìïî]'), 'i');
    str = str.replaceAll(RegExp(r'[óòöô]'), 'o');
    str = str.replaceAll(RegExp(r'[úùüû]'), 'u');
    return str;
  }

  String _obtenerEstado(int salud) {
    if (salud >= 80) return 'Sano';
    if (salud >= 50) return 'Alerta';
    return 'Crítico';
  }

  Color _obtenerColorTextoEstado(int salud) {
    final estado = _obtenerEstado(salud);
    if (estado == 'Sano') return HistorialStyles.sanoText;
    if (estado == 'Alerta') return HistorialStyles.alertaText;
    return HistorialStyles.criticoText;
  }

  Color _obtenerColorBgEstado(int salud) {
    final estado = _obtenerEstado(salud);
    if (estado == 'Sano') return HistorialStyles.sanoBg;
    if (estado == 'Alerta') return HistorialStyles.alertaBg;
    return HistorialStyles.criticoBg;
  }

  bool _coincideFecha(String fechaRegistroStr) {
    if (_fechaInicio == null && _fechaFin == null) {
      return true;
    }
    try {
      final dateParts = fechaRegistroStr.split('-');
      final fRegistro = DateTime(
        int.parse(dateParts[0]),
        int.parse(dateParts[1]),
        int.parse(dateParts[2]),
      );
      if (_fechaInicio != null && fRegistro.isBefore(_fechaInicio!)) {
        return false;
      }
      if (_fechaFin != null && fRegistro.isAfter(_fechaFin!.add(const Duration(days: 1)))) {
        return false;
      }
      return true;
    } catch (e) {
      return true;
    }
  }

  List<RegistroHistorial> get _registrosFiltrados {
    final termino = _normalizar(_busqueda);
    final filtrados = _registros.where((registro) {
      final diagnosticoNormalizado = _normalizar(registro.diagnostico);
      final coincidenciaBusqueda = termino.isEmpty || diagnosticoNormalizado.contains(termino);
      
      final estadoRegistro = _obtenerEstado(registro.salud);
      final coincidenciaEstado = _filtroEstado == 'Todos' || estadoRegistro == _filtroEstado;
      
      final coincidenciaFecha = _coincideFecha(registro.fecha);

      return coincidenciaBusqueda && coincidenciaEstado && coincidenciaFecha;
    }).toList();

    filtrados.sort((a, b) {
      try {
        final dateA = DateTime.parse('${a.fecha}T${a.hora.length == 5 ? a.hora : '${a.hora}:00'}');
        final dateB = DateTime.parse('${b.fecha}T${b.hora.length == 5 ? b.hora : '${b.hora}:00'}');
        return dateB.compareTo(dateA);
      } catch (e) {
        return b.id.compareTo(a.id);
      }
    });

    return filtrados;
  }

  int get _totalReportes => _registros.length;
  int get _totalSanos => _registros.where((r) => _obtenerEstado(r.salud) == 'Sano').length;
  int get _totalAlerta => _registros.where((r) => _obtenerEstado(r.salud) == 'Alerta').length;
  int get _totalCriticos => _registros.where((r) => _obtenerEstado(r.salud) == 'Crítico').length;

  String _formatearFecha(String fecha, String hora) {
    try {
      final meses = ['ene', 'feb', 'mar', 'abr', 'may', 'jun', 'jul', 'ago', 'sep', 'oct', 'nov', 'dic'];
      final partes = fecha.split('-');
      final anio = partes[0];
      final mesIdx = int.parse(partes[1]) - 1;
      final mes = (mesIdx >= 0 && mesIdx < 12) ? meses[mesIdx] : '';
      final dia = int.parse(partes[2]);

      final horaPartes = hora.split(':');
      final horas = int.parse(horaPartes[0]);
      final minutos = horaPartes[1];
      final periodo = horas >= 12 ? 'pm' : 'am';
      final hora12 = horas % 12 == 0 ? 12 : horas % 12;

      return '$dia $mes $anio · $hora12:$minutos $periodo';
    } catch (e) {
      return '$fecha · $hora';
    }
  }

  Future<void> _seleccionarFechaInicio(BuildContext context) async {
    final DateTime? picked = await showDatePicker(
      context: context,
      initialDate: _fechaInicio ?? DateTime.now(),
      firstDate: DateTime(2020),
      lastDate: DateTime(2030),
      builder: (context, child) {
        return Theme(
          data: Theme.of(context).copyWith(
            colorScheme: const ColorScheme.light(
              primary: HistorialStyles.primaryGreen,
              onPrimary: Colors.white,
              onSurface: HistorialStyles.darkGreen,
            ),
          ),
          child: child!,
        );
      },
    );
    if (picked != null && picked != _fechaInicio) {
      setState(() {
        _fechaInicio = picked;
      });
    }
  }

  Future<void> _seleccionarFechaFin(BuildContext context) async {
    final DateTime? picked = await showDatePicker(
      context: context,
      initialDate: _fechaFin ?? DateTime.now(),
      firstDate: DateTime(2020),
      lastDate: DateTime(2030),
      builder: (context, child) {
        return Theme(
          data: Theme.of(context).copyWith(
            colorScheme: const ColorScheme.light(
              primary: HistorialStyles.primaryGreen,
              onPrimary: Colors.white,
              onSurface: HistorialStyles.darkGreen,
            ),
          ),
          child: child!,
        );
      },
    );
    if (picked != null && picked != _fechaFin) {
      setState(() {
        _fechaFin = picked;
      });
    }
  }

  void _abrirReporte(RegistroHistorial registro) {
    showDialog(
      context: context,
      barrierColor: const Color.fromRGBO(7, 61, 43, 0.45),
      builder: (context) {
        return ModalReporte(registro: registro);
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    final screenWidth = MediaQuery.of(context).size.width;

    return Scaffold(
      backgroundColor: HistorialStyles.backgroundLight,
      body: _isLoading
          ? const Center(child: CircularProgressIndicator(color: HistorialStyles.primaryGreen))
          : Column(
              children: [
                const BarraAgricultor(),
                Expanded(
                  child: SingleChildScrollView(
                    padding: EdgeInsets.all(screenWidth > 700 ? 32.0 : 16.0),
                    child: Center(
                      child: ConstrainedBox(
                        constraints: const BoxConstraints(maxWidth: 1220),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.stretch,
                          children: [
                            _buildHeader(),
                            const SizedBox(height: 18),
                            _buildFilters(screenWidth),
                            const SizedBox(height: 18),
                            _buildSummaryStrip(screenWidth),
                            const SizedBox(height: 18),
                            _buildRecordsGrid(screenWidth),
                          ],
                        ),
                      ),
                    ),
                  ),
                ),
              ],
            ),
    );
  }

  Widget _buildHeader() {
    return const Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text('MONITOREO Y CONTROL', style: HistorialStyles.eyebrowText),
        SizedBox(height: 8),
        Text('Historial de Monitoreo', style: HistorialStyles.headerText),
        SizedBox(height: 10),
        Text(
          'Visualiza el historial de datos de tus sensores y monitorea la salud de tus cultivos.',
          style: HistorialStyles.headerDescription,
        ),
      ],
    );
  }

  Widget _buildFilters(double screenWidth) {
    final double spacing = 14.0;

    if (screenWidth > 1120) {
      // Desktop: 3 columns (Search, Status, Dates)
      return Container(
        padding: const EdgeInsets.all(18),
        decoration: HistorialStyles.containerDecoration,
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.end,
          children: [
            Expanded(flex: 15, child: _buildSearchField()),
            SizedBox(width: spacing),
            Expanded(flex: 8, child: _buildStatusField()),
            SizedBox(width: spacing),
            Expanded(flex: 13, child: _buildDateRangeField()),
          ],
        ),
      );
    } else if (screenWidth > 700) {
      // Tablet: Row for Search & Status, Column for Date below
      return Container(
        padding: const EdgeInsets.all(18),
        decoration: HistorialStyles.containerDecoration,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            Row(
              crossAxisAlignment: CrossAxisAlignment.end,
              children: [
                Expanded(child: _buildSearchField()),
                SizedBox(width: spacing),
                Expanded(child: _buildStatusField()),
              ],
            ),
            SizedBox(height: spacing),
            _buildDateRangeField(),
          ],
        ),
      );
    } else {
      // Mobile: Stacking all
      return Container(
        padding: const EdgeInsets.all(18),
        decoration: HistorialStyles.containerDecoration,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            _buildSearchField(),
            SizedBox(height: spacing),
            _buildStatusField(),
            SizedBox(height: spacing),
            _buildDateRangeField(),
          ],
        ),
      );
    }
  }

  Widget _buildSearchField() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const Text('Buscar diagnóstico', style: HistorialStyles.labelText),
        const SizedBox(height: 8),
        Container(
          height: 44,
          decoration: HistorialStyles.inputDecoration(_searchFocused),
          child: Row(
            children: [
              const Padding(
                padding: EdgeInsets.symmetric(horizontal: 12),
                child: FaIcon(FontAwesomeIcons.magnifyingGlass, color: HistorialStyles.primaryGreen, size: 16),
              ),
              Expanded(
                child: TextField(
                  focusNode: _searchFocusNode,
                  controller: _searchController,
                  decoration: const InputDecoration(
                    hintText: 'Ej: Tomate sano, Tizón temprano...',
                    border: InputBorder.none,
                    hintStyle: TextStyle(color: Color(0xFF8FA69C), fontSize: 13),
                    isDense: true,
                    contentPadding: EdgeInsets.symmetric(vertical: 12),
                  ),
                  style: const TextStyle(color: HistorialStyles.darkGreen, fontSize: 14, fontWeight: FontWeight.w700),
                  onChanged: (val) {
                    setState(() {
                      _busqueda = val;
                    });
                  },
                ),
              ),
            ],
          ),
        ),
      ],
    );
  }

  Widget _buildStatusField() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const Text('Estado', style: HistorialStyles.labelText),
        const SizedBox(height: 8),
        Container(
          height: 44,
          padding: const EdgeInsets.symmetric(horizontal: 12),
          decoration: HistorialStyles.inputDecoration(_statusFocused),
          child: DropdownButtonHideUnderline(
            child: DropdownButton<String>(
              value: _filtroEstado,
              focusNode: _statusFocusNode,
              icon: const FaIcon(FontAwesomeIcons.chevronDown, color: HistorialStyles.primaryGreen, size: 14),
              isExpanded: true,
              style: const TextStyle(color: HistorialStyles.darkGreen, fontSize: 14, fontWeight: FontWeight.w700),
              onChanged: (String? newValue) {
                if (newValue != null) {
                  setState(() {
                    _filtroEstado = newValue;
                  });
                }
              },
              items: <String>['Todos', 'Sano', 'Alerta', 'Crítico'].map<DropdownMenuItem<String>>((String value) {
                return DropdownMenuItem<String>(
                  value: value,
                  child: Text(value),
                );
              }).toList(),
            ),
          ),
        ),
      ],
    );
  }

  Widget _buildDateRangeField() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const Text('Rango de fecha', style: HistorialStyles.labelText),
        const SizedBox(height: 8),
        Row(
          children: [
            _buildDatePickerField(
              label: 'Fecha inicio',
              selectedDate: _fechaInicio,
              onTap: () => _seleccionarFechaInicio(context),
              onClear: () {
                setState(() {
                  _fechaInicio = null;
                });
              },
            ),
            const Padding(
              padding: EdgeInsets.symmetric(horizontal: 6),
              child: Text('al', style: TextStyle(color: HistorialStyles.textGreen, fontWeight: FontWeight.bold)),
            ),
            _buildDatePickerField(
              label: 'Fecha fin',
              selectedDate: _fechaFin,
              onTap: () => _seleccionarFechaFin(context),
              onClear: () {
                setState(() {
                  _fechaFin = null;
                });
              },
            ),
          ],
        ),
      ],
    );
  }

  Widget _buildDatePickerField({
    required String label,
    required DateTime? selectedDate,
    required VoidCallback onTap,
    required VoidCallback onClear,
  }) {
    return Expanded(
      child: InkWell(
        onTap: onTap,
        borderRadius: BorderRadius.circular(8),
        child: Container(
          height: 44,
          padding: const EdgeInsets.symmetric(horizontal: 10),
          decoration: HistorialStyles.inputDecoration(false),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Expanded(
                child: Row(
                  children: [
                    const FaIcon(FontAwesomeIcons.calendar, color: HistorialStyles.primaryGreen, size: 14),
                    const SizedBox(width: 8),
                    Expanded(
                      child: Text(
                        selectedDate != null
                            ? '${selectedDate.day}/${selectedDate.month}/${selectedDate.year}'
                            : label,
                        overflow: TextOverflow.ellipsis,
                        style: TextStyle(
                          color: selectedDate != null ? HistorialStyles.darkGreen : const Color(0xFF8FA69C),
                          fontSize: 13,
                          fontWeight: FontWeight.w700,
                        ),
                      ),
                    ),
                  ],
                ),
              ),
              if (selectedDate != null)
                IconButton(
                  padding: EdgeInsets.zero,
                  constraints: const BoxConstraints(),
                  icon: const FaIcon(FontAwesomeIcons.xmark, color: Color(0xFF8FA69C), size: 14),
                  onPressed: onClear,
                ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildSummaryStrip(double screenWidth) {
    final spacing = 14.0;
    
    if (screenWidth > 700) {
      return Row(
        children: [
          Expanded(child: _buildSummaryCard('$_totalReportes', 'Total de reportes')),
          SizedBox(width: spacing),
          Expanded(child: _buildSummaryCard('$_totalSanos', 'Sanos')),
          SizedBox(width: spacing),
          Expanded(child: _buildSummaryCard('$_totalAlerta', 'En alerta')),
          SizedBox(width: spacing),
          Expanded(child: _buildSummaryCard('$_totalCriticos', 'Críticos')),
        ],
      );
    } else {
      // Mobile: 2x2 grid
      return Column(
        children: [
          Row(
            children: [
              Expanded(child: _buildSummaryCard('$_totalReportes', 'Total de reportes')),
              SizedBox(width: spacing),
              Expanded(child: _buildSummaryCard('$_totalSanos', 'Sanos')),
            ],
          ),
          SizedBox(height: spacing),
          Row(
            children: [
              Expanded(child: _buildSummaryCard('$_totalAlerta', 'En alerta')),
              SizedBox(width: spacing),
              Expanded(child: _buildSummaryCard('$_totalCriticos', 'Críticos')),
            ],
          ),
        ],
      );
    }
  }

  Widget _buildSummaryCard(String value, String label) {
    return Container(
      padding: const EdgeInsets.all(18),
      decoration: HistorialStyles.containerDecoration,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(value, style: HistorialStyles.summaryNumber),
          const SizedBox(height: 5),
          Text(label, style: HistorialStyles.summaryLabel),
        ],
      ),
    );
  }

  Widget _buildRecordsGrid(double screenWidth) {
    final spacing = 16.0;
    final filteredList = _registrosFiltrados;

    if (filteredList.isEmpty) {
      return Container(
        width: double.infinity,
        padding: const EdgeInsets.all(26),
        decoration: BoxDecoration(
          color: Colors.white,
          border: Border.all(color: const Color(0xFFAAC0B3), width: 1, style: BorderStyle.solid),
          borderRadius: BorderRadius.circular(8),
        ),
        child: const Text(
          'No se encontraron reportes con los filtros seleccionados.',
          textAlign: TextAlign.center,
          style: TextStyle(color: Color(0xFF597268), fontSize: 14, fontWeight: FontWeight.w700),
        ),
      );
    }

    int cols = 1;
    if (screenWidth > 1120) {
      cols = 3;
    } else if (screenWidth > 700) {
      cols = 2;
    }

    final double width = screenWidth > 700 ? (screenWidth - (screenWidth > 1120 ? 64 : 32) * 2) : (screenWidth - 32);
    final double cardWidth = (width - (spacing * (cols - 1))) / cols;

    return Wrap(
      spacing: spacing,
      runSpacing: spacing,
      children: filteredList.map((registro) {
        return SizedBox(
          width: cardWidth,
          child: _buildRecordCard(registro),
        );
      }).toList(),
    );
  }

  Widget _buildRecordCard(RegistroHistorial registro) {
    return Container(
      padding: const EdgeInsets.all(20),
      decoration: HistorialStyles.containerDecoration,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          Row(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Container(
                width: 52,
                height: 52,
                decoration: BoxDecoration(
                  color: HistorialStyles.darkGreen,
                  borderRadius: BorderRadius.circular(8),
                ),
                child: const Center(
                  child: FaIcon(FontAwesomeIcons.leaf, color: Colors.white, size: 20),
                ),
              ),
              const SizedBox(width: 14),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      registro.diagnostico,
                      style: HistorialStyles.cardTitle,
                      overflow: TextOverflow.ellipsis,
                    ),
                    const SizedBox(height: 5),
                    Container(
                      padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 4),
                      decoration: BoxDecoration(
                        color: _obtenerColorBgEstado(registro.salud),
                        borderRadius: BorderRadius.circular(8),
                      ),
                      child: Text(
                        _obtenerEstado(registro.salud),
                        style: TextStyle(
                          color: _obtenerColorTextoEstado(registro.salud),
                          fontSize: 12,
                          fontWeight: FontWeight.w800,
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
          const SizedBox(height: 18),
          Row(
            children: [
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const Text('Fecha y Hora', style: HistorialStyles.dtText),
                    const SizedBox(height: 4),
                    Text(_formatearFecha(registro.fecha, registro.hora), style: HistorialStyles.ddText),
                  ],
                ),
              ),
            ],
          ),
          const SizedBox(height: 12),
          Row(
            children: [
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const Text('Salud', style: HistorialStyles.dtText),
                    const SizedBox(height: 4),
                    Text('${registro.salud} %', style: HistorialStyles.ddText),
                  ],
                ),
              ),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const Text('Resultado de la IA', style: HistorialStyles.dtText),
                    const SizedBox(height: 4),
                    Text('${registro.confianza} %', style: HistorialStyles.ddText),
                  ],
                ),
              ),
            ],
          ),
          const SizedBox(height: 18),
          OutlinedButton.icon(
            onPressed: () => _abrirReporte(registro),
            icon: const FaIcon(FontAwesomeIcons.circleInfo, size: 14, color: HistorialStyles.darkGreen),
            label: const Text('Ver reporte completo', style: TextStyle(color: HistorialStyles.darkGreen, fontWeight: FontWeight.w800, fontSize: 13)),
            style: OutlinedButton.styleFrom(
              backgroundColor: const Color(0xFFFBFDF9),
              side: const BorderSide(color: HistorialStyles.borderGrey),
              padding: const EdgeInsets.symmetric(vertical: 12),
              shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8)),
            ),
          ),
        ],
      ),
    );
  }
}
