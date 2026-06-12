import 'package:flutter/material.dart';
import '../../styles/admin-styles/modales-styles/eliminar-usuario.dart';
import '../../environments/datos-simulados-admin.dart';

class EliminarUsuario extends StatelessWidget {
  final UsuarioAdmin usuario;
  final VoidCallback onCerrar;
  final VoidCallback onConfirmar;

  const EliminarUsuario({
    super.key,
    required this.usuario,
    required this.onCerrar,
    required this.onConfirmar,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onCerrar,
      child: Container(
        color: EliminarUsuarioStyles.overlayColor,
        child: Center(
          child: GestureDetector(
            onTap: () {},
            child: Container(
              constraints: const BoxConstraints(maxWidth: EliminarUsuarioStyles.maxWidth),
              margin: EliminarUsuarioStyles.modalMargin,
              padding: EliminarUsuarioStyles.modalPadding,
              decoration: EliminarUsuarioStyles.modalDecoration,
              child: Column(
                mainAxisSize: MainAxisSize.min,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    children: [
                      const Expanded(
                        child: Text('Eliminar usuario', style: EliminarUsuarioStyles.titleText),
                      ),
                      GestureDetector(
                        onTap: onCerrar,
                        child: Container(
                          width: EliminarUsuarioStyles.closeButtonSize,
                          height: EliminarUsuarioStyles.closeButtonSize,
                          decoration: EliminarUsuarioStyles.closeButtonDecoration,
                          child: const Icon(Icons.close,
                              color: EliminarUsuarioStyles.closeIconColor, 
                              size: EliminarUsuarioStyles.closeIconSize),
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(height: EliminarUsuarioStyles.contentSpacing),
                  RichText(
                    text: TextSpan(
                      style: EliminarUsuarioStyles.bodyText,
                      children: [
                        const TextSpan(text: '¿Estas seguro de que deseas eliminar al usuario '),
                        TextSpan(
                          text: usuario.nombreCompleto,
                          style: EliminarUsuarioStyles.boldText,
                        ),
                        const TextSpan(text: ' con el rol de '),
                        TextSpan(
                          text: usuario.rol.label,
                          style: EliminarUsuarioStyles.boldText,
                        ),
                        const TextSpan(text: '?'),
                      ],
                    ),
                  ),
                  const SizedBox(height: EliminarUsuarioStyles.warningSpacing),
                  const Text(
                    'Esta accion no se puede deshacer.',
                    style: EliminarUsuarioStyles.warningText,
                  ),
                  const SizedBox(height: EliminarUsuarioStyles.footerSpacing),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.end,
                    children: [
                      GestureDetector(
                        onTap: onCerrar,
                        child: Container(
                          constraints: const BoxConstraints(minHeight: EliminarUsuarioStyles.minButtonHeight),
                          padding: EliminarUsuarioStyles.cancelButtonPadding,
                          decoration: EliminarUsuarioStyles.cancelButtonDecoration,
                          child: const Center(
                            child: Text('Cancelar', style: EliminarUsuarioStyles.cancelButtonText),
                          ),
                        ),
                      ),
                      const SizedBox(width: EliminarUsuarioStyles.buttonSpacing),
                      GestureDetector(
                        onTap: onConfirmar,
                        child: Container(
                          constraints: const BoxConstraints(minHeight: EliminarUsuarioStyles.minButtonHeight),
                          padding: EliminarUsuarioStyles.deleteButtonPadding,
                          decoration: EliminarUsuarioStyles.deleteButtonDecoration,
                          child: const Row(
                            mainAxisSize: MainAxisSize.min,
                            children: [
                              Icon(Icons.delete, color: Colors.white, size: EliminarUsuarioStyles.deleteIconSize),
                              SizedBox(width: EliminarUsuarioStyles.iconTextSpacing),
                              Text('Eliminar usuario', style: EliminarUsuarioStyles.deleteButtonText),
                            ],
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
    );
  }
}
