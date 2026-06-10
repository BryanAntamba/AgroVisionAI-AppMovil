import 'package:flutter/material.dart';
import '../../styles/admin-styles/panel-admin.dart';
import '../../environments/datos-simulados-admin.dart';

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

  void _submit() {
    if (_correoCorpCtrl.text.isEmpty ||
        _correoElecCtrl.text.isEmpty ||
        _telefonoCtrl.text.isEmpty ||
        _passwordCtrl.text.isEmpty ||
        _rol == null) {
      // Idealmente, se muestra un error, pero por ahora solo se bloquea.
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
    final bool isMobile = MediaQuery.of(context).size.width <= 700;

    return GestureDetector(
      onTap: widget.onCerrar,
      child: Container(
        color: const Color.fromRGBO(7, 61, 43, 0.45),
        child: Center(
          child: GestureDetector(
            onTap: () {},
            child: Container(
              constraints: const BoxConstraints(maxWidth: 760),
              margin: const EdgeInsets.all(24),
              decoration: BoxDecoration(
                color: Colors.white,
                border: Border.all(color: PanelAdminStyles.borderGrey),
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
                  // Header
                  Padding(
                    padding: const EdgeInsets.fromLTRB(28, 28, 28, 0),
                    child: Row(
                      children: [
                        Expanded(
                          child: Text('Registro de usuario', style: PanelAdminStyles.h1Text),
                        ),
                        GestureDetector(
                          onTap: widget.onCerrar,
                          child: Container(
                            width: 40,
                            height: 40,
                            decoration: BoxDecoration(
                              color: PanelAdminStyles.backgroundPage,
                              borderRadius: BorderRadius.circular(8),
                            ),
                            child: const Icon(Icons.close,
                                color: PanelAdminStyles.darkGreen, size: 18),
                          ),
                        ),
                      ],
                    ),
                  ),
                  const SizedBox(height: 22),
                  // Formulario
                  Flexible(
                    child: SingleChildScrollView(
                      padding: const EdgeInsets.symmetric(horizontal: 28),
                      child: Column(
                        children: [
                          _buildGrid(
                            isMobile: isMobile,
                            children: [
                              _buildTextField('Nombre', Icons.person, _nombreCtrl),
                              _buildTextField('Segundo nombre', Icons.person, _segundoNombreCtrl),
                              _buildTextField('Apellido', Icons.person, _apellidoCtrl),
                              _buildTextField('Segundo apellido', Icons.person, _segundoApellidoCtrl),
                              _buildTextField('Correo corporativo *', Icons.email, _correoCorpCtrl,
                                  isFull: true, placeholder: 'usuario@agrovision.com'),
                              _buildTextField('Correo electronico *', Icons.email, _correoElecCtrl,
                                  isFull: true, placeholder: 'usuario@gmail.com'),
                              _buildTextField('Numero de telefono *', Icons.phone, _telefonoCtrl,
                                  isFull: true, placeholder: '10 digitos', keyboardType: TextInputType.phone),
                              _buildPasswordField('Contraseña *', _passwordCtrl, _showPassword, () {
                                setState(() => _showPassword = !_showPassword);
                              }),
                              _buildPasswordField('Confirmar contraseña *', _confirmPassCtrl, _showConfirmPassword, () {
                                setState(() => _showConfirmPassword = !_showConfirmPassword);
                              }),
                              _buildRolField(),
                            ],
                          ),
                        ],
                      ),
                    ),
                  ),
                  // Footer
                  Padding(
                    padding: const EdgeInsets.fromLTRB(28, 16, 28, 24),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.end,
                      children: [
                        GestureDetector(
                          onTap: widget.onCerrar,
                          child: Container(
                            constraints: const BoxConstraints(minHeight: 54),
                            padding: const EdgeInsets.symmetric(horizontal: 18),
                            decoration: BoxDecoration(
                              color: PanelAdminStyles.backgroundInput,
                              border: Border.all(color: PanelAdminStyles.borderGrey),
                              borderRadius: BorderRadius.circular(8),
                            ),
                            child: const Center(
                              child: Text('Cancelar',
                                  style: TextStyle(
                                      color: PanelAdminStyles.darkGreen,
                                      fontSize: 16,
                                      fontWeight: FontWeight.w800)),
                            ),
                          ),
                        ),
                        const SizedBox(width: 10),
                        GestureDetector(
                          onTap: _submit,
                          child: Container(
                            constraints: const BoxConstraints(minHeight: 54),
                            padding: const EdgeInsets.symmetric(horizontal: 22),
                            decoration: PanelAdminStyles.createBtnDecoration,
                            child: const Center(
                              child: Text('Registrar usuario',
                                  style: TextStyle(
                                      color: Colors.white,
                                      fontSize: 16,
                                      fontWeight: FontWeight.w800)),
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
        children: children.map((w) => Padding(padding: const EdgeInsets.only(bottom: 18), child: w)).toList(),
      );
    }
    List<Widget> rows = [];
    List<Widget> currentRow = [];
    for (int i = 0; i < children.length; i++) {
      final child = children[i];
      // Determinar si es full width basado en un tag rudimentario (en Flutter no tenemos CSS grid column, simulamos con Row)
      bool isFull = child is Container && child.key == const ValueKey('full');
      if (isFull) {
        if (currentRow.isNotEmpty) {
          rows.add(Row(crossAxisAlignment: CrossAxisAlignment.start, children: currentRow));
          rows.add(const SizedBox(height: 18));
          currentRow = [];
        }
        rows.add(child);
        rows.add(const SizedBox(height: 18));
      } else {
        currentRow.add(Expanded(child: child));
        if (currentRow.length == 2) {
          // Agregar espaciado entre las 2 columnas
          rows.add(Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              currentRow[0],
              const SizedBox(width: 16),
              currentRow[1],
            ],
          ));
          rows.add(const SizedBox(height: 18));
          currentRow = [];
        }
      }
    }
    if (currentRow.isNotEmpty) {
      rows.add(Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          currentRow[0],
          const SizedBox(width: 16),
          Expanded(child: Container()), // Spacer vacío
        ],
      ));
    }
    return Column(crossAxisAlignment: CrossAxisAlignment.stretch, children: rows);
  }

  Widget _buildTextField(String label, IconData icon, TextEditingController ctrl,
      {bool isFull = false, String placeholder = '', TextInputType? keyboardType}) {
    return Container(
      key: isFull ? const ValueKey('full') : null,
      constraints: const BoxConstraints(minHeight: 103),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(label, style: const TextStyle(fontSize: 13, fontWeight: FontWeight.w800, color: PanelAdminStyles.darkGreen)),
          const SizedBox(height: 8),
          Container(
            height: 54,
            decoration: BoxDecoration(
              color: PanelAdminStyles.backgroundInput,
              border: Border.all(color: PanelAdminStyles.borderGrey),
              borderRadius: BorderRadius.circular(8),
            ),
            child: Row(
              children: [
                SizedBox(
                  width: 48,
                  child: Center(child: Icon(icon, color: PanelAdminStyles.primaryGreen, size: 16)),
                ),
                Expanded(
                  child: TextField(
                    controller: ctrl,
                    keyboardType: keyboardType,
                    decoration: InputDecoration(
                      hintText: placeholder.isEmpty ? label : placeholder,
                      hintStyle: const TextStyle(color: Color(0xFF6B8177), fontSize: 14),
                      border: InputBorder.none,
                      contentPadding: const EdgeInsets.symmetric(vertical: 16),
                    ),
                    style: const TextStyle(color: PanelAdminStyles.darkGreen, fontSize: 14),
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildPasswordField(String label, TextEditingController ctrl, bool showPass, VoidCallback onToggle) {
    return Container(
      constraints: const BoxConstraints(minHeight: 103),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(label, style: const TextStyle(fontSize: 13, fontWeight: FontWeight.w800, color: PanelAdminStyles.darkGreen)),
          const SizedBox(height: 8),
          Container(
            height: 54,
            decoration: BoxDecoration(
              color: PanelAdminStyles.backgroundInput,
              border: Border.all(color: PanelAdminStyles.borderGrey),
              borderRadius: BorderRadius.circular(8),
            ),
            child: Row(
              children: [
                const SizedBox(
                  width: 48,
                  child: Center(child: Icon(Icons.lock, color: PanelAdminStyles.primaryGreen, size: 16)),
                ),
                Expanded(
                  child: TextField(
                    controller: ctrl,
                    obscureText: !showPass,
                    decoration: InputDecoration(
                      hintText: 'Contraseña',
                      hintStyle: const TextStyle(color: Color(0xFF6B8177), fontSize: 14),
                      border: InputBorder.none,
                      contentPadding: const EdgeInsets.symmetric(vertical: 16),
                    ),
                    style: const TextStyle(color: PanelAdminStyles.darkGreen, fontSize: 14),
                  ),
                ),
                GestureDetector(
                  onTap: onToggle,
                  child: SizedBox(
                    width: 46,
                    child: Center(
                      child: Icon(
                        showPass ? Icons.visibility_off : Icons.visibility,
                        color: PanelAdminStyles.darkGreen,
                        size: 16,
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildRolField() {
    return Container(
      key: const ValueKey('full'),
      constraints: const BoxConstraints(minHeight: 103),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Text('Rol *', style: TextStyle(fontSize: 14, fontWeight: FontWeight.w700, color: PanelAdminStyles.darkGreen)),
          const SizedBox(height: 8),
          RadioGroup<RolUsuario?>(
            groupValue: _rol,
            onChanged: (v) => setState(() => _rol = v),
            child: Wrap(
              spacing: 12,
              runSpacing: 12,
              children: [
                _buildRadioOption(RolUsuario.admin),
                _buildRadioOption(RolUsuario.agricultor),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildRadioOption(RolUsuario rol) {
    return GestureDetector(
      onTap: () => setState(() => _rol = rol),
      child: Container(
        height: 54,
        padding: const EdgeInsets.symmetric(horizontal: 16),
        decoration: BoxDecoration(
          color: PanelAdminStyles.backgroundInput,
          border: Border.all(color: PanelAdminStyles.borderGrey),
          borderRadius: BorderRadius.circular(8),
        ),
        child: Row(
          mainAxisSize: MainAxisSize.min,
          children: [
            Radio<RolUsuario>(
              value: rol,
              activeColor: PanelAdminStyles.primaryGreen,
            ),
            const SizedBox(width: 4),
            Text(rol.label, style: const TextStyle(fontSize: 14, fontWeight: FontWeight.w700, color: PanelAdminStyles.darkGreen)),
          ],
        ),
      ),
    );
  }
}
