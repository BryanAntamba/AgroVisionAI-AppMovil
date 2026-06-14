import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import '../../styles/agricultor-styles/modales-styles/guardar-reporte.dart';

class GuardarReporte extends StatefulWidget {
  const GuardarReporte({super.key});

  @override
  State<GuardarReporte> createState() => _GuardarReporteState();
}

class _GuardarReporteState extends State<GuardarReporte> with SingleTickerProviderStateMixin {
  late AnimationController _controller;
  late Animation<double> _fadeAnimation;
  late Animation<Offset> _slideAnimation;

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 300),
    );
    
    // fade-in takes 0.2s, slide-up takes 0.3s. 200/300 = 0.66
    _fadeAnimation = CurvedAnimation(
      parent: _controller,
      curve: const Interval(0.0, 0.66, curve: Curves.easeOut),
    );

    _slideAnimation = Tween<Offset>(
      begin: const Offset(0, 20),
      end: Offset.zero,
    ).animate(CurvedAnimation(
      parent: _controller,
      curve: Curves.easeOut,
    ));

    _controller.forward();
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Material(
      type: MaterialType.transparency,
      child: AnimatedBuilder(
        animation: _controller,
        builder: (context, child) {
          return GestureDetector(
            onTap: () => Navigator.pop(context),
            child: Container(
              color: GuardarReporteStyles.overlayColor.withValues(
                alpha: GuardarReporteStyles.overlayColor.a * _fadeAnimation.value,
              ),
              child: Center(
                child: GestureDetector(
                  onTap: () {}, // Prevent closing when tapping inside the modal
                  child: Transform.translate(
                    offset: _slideAnimation.value,
                    child: Opacity(
                      opacity: _controller.value, // overall fade-in for the modal card itself
                      child: Container(
                        constraints: BoxConstraints(
                          maxWidth: GuardarReporteStyles.maxWidth,
                          maxHeight: MediaQuery.of(context).size.height * 0.9,
                        ),
                        margin: const EdgeInsets.symmetric(horizontal: 16, vertical: 24),
                        padding: const EdgeInsets.symmetric(horizontal: 28, vertical: 32),
                        decoration: GuardarReporteStyles.modalDecoration,
                        child: Column(
                          mainAxisSize: MainAxisSize.min,
                          children: [
                            Container(
                              width: 64,
                              height: 64,
                              margin: const EdgeInsets.only(bottom: 16),
                              decoration: GuardarReporteStyles.iconDecoration,
                              alignment: Alignment.center,
                              child: const FaIcon(
                                FontAwesomeIcons.circleCheck,
                                color: GuardarReporteStyles.iconColor,
                                size: 36,
                              ),
                            ),
                            const Text(
                              'Reporte guardado correctamente',
                              textAlign: TextAlign.center,
                              style: GuardarReporteStyles.titleStyle,
                            ),
                            const SizedBox(height: 10),
                            const Text(
                              'El reporte se guardó con éxito y estará disponible en el historial.',
                              textAlign: TextAlign.center,
                              style: GuardarReporteStyles.messageStyle,
                            ),
                            const SizedBox(height: 24),
                            SizedBox(
                              width: double.infinity,
                              height: 54,
                              child: Material(
                                color: Colors.transparent,
                                child: InkWell(
                                  onTap: () => Navigator.pop(context),
                                  borderRadius: BorderRadius.circular(8),
                                  child: Container(
                                    decoration: GuardarReporteStyles.btnDecoration,
                                    child: const Center(
                                      child: Text(
                                        'Aceptar',
                                        style: GuardarReporteStyles.btnStyle,
                                      ),
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
              ),
            ),
          );
        },
      ),
    );
  }
}