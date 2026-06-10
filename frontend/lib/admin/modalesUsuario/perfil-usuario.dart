import 'package:flutter/material.dart';
import '../../styles/admin-styles/panel-admin.dart';
import '../../environments/datos-simulados-admin.dart';

class PerfilUsuario extends StatelessWidget {
  final UsuarioAdmin usuario;
  final VoidCallback onCerrar;

  const PerfilUsuario({
    super.key,
    required this.usuario,
    required this.onCerrar,
  });

  @override
  Widget build(BuildContext context) {
    final bool isMobile = MediaQuery.of(context).size.width <= 700;

    return GestureDetector(
      onTap: onCerrar,
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
                          child: Text('Perfil de usuario', style: PanelAdminStyles.h1Text),
                        ),
                        GestureDetector(
                          onTap: onCerrar,
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
                              _buildTextField('Nombre', Icons.person, usuario.nombre),
                              _buildTextField('Segundo nombre', Icons.person, usuario.segundoNombre),
                              _buildTextField('Apellido', Icons.person, usuario.apellido),
                              _buildTextField('Segundo apellido', Icons.person, usuario.segundoApellido),
                              _buildTextField('Correo corporativo', Icons.email, usuario.correoCorporativo, isFull: true),
                              _buildTextField('Correo electronico', Icons.email, usuario.correoElectronico, isFull: true),
                              _buildTextField('Numero de telefono', Icons.phone, usuario.telefono, isFull: true),
                              _buildPasswordField('Contraseña'),
                              _buildPasswordField('Confirmar contraseña'),
                              _buildRolField(usuario.rol),
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
                      children: [
                        Expanded(
                          child: GestureDetector(
                            onTap: onCerrar,
                            child: Container(
                              constraints: const BoxConstraints(minHeight: 54),
                              decoration: PanelAdminStyles.createBtnDecoration,
                              child: const Center(
                                child: Text('Cerrar',
                                    style: TextStyle(
                                        color: Colors.white,
                                        fontSize: 16,
                                        fontWeight: FontWeight.w800)),
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
          rows.add(Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [currentRow[0], const SizedBox(width: 16), currentRow[1]],
          ));
          rows.add(const SizedBox(height: 18));
          currentRow = [];
        }
      }
    }
    if (currentRow.isNotEmpty) {
      rows.add(Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [currentRow[0], const SizedBox(width: 16), Expanded(child: Container())],
      ));
    }
    return Column(crossAxisAlignment: CrossAxisAlignment.stretch, children: rows);
  }

  Widget _buildTextField(String label, IconData icon, String text, {bool isFull = false}) {
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
                  child: Text(
                    text.isEmpty ? '---' : text,
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

  Widget _buildPasswordField(String label) {
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
                const Expanded(
                  child: Text('********', style: TextStyle(color: PanelAdminStyles.darkGreen, fontSize: 14)),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildRolField(RolUsuario rol) {
    return Container(
      key: const ValueKey('full'),
      constraints: const BoxConstraints(minHeight: 103),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Text('Rol', style: TextStyle(fontSize: 14, fontWeight: FontWeight.w700, color: PanelAdminStyles.darkGreen)),
          const SizedBox(height: 8),
          RadioGroup<RolUsuario>(
            groupValue: rol,
            onChanged: (_) {},
            child: Wrap(
              spacing: 12,
              runSpacing: 12,
              children: [
                _buildRadioOption(RolUsuario.admin, rol),
                _buildRadioOption(RolUsuario.agricultor, rol),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildRadioOption(RolUsuario option, RolUsuario selected) {
    return Container(
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
          Opacity(
            opacity: 0.92,
            child: Radio<RolUsuario>(
              value: option,
              activeColor: PanelAdminStyles.primaryGreen,
            ),
          ),
          const SizedBox(width: 4),
          Text(option.label, style: const TextStyle(fontSize: 14, fontWeight: FontWeight.w700, color: PanelAdminStyles.darkGreen)),
        ],
      ),
    );
  }
}
