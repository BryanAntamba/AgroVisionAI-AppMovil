import 'package:flutter/material.dart';
import '../../styles/admin-styles/panel-admin.dart';
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
        color: const Color.fromRGBO(7, 61, 43, 0.45),
        child: Center(
          child: GestureDetector(
            onTap: () {},
            child: Container(
              constraints: const BoxConstraints(maxWidth: 480),
              margin: const EdgeInsets.all(24),
              padding: const EdgeInsets.fromLTRB(28, 28, 28, 24),
              decoration: PanelAdminStyles.cardDecoration,
              child: Column(
                mainAxisSize: MainAxisSize.min,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    children: [
                      const Expanded(
                        child: Text('Eliminar usuario', style: PanelAdminStyles.h1Text),
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
                  const SizedBox(height: 14),
                  RichText(
                    text: TextSpan(
                      style: const TextStyle(color: Color(0xFF456657), fontSize: 15, height: 1.5, fontFamily: 'Arial'),
                      children: [
                        const TextSpan(text: '¿Estas seguro de que deseas eliminar al usuario '),
                        TextSpan(
                          text: usuario.nombreCompleto,
                          style: const TextStyle(color: Color(0xFF073d2b), fontWeight: FontWeight.bold),
                        ),
                        const TextSpan(text: ' con el rol de '),
                        TextSpan(
                          text: usuario.rol.label,
                          style: const TextStyle(color: Color(0xFF073d2b), fontWeight: FontWeight.bold),
                        ),
                        const TextSpan(text: '?'),
                      ],
                    ),
                  ),
                  const SizedBox(height: 12),
                  const Text(
                    'Esta accion no se puede deshacer.',
                    style: TextStyle(
                      color: Color(0xFFA32626),
                      fontSize: 13,
                      fontWeight: FontWeight.w700,
                    ),
                  ),
                  const SizedBox(height: 24),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.end,
                    children: [
                      GestureDetector(
                        onTap: onCerrar,
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
                        onTap: onConfirmar,
                        child: Container(
                          constraints: const BoxConstraints(minHeight: 54),
                          padding: const EdgeInsets.symmetric(horizontal: 22),
                          decoration: BoxDecoration(
                            color: const Color(0xFFA32626),
                            borderRadius: BorderRadius.circular(8),
                            boxShadow: const [
                              BoxShadow(
                                color: Color.fromRGBO(163, 38, 38, 0.24),
                                blurRadius: 24,
                                offset: Offset(0, 12),
                              ),
                            ],
                          ),
                          child: const Row(
                            mainAxisSize: MainAxisSize.min,
                            children: [
                              Icon(Icons.delete, color: Colors.white, size: 16),
                              SizedBox(width: 8),
                              Text('Eliminar usuario',
                                  style: TextStyle(
                                      color: Colors.white,
                                      fontSize: 16,
                                      fontWeight: FontWeight.w800)),
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
