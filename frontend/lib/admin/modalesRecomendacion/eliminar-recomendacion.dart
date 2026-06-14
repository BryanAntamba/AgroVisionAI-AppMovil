import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import '../../environments/modales-recomendacion.dart';
import '../../styles/admin-styles/modalesRecomendacion-styles/eliminar-recomendacion.dart';

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
        color: EliminarRecomendacionStyles.backdropColor,
        child: Center(
          child: GestureDetector(
            onTap: () {},
            child: Container(
              constraints: const BoxConstraints(maxWidth: 480),
              margin: const EdgeInsets.symmetric(horizontal: 16, vertical: 24),
              decoration: EliminarRecomendacionStyles.cardDecoration,
              child: Stack(
                clipBehavior: Clip.none,
                children: [
                  Padding(
                    padding: const EdgeInsets.only(
                      left: 28,
                      right: 28,
                      top: 28,
                      bottom: 24,
                    ),
                    child: Column(
                      mainAxisSize: MainAxisSize.min,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Padding(
                          padding: const EdgeInsets.only(right: 44, bottom: 16),
                          child: Text(
                            'Eliminar recomendación',
                            style: EliminarRecomendacionStyles.titleStyle,
                          ),
                        ),
                        RichText(
                          text: TextSpan(
                            style: EliminarRecomendacionStyles.confirmMessage,
                            children: [
                              const TextSpan(
                                text:
                                    '¿Está seguro de que desea eliminar la recomendación ',
                              ),
                              TextSpan(
                                text: '${recomendacion.titulo}?',
                                style: EliminarRecomendacionStyles
                                    .confirmMessageBold,
                              ),
                            ],
                          ),
                        ),
                        const SizedBox(height: 12),
                        const Text(
                          'Esta acción no se puede deshacer.',
                          style: EliminarRecomendacionStyles.confirmWarning,
                        ),
                        const SizedBox(height: 22),
                        Row(
                          children: [
                            Expanded(
                              child: GestureDetector(
                                onTap: onCerrar,
                                child: Container(
                                  constraints: const BoxConstraints(
                                    minHeight: 54,
                                  ),
                                  padding: const EdgeInsets.symmetric(
                                    horizontal: 18,
                                  ),
                                  decoration: EliminarRecomendacionStyles
                                      .cancelBtnDecoration,
                                  child: const Center(
                                    child: Text(
                                      'Cancelar',
                                      style: EliminarRecomendacionStyles
                                          .cancelBtnStyle,
                                    ),
                                  ),
                                ),
                              ),
                            ),
                            const SizedBox(width: 10),
                            Expanded(
                              child: GestureDetector(
                                onTap: onConfirmar,
                                child: Container(
                                  constraints: const BoxConstraints(
                                    minHeight: 54,
                                  ),
                                  padding: const EdgeInsets.symmetric(
                                    horizontal: 4,
                                    vertical: 10,
                                  ),
                                  decoration: EliminarRecomendacionStyles
                                      .deleteBtnDecoration,
                                  child: const Wrap(
                                    alignment: WrapAlignment.center,
                                    crossAxisAlignment:
                                        WrapCrossAlignment.center,
                                    spacing: 8,
                                    children: [
                                      FaIcon(
                                        FontAwesomeIcons.trash,
                                        color: Colors.white,
                                        size: 16,
                                      ),
                                      Text(
                                        'Eliminar',
                                        style: EliminarRecomendacionStyles
                                            .deleteBtnStyle,
                                        textAlign: TextAlign.center,
                                      ),
                                    ],
                                  ),
                                ),
                              ),
                            ),
                          ],
                        ),
                      ],
                    ),
                  ),
                  Positioned(
                    top: 18,
                    right: 18,
                    child: GestureDetector(
                      onTap: onCerrar,
                      child: Container(
                        width: 40,
                        height: 40,
                        decoration: BoxDecoration(
                          color: EliminarRecomendacionStyles.backgroundPage,
                          borderRadius: BorderRadius.circular(8),
                        ),
                        child: const Center(
                          child: FaIcon(
                            FontAwesomeIcons.xmark,
                            color: EliminarRecomendacionStyles.darkGreen,
                            size: 18,
                          ),
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
