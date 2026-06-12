import 'package:flutter/material.dart';
import '../../styles/admin-styles/panel-admin.dart';
import '../../styles/admin-styles/modales-styles/editar-usuario.dart';
import '../../environments/datos-simulados-admin.dart';
import 'registro-usuario.dart';
import '../../shared/validators/modales-validaciones.dart';

class EditarUsuario extends StatefulWidget {
  final UsuarioAdmin usuario;
  final VoidCallback onCerrar;
  final void Function(DatosUsuario) onGuardar;

  const EditarUsuario({
    super.key,
    required this.usuario,
    required this.onCerrar,
    required this.onGuardar,
  });

  @override
  State<EditarUsuario> createState() => _EditarUsuarioState();
}

class _EditarUsuarioState extends State<EditarUsuario> {
  late final TextEditingController _nombreCtrl;
  late final TextEditingController _segundoNombreCtrl;
  late final TextEditingController _apellidoCtrl;
  late final TextEditingController _segundoApellidoCtrl;
  late final TextEditingController _correoCorpCtrl;
  late final TextEditingController _correoElecCtrl;
  late final TextEditingController _telefonoCtrl;
  late final TextEditingController _passwordCtrl;
  late final TextEditingController _confirmPassCtrl;

  bool _showPassword = false;
  bool _showConfirmPassword = false;
  RolUsuario? _rol;

  // Errores de validación
  String? _nombreError;
  String? _segundoNombreError;
  String? _apellidoError;
  String? _segundoApellidoError;
  String? _correoCorpError;
  String? _correoElecError;
  String? _telefonoError;
  String? _passwordError;
  String? _confirmPassError;
  String? _rolError;

  @override
  void initState() {
    super.initState();
    final u = widget.usuario;
    _nombreCtrl = TextEditingController(text: u.nombre);
    _segundoNombreCtrl = TextEditingController(text: u.segundoNombre);
    _apellidoCtrl = TextEditingController(text: u.apellido);
    _segundoApellidoCtrl = TextEditingController(text: u.segundoApellido);
    _correoCorpCtrl = TextEditingController(text: u.correoCorporativo);
    _correoElecCtrl = TextEditingController(text: u.correoElectronico);
    _telefonoCtrl = TextEditingController(text: u.telefono);
    _passwordCtrl = TextEditingController(text: 'AgroVision2026!');
    _confirmPassCtrl = TextEditingController(text: 'AgroVision2026!');
    _rol = u.rol;
  }

  @override
  void dispose() {
    _nombreCtrl.dispose();
    _segundoNombreCtrl.dispose();
    _apellidoCtrl.dispose();
    _segundoApellidoCtrl.dispose();
    _correoCorpCtrl.dispose();
    _correoElecCtrl.dispose();
    _telefonoCtrl.dispose();
    _passwordCtrl.dispose();
    _confirmPassCtrl.dispose();
    super.dispose();
  }

  void _validarNombre() {
    final valor = _nombreCtrl.text.trim();
    setState(() {
      // Nombre es opcional, pero si tiene valor debe ser válido
      if (valor.isNotEmpty && !ModalesValidaciones.nombrePattern.hasMatch(valor)) {
        _nombreError = ModalesValidaciones.mensajesError['nombrePattern'];
      } else {
        _nombreError = null;
      }
    });
  }

  void _validarSegundoNombre() {
    final valor = _segundoNombreCtrl.text.trim();
    setState(() {
      // Segundo nombre es opcional, pero si tiene valor debe ser válido
      if (valor.isNotEmpty && !ModalesValidaciones.nombrePattern.hasMatch(valor)) {
        _segundoNombreError = ModalesValidaciones.mensajesError['nombrePattern'];
      } else {
        _segundoNombreError = null;
      }
    });
  }

  void _validarApellido() {
    final valor = _apellidoCtrl.text.trim();
    setState(() {
      // Apellido es opcional, pero si tiene valor debe ser válido
      if (valor.isNotEmpty && !ModalesValidaciones.nombrePattern.hasMatch(valor)) {
        _apellidoError = ModalesValidaciones.mensajesError['nombrePattern'];
      } else {
        _apellidoError = null;
      }
    });
  }

  void _validarSegundoApellido() {
    final valor = _segundoApellidoCtrl.text.trim();
    setState(() {
      // Segundo apellido es opcional, pero si tiene valor debe ser válido
      if (valor.isNotEmpty && !ModalesValidaciones.nombrePattern.hasMatch(valor)) {
        _segundoApellidoError = ModalesValidaciones.mensajesError['nombrePattern'];
      } else {
        _segundoApellidoError = null;
      }
    });
  }

  void _validarCorreoCorporativo() {
    final valor = _correoCorpCtrl.text.trim();
    setState(() {
      if (valor.isEmpty) {
        _correoCorpError = ModalesValidaciones.mensajesError['correoCorporativoRequired'];
      } else if (!ModalesValidaciones.correoCorporativoPattern.hasMatch(valor)) {
        _correoCorpError = ModalesValidaciones.mensajesError['correoCorporativoPattern'];
      } else {
        _correoCorpError = null;
      }
    });
  }

  void _validarCorreoElectronico() {
    final valor = _correoElecCtrl.text.trim();
    setState(() {
      if (valor.isEmpty) {
        _correoElecError = ModalesValidaciones.mensajesError['correoElectronicoRequired'];
      } else if (!ModalesValidaciones.correoGmailPattern.hasMatch(valor)) {
        _correoElecError = ModalesValidaciones.mensajesError['correoGmailPattern'];
      } else {
        _correoElecError = null;
      }
    });
  }

  void _validarTelefono() {
    final valor = _telefonoCtrl.text.trim();
    setState(() {
      if (valor.isEmpty) {
        _telefonoError = ModalesValidaciones.mensajesError['telefonoRequired'];
      } else if (!ModalesValidaciones.telefonoPattern.hasMatch(valor)) {
        _telefonoError = ModalesValidaciones.mensajesError['telefonoPattern'];
      } else {
        _telefonoError = null;
      }
    });
  }

  void _validarPassword() {
    final valor = _passwordCtrl.text;
    setState(() {
      if (valor.isEmpty) {
        _passwordError = ModalesValidaciones.mensajesError['passwordRequired'];
      } else {
        _passwordError = null;
      }
    });
  }

  void _validarConfirmPassword() {
    final valor = _confirmPassCtrl.text;
    setState(() {
      if (valor.isEmpty) {
        _confirmPassError = ModalesValidaciones.mensajesError['confirmarPasswordRequired'];
      } else if (valor != _passwordCtrl.text) {
        _confirmPassError = ModalesValidaciones.mensajesError['passwordMismatch'];
      } else {
        _confirmPassError = null;
      }
    });
  }

  void _submit() {
    // Validar todos los campos
    _validarNombre();
    _validarSegundoNombre();
    _validarApellido();
    _validarSegundoApellido();
    _validarCorreoCorporativo();
    _validarCorreoElectronico();
    _validarTelefono();
    _validarPassword();
    _validarConfirmPassword();

    // Validar rol
    setState(() {
      if (_rol == null) {
        _rolError = ModalesValidaciones.mensajesError['required'];
      } else {
        _rolError = null;
      }
    });

    // Verificar si hay errores
    if (_nombreError != null ||
        _segundoNombreError != null ||
        _apellidoError != null ||
        _segundoApellidoError != null ||
        _correoCorpError != null ||
        _correoElecError != null ||
        _telefonoError != null ||
        _passwordError != null ||
        _confirmPassError != null ||
        _rolError != null) {
      return;
    }

    widget.onGuardar(DatosUsuario(
      nombre: _nombreCtrl.text.trim(),
      segundoNombre: _segundoNombreCtrl.text.trim(),
      apellido: _apellidoCtrl.text.trim(),
      segundoApellido: _segundoApellidoCtrl.text.trim(),
      correoCorporativo: _correoCorpCtrl.text.trim(),
      correoElectronico: _correoElecCtrl.text.trim(),
      telefono: _telefonoCtrl.text.trim(),
      password: _passwordCtrl.text,
      rol: _rol!,
    ));
  }

  @override
  Widget build(BuildContext context) {
    final bool isMobile = MediaQuery.of(context).size.width <= EditarUsuarioStyles.mobileBreakpoint;

    return GestureDetector(
      onTap: widget.onCerrar,
      child: Container(
        color: EditarUsuarioStyles.overlayColor,
        child: Center(
          child: GestureDetector(
            onTap: () {},
            child: Container(
              constraints: const BoxConstraints(maxWidth: EditarUsuarioStyles.maxWidth),
              margin: EditarUsuarioStyles.modalMargin,
              decoration: EditarUsuarioStyles.modalDecoration,
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  // Header
                  Padding(
                    padding: EditarUsuarioStyles.headerPadding,
                    child: Row(
                      children: [
                        const Expanded(
                          child: Text('Editar usuario', style: EditarUsuarioStyles.titleText),
                        ),
                        GestureDetector(
                          onTap: widget.onCerrar,
                          child: Container(
                            width: EditarUsuarioStyles.closeButtonSize,
                            height: EditarUsuarioStyles.closeButtonSize,
                            decoration: EditarUsuarioStyles.closeButtonDecoration,
                            child: const Icon(Icons.close,
                                color: EditarUsuarioStyles.closeIconColor, 
                                size: EditarUsuarioStyles.closeIconSize),
                          ),
                        ),
                      ],
                    ),
                  ),
                  const SizedBox(height: 22),
                  // Formulario
                  Flexible(
                    child: SingleChildScrollView(
                      padding: EditarUsuarioStyles.formPadding,
                      child: Column(
                        children: [
                          _buildGrid(
                            isMobile: isMobile,
                            children: [
                              _buildTextField('Nombre', Icons.person, _nombreCtrl,
                                error: _nombreError, onChanged: _validarNombre),
                              _buildTextField('Segundo nombre', Icons.person, _segundoNombreCtrl,
                                error: _segundoNombreError, onChanged: _validarSegundoNombre),
                              _buildTextField('Apellido', Icons.person, _apellidoCtrl,
                                error: _apellidoError, onChanged: _validarApellido),
                              _buildTextField('Segundo apellido', Icons.person, _segundoApellidoCtrl,
                                error: _segundoApellidoError, onChanged: _validarSegundoApellido),
                              _buildTextField('Correo corporativo *', Icons.email, _correoCorpCtrl,
                                  isFull: true, error: _correoCorpError, onChanged: _validarCorreoCorporativo),
                              _buildTextField('Correo electronico *', Icons.email, _correoElecCtrl,
                                  isFull: true, error: _correoElecError, onChanged: _validarCorreoElectronico),
                              _buildTextField('Numero de telefono *', Icons.phone, _telefonoCtrl,
                                  isFull: true, keyboardType: TextInputType.phone,
                                  error: _telefonoError, onChanged: _validarTelefono),
                              _buildPasswordField('Contraseña *', _passwordCtrl, _showPassword, () {
                                setState(() => _showPassword = !_showPassword);
                              }, error: _passwordError, onChanged: _validarPassword),
                              _buildPasswordField('Confirmar contraseña *', _confirmPassCtrl, _showConfirmPassword, () {
                                setState(() => _showConfirmPassword = !_showConfirmPassword);
                              }, error: _confirmPassError, onChanged: _validarConfirmPassword),
                              _buildRolField(),
                            ],
                          ),
                        ],
                      ),
                    ),
                  ),
                  // Footer
                  Padding(
                    padding: EditarUsuarioStyles.footerPadding,
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.end,
                      children: [
                        GestureDetector(
                          onTap: widget.onCerrar,
                          child: Container(
                            constraints: const BoxConstraints(minHeight: EditarUsuarioStyles.minButtonHeight),
                            padding: EditarUsuarioStyles.cancelButtonPadding,
                            decoration: EditarUsuarioStyles.cancelButtonDecoration,
                            child: const Center(
                              child: Text('Cancelar', style: EditarUsuarioStyles.cancelButtonText),
                            ),
                          ),
                        ),
                        const SizedBox(width: EditarUsuarioStyles.buttonSpacing),
                        GestureDetector(
                          onTap: _submit,
                          child: Container(
                            constraints: const BoxConstraints(minHeight: EditarUsuarioStyles.minButtonHeight),
                            padding: EditarUsuarioStyles.submitButtonPadding,
                            decoration: EditarUsuarioStyles.submitButtonDecoration,
                            child: const Center(
                              child: Text('Guardar cambios', style: EditarUsuarioStyles.submitButtonText),
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

  Widget _buildGrid({required bool isMobile, required List<Widget> children}) {
    if (isMobile) {
      return Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: children.map((w) => Padding(padding: const EdgeInsets.only(bottom: EditarUsuarioStyles.fieldSpacing), child: w)).toList(),
      );
    }
    List<Widget> rows = [];
    List<Widget> currentRow = [];
    for (int i = 0; i < children.length; i++) {
      final child = children[i];
      bool isFull = child is Container && child.key == const ValueKey('full');
      if (isFull) {
        if (currentRow.isNotEmpty) {
          rows.add(Row(crossAxisAlignment: CrossAxisAlignment.start, children: currentRow));
          rows.add(const SizedBox(height: EditarUsuarioStyles.fieldSpacing));
          currentRow = [];
        }
        rows.add(child);
        rows.add(const SizedBox(height: EditarUsuarioStyles.fieldSpacing));
      } else {
        currentRow.add(Expanded(child: child));
        if (currentRow.length == 2) {
          rows.add(Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [currentRow[0], const SizedBox(width: EditarUsuarioStyles.columnSpacing), currentRow[1]],
          ));
          rows.add(const SizedBox(height: EditarUsuarioStyles.fieldSpacing));
          currentRow = [];
        }
      }
    }
    if (currentRow.isNotEmpty) {
      rows.add(Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [currentRow[0], const SizedBox(width: EditarUsuarioStyles.columnSpacing), Expanded(child: Container())],
      ));
    }
    return Column(crossAxisAlignment: CrossAxisAlignment.stretch, children: rows);
  }

  Widget _buildTextField(String label, IconData icon, TextEditingController ctrl,
      {bool isFull = false, TextInputType? keyboardType, String? error, VoidCallback? onChanged}) {
    return Container(
      key: isFull ? const ValueKey('full') : null,
      constraints: const BoxConstraints(minHeight: EditarUsuarioStyles.minFieldHeight),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(label, style: EditarUsuarioStyles.labelText),
          const SizedBox(height: EditarUsuarioStyles.labelSpacing),
          Container(
            height: EditarUsuarioStyles.inputHeight,
            decoration: error != null 
                ? EditarUsuarioStyles.inputErrorDecoration 
                : EditarUsuarioStyles.inputDecoration,
            child: Row(
              children: [
                SizedBox(
                  width: EditarUsuarioStyles.iconContainerWidth,
                  child: Center(child: Icon(icon, color: EditarUsuarioStyles.iconColor, size: EditarUsuarioStyles.iconSize)),
                ),
                Expanded(
                  child: TextField(
                    controller: ctrl,
                    keyboardType: keyboardType,
                    onChanged: onChanged != null ? (_) => onChanged() : null,
                    decoration: const InputDecoration(
                      border: InputBorder.none,
                      contentPadding: EditarUsuarioStyles.inputContentPadding,
                    ),
                    style: EditarUsuarioStyles.inputTextStyle,
                  ),
                ),
              ],
            ),
          ),
          if (error != null) ...[
            const SizedBox(height: EditarUsuarioStyles.errorSpacing),
            Text(error, style: EditarUsuarioStyles.errorText),
          ],
        ],
      ),
    );
  }

  Widget _buildPasswordField(String label, TextEditingController ctrl, bool showPass, VoidCallback onToggle, {String? error, VoidCallback? onChanged}) {
    return Container(
      constraints: const BoxConstraints(minHeight: EditarUsuarioStyles.minFieldHeight),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(label, style: EditarUsuarioStyles.labelText),
          const SizedBox(height: EditarUsuarioStyles.labelSpacing),
          Container(
            height: EditarUsuarioStyles.inputHeight,
            decoration: error != null 
                ? EditarUsuarioStyles.inputErrorDecoration 
                : EditarUsuarioStyles.inputDecoration,
            child: Row(
              children: [
                const SizedBox(
                  width: EditarUsuarioStyles.iconContainerWidth,
                  child: Center(child: Icon(Icons.lock, color: EditarUsuarioStyles.iconColor, size: EditarUsuarioStyles.iconSize)),
                ),
                Expanded(
                  child: TextField(
                    controller: ctrl,
                    obscureText: !showPass,
                    onChanged: onChanged != null ? (_) => onChanged() : null,
                    decoration: const InputDecoration(
                      border: InputBorder.none,
                      contentPadding: EditarUsuarioStyles.inputContentPadding,
                    ),
                    style: EditarUsuarioStyles.inputTextStyle,
                  ),
                ),
                GestureDetector(
                  onTap: onToggle,
                  child: SizedBox(
                    width: EditarUsuarioStyles.passwordToggleWidth,
                    child: Center(
                      child: Icon(
                        showPass ? Icons.visibility_off : Icons.visibility,
                        color: PanelAdminStyles.darkGreen,
                        size: EditarUsuarioStyles.passwordIconSize,
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ),
          if (error != null) ...[
            const SizedBox(height: EditarUsuarioStyles.errorSpacing),
            Text(error, style: EditarUsuarioStyles.errorText),
          ],
        ],
      ),
    );
  }

  Widget _buildRolField() {
    return Container(
      key: const ValueKey('full'),
      constraints: const BoxConstraints(minHeight: EditarUsuarioStyles.minFieldHeight),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Text('Rol *', style: EditarUsuarioStyles.rolLabelText),
          const SizedBox(height: EditarUsuarioStyles.labelSpacing),
          RadioGroup<RolUsuario?>(
            groupValue: _rol,
            onChanged: (v) => setState(() {
              _rol = v;
              _rolError = null;
            }),
            child: Wrap(
              spacing: EditarUsuarioStyles.rolSpacing,
              runSpacing: EditarUsuarioStyles.rolSpacing,
              children: [
                _buildRadioOption(RolUsuario.admin),
                _buildRadioOption(RolUsuario.agricultor),
              ],
            ),
          ),
          if (_rolError != null) ...[
            const SizedBox(height: EditarUsuarioStyles.errorSpacing),
            Text(_rolError!, style: EditarUsuarioStyles.errorText),
          ],
        ],
      ),
    );
  }

  Widget _buildRadioOption(RolUsuario rol) {
    return GestureDetector(
      onTap: () => setState(() {
        _rol = rol;
        _rolError = null;
      }),
      child: Container(
        height: EditarUsuarioStyles.rolOptionHeight,
        padding: EditarUsuarioStyles.rolOptionPadding,
        decoration: _rolError != null 
            ? EditarUsuarioStyles.rolOptionErrorDecoration 
            : EditarUsuarioStyles.rolOptionDecoration,
        child: Row(
          mainAxisSize: MainAxisSize.min,
          children: [
            Radio<RolUsuario>(
              value: rol,
              groupValue: _rol,
              activeColor: EditarUsuarioStyles.radioActiveColor,
              onChanged: (v) => setState(() {
                _rol = v;
                _rolError = null;
              }),
            ),
            const SizedBox(width: EditarUsuarioStyles.radioSpacing),
            Text(rol.label, style: EditarUsuarioStyles.rolOptionText),
          ],
        ),
      ),
    );
  }
}
