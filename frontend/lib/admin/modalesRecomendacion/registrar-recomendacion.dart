import 'package:flutter/material.dart';
import '../../environments/modales-recomendacion.dart';
import '../../styles/admin-styles/modalesRecomendacion-styles/registrar-recomendacion.dart';
import '../../shared/validators/panel-admin/recomendaciones-validaciones.dart';

class RegistrarRecomendacion extends StatefulWidget {
  final VoidCallback onCerrar;
  final void Function(DatosRecomendacionForm) onGuardar;

  const RegistrarRecomendacion({
    super.key,
    required this.onCerrar,
    required this.onGuardar,
  });

  @override
  State<RegistrarRecomendacion> createState() => _RegistrarRecomendacionState();
}

class _RegistrarRecomendacionState extends State<RegistrarRecomendacion> {
  late final TextEditingController _tituloCtrl;
  late final TextEditingController _descCtrl;
  late final TextEditingController _accionCtrl;
  PrioridadRecomendacion? _prioridad;
  ColorRecomendacion? _color;

  String? _errorTitulo;
  String? _errorDesc;
  String? _errorAccion;
  String? _errorPrioridad;
  String? _errorColor;

  @override
  void initState() {
    super.initState();
    _tituloCtrl = TextEditingController();
    _descCtrl   = TextEditingController();
    _accionCtrl = TextEditingController();
  }

  @override
  void dispose() {
    _tituloCtrl.dispose();
    _descCtrl.dispose();
    _accionCtrl.dispose();
    super.dispose();
  }

  void _submit() {
    setState(() {
      _errorTitulo = RecomendacionesValidaciones.mensajeTitulo(_tituloCtrl.text);
      _errorDesc = RecomendacionesValidaciones.mensajeDescripcion(_descCtrl.text);
      _errorAccion = RecomendacionesValidaciones.mensajeAccion(_accionCtrl.text);
      _errorPrioridad = RecomendacionesValidaciones.mensajeSelect(_prioridad?.toString(), 'La prioridad');
      _errorColor = RecomendacionesValidaciones.mensajeSelect(_color?.toString(), 'El color');
    });

    if (_errorTitulo != null || _errorDesc != null || _errorAccion != null || _errorPrioridad != null || _errorColor != null) {
      return;
    }

    widget.onGuardar(DatosRecomendacionForm(
      titulo:      _tituloCtrl.text.trim(),
      descripcion: _descCtrl.text.trim(),
      accion:      _accionCtrl.text.trim(),
      prioridad:   _prioridad!,
      color:       _color!,
    ));
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: widget.onCerrar,
      child: Container(
        color: const Color.fromRGBO(7, 61, 43, 0.45),
        child: Center(
          child: GestureDetector(
            onTap: () {},
            child: Container(
              constraints: const BoxConstraints(maxWidth: 580),
              margin: const EdgeInsets.all(24),
              decoration: BoxDecoration(
                color: Colors.white,
                border: Border.all(color: RegistrarRecomendacionStyles.borderGrey),
                borderRadius: BorderRadius.circular(8),
                boxShadow: const [
                  BoxShadow(
                    color: Color.fromRGBO(7, 61, 43, 0.2),
                    blurRadius: 48,
                    offset: Offset(0, 24),
                  ),
                ],
              ),
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  // Header fijo
                  Padding(
                    padding: const EdgeInsets.fromLTRB(28, 28, 28, 0),
                    child: Row(
                      children: [
                        Expanded(
                          child: Text('Registrar recomendación',
                              style: RegistrarRecomendacionStyles.h1Text.copyWith(fontSize: 22)),
                        ),
                        GestureDetector(
                          onTap: widget.onCerrar,
                          child: Container(
                            width: 40,
                            height: 40,
                            decoration: BoxDecoration(
                              color: RegistrarRecomendacionStyles.backgroundPage,
                              borderRadius: BorderRadius.circular(8),
                            ),
                            child: const Icon(Icons.close,
                                color: RegistrarRecomendacionStyles.darkGreen, size: 18),
                          ),
                        ),
                      ],
                    ),
                  ),
                  // Cuerpo con scroll
                  Flexible(
                    child: SingleChildScrollView(
                      padding: const EdgeInsets.fromLTRB(28, 20, 28, 0),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.stretch,
                        children: [
                          _buildTextField('Título', _tituloCtrl,
                              hint: 'Ej: Humedad foliar por debajo del óptimo',
                              errorText: _errorTitulo,
                              onChanged: (v) => setState(() => _errorTitulo = RecomendacionesValidaciones.mensajeTitulo(v))),
                          const SizedBox(height: 14),
                          _buildTextField('Descripción', _descCtrl,
                              hint: 'Descripción del hallazgo',
                              maxLines: 3,
                              errorText: _errorDesc,
                              onChanged: (v) => setState(() => _errorDesc = RecomendacionesValidaciones.mensajeDescripcion(v))),
                          const SizedBox(height: 14),
                          _buildTextField('Acción recomendada', _accionCtrl,
                              hint: 'Qué debe hacer el agricultor',
                              maxLines: 2,
                              errorText: _errorAccion,
                              onChanged: (v) => setState(() => _errorAccion = RecomendacionesValidaciones.mensajeAccion(v))),
                          const SizedBox(height: 14),
                          Row(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Expanded(
                                child: _buildDropdown<PrioridadRecomendacion>(
                                  label: 'Prioridad',
                                  hint: 'Seleccione prioridad',
                                  value: _prioridad,
                                  errorText: _errorPrioridad,
                                  items: PrioridadRecomendacion.values
                                      .map((p) => DropdownMenuItem(
                                            value: p,
                                            child: Text(p.label),
                                          ))
                                      .toList(),
                                  onChanged: (v) =>
                                      setState(() { _prioridad = v; _errorPrioridad = RecomendacionesValidaciones.mensajeSelect(v?.toString(), 'La prioridad'); }),
                                ),
                              ),
                              const SizedBox(width: 14),
                              Expanded(
                                child: _buildDropdown<ColorRecomendacion>(
                                  label: 'Color',
                                  hint: 'Seleccione color',
                                  value: _color,
                                  errorText: _errorColor,
                                  items: ColorRecomendacion.values
                                      .map((c) => DropdownMenuItem(
                                            value: c,
                                            child: Text(c.label),
                                          ))
                                      .toList(),
                                  onChanged: (v) =>
                                      setState(() { _color = v; _errorColor = RecomendacionesValidaciones.mensajeSelect(v?.toString(), 'El color'); }),
                                ),
                              ),
                            ],
                          ),
                          const SizedBox(height: 24),
                        ],
                      ),
                    ),
                  ),
                  // Footer fijo
                  Padding(
                    padding: const EdgeInsets.fromLTRB(28, 16, 28, 24),
                    child: Row(
                      children: [
                        Expanded(
                          child: GestureDetector(
                            onTap: widget.onCerrar,
                            child: Container(
                              constraints: const BoxConstraints(minHeight: 50),
                              padding: const EdgeInsets.symmetric(horizontal: 4),
                              decoration: BoxDecoration(
                                color: RegistrarRecomendacionStyles.backgroundInput,
                                border: Border.all(color: RegistrarRecomendacionStyles.borderGrey),
                                borderRadius: BorderRadius.circular(8),
                              ),
                              child: const Center(
                                child: Text('Cancelar', style: RegistrarRecomendacionStyles.labelText, textAlign: TextAlign.center),
                              ),
                            ),
                          ),
                        ),
                        const SizedBox(width: 10),
                        Expanded(
                          child: GestureDetector(
                            onTap: _submit,
                            child: Container(
                              constraints: const BoxConstraints(minHeight: 50),
                              padding: const EdgeInsets.symmetric(horizontal: 4),
                              decoration: RegistrarRecomendacionStyles.createBtnDecoration,
                              child: const Center(
                                child: Text(
                                  'Registrar recomendación',
                                  style: TextStyle(
                                      color: Colors.white,
                                      fontSize: 14,
                                      fontWeight: FontWeight.w800),
                                  textAlign: TextAlign.center,
                                ),
                              ),
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildTextField(String label, TextEditingController ctrl,
      {String hint = '', int maxLines = 1, String? errorText, void Function(String)? onChanged}) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(label, style: RegistrarRecomendacionStyles.labelText),
        const SizedBox(height: 8),
        TextField(
          controller: ctrl,
          maxLines: maxLines,
          onChanged: onChanged,
          decoration: InputDecoration(
            hintText: hint,
            errorText: errorText,
            hintStyle: const TextStyle(color: Color(0xFF6B8177), fontSize: 14),
            contentPadding: const EdgeInsets.symmetric(horizontal: 14, vertical: 12),
            filled: true,
            fillColor: RegistrarRecomendacionStyles.backgroundInput,
            enabledBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(8),
              borderSide: BorderSide(color: errorText != null ? Colors.red : RegistrarRecomendacionStyles.borderInput),
            ),
            focusedBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(8),
              borderSide: BorderSide(color: errorText != null ? Colors.red : RegistrarRecomendacionStyles.primaryGreen, width: 1.5),
            ),
            errorBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(8),
              borderSide: const BorderSide(color: Colors.red, width: 1.5),
            ),
            focusedErrorBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(8),
              borderSide: const BorderSide(color: Colors.red, width: 1.5),
            ),
          ),
          style: const TextStyle(color: RegistrarRecomendacionStyles.darkGreen, fontSize: 14),
        ),
      ],
    );
  }

  Widget _buildDropdown<T>({
    required String label,
    required T? value,
    required List<DropdownMenuItem<T>> items,
    required ValueChanged<T?> onChanged,
    required String hint,
    String? errorText,
  }) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(label, style: RegistrarRecomendacionStyles.labelText),
        const SizedBox(height: 8),
        Container(
          height: 48,
          decoration: RegistrarRecomendacionStyles.inputDecoration().copyWith(
            border: Border.all(color: errorText != null ? Colors.red : RegistrarRecomendacionStyles.borderInput),
          ),
          padding: const EdgeInsets.symmetric(horizontal: 14),
          child: DropdownButtonHideUnderline(
            child: DropdownButton<T>(
              value: value,
              hint: Text(hint, style: const TextStyle(color: Color(0xFF6B8177), fontSize: 14)),
              isExpanded: true,
              icon: const Icon(Icons.keyboard_arrow_down, color: RegistrarRecomendacionStyles.primaryGreen),
              style: const TextStyle(
                  color: RegistrarRecomendacionStyles.darkGreen,
                  fontSize: 14,
                  fontFamily: 'Arial'),
              items: items,
              onChanged: onChanged,
            ),
          ),
        ),
        if (errorText != null) ...[
          const SizedBox(height: 6),
          Text(errorText, style: const TextStyle(color: Colors.red, fontSize: 12)),
        ],
      ],
    );
  }
}
