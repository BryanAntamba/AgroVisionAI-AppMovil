import 'package:flutter/material.dart';
import '../../styles/admin-styles/panel-admin.dart';
import '../../styles/admin-styles/modales-styles/registro-usuario.dart';
import '../../environments/datos-simulados-admin.dart';
import '../../shared/validators/modales-validaciones.dart';

class DatosUsuario {
  final String nombre;
  final String segundoNombre;
  final String apellido;
  final String segundoApellido;
  final String correoCorporativo;
  final String correoElectronico;
  final String telefono;
  final String password;
  final RolUsuario rol;

  DatosUsuario({
    required this.nombre,
    required this.segundoNombre,
    required this.apellido,
    required this.segundoApellido,
    required this.correoCorporativo,
    required this.correoElectronico,
    required this.telefono,
    required this.password,
    required this.rol,
  });
}

class RegistroUsuario extends StatefulWidget {
  final VoidCallback onCerrar;
  final void Function(DatosUsuario) onGuardar;

  const RegistroUsuario({
    super.key,
    required this.onCerrar,
    required this.onGuardar,
  });

  @override
  State<RegistroUsuario> createState() => _RegistroUsuarioState();
}

class _RegistroUsuarioState extends State<RegistroUsuario> {
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
    _nombreCtrl = TextEditingController();
    _segundoNombreCtrl = TextEditingController();
    _apellidoCtrl = TextEditingController();
    _segundoApellidoCtrl = TextEditingController();
    _correoCorpCtrl = TextEditingController();
    _correoElecCtrl = TextEditingController();
    _telefonoCtrl = TextEditingController();
    _passwordCtrl = TextEditingController();
    _confirmPassCtrl = TextEditingController();
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
    final bool isMobile = MediaQuery.of(context).size.width <= RegistroUsuarioStyles.mobileBreakpoint;

    return GestureDetector(
      onTap: widget.onCerrar,
      child: Container(
        color: RegistroUsuarioStyles.overlayColor,
        child: Center(
          child: GestureDetector(
            onTap: () {},
            child: Container(
              constraints: const BoxConstraints(maxWidth: RegistroUsuarioStyles.maxWidth),
              margin: RegistroUsuarioStyles.modalMargin,
              decoration: RegistroUsuarioStyles.modalDecoration,
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  // Header
                  Padding(
                    padding: RegistroUsuarioStyles.headerPadding,
                    child: Row(
                      children: [
                        const Expanded(
                          child: Text('Registro de usuario', style: RegistroUsuarioStyles.titleText),
                        ),
                        GestureDetector(
                          onTap: widget.onCerrar,
                          child: Container(
                            width: RegistroUsuarioStyles.closeButtonSize,
                            height: RegistroUsuarioStyles.closeButtonSize,
                            decoration: RegistroUsuarioStyles.closeButtonDecoration,
                            child: const Icon(Icons.close,
                                color: RegistroUsuarioStyles.closeIconColor, 
                                size: RegistroUsuarioStyles.closeIconSize),
                          ),
                        ),
                      ],
                    ),
                  ),
                  const SizedBox(height: 22),
                  // Formulario
                  Flexible(
                    child: SingleChildScrollView(
                      padding: RegistroUsuarioStyles.formPadding,
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
                                  isFull: true, placeholder: 'usuario@agrovision.com',
                                  error: _correoCorpError, onChanged: _validarCorreoCorporativo),
                              _buildTextField('Correo electronico *', Icons.email, _correoElecCtrl,
                                  isFull: true, placeholder: 'usuario@gmail.com',
                                  error: _correoElecError, onChanged: _validarCorreoElectronico),
                              _buildTextField('Numero de telefono *', Icons.phone, _telefonoCtrl,
                                  isFull: true, placeholder: '10 digitos', keyboardType: TextInputType.phone,
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
                    padding: RegistroUsuarioStyles.footerPadding,
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.end,
                      children: [
                        GestureDetector(
                          onTap: widget.onCerrar,
                          child: Container(
                            constraints: const BoxConstraints(minHeight: RegistroUsuarioStyles.minButtonHeight),
                            padding: RegistroUsuarioStyles.cancelButtonPadding,
                            decoration: RegistroUsuarioStyles.cancelButtonDecoration,
                            child: const Center(
                              child: Text('Cancelar', style: RegistroUsuarioStyles.cancelButtonText),
                            ),
                          ),
                        ),
                        const SizedBox(width: RegistroUsuarioStyles.buttonSpacing),
                        GestureDetector(
                          onTap: _submit,
                          child: Container(
                            constraints: const BoxConstraints(minHeight: RegistroUsuarioStyles.minButtonHeight),
                            padding: RegistroUsuarioStyles.submitButtonPadding,
                            decoration: RegistroUsuarioStyles.submitButtonDecoration,
                            child: const Center(
                              child: Text('Registrar usuario', style: RegistroUsuarioStyles.submitButtonText),
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
        children: children.map((w) => Padding(padding: const EdgeInsets.only(bottom: RegistroUsuarioStyles.fieldSpacing), child: w)).toList(),
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
          rows.add(const SizedBox(height: RegistroUsuarioStyles.fieldSpacing));
          currentRow = [];
        }
        rows.add(child);
        rows.add(const SizedBox(height: RegistroUsuarioStyles.fieldSpacing));
      } else {
        currentRow.add(Expanded(child: child));
        if (currentRow.length == 2) {
          rows.add(Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              currentRow[0],
              const SizedBox(width: RegistroUsuarioStyles.columnSpacing),
              currentRow[1],
            ],
          ));
          rows.add(const SizedBox(height: RegistroUsuarioStyles.fieldSpacing));
          currentRow = [];
        }
      }
    }
    if (currentRow.isNotEmpty) {
      rows.add(Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          currentRow[0],
          const SizedBox(width: RegistroUsuarioStyles.columnSpacing),
          Expanded(child: Container()),
        ],
      ));
    }
    return Column(crossAxisAlignment: CrossAxisAlignment.stretch, children: rows);
  }

  Widget _buildTextField(String label, IconData icon, TextEditingController ctrl,
      {bool isFull = false, String placeholder = '', TextInputType? keyboardType, String? error, VoidCallback? onChanged}) {
    return Container(
      key: isFull ? const ValueKey('full') : null,
      constraints: const BoxConstraints(minHeight: RegistroUsuarioStyles.minFieldHeight),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(label, style: RegistroUsuarioStyles.labelText),
          const SizedBox(height: RegistroUsuarioStyles.labelSpacing),
          Container(
            height: RegistroUsuarioStyles.inputHeight,
            decoration: error != null 
                ? RegistroUsuarioStyles.inputErrorDecoration 
                : RegistroUsuarioStyles.inputDecoration,
            child: Row(
              children: [
                SizedBox(
                  width: RegistroUsuarioStyles.iconContainerWidth,
                  child: Center(child: Icon(icon, color: RegistroUsuarioStyles.iconColor, size: RegistroUsuarioStyles.iconSize)),
                ),
                Expanded(
                  child: TextField(
                    controller: ctrl,
                    keyboardType: keyboardType,
                    onChanged: onChanged != null ? (_) => onChanged() : null,
                    decoration: InputDecoration(
                      hintText: placeholder.isEmpty ? label : placeholder,
                      hintStyle: RegistroUsuarioStyles.hintTextStyle,
                      border: InputBorder.none,
                      contentPadding: RegistroUsuarioStyles.inputContentPadding,
                    ),
                    style: RegistroUsuarioStyles.inputTextStyle,
                  ),
                ),
              ],
            ),
          ),
          if (error != null) ...[
            const SizedBox(height: RegistroUsuarioStyles.errorSpacing),
            Text(error, style: RegistroUsuarioStyles.errorText),
          ],
        ],
      ),
    );
  }

  Widget _buildPasswordField(String label, TextEditingController ctrl, bool showPass, VoidCallback onToggle, {String? error, VoidCallback? onChanged}) {
    return Container(
      constraints: const BoxConstraints(minHeight: RegistroUsuarioStyles.minFieldHeight),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(label, style: RegistroUsuarioStyles.labelText),
          const SizedBox(height: RegistroUsuarioStyles.labelSpacing),
          Container(
            height: RegistroUsuarioStyles.inputHeight,
            decoration: error != null 
                ? RegistroUsuarioStyles.inputErrorDecoration 
                : RegistroUsuarioStyles.inputDecoration,
            child: Row(
              children: [
                const SizedBox(
                  width: RegistroUsuarioStyles.iconContainerWidth,
                  child: Center(child: Icon(Icons.lock, color: RegistroUsuarioStyles.iconColor, size: RegistroUsuarioStyles.iconSize)),
                ),
                Expanded(
                  child: TextField(
                    controller: ctrl,
                    obscureText: !showPass,
                    onChanged: onChanged != null ? (_) => onChanged() : null,
                    decoration: const InputDecoration(
                      hintText: 'Contraseña',
                      hintStyle: RegistroUsuarioStyles.hintTextStyle,
                      border: InputBorder.none,
                      contentPadding: RegistroUsuarioStyles.inputContentPadding,
                    ),
                    style: RegistroUsuarioStyles.inputTextStyle,
                  ),
                ),
                GestureDetector(
                  onTap: onToggle,
                  child: SizedBox(
                    width: RegistroUsuarioStyles.passwordToggleWidth,
                    child: Center(
                      child: Icon(
                        showPass ? Icons.visibility_off : Icons.visibility,
                        color: PanelAdminStyles.darkGreen,
                        size: RegistroUsuarioStyles.passwordIconSize,
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ),
          if (error != null) ...[
            const SizedBox(height: RegistroUsuarioStyles.errorSpacing),
            Text(error, style: RegistroUsuarioStyles.errorText),
          ],
        ],
      ),
    );
  }

  Widget _buildRolField() {
    return Container(
      key: const ValueKey('full'),
      constraints: const BoxConstraints(minHeight: RegistroUsuarioStyles.minFieldHeight),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Text('Rol *', style: RegistroUsuarioStyles.rolLabelText),
          const SizedBox(height: RegistroUsuarioStyles.labelSpacing),
          RadioGroup<RolUsuario?>(
            groupValue: _rol,
            onChanged: (v) => setState(() {
              _rol = v;
              _rolError = null;
            }),
            child: Wrap(
              spacing: RegistroUsuarioStyles.rolSpacing,
              runSpacing: RegistroUsuarioStyles.rolSpacing,
              children: [
                _buildRadioOption(RolUsuario.admin),
                _buildRadioOption(RolUsuario.agricultor),
              ],
            ),
          ),
          if (_rolError != null) ...[
            const SizedBox(height: RegistroUsuarioStyles.errorSpacing),
            Text(_rolError!, style: RegistroUsuarioStyles.errorText),
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
        height: RegistroUsuarioStyles.rolOptionHeight,
        padding: RegistroUsuarioStyles.rolOptionPadding,
        decoration: _rolError != null 
            ? RegistroUsuarioStyles.rolOptionErrorDecoration 
            : RegistroUsuarioStyles.rolOptionDecoration,
        child: Row(
          mainAxisSize: MainAxisSize.min,
          children: [
            Radio<RolUsuario>(
              value: rol,
              groupValue: _rol,
              activeColor: RegistroUsuarioStyles.radioActiveColor,
              onChanged: (v) => setState(() {
                _rol = v;
                _rolError = null;
              }),
            ),
            const SizedBox(width: RegistroUsuarioStyles.radioSpacing),
            Text(rol.label, style: RegistroUsuarioStyles.rolOptionText),
          ],
        ),
      ),
    );
  }
}
