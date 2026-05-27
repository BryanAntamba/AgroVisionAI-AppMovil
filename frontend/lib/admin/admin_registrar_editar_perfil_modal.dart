import 'package:flutter/material.dart';
import '../core/validaciones/formulario_validaciones_widget.dart';
import '../core/widgets/inputs_autenticacion_widget.dart';
import '../models/usuariosRandom_admin.dart';
import '../styles/app_colors.dart';
import '../styles/formulario_autenticacion_style.dart';
import '../styles/panel_admin_style.dart';

enum ModalModoUsuario { registro, editar, perfil }

class PanelAdminUsuarioModal extends StatefulWidget {
  const PanelAdminUsuarioModal({
    super.key,
    required this.modo,
    this.usuario,
    required this.onCerrar,
    required this.onGuardar,
  });

  final ModalModoUsuario modo;
  final UsuarioAdmin? usuario;
  final VoidCallback onCerrar;
  final void Function(Map<String, String> valores, RolUsuario rol) onGuardar;

  @override
  State<PanelAdminUsuarioModal> createState() => _PanelAdminUsuarioModalState();
}

class _PanelAdminUsuarioModalState extends State<PanelAdminUsuarioModal> {
  late final TextEditingController _nombre;
  late final TextEditingController _segundoNombre;
  late final TextEditingController _apellido;
  late final TextEditingController _segundoApellido;
  late final TextEditingController _correoCorp;
  late final TextEditingController _correoGmail;
  late final TextEditingController _telefono;
  late final TextEditingController _password;
  late final TextEditingController _confirmPassword;

  RolUsuario? _rol;
  bool _submitted = false;

  bool get _soloLectura => widget.modo == ModalModoUsuario.perfil;

  String get _titulo => switch (widget.modo) {
        ModalModoUsuario.registro => 'Registro de usuario',
        ModalModoUsuario.editar => 'Editar usuario',
        ModalModoUsuario.perfil => 'Perfil de usuario',
      };

  @override
  void initState() {
    super.initState();
    final u = widget.usuario;
    _nombre = TextEditingController(text: u?.nombre ?? '');
    _segundoNombre = TextEditingController(text: u?.segundoNombre ?? '');
    _apellido = TextEditingController(text: u?.apellido ?? '');
    _segundoApellido = TextEditingController(text: u?.segundoApellido ?? '');
    _correoCorp = TextEditingController(text: u?.correoCorporativo ?? '');
    _correoGmail = TextEditingController(text: u?.correoElectronico ?? '');
    _telefono = TextEditingController(
      text: u != null ? FormValidators.telefonoParaFormulario(u.telefono) : '',
    );
    _password = TextEditingController(
      text: u != null ? 'AgroVision2026!' : '',
    );
    _confirmPassword = TextEditingController(
      text: u != null ? 'AgroVision2026!' : '',
    );
    _rol = u?.rol;
  }

  @override
  void dispose() {
    _nombre.dispose();
    _segundoNombre.dispose();
    _apellido.dispose();
    _segundoApellido.dispose();
    _correoCorp.dispose();
    _correoGmail.dispose();
    _telefono.dispose();
    _password.dispose();
    _confirmPassword.dispose();
    super.dispose();
  }

  void _guardar() {
    if (_soloLectura) {
      widget.onCerrar();
      return;
    }
    setState(() => _submitted = true);

    final errores = [
      FormValidators.nombreOpcional(_nombre.text),
      FormValidators.nombreOpcional(_segundoNombre.text),
      FormValidators.nombreOpcional(_apellido.text),
      FormValidators.nombreOpcional(_segundoApellido.text),
      FormValidators.correoAgrovisionRequerido(_correoCorp.text),
      FormValidators.correoGmailRequerido(_correoGmail.text),
      FormValidators.telefono10Requerido(_telefono.text),
      FormValidators.requerido(_password.text, 'La contrasena es obligatoria'),
      FormValidators.requerido(
        _confirmPassword.text,
        'Debe confirmar la contrasena',
      ),
      FormValidators.contrasenasCoinciden(_password.text, _confirmPassword.text),
      _rol == null ? 'Debe seleccionar un rol' : null,
    ];

    if (errores.any((e) => e != null)) return;

    widget.onGuardar({
      'nombre': _nombre.text.trim(),
      'segundoNombre': _segundoNombre.text.trim(),
      'apellido': _apellido.text.trim(),
      'segundoApellido': _segundoApellido.text.trim(),
      'correoCorporativo': _correoCorp.text.trim(),
      'correoElectronico': _correoGmail.text.trim(),
      'telefono': _telefono.text.trim(),
    }, _rol!);
  }

  @override
  Widget build(BuildContext context) {
    final screenSize = MediaQuery.sizeOf(context);
    final dialogWidth = screenSize.width > 792 ? 760.0 : screenSize.width - 32;
    final dialogHeight = (screenSize.height * 0.92).clamp(420.0, screenSize.height * 0.92);
    final isNarrow = screenSize.width < 640;

    return Material(
      color: Colors.transparent,
      child: Stack(
        children: [
          Positioned.fill(
            child: GestureDetector(
              onTap: widget.onCerrar,
              behavior: HitTestBehavior.opaque,
              child: Container(color: AppColors.modalBackdrop),
            ),
          ),
          Center(
            child: GestureDetector(
              onTap: () {},
              child: Container(
                width: dialogWidth,
                height: dialogHeight,
                padding: const EdgeInsets.fromLTRB(28, 28, 28, 24),
                decoration: PanelAdminStyle.modalCard,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.stretch,
                  children: [
                    Row(
                      children: [
                        Expanded(
                          child: Text(_titulo, style: PanelAdminStyle.modalTitle),
                        ),
                        IconButton(
                          onPressed: widget.onCerrar,
                          icon: const Icon(Icons.close),
                          style: IconButton.styleFrom(
                            backgroundColor: const Color(0xFFF5FAF3),
                          ),
                        ),
                      ],
                    ),
                    Expanded(
                      child: SingleChildScrollView(
                        padding: const EdgeInsets.only(top: 8),
                        child: Column(
                          children: [
                            if (isNarrow) ...[
                              _field(
                                'Nombre',
                                _nombre,
                                err: _submitted
                                    ? FormValidators.nombreOpcional(_nombre.text)
                                    : null,
                              ),
                              _field(
                                'Segundo nombre',
                                _segundoNombre,
                                err: _submitted
                                    ? FormValidators.nombreOpcional(
                                        _segundoNombre.text)
                                    : null,
                              ),
                              _field(
                                'Apellido',
                                _apellido,
                                err: _submitted
                                    ? FormValidators.nombreOpcional(_apellido.text)
                                    : null,
                              ),
                              _field(
                                'Segundo apellido',
                                _segundoApellido,
                                err: _submitted
                                    ? FormValidators.nombreOpcional(
                                        _segundoApellido.text)
                                    : null,
                              ),
                            ] else ...[
                              _row([
                                _field(
                                  'Nombre',
                                  _nombre,
                                  err: _submitted
                                      ? FormValidators.nombreOpcional(_nombre.text)
                                      : null,
                                ),
                                _field(
                                  'Segundo nombre',
                                  _segundoNombre,
                                  err: _submitted
                                      ? FormValidators.nombreOpcional(
                                          _segundoNombre.text)
                                      : null,
                                ),
                              ]),
                              _row([
                                _field(
                                  'Apellido',
                                  _apellido,
                                  err: _submitted
                                      ? FormValidators.nombreOpcional(_apellido.text)
                                      : null,
                                ),
                                _field(
                                  'Segundo apellido',
                                  _segundoApellido,
                                  err: _submitted
                                      ? FormValidators.nombreOpcional(
                                          _segundoApellido.text)
                                      : null,
                                ),
                              ]),
                            ],
                            _field(
                              'Correo corporativo',
                              _correoCorp,
                              icon: Icons.email_outlined,
                              placeholder: 'usuario@agrovision.com',
                              full: true,
                              err: _submitted
                                  ? FormValidators.correoAgrovisionRequerido(
                                      _correoCorp.text)
                                  : null,
                            ),
                            _field(
                              'Correo electronico',
                              _correoGmail,
                              icon: Icons.email_outlined,
                              placeholder: 'usuario@gmail.com',
                              full: true,
                              err: _submitted
                                  ? FormValidators.correoGmailRequerido(
                                      _correoGmail.text)
                                  : null,
                            ),
                            _field(
                              'Numero de telefono',
                              _telefono,
                              icon: Icons.phone_outlined,
                              placeholder: '10 digitos',
                              full: true,
                              keyboard: TextInputType.phone,
                              maxLength: 10,
                              err: _submitted
                                  ? FormValidators.telefono10Requerido(_telefono.text)
                                  : null,
                            ),
                            if (isNarrow) ...[
                              _field(
                                'Contrasena',
                                _password,
                                icon: Icons.lock_outline,
                                obscure: true,
                                toggle: true,
                                err: _submitted
                                    ? FormValidators.requerido(
                                        _password.text, 'La contrasena es obligatoria')
                                    : null,
                              ),
                              _field(
                                'Confirmar contrasena',
                                _confirmPassword,
                                icon: Icons.lock_outline,
                                obscure: true,
                                toggle: true,
                                err: _submitted
                                    ? FormValidators.requerido(
                                            _confirmPassword.text,
                                            'Debe confirmar la contrasena') ??
                                        FormValidators.contrasenasCoinciden(
                                          _password.text,
                                          _confirmPassword.text,
                                        )
                                    : null,
                              ),
                            ] else
                              _row([
                                _field(
                                  'Contrasena',
                                  _password,
                                  icon: Icons.lock_outline,
                                  obscure: true,
                                  toggle: true,
                                  err: _submitted
                                      ? FormValidators.requerido(
                                          _password.text, 'La contrasena es obligatoria')
                                      : null,
                                ),
                                _field(
                                  'Confirmar contrasena',
                                  _confirmPassword,
                                  icon: Icons.lock_outline,
                                  obscure: true,
                                  toggle: true,
                                  err: _submitted
                                      ? FormValidators.requerido(
                                              _confirmPassword.text,
                                              'Debe confirmar la contrasena') ??
                                          FormValidators.contrasenasCoinciden(
                                            _password.text,
                                            _confirmPassword.text,
                                          )
                                      : null,
                                ),
                              ]),
                            _rolSelector(),
                          ],
                        ),
                      ),
                    ),
                    const SizedBox(height: 12),
                    _modalActions(isNarrow: isNarrow),
                  ],
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _modalActions({required bool isNarrow}) {
    final submitLabel = widget.modo == ModalModoUsuario.registro
        ? 'Registrar usuario'
        : 'Guardar cambios';

    final submitButton = DecoratedBox(
      decoration: AuthFormStyle.submitButtonDecoration,
      child: ElevatedButton(
        onPressed: _soloLectura ? widget.onCerrar : _guardar,
        style: AuthFormStyle.submitButtonStyle.copyWith(
          minimumSize: WidgetStateProperty.all(const Size(0, 54)),
          padding: WidgetStateProperty.all(
            const EdgeInsets.symmetric(horizontal: 22, vertical: 14),
          ),
        ),
        child: Text(_soloLectura ? 'Cerrar' : submitLabel),
      ),
    );

    if (_soloLectura) {
      return SizedBox(width: double.infinity, child: submitButton);
    }

    if (isNarrow) {
      return Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          submitButton,
          const SizedBox(height: 10),
          OutlinedButton(
            onPressed: widget.onCerrar,
            child: const Text('Cancelar'),
          ),
        ],
      );
    }

    return Row(
      mainAxisAlignment: MainAxisAlignment.end,
      children: [
        OutlinedButton(
          onPressed: widget.onCerrar,
          child: const Text('Cancelar'),
        ),
        const SizedBox(width: 10),
        submitButton,
      ],
    );
  }

  Widget _row(List<Widget> children) {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: children
          .map((c) => Expanded(child: Padding(
                padding: const EdgeInsets.only(bottom: 14, right: 8),
                child: c,
              )))
          .toList(),
    );
  }

  Widget _field(
    String label,
    TextEditingController controller, {
    IconData icon = Icons.person_outline,
    String? placeholder,
    bool full = false,
    bool obscure = false,
    bool toggle = false,
    TextInputType? keyboard,
    int? maxLength,
    String? err,
  }) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 14),
      child: AuthInputField(
        label: label,
        controller: controller,
        icon: icon,
        placeholder: placeholder,
        readOnly: _soloLectura,
        obscureText: obscure,
        showToggle: toggle,
        keyboardType: keyboard,
        maxLength: maxLength,
        errorText: _submitted ? err : null,
      ),
    );
  }

  Widget _rolSelector() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const Text(
          'Rol',
          style: TextStyle(fontWeight: FontWeight.w700, fontSize: 14),
        ),
        const SizedBox(height: 8),
        Row(
          children: [
            _rolChip(RolUsuario.admin, 'Admin'),
            const SizedBox(width: 12),
            _rolChip(RolUsuario.agricultor, 'Agricultor'),
          ],
        ),
        if (_submitted && _rol == null)
          const Padding(
            padding: EdgeInsets.only(top: 7),
            child: Text(
              'Debe seleccionar un rol',
              style: TextStyle(color: AppColors.error, fontWeight: FontWeight.w700),
            ),
          ),
      ],
    );
  }

  Widget _rolChip(RolUsuario rol, String label) {
    final selected = _rol == rol;
    return InkWell(
      onTap: _soloLectura ? null : () => setState(() => _rol = rol),
      child: Container(
        padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
        decoration: BoxDecoration(
          border: Border.all(color: AppColors.border),
          borderRadius: BorderRadius.circular(8),
          color: AppColors.inputBackground,
        ),
        child: Row(
          mainAxisSize: MainAxisSize.min,
          children: [
            Icon(
              selected ? Icons.radio_button_checked : Icons.radio_button_off,
              color: AppColors.primaryGreen,
              size: 20,
            ),
            const SizedBox(width: 8),
            Text(label, style: const TextStyle(fontWeight: FontWeight.w700)),
          ],
        ),
      ),
    );
  }
}
