import 'package:flutter/material.dart';
import '../../styles/admin-styles/modales-styles/perfil-usuario.dart';
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
    final bool isMobile = MediaQuery.of(context).size.width <= PerfilUsuarioStyles.mobileBreakpoint;

    return GestureDetector(
      onTap: onCerrar,
      child: Container(
        color: PerfilUsuarioStyles.overlayColor,
        child: Center(
          child: GestureDetector(
            onTap: () {},
            child: Container(
              constraints: const BoxConstraints(maxWidth: PerfilUsuarioStyles.maxWidth),
              margin: PerfilUsuarioStyles.modalMargin,
              decoration: PerfilUsuarioStyles.modalDecoration,
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  // Header
                  Padding(
                    padding: PerfilUsuarioStyles.headerPadding,
                    child: Row(
                      children: [
                        const Expanded(
                          child: Text('Perfil de usuario', style: PerfilUsuarioStyles.titleText),
                        ),
                        GestureDetector(
                          onTap: onCerrar,
                          child: Container(
                            width: PerfilUsuarioStyles.closeButtonSize,
                            height: PerfilUsuarioStyles.closeButtonSize,
                            decoration: PerfilUsuarioStyles.closeButtonDecoration,
                            child: const Icon(Icons.close,
                                color: PerfilUsuarioStyles.closeIconColor, 
                                size: PerfilUsuarioStyles.closeIconSize),
                          ),
                        ),
                      ],
                    ),
                  ),
                  const SizedBox(height: 22),
                  // Formulario
                  Flexible(
                    child: SingleChildScrollView(
                      padding: PerfilUsuarioStyles.formPadding,
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
                    padding: PerfilUsuarioStyles.footerPadding,
                    child: Row(
                      children: [
                        Expanded(
                          child: GestureDetector(
                            onTap: onCerrar,
                            child: Container(
                              constraints: const BoxConstraints(minHeight: PerfilUsuarioStyles.minButtonHeight),
                              decoration: PerfilUsuarioStyles.closeFooterButtonDecoration,
                              child: const Center(
                                child: Text('Cerrar', style: PerfilUsuarioStyles.closeFooterButtonText),
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
        children: children.map((w) => Padding(padding: const EdgeInsets.only(bottom: PerfilUsuarioStyles.fieldSpacing), child: w)).toList(),
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
          rows.add(const SizedBox(height: PerfilUsuarioStyles.fieldSpacing));
          currentRow = [];
        }
        rows.add(child);
        rows.add(const SizedBox(height: PerfilUsuarioStyles.fieldSpacing));
      } else {
        currentRow.add(Expanded(child: child));
        if (currentRow.length == 2) {
          rows.add(Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [currentRow[0], const SizedBox(width: PerfilUsuarioStyles.columnSpacing), currentRow[1]],
          ));
          rows.add(const SizedBox(height: PerfilUsuarioStyles.fieldSpacing));
          currentRow = [];
        }
      }
    }
    if (currentRow.isNotEmpty) {
      rows.add(Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [currentRow[0], const SizedBox(width: PerfilUsuarioStyles.columnSpacing), Expanded(child: Container())],
      ));
    }
    return Column(crossAxisAlignment: CrossAxisAlignment.stretch, children: rows);
  }

  Widget _buildTextField(String label, IconData icon, String text, {bool isFull = false}) {
    return Container(
      key: isFull ? const ValueKey('full') : null,
      constraints: const BoxConstraints(minHeight: PerfilUsuarioStyles.minFieldHeight),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(label, style: PerfilUsuarioStyles.labelText),
          const SizedBox(height: PerfilUsuarioStyles.labelSpacing),
          Container(
            height: PerfilUsuarioStyles.inputHeight,
            decoration: PerfilUsuarioStyles.inputDecoration,
            child: Row(
              children: [
                SizedBox(
                  width: PerfilUsuarioStyles.iconContainerWidth,
                  child: Center(child: Icon(icon, color: PerfilUsuarioStyles.iconColor, size: PerfilUsuarioStyles.iconSize)),
                ),
                Expanded(
                  child: Text(
                    text.isEmpty ? PerfilUsuarioStyles.emptyValue : text,
                    style: PerfilUsuarioStyles.inputTextStyle,
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
      constraints: const BoxConstraints(minHeight: PerfilUsuarioStyles.minFieldHeight),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(label, style: PerfilUsuarioStyles.labelText),
          const SizedBox(height: PerfilUsuarioStyles.labelSpacing),
          Container(
            height: PerfilUsuarioStyles.inputHeight,
            decoration: PerfilUsuarioStyles.inputDecoration,
            child: const Row(
              children: [
                SizedBox(
                  width: PerfilUsuarioStyles.iconContainerWidth,
                  child: Center(child: Icon(Icons.lock, color: PerfilUsuarioStyles.iconColor, size: PerfilUsuarioStyles.iconSize)),
                ),
                Expanded(
                  child: Text('********', style: PerfilUsuarioStyles.inputTextStyle),
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
      constraints: const BoxConstraints(minHeight: PerfilUsuarioStyles.minFieldHeight),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Text('Rol', style: PerfilUsuarioStyles.rolLabelText),
          const SizedBox(height: PerfilUsuarioStyles.labelSpacing),
          RadioGroup<RolUsuario>(
            groupValue: rol,
            onChanged: (_) {},
            child: Wrap(
              spacing: PerfilUsuarioStyles.rolSpacing,
              runSpacing: PerfilUsuarioStyles.rolSpacing,
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
      height: PerfilUsuarioStyles.rolOptionHeight,
      padding: PerfilUsuarioStyles.rolOptionPadding,
      decoration: PerfilUsuarioStyles.rolOptionDecoration,
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          Opacity(
            opacity: PerfilUsuarioStyles.radioOpacity,
            child: Radio<RolUsuario>(
              value: option,
              activeColor: PerfilUsuarioStyles.radioActiveColor,
            ),
          ),
          const SizedBox(width: PerfilUsuarioStyles.radioSpacing),
          Text(option.label, style: PerfilUsuarioStyles.rolOptionText),
        ],
      ),
    );
  }
}
