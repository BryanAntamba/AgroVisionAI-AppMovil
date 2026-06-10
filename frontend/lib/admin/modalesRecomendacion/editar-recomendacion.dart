import 'package:flutter/material.dart';
import '../../environments/modales-recomendacion.dart';
import '../../styles/admin-styles/recomendaciones.dart';

class EditarRecomendacion extends StatefulWidget {
  final RecomendacionRegistrada recomendacion;
  final VoidCallback onCerrar;
  final void Function(DatosRecomendacionForm) onGuardar;

  const EditarRecomendacion({
    super.key,
    required this.recomendacion,
    required this.onCerrar,
    required this.onGuardar,
  });

  @override
  State<EditarRecomendacion> createState() => _EditarRecomendacionState();
}

class _EditarRecomendacionState extends State<EditarRecomendacion> {
  late final TextEditingController _tituloCtrl;
  late final TextEditingController _descCtrl;
  late final TextEditingController _accionCtrl;
  late PrioridadRecomendacion _prioridad;
  late ColorRecomendacion _color;

  @override
  void initState() {
    super.initState();
    final ini = widget.recomendacion;
    _tituloCtrl = TextEditingController(text: ini.titulo);
    _descCtrl   = TextEditingController(text: ini.descripcion);
    _accionCtrl = TextEditingController(text: ini.accion);
    _prioridad  = ini.prioridad;
    _color      = ini.color;
  }

  @override
  void dispose() {
    _tituloCtrl.dispose();
    _descCtrl.dispose();
    _accionCtrl.dispose();
    super.dispose();
  }

  void _submit() {
    if (_tituloCtrl.text.trim().isEmpty || _descCtrl.text.trim().isEmpty) return;
    widget.onGuardar(DatosRecomendacionForm(
      titulo:      _tituloCtrl.text.trim(),
      descripcion: _descCtrl.text.trim(),
      accion:      _accionCtrl.text.trim(),
      prioridad:   _prioridad,
      color:       _color,
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
                border: Border.all(color: RecomendacionesStyles.borderGrey),
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
                          child: Text('Editar recomendación',
                              style: RecomendacionesStyles.h1Text.copyWith(fontSize: 22)),
                        ),
                        GestureDetector(
                          onTap: widget.onCerrar,
                          child: Container(
                            width: 40,
                            height: 40,
                            decoration: BoxDecoration(
                              color: RecomendacionesStyles.backgroundPage,
                              borderRadius: BorderRadius.circular(8),
                            ),
                            child: const Icon(Icons.close,
                                color: RecomendacionesStyles.darkGreen, size: 18),
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
                          _buildTextField('Título *', _tituloCtrl),
                          const SizedBox(height: 14),
                          _buildTextField('Descripción *', _descCtrl, maxLines: 3),
                          const SizedBox(height: 14),
                          _buildTextField('Acción recomendada', _accionCtrl, maxLines: 2),
                          const SizedBox(height: 14),
                          Row(
                            children: [
                              Expanded(
                                child: _buildDropdown<PrioridadRecomendacion>(
                                  label: 'Prioridad',
                                  value: _prioridad,
                                  items: PrioridadRecomendacion.values
                                      .map((p) => DropdownMenuItem(
                                            value: p,
                                            child: Text(p.label),
                                          ))
                                      .toList(),
                                  onChanged: (v) =>
                                      setState(() => _prioridad = v!),
                                ),
                              ),
                              const SizedBox(width: 14),
                              Expanded(
                                child: _buildDropdown<ColorRecomendacion>(
                                  label: 'Color',
                                  value: _color,
                                  items: ColorRecomendacion.values
                                      .map((c) => DropdownMenuItem(
                                            value: c,
                                            child: Text(c.label),
                                          ))
                                      .toList(),
                                  onChanged: (v) =>
                                      setState(() => _color = v!),
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
                      mainAxisAlignment: MainAxisAlignment.end,
                      children: [
                        GestureDetector(
                          onTap: widget.onCerrar,
                          child: Container(
                            constraints: const BoxConstraints(minHeight: 50),
                            padding: const EdgeInsets.symmetric(horizontal: 18),
                            decoration: BoxDecoration(
                              color: RecomendacionesStyles.backgroundInput,
                              border: Border.all(color: RecomendacionesStyles.borderGrey),
                              borderRadius: BorderRadius.circular(8),
                            ),
                            child: const Center(
                              child: Text('Cancelar', style: RecomendacionesStyles.labelText),
                            ),
                          ),
                        ),
                        const SizedBox(width: 10),
                        GestureDetector(
                          onTap: _submit,
                          child: Container(
                            constraints: const BoxConstraints(minHeight: 50),
                            padding: const EdgeInsets.symmetric(horizontal: 22),
                            decoration: RecomendacionesStyles.createBtnDecoration,
                            child: const Center(
                              child: Text(
                                'Guardar cambios',
                                style: TextStyle(
                                    color: Colors.white,
                                    fontSize: 16,
                                    fontWeight: FontWeight.w800),
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
      {int maxLines = 1}) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(label, style: RecomendacionesStyles.labelText),
        const SizedBox(height: 8),
        TextField(
          controller: ctrl,
          maxLines: maxLines,
          decoration: InputDecoration(
            contentPadding: const EdgeInsets.symmetric(horizontal: 14, vertical: 12),
            filled: true,
            fillColor: RecomendacionesStyles.backgroundInput,
            enabledBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(8),
              borderSide: const BorderSide(color: RecomendacionesStyles.borderInput),
            ),
            focusedBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(8),
              borderSide: const BorderSide(color: RecomendacionesStyles.primaryGreen, width: 1.5),
            ),
          ),
          style: const TextStyle(color: RecomendacionesStyles.darkGreen, fontSize: 14),
        ),
      ],
    );
  }

  Widget _buildDropdown<T>({
    required String label,
    required T value,
    required List<DropdownMenuItem<T>> items,
    required ValueChanged<T?> onChanged,
  }) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(label, style: RecomendacionesStyles.labelText),
        const SizedBox(height: 8),
        Container(
          height: 48,
          decoration: RecomendacionesStyles.inputDecoration(),
          padding: const EdgeInsets.symmetric(horizontal: 14),
          child: DropdownButtonHideUnderline(
            child: DropdownButton<T>(
              value: value,
              isExpanded: true,
              icon: const Icon(Icons.keyboard_arrow_down, color: RecomendacionesStyles.primaryGreen),
              style: const TextStyle(
                  color: RecomendacionesStyles.darkGreen,
                  fontSize: 14,
                  fontFamily: 'Arial'),
              items: items,
              onChanged: onChanged,
            ),
          ),
        ),
      ],
    );
  }
}
