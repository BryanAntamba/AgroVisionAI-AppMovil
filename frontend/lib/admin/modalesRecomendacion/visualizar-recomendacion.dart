import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import '../../environments/modales-recomendacion.dart';
import '../../styles/admin-styles/modalesRecomendacion-styles/visualizar-recomendacion.dart';

class VisualizarRecomendacion extends StatelessWidget {
  final RecomendacionRegistrada recomendacion;
  final VoidCallback onCerrar;

  const VisualizarRecomendacion({
    super.key,
    required this.recomendacion,
    required this.onCerrar,
  });

  String formatearFecha(String iso) {
    try {
      final d = DateTime.parse(iso);
      final meses = ['ene', 'feb', 'mar', 'abr', 'may', 'jun', 'jul', 'ago', 'sep', 'oct', 'nov', 'dic'];
      final dia = d.day.toString().padLeft(2, '0');
      final mes = meses[d.month - 1];
      final ano = d.year;
      final hora = d.hour.toString().padLeft(2, '0');
      final min = d.minute.toString().padLeft(2, '0');
      return '$dia $mes $ano, $hora:$min';
    } catch (e) {
      return iso;
    }
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onCerrar,
      child: Container(
        color: VisualizarRecomendacionStyles.backdropColor,
        child: Center(
          child: GestureDetector(
            onTap: () {}, // Evitar que el tap se propague al fondo
            child: Container(
              constraints: const BoxConstraints(maxWidth: 760, maxHeight: 920),
              margin: const EdgeInsets.symmetric(horizontal: 16, vertical: 24),
              decoration: VisualizarRecomendacionStyles.cardDecoration,
              child: Stack(
                children: [
                  Padding(
                    padding: const EdgeInsets.only(left: 28, right: 28, top: 28, bottom: 24),
                    child: SingleChildScrollView(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          Padding(
                            padding: const EdgeInsets.only(right: 44, bottom: 22),
                            child: Text(
                              'Detalle de recomendación',
                              style: VisualizarRecomendacionStyles.titleStyle,
                            ),
                          ),
                          Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              _buildField('Título:', recomendacion.titulo),
                              const SizedBox(height: 18),
                              _buildField('Descripción:', recomendacion.descripcion),
                              const SizedBox(height: 18),
                              _buildField('Acción recomendada:', recomendacion.accion),
                              const SizedBox(height: 18),
                              _buildField('Prioridad:', recomendacion.prioridad.label),
                              const SizedBox(height: 18),
                              _buildField('Color:', recomendacion.color.label),
                              const SizedBox(height: 18),
                              _buildField('Registrada:', formatearFecha(recomendacion.fechaRegistro)),
                            ],
                          ),
                          const SizedBox(height: 22),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.end,
                            children: [
                              GestureDetector(
                                onTap: onCerrar,
                                child: Container(
                                  constraints: const BoxConstraints(minHeight: 54),
                                  padding: const EdgeInsets.symmetric(horizontal: 22),
                                  decoration: VisualizarRecomendacionStyles.submitBtnDecoration,
                                  child: const Center(
                                    child: Text('Cerrar', style: VisualizarRecomendacionStyles.submitBtnStyle),
                                  ),
                                ),
                              ),
                            ],
                          ),
                        ],
                      ),
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
                        decoration: VisualizarRecomendacionStyles.closeBtnDecoration,
                        child: const Center(
                          child: FaIcon(
                            FontAwesomeIcons.xmark,
                            color: VisualizarRecomendacionStyles.darkGreen,
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

  Widget _buildField(String label, String value) {
    return RichText(
      text: TextSpan(
        children: [
          TextSpan(text: '$label ', style: VisualizarRecomendacionStyles.formTextBoldStyle),
          TextSpan(text: value, style: VisualizarRecomendacionStyles.formTextStyle),
        ],
      ),
    );
  }
}
