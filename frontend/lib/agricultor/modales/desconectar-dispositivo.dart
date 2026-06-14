// ═══════════════════════════════════════════════════════════════════════════
// IMPORTACIONES
// ═══════════════════════════════════════════════════════════════════════════
import 'package:flutter/material.dart'; // Framework de Flutter
import 'package:font_awesome_flutter/font_awesome_flutter.dart'; // Iconos de FontAwesome
import '../../styles/agricultor-styles/modales-styles/desconectar-dispositivo.dart'; // Estilos del modal

// ═══════════════════════════════════════════════════════════════════════════
// WIDGET: DesconectarDispositivo - Modal de confirmación para desconectar IoT
// ═══════════════════════════════════════════════════════════════════════════
/// Modal de confirmación que aparece cuando el usuario quiere desconectar
/// el dispositivo IoT de monitoreo en tiempo real.
/// 
/// Características:
/// - Animaciones suaves de entrada (fade-in + slide-up)
/// - Overlay semitransparente que cubre toda la pantalla
/// - Dos opciones: Cancelar o Confirmar desconexión
/// - Advertencia sobre detención del monitoreo en tiempo real
class DesconectarDispositivo extends StatefulWidget {
  final VoidCallback onCerrar; // Callback para cerrar el modal sin confirmar
  final VoidCallback onConfirmar; // Callback para confirmar la desconexión

  /// Constructor del modal de desconexión
  /// @param onCerrar: Función a ejecutar al cancelar (cierra modal)
  /// @param onConfirmar: Función a ejecutar al confirmar desconexión
  const DesconectarDispositivo({
    super.key,
    required this.onCerrar,
    required this.onConfirmar,
  });

  @override
  State<DesconectarDispositivo> createState() => _DesconectarDispositivoState();
}

// ═══════════════════════════════════════════════════════════════════════════
// ESTADO: _DesconectarDispositivoState - Maneja animaciones y UI del modal
// ═══════════════════════════════════════════════════════════════════════════
class _DesconectarDispositivoState extends State<DesconectarDispositivo> with SingleTickerProviderStateMixin {
  // ─── ANIMACIONES ───
  late AnimationController _controller; // Controlador principal de animaciones (300ms)
  late Animation<double> _fadeAnimation; // Animación de fade-in del overlay (0.0 a 1.0)
  late Animation<Offset> _slideAnimation; // Animación de slide-up del modal (20px arriba a 0)

  @override
  void initState() {
    super.initState();
    
    // Inicializa el controlador de animaciones (300ms de duración)
    _controller = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 300),
    );
    
    // Fade-in del overlay: primeros 200ms (66% del total)
    _fadeAnimation = CurvedAnimation(
      parent: _controller,
      curve: const Interval(0.0, 0.66, curve: Curves.easeOut),
    );

    // Slide-up del modal: 300ms completos con curva easeOut
    _slideAnimation = Tween<Offset>(
      begin: const Offset(0, 20), // Inicia 20px abajo
      end: Offset.zero, // Termina en posición normal
    ).animate(CurvedAnimation(
      parent: _controller,
      curve: Curves.easeOut,
    ));

    _controller.forward(); // Inicia las animaciones
  }

  @override
  void dispose() {
    _controller.dispose(); // Libera recursos del controlador
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Material(
      type: MaterialType.transparency, // Material transparente para permitir overlay
      child: AnimatedBuilder(
        animation: _controller, // Reconstruye cuando la animación cambia
        builder: (context, child) {
          return SizedBox.expand( // Ocupa toda la pantalla
            child: GestureDetector(
              onTap: widget.onCerrar, // Cerrar modal al tocar fuera
              child: Container(
                width: double.infinity,
                height: double.infinity,
                // Overlay semitransparente con opacidad animada
                color: DesconectarDispositivoStyles.overlayColor.withValues(
                  alpha: DesconectarDispositivoStyles.overlayColor.a * _fadeAnimation.value,
                ),
                child: Center(
                  child: GestureDetector(
                    onTap: () {}, // Evita que el tap dentro del modal lo cierre
                    child: Transform.translate(
                      offset: _slideAnimation.value, // Aplica animación de slide-up
                      child: Opacity(
                        opacity: _controller.value, // Aplica fade-in al modal
                        child: Container(
                          constraints: BoxConstraints(
                            maxWidth: DesconectarDispositivoStyles.maxWidth, // Máximo 400px
                            maxHeight: MediaQuery.of(context).size.height * 0.9, // Máx 90% altura pantalla
                          ),
                          margin: const EdgeInsets.symmetric(horizontal: 16, vertical: 24),
                          padding: const EdgeInsets.only(left: 28, right: 28, top: 28, bottom: 24),
                          decoration: DesconectarDispositivoStyles.modalDecoration, // Fondo blanco, bordes redondeados
                          child: Stack(
                            children: [
                              // ─────────────────────────────────────────────
                              // CONTENIDO DEL MODAL
                              // ─────────────────────────────────────────────
                              Column(
                                mainAxisSize: MainAxisSize.min,
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  // Título del modal
                                  const Text(
                                    '¿Desconectar el dispositivo?',
                                    style: DesconectarDispositivoStyles.titleStyle,
                                  ),
                                  const SizedBox(height: 16),
                                  // Mensaje explicativo
                                  const Text(
                                    'El monitoreo en tiempo real se detendrá. Podrá conectar el dispositivo nuevamente cuando lo necesite.',
                                    style: DesconectarDispositivoStyles.messageStyle,
                                  ),
                                  const SizedBox(height: 22),
                                  // ─────────────────────────────────────────
                                  // BOTONES DE ACCIÓN (Cancelar / Desconectar)
                                  // ─────────────────────────────────────────
                                  Row(
                                    mainAxisAlignment: MainAxisAlignment.end,
                                    children: [
                                      // Botón Cancelar
                                      Expanded(
                                        child: Material(
                                          color: Colors.transparent,
                                          child: InkWell(
                                            onTap: widget.onCerrar, // Cierra modal sin confirmar
                                            borderRadius: BorderRadius.circular(8),
                                            child: Container(
                                              height: 54,
                                              decoration: DesconectarDispositivoStyles.cancelBtnDecoration,
                                              child: const Center(
                                                child: Text(
                                                  'Cancelar',
                                                  style: DesconectarDispositivoStyles.cancelBtnStyle,
                                                ),
                                              ),
                                            ),
                                          ),
                                        ),
                                      ),
                                      const SizedBox(width: 10),
                                      // Botón Desconectar (destructivo)
                                      Expanded(
                                        child: Material(
                                          color: Colors.transparent,
                                          child: InkWell(
                                            onTap: widget.onConfirmar, // Ejecuta confirmación
                                            borderRadius: BorderRadius.circular(8),
                                            child: Container(
                                              height: 54,
                                              decoration: DesconectarDispositivoStyles.disconnectBtnDecoration,
                                              child: Center(
                                                child: Row(
                                                  mainAxisAlignment: MainAxisAlignment.center,
                                                  children: [
                                                    const FaIcon(
                                                      FontAwesomeIcons.plug,
                                                      color: Colors.white,
                                                      size: 16,
                                                    ),
                                                    const SizedBox(width: 8),
                                                    const Text(
                                                      'Desconectar',
                                                      style: DesconectarDispositivoStyles.disconnectBtnStyle,
                                                    ),
                                                  ],
                                                ),
                                              ),
                                            ),
                                          ),
                                        ),
                                      ),
                                    ],
                                  ),
                                ],
                              ),
                              // ─────────────────────────────────────────────
                              // BOTÓN CERRAR (X) EN ESQUINA SUPERIOR DERECHA
                              // ─────────────────────────────────────────────
                              Positioned(
                                top: 0,
                                right: 0,
                                child: GestureDetector(
                                  onTap: widget.onCerrar, // Cierra modal
                                  child: Container(
                                    width: 40,
                                    height: 40,
                                    decoration: DesconectarDispositivoStyles.closeBtnDecoration,
                                    child: const Center(
                                      child: FaIcon(
                                        FontAwesomeIcons.xmark,
                                        color: DesconectarDispositivoStyles.closeBtnColor,
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
                ),
              ),
            ),
          );
        },
      ),
    );
  }
}