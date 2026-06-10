import 'package:flutter/material.dart';
import '../../environments/modales-recomendacion.dart';
import '../../styles/admin-styles/recomendaciones.dart';

class EliminarRecomendacion extends StatelessWidget {
  final RecomendacionRegistrada recomendacion;
  final VoidCallback onCerrar;
  final VoidCallback onConfirmar;

  const EliminarRecomendacion({
    super.key,
    required this.recomendacion,
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
            onTap: () {}, // Evitar que el tap se propague al fondo
            child: Container(
              constraints: const BoxConstraints(maxWidth: 560),
              margin: const EdgeInsets.all(24),
              padding: const EdgeInsets.all(28),
              decoration: BoxDecoration(
                color: Colors.white,
                border: Border.all(color: RecomendacionesStyles.borderGrey),
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
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    children: [
                      Expanded(
                        child: Text('¿Eliminar recomendación?',
                            style: RecomendacionesStyles.h1Text.copyWith(fontSize: 22)),
                      ),
                      GestureDetector(
                        onTap: onCerrar,
                        child: Container(
                          width: 40,
                          height: 40,
                          decoration: BoxDecoration(
                            color: RecomendacionesStyles.backgroundPage,
                            borderRadius: BorderRadius.circular(8),
                          ),
                          child: const Icon(Icons.close,
                              color: RecomendacionesStyles.darkGreen, size: 18),
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(height: 14),
                  Text(
                    '¿Está seguro de que desea eliminar la recomendación "${recomendacion.titulo}"?',
                    style: RecomendacionesStyles.headerDesc,
                  ),
                  const SizedBox(height: 8),
                  const Text(
                    'Esta acción no se puede deshacer.',
                    style: TextStyle(
                      color: RecomendacionesStyles.dangerText,
                      fontSize: 14,
                      fontWeight: FontWeight.w800,
                    ),
                  ),
                  const SizedBox(height: 24),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.end,
                    children: [
                      GestureDetector(
                        onTap: onCerrar,
                        child: Container(
                          constraints: const BoxConstraints(minHeight: 50),
                          padding: const EdgeInsets.symmetric(horizontal: 18),
                          decoration: BoxDecoration(
                            color: RecomendacionesStyles.backgroundInput,
                            border: Border.all(color: RecomendacionesStyles.borderGrey),
                            borderRadius: BorderRadius.circular(8),
                          ),
                          child: const Center(
                            child: Text('Cancelar', style: RecomendacionesStyles.labelText),
                          ),
                        ),
                      ),
                      const SizedBox(width: 10),
                      GestureDetector(
                        onTap: onConfirmar,
                        child: Container(
                          constraints: const BoxConstraints(minHeight: 50),
                          padding: const EdgeInsets.symmetric(horizontal: 22),
                          decoration: BoxDecoration(
                            color: RecomendacionesStyles.dangerText,
                            borderRadius: BorderRadius.circular(8),
                            boxShadow: const [
                              BoxShadow(
                                color: Color.fromRGBO(198, 40, 40, 0.24),
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
                              Text('Eliminar recomendación',
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
