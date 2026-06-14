import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import '../../environments/modales-recomendacion.dart';
import '../../styles/admin-styles/modalesRecomendacion-styles/editar-recomendacion.dart';
import '../../shared/validators/panel-admin/recomendaciones-validaciones.dart';


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

class _EditarRecomendacionState extends State<EditarRecomendacion> with SingleTickerProviderStateMixin {
  late final TextEditingController _tituloCtrl;
  late final TextEditingController _descCtrl;
  late final TextEditingController _accionCtrl;
  late PrioridadRecomendacion _prioridad;
  late ColorRecomendacion _color;

  late AnimationController _controller;
  late Animation<double> _fadeAnimation;
  late Animation<Offset> _slideAnimation;

  final FocusNode _tituloFocus = FocusNode();
  final FocusNode _descFocus = FocusNode();
  final FocusNode _accionFocus = FocusNode();

  bool _tituloFocused = false;
  bool _descFocused = false;
  bool _accionFocused = false;

  String? _errorTitulo;
  String? _errorDesc;
  String? _errorAccion;

  @override
  void initState() {
    super.initState();
    final ini = widget.recomendacion;
    _tituloCtrl = TextEditingController(text: ini.titulo);
    _descCtrl   = TextEditingController(text: ini.descripcion);
    _accionCtrl = TextEditingController(text: ini.accion);
    _prioridad  = ini.prioridad;
    _color      = ini.color;

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

    _tituloFocus.addListener(() => setState(() => _tituloFocused = _tituloFocus.hasFocus));
    _descFocus.addListener(() => setState(() => _descFocused = _descFocus.hasFocus));
    _accionFocus.addListener(() => setState(() => _accionFocused = _accionFocus.hasFocus));

    _controller.forward();
  }

  @override
  void dispose() {
    _tituloCtrl.dispose();
    _descCtrl.dispose();
    _accionCtrl.dispose();
    _tituloFocus.dispose();
    _descFocus.dispose();
    _accionFocus.dispose();
    _controller.dispose();
    super.dispose();
  }

  void _submit() {
    setState(() {
      _errorTitulo = RecomendacionesValidaciones.mensajeTitulo(_tituloCtrl.text);
      _errorDesc = RecomendacionesValidaciones.mensajeDescripcion(_descCtrl.text);
      _errorAccion = RecomendacionesValidaciones.mensajeAccion(_accionCtrl.text);
    });

    if (_errorTitulo != null || _errorDesc != null || _errorAccion != null) {
      return;
    }

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
    final isMobile = MediaQuery.of(context).size.width < 700;

    return Material(
      type: MaterialType.transparency,
      child: AnimatedBuilder(
        animation: _controller,
        builder: (context, child) {
          return GestureDetector(
            onTap: widget.onCerrar,
            child: Container(
              color: EditarRecomendacionStyles.overlayColor.withValues(
                alpha: EditarRecomendacionStyles.overlayColor.a * _fadeAnimation.value,
              ),
              child: Center(
                child: GestureDetector(
                  onTap: () {}, // Prevent tap from bubbling up
                  child: Transform.translate(
                    offset: _slideAnimation.value,
                    child: Opacity(
                      opacity: _controller.value,
                      child: Container(
                        constraints: const BoxConstraints(maxWidth: 760),
                        margin: const EdgeInsets.symmetric(horizontal: 16, vertical: 24),
                        padding: const EdgeInsets.only(left: 28, right: 28, top: 28, bottom: 24),
                        decoration: EditarRecomendacionStyles.modalDecoration,
                        child: SingleChildScrollView(
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            mainAxisSize: MainAxisSize.min,
                            children: [
                              Stack(
                                children: [
                                  Padding(
                                    padding: const EdgeInsets.only(right: 44, bottom: 22),
                                    child: Text(
                                      'Editar recomendación',
                                      style: EditarRecomendacionStyles.titleStyle,
                                    ),
                                  ),
                                  Positioned(
                                    top: -10,
                                    right: -10,
                                    child: GestureDetector(
                                      onTap: widget.onCerrar,
                                      child: Container(
                                        width: 40,
                                        height: 40,
                                        decoration: EditarRecomendacionStyles.closeBtnDecoration,
                                        child: const Center(
                                          child: FaIcon(
                                            FontAwesomeIcons.xmark,
                                            color: EditarRecomendacionStyles.darkGreen,
                                            size: 18,
                                          ),
                                        ),
                                      ),
                                    ),
                                  ),
                                ],
                              ),
                              _buildTextField(
                                label: 'Título',
                                ctrl: _tituloCtrl,
                                icon: FontAwesomeIcons.heading,
                                focusNode: _tituloFocus,
                                isFocused: _tituloFocused,
                                errorText: _errorTitulo,
                                onChanged: (v) => setState(() => _errorTitulo = RecomendacionesValidaciones.mensajeTitulo(v)),
                              ),
                              const SizedBox(height: 14),
                              _buildTextField(
                                label: 'Descripción',
                                ctrl: _descCtrl,
                                focusNode: _descFocus,
                                isFocused: _descFocused,
                                maxLines: 3,
                                errorText: _errorDesc,
                                onChanged: (v) => setState(() => _errorDesc = RecomendacionesValidaciones.mensajeDescripcion(v)),
                              ),
                              const SizedBox(height: 14),
                              _buildTextField(
                                label: 'Acción recomendada',
                                ctrl: _accionCtrl,
                                focusNode: _accionFocus,
                                isFocused: _accionFocused,
                                maxLines: 2,
                                errorText: _errorAccion,
                                onChanged: (v) => setState(() => _errorAccion = RecomendacionesValidaciones.mensajeAccion(v)),
                              ),
                              const SizedBox(height: 14),
                              if (isMobile) ...[
                                _buildDropdown<PrioridadRecomendacion>(
                                  label: 'Prioridad de la recomendación',
                                  value: _prioridad,
                                  items: PrioridadRecomendacion.values.map((p) => DropdownMenuItem(value: p, child: Text(p.label))).toList(),
                                  onChanged: (v) => setState(() => _prioridad = v!),
                                ),
                                const SizedBox(height: 14),
                                _buildDropdown<ColorRecomendacion>(
                                  label: 'Color de la recomendación',
                                  value: _color,
                                  items: ColorRecomendacion.values.map((c) => DropdownMenuItem(value: c, child: Text(c.label))).toList(),
                                  onChanged: (v) => setState(() => _color = v!),
                                ),
                              ] else ...[
                                Row(
                                  children: [
                                    Expanded(
                                      child: _buildDropdown<PrioridadRecomendacion>(
                                        label: 'Prioridad de la recomendación',
                                        value: _prioridad,
                                        items: PrioridadRecomendacion.values.map((p) => DropdownMenuItem(value: p, child: Text(p.label))).toList(),
                                        onChanged: (v) => setState(() => _prioridad = v!),
                                      ),
                                    ),
                                    const SizedBox(width: 16),
                                    Expanded(
                                      child: _buildDropdown<ColorRecomendacion>(
                                        label: 'Color de la recomendación',
                                        value: _color,
                                        items: ColorRecomendacion.values.map((c) => DropdownMenuItem(value: c, child: Text(c.label))).toList(),
                                        onChanged: (v) => setState(() => _color = v!),
                                      ),
                                    ),
                                  ],
                                ),
                              ],
                              const SizedBox(height: 18),
                              Row(
                                children: [
                                  Expanded(
                                    child: GestureDetector(
                                      onTap: widget.onCerrar,
                                      child: Container(
                                        constraints: const BoxConstraints(minHeight: 54),
                                        padding: const EdgeInsets.symmetric(horizontal: 4),
                                        decoration: EditarRecomendacionStyles.cancelBtnDecoration,
                                        child: const Center(
                                          child: Text(
                                            'Cancelar',
                                            style: EditarRecomendacionStyles.cancelBtnStyle,
                                            textAlign: TextAlign.center,
                                          ),
                                        ),
                                      ),
                                    ),
                                  ),
                                  const SizedBox(width: 10),
                                  Expanded(
                                    child: GestureDetector(
                                      onTap: _submit,
                                      child: Container(
                                        constraints: const BoxConstraints(minHeight: 54),
                                        padding: const EdgeInsets.symmetric(horizontal: 4),
                                        decoration: EditarRecomendacionStyles.submitBtnDecoration,
                                        child: const Center(
                                          child: Text(
                                            'Guardar cambios',
                                            style: EditarRecomendacionStyles.submitBtnStyle,
                                            textAlign: TextAlign.center,
                                          ),
                                        ),
                                      ),
                                    ),
                                  ),
                                ],
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

  Widget _buildTextField({
    required String label,
    required TextEditingController ctrl,
    FaIconData? icon,
    required FocusNode focusNode,
    required bool isFocused,
    int maxLines = 1,
    String? errorText,
    void Function(String)? onChanged,
  }) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(label, style: EditarRecomendacionStyles.labelStyle),
        const SizedBox(height: 8),
        Container(
          constraints: BoxConstraints(minHeight: maxLines == 1 ? 54 : 72),
          decoration: errorText != null 
              ? EditarRecomendacionStyles.inputShellDecoration(focused: isFocused).copyWith(
                  border: Border.all(color: Colors.red, width: 1.5))
              : EditarRecomendacionStyles.inputShellDecoration(focused: isFocused),
          child: Row(
            crossAxisAlignment: maxLines == 1 ? CrossAxisAlignment.center : CrossAxisAlignment.start,
            children: [
              if (icon != null)
                Container(
                  width: 48,
                  height: 54,
                  alignment: Alignment.center,
                  child: FaIcon(
                    icon,
                    color: errorText != null ? Colors.red : EditarRecomendacionStyles.primaryGreen,
                    size: 18,
                  ),
                ),
              Expanded(
                child: Padding(
                  padding: EdgeInsets.only(
                    left: icon == null ? 14 : 0,
                    right: 14,
                    top: maxLines == 1 ? 0 : 12,
                    bottom: maxLines == 1 ? 0 : 12,
                  ),
                  child: TextField(
                    controller: ctrl,
                    focusNode: focusNode,
                    maxLines: maxLines,
                    onChanged: onChanged,
                    decoration: const InputDecoration(
                      border: InputBorder.none,
                      isDense: true,
                      contentPadding: EdgeInsets.zero,
                    ),
                    style: EditarRecomendacionStyles.inputTextStyle,
                  ),
                ),
              ),
            ],
          ),
        ),
        if (errorText != null) ...[
          const SizedBox(height: 6),
          Text(errorText, style: const TextStyle(color: Colors.red, fontSize: 12)),
        ],
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
        Text(label, style: EditarRecomendacionStyles.labelStyle),
        const SizedBox(height: 8),
        Container(
          height: 54,
          decoration: EditarRecomendacionStyles.inputShellDecoration(),
          padding: const EdgeInsets.symmetric(horizontal: 14),
          child: DropdownButtonHideUnderline(
            child: DropdownButton<T>(
              value: value,
              isExpanded: true,
              icon: const FaIcon(FontAwesomeIcons.chevronDown, color: EditarRecomendacionStyles.darkGreen, size: 16),
              style: EditarRecomendacionStyles.inputTextStyle,
              dropdownColor: EditarRecomendacionStyles.backgroundModal,
              items: items,
              onChanged: onChanged,
            ),
          ),
        ),
      ],
    );
  }
}
