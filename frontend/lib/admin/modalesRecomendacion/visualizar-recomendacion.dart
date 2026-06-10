import 'package:flutter/material.dart';
import '../../environments/modales-recomendacion.dart';
import '../../styles/admin-styles/recomendaciones.dart';

class VisualizarRecomendacion extends StatelessWidget {
  final RecomendacionRegistrada recomendacion;
  final VoidCallback onCerrar;

  const VisualizarRecomendacion({
    super.key,
    required this.recomendacion,
    required this.onCerrar,
  });

  @override
  Widget build(BuildContext context) {
    final bg     = RecomendacionesStyles.cardBg(recomendacion.color);
    final border = RecomendacionesStyles.cardBorder(recomendacion.color);
    final priBg  = RecomendacionesStyles.prioridadBg(recomendacion.prioridad);
    final priTxt = RecomendacionesStyles.prioridadText(recomendacion.prioridad);
    final icono  = RecomendacionesStyles.prioridadIcon(recomendacion.color);

    return GestureDetector(
      onTap: onCerrar,
      child: Container(
        color: const Color.fromRGBO(7, 61, 43, 0.45),
        child: Center(
          child: GestureDetector(
            onTap: () {},
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
                        child: Text('Visualizar recomendación',
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
                  const SizedBox(height: 16),
                  Container(
                    width: double.infinity,
                    padding: const EdgeInsets.all(16),
                    decoration: BoxDecoration(
                      color: bg,
                      border: Border.all(color: border),
                      borderRadius: BorderRadius.circular(8),
                    ),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Container(
                          padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 3),
                          decoration: BoxDecoration(
                              color: priBg,
                              borderRadius: BorderRadius.circular(99)),
                          child: Row(mainAxisSize: MainAxisSize.min, children: [
                            Icon(icono, size: 11, color: priTxt),
                            const SizedBox(width: 4),
                            Text(
                              recomendacion.prioridad.label.toUpperCase(),
                              style: RecomendacionesStyles.badgeText
                                  .copyWith(color: priTxt),
                            ),
                          ]),
                        ),
                        const SizedBox(height: 8),
                        Text(recomendacion.titulo, style: RecomendacionesStyles.cardTitle),
                        const SizedBox(height: 6),
                        Text(recomendacion.descripcion, style: RecomendacionesStyles.cardDesc),
                        if (recomendacion.accion.isNotEmpty) ...[
                          const SizedBox(height: 10),
                          Container(
                            padding: const EdgeInsets.only(top: 10),
                            decoration: const BoxDecoration(
                              border: Border(
                                  top: BorderSide(
                                      color: Color.fromRGBO(7, 61, 43, 0.1))),
                            ),
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                const Text('ACCIÓN RECOMENDADA:',
                                    style: RecomendacionesStyles.accionLabel),
                                const SizedBox(height: 4),
                                Text(recomendacion.accion,
                                    style: RecomendacionesStyles.accionText),
                              ],
                            ),
                          ),
                        ],
                      ],
                    ),
                  ),
                  const SizedBox(height: 20),
                  Align(
                    alignment: Alignment.centerRight,
                    child: GestureDetector(
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
                          widthFactor: 1.0,
                          child: Text('Cerrar', style: RecomendacionesStyles.labelText),
                        ),
                      ),
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
}
