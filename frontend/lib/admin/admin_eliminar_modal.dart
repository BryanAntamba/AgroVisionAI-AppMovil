import 'package:flutter/material.dart';
import '../models/usuariosRandom_admin.dart';
import '../styles/app_colors.dart';
import '../styles/panel_admin_style.dart';

class PanelAdminDeleteModal extends StatelessWidget {
  const PanelAdminDeleteModal({
    super.key,
    required this.usuario,
    required this.onCancelar,
    required this.onConfirmar,
  });

  final UsuarioAdmin usuario;
  final VoidCallback onCancelar;
  final VoidCallback onConfirmar;

  @override
  Widget build(BuildContext context) {
    final dialogWidth =
        MediaQuery.sizeOf(context).width > 528 ? 480.0 : MediaQuery.sizeOf(context).width - 32;

    return Material(
      color: Colors.transparent,
      child: Stack(
        children: [
          Positioned.fill(
            child: GestureDetector(
              onTap: onCancelar,
              behavior: HitTestBehavior.opaque,
              child: Container(color: AppColors.modalBackdrop),
            ),
          ),
          Center(
            child: GestureDetector(
              onTap: () {},
              child: Container(
                width: dialogWidth,
                padding: const EdgeInsets.fromLTRB(28, 28, 28, 24),
                decoration: PanelAdminStyle.modalCard,
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                  Align(
                    alignment: Alignment.topRight,
                    child: IconButton(
                      onPressed: onCancelar,
                      icon: const Icon(Icons.close),
                      style: IconButton.styleFrom(
                        backgroundColor: const Color(0xFFF5FAF3),
                      ),
                    ),
                  ),
                  Text('Eliminar usuario', style: PanelAdminStyle.modalTitle),
                  const SizedBox(height: 16),
                  RichText(
                    text: TextSpan(
                      style: PanelAdminStyle.confirmMessage,
                      children: [
                        const TextSpan(
                          text:
                              '¿Estas seguro de que deseas eliminar al usuario ',
                        ),
                        TextSpan(
                          text: usuario.nombreCompleto,
                          style: const TextStyle(
                            fontWeight: FontWeight.w800,
                            color: Color(0xFF073D2B),
                          ),
                        ),
                        const TextSpan(text: ' con el rol de '),
                        TextSpan(
                          text: usuario.rol.label,
                          style: const TextStyle(
                            fontWeight: FontWeight.w800,
                            color: Color(0xFF073D2B),
                          ),
                        ),
                        const TextSpan(text: '?'),
                      ],
                    ),
                  ),
                  const SizedBox(height: 12),
                  Text(
                    'Esta accion no se puede deshacer.',
                    style: PanelAdminStyle.confirmWarning,
                  ),
                  const SizedBox(height: 22),
                  LayoutBuilder(
                    builder: (context, constraints) {
                      final isNarrow = constraints.maxWidth < 420;
                      final deleteButton = DecoratedBox(
                        decoration: PanelAdminStyle.deleteButton,
                        child: ElevatedButton.icon(
                          onPressed: onConfirmar,
                          style: ElevatedButton.styleFrom(
                            backgroundColor: Colors.transparent,
                            shadowColor: Colors.transparent,
                            foregroundColor: Colors.white,
                            minimumSize: const Size(0, 54),
                            padding: const EdgeInsets.symmetric(
                              horizontal: 22,
                              vertical: 14,
                            ),
                          ),
                          icon: const Icon(Icons.delete_outline, size: 18),
                          label: const Text(
                            'Eliminar usuario',
                            style: TextStyle(fontWeight: FontWeight.w800),
                          ),
                        ),
                      );

                      if (isNarrow) {
                        return Column(
                          crossAxisAlignment: CrossAxisAlignment.stretch,
                          children: [
                            deleteButton,
                            const SizedBox(height: 10),
                            OutlinedButton(
                              onPressed: onCancelar,
                              child: const Text('Cancelar'),
                            ),
                          ],
                        );
                      }

                      return Row(
                        mainAxisAlignment: MainAxisAlignment.end,
                        children: [
                          OutlinedButton(
                            onPressed: onCancelar,
                            child: const Text('Cancelar'),
                          ),
                          const SizedBox(width: 10),
                          deleteButton,
                        ],
                      );
                    },
                  ),
                ],
              ),
            ),
          ),
        ),
        ],
      ),
    );
  }
}
