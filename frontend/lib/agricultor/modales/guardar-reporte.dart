// ═══════════════════════════════════════════════════════════════════════════
// IMPORTACIONES
// ═══════════════════════════════════════════════════════════════════════════
import 'package:flutter/material.dart'; // Framework de Flutter
import 'package:font_awesome_flutter/font_awesome_flutter.dart'; // Iconos de FontAwesome
import '../../styles/agricultor-styles/modales-styles/guardar-reporte.dart'; // Estilos del modal

// ═══════════════════════════════════════════════════════════════════════════
// WIDGET: GuardarReporte - Modal de confirmación de guardado exitoso
// ═══════════════════════════════════════════════════════════════════════════
/// Modal de éxito que aparece después de guardar un reporte en el historial.
/// 
/// Características:
/// - Animaciones suaves (fade-in + slide-up en 300ms)
/// - Icono de check verde en círculo
/// - Mensaje de confirmación
/// - Botón "Aceptar" para cerrar
/// - Overlay semitransparente
class GuardarReporte extends StatefulWidget {
  final VoidCallback onCerrar; // Callback para cerrar el modal

  /// Constructor del modal de éxito
  /// @param onCerrar: Función a ejecutar al cerrar el modal
  const GuardarReporte({
    super.key,
    required this.onCerrar,
  });

  @override
  State<GuardarReporte> createState() => _GuardarReporteState();
}

// ═══════════════════════════════════════════════════════════════════════════
// ESTADO: _GuardarReporteState - Maneja animaciones y UI del modal de éxito
// ═══════════════════════════════════════════════════════════════════════════
class _GuardarReporteState extends State<GuardarReporte> with SingleTickerProviderStateMixin {
  // ─── ANIMACIONES ───
  late AnimationController _controller; // Controlador principal (300ms)
  late Animation<double> _fadeAnimation; // Fade-in del overlay (primeros 200ms)
  late Animation<Offset> _slideAnimation; // Slide-up del modal (300ms completos)

  @override
  void initState() {
    super.initState();
    
    // Configura controlador de animaciones
    _controller = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 300),
    );
    
    // Fade-in del overlay: primeros 66% de la duración (200ms / 300ms = 0.66)
    _fadeAnimation = CurvedAnimation(
      parent: _controller,
      curve: const Interval(0.0, 0.66, curve: Curves.easeOut),
    );

    // Slide-up: toda la duración con curva easeOut
    _slideAnimation = Tween<Offset>(
      begin: const Offset(0, 20), // Inicia 20px abajo
      end: Offset.zero, // Termina en posición original
    ).animate(CurvedAnimation(
      parent: _controller,
      curve: Curves.easeOut,
    ));

    _controller.forward(); // Inicia animaciones
  }

  @override
  void dispose() {
    _controller.dispose(); // Libera recursos
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Material(
      type: MaterialType.transparency, // Material transparente para overlay
      child: AnimatedBuilder(
        animation: _controller, // Reconstruye cuando animación cambia
        builder: (context, child) {
          return SizedBox.expand( // Ocupa toda la pantalla
            child: GestureDetector(
              onTap: widget.onCerrar, // Cierra modal al tocar fuera
              child: Container(
                width: double.infinity,
                height: double.infinity,
                // Overlay con opacidad animada
                color: GuardarReporteStyles.overlayColor.withValues(
                  alpha: GuardarReporteStyles.overlayColor.a * _fadeAnimation.value,
                ),
                child: Center(
                  child: GestureDetector(
                    onTap: () {}, // Evita cerrar modal al tocar dentro
                    child: Transform.translate(
                      offset: _slideAnimation.value, // Aplica slide-up
                      child: Opacity(
                        opacity: _controller.value, // Aplica fade-in al modal
                        child: Container(
                          constraints: BoxConstraints(
                            maxWidth: GuardarReporteStyles.maxWidth, // Máx 400px
                            maxHeight: MediaQuery.of(context).size.height * 0.9,
                          ),
                          margin: const EdgeInsets.symmetric(horizontal: 16, vertical: 24),
                          padding: const EdgeInsets.symmetric(horizontal: 28, vertical: 32),
                          decoration: GuardarReporteStyles.modalDecoration, // Fondo blanco, bordes redondeados
                          child: Column(
                            mainAxisSize: MainAxisSize.min,
                            children: [
                              // ─────────────────────────────────────────────
                              // ICONO DE ÉXITO (Check verde en círculo)
                              // ─────────────────────────────────────────────
                              Container(
                                width: 64,
                                height: 64,
                                margin: const EdgeInsets.only(bottom: 16),
                                decoration: GuardarReporteStyles.iconDecoration, // Círculo verde claro
                                alignment: Alignment.center,
                                child: const FaIcon(
                                  FontAwesomeIcons.circleCheck,
                                  color: GuardarReporteStyles.iconColor, // Verde
                                  size: 36,
                                ),
                              ),
                              // Título del modal
                              const Text(
                                'Reporte guardado correctamente',
                                textAlign: TextAlign.center,
                                style: GuardarReporteStyles.titleStyle,
                              ),
                              const SizedBox(height: 10),
                              // Mensaje explicativo
                              const Text(
                                'El reporte se guardó con éxito y estará disponible en el historial.',
                                textAlign: TextAlign.center,
                                style: GuardarReporteStyles.messageStyle,
                              ),
                              const SizedBox(height: 24),
                              // ─────────────────────────────────────────────
                              // BOTÓN ACEPTAR
                              // ─────────────────────────────────────────────
                              SizedBox(
                                width: double.infinity,
                                height: 54,
                                child: Material(
                                  color: Colors.transparent,
                                  child: InkWell(
                                    onTap: widget.onCerrar, // Cierra modal
                                    borderRadius: BorderRadius.circular(8),
                                    child: Container(
                                      decoration: GuardarReporteStyles.btnDecoration, // Fondo verde
                                      child: const Center(
                                        child: Text(
                                          'Aceptar',
                                          style: GuardarReporteStyles.btnStyle, // Texto blanco y bold
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
            ),
          );
        },
      ),
    );
  }
}