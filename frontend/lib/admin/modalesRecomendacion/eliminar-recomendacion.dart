// ═══════════════════════════════════════════════════════════════════════════
// IMPORTACIONES
// ═══════════════════════════════════════════════════════════════════════════
import 'package:flutter/material.dart'; // Framework de Flutter para widgets
import 'package:font_awesome_flutter/font_awesome_flutter.dart'; // Iconos de FontAwesome
import '../../environments/modales-recomendacion.dart'; // Tipos de datos (RecomendacionRegistrada)
import '../../styles/admin-styles/modalesRecomendacion-styles/eliminar-recomendacion.dart'; // Estilos específicos

// ═══════════════════════════════════════════════════════════════════════════
// WIDGET PRINCIPAL DEL MODAL DE ELIMINAR RECOMENDACIÓN
// Modal de confirmación para eliminar una recomendación existente
// ═══════════════════════════════════════════════════════════════════════════
class EliminarRecomendacion extends StatefulWidget {
  final RecomendacionRegistrada recomendacion; // Recomendación a eliminar
  final VoidCallback onCerrar; // Callback para cerrar el modal
  final VoidCallback onConfirmar; // Callback para confirmar eliminación

  const EliminarRecomendacion({
    super.key,
    required this.recomendacion, // Recomendación obligatoria
    required this.onCerrar, // Callback cerrar obligatorio
    required this.onConfirmar, // Callback confirmar obligatorio
  });

  @override
  State<EliminarRecomendacion> createState() => _EliminarRecomendacionState();
}

// ═══════════════════════════════════════════════════════════════════════════
// ESTADO DEL MODAL DE ELIMINAR RECOMENDACIÓN (Modal de confirmación)
// SingleTickerProviderStateMixin: permite usar AnimationController
// ═══════════════════════════════════════════════════════════════════════════
class _EliminarRecomendacionState extends State<EliminarRecomendacion> with SingleTickerProviderStateMixin {
  // ─── CONTROLADORES DE ANIMACIÓN ───
  late AnimationController _controller; // Controla el progreso de las animaciones (0.0 a 1.0)
  late Animation<double> _fadeAnimation; // Animación de fade-in para el fondo oscuro
  late Animation<Offset> _slideAnimation; // Animación de deslizamiento del modal desde abajo

  // ═══════════════════════════════════════════════════════════════════════════
  // INICIALIZACIÓN
  // ═══════════════════════════════════════════════════════════════════════════
  @override
  void initState() {
    super.initState(); // Llama al initState del padre
    
    // Configura el controlador de animación
    _controller = AnimationController(
      vsync: this, // Sincroniza con el tick del frame
      duration: const Duration(milliseconds: 300), // Duración total: 300ms
    );
    
    // Animación de fade (opacidad) - se completa en los primeros 200ms (66%)
    _fadeAnimation = CurvedAnimation(
      parent: _controller, // Usa el controlador principal
      curve: const Interval(0.0, 0.66, curve: Curves.easeOut), // 0% a 66% con curva suave
    );

    // Animación de deslizamiento desde abajo
    _slideAnimation = Tween<Offset>(
      begin: const Offset(0, 20), // Comienza 20 píxeles abajo
      end: Offset.zero, // Termina en posición final (0, 0)
    ).animate(CurvedAnimation(
      parent: _controller, // Usa el controlador principal
      curve: Curves.easeOut, // Curva de desaceleración suave
    ));

    _controller.forward(); // Inicia las animaciones (de 0.0 a 1.0)
  }

  // ═══════════════════════════════════════════════════════════════════════════
  // LIMPIEZA DE RECURSOS
  // ═══════════════════════════════════════════════════════════════════════════
  @override
  void dispose() {
    _controller.dispose(); // Libera el controlador de animación
    super.dispose(); // Llama al dispose del padre
  }

  // ═══════════════════════════════════════════════════════════════════════════
  // BUILD METHOD - Construye la interfaz del modal de confirmación de eliminación
  // ═══════════════════════════════════════════════════════════════════════════
  @override
  Widget build(BuildContext context) {
    return Material( // Widget base para efectos materiales
      type: MaterialType.transparency, // Fondo transparente para mostrar overlay
      child: AnimatedBuilder( // Reconstruye cuando cambia la animación
        animation: _controller, // Escucha cambios en el controlador
        builder: (context, child) { // Se ejecuta cada frame (60fps)
          return SizedBox.expand( // Expande para ocupar toda la pantalla
            child: GestureDetector( // Detecta toques en el fondo
              onTap: widget.onCerrar, // Al tocar el fondo, cierra el modal
              child: Container( // Contenedor del fondo oscuro (overlay)
                width: double.infinity, // Ancho completo de la pantalla
                height: double.infinity, // Alto completo de la pantalla
                color: EliminarRecomendacionStyles.backdropColor.withValues( // Color verde oscuro semitransparente
                  alpha: EliminarRecomendacionStyles.backdropColor.a * _fadeAnimation.value, // Opacidad animada
                ),
                child: Center( // Centra el modal en la pantalla
                  child: GestureDetector( // Detecta toques DENTRO del modal
                    onTap: () {}, // Toque vacío previene cerrar modal (detiene propagación)
                    child: Transform.translate( // Aplica transformación de posición
                      offset: _slideAnimation.value, // Desplaza verticalmente (slide animation)
                      child: Opacity( // Controla opacidad del modal
                        opacity: _controller.value, // Fade-in del modal card (0.0 a 1.0)
                        child: Container( // ← CONTENEDOR PRINCIPAL DEL MODAL (tarjeta blanca)
                          constraints: const BoxConstraints(maxWidth: 480), // Ancho máximo 480px
                          margin: const EdgeInsets.symmetric(horizontal: 16, vertical: 24), // Márgen exterior
                          decoration: EliminarRecomendacionStyles.cardDecoration, // Bordes, sombra, color
                          child: Stack( // Stack permite posicionar botón X absoluto
                          clipBehavior: Clip.none, // Permite contenido fuera de límites
                          children: [
                            // ─────────────────────────────────────────────────
                            // CONTENIDO PRINCIPAL - Mensaje y botones
                            // ─────────────────────────────────────────────────
                            Padding( // Espaciado del contenido
                              padding: const EdgeInsets.only(
                                left: 28, // Espaciado izquierdo
                                right: 28, // Espaciado derecho
                                top: 28, // Espaciado superior
                                bottom: 24, // Espaciado inferior
                              ),
                              child: Column( // Columna: título + mensaje + advertencia + botones
                                mainAxisSize: MainAxisSize.min, // Ocupa solo espacio necesario
                                crossAxisAlignment: CrossAxisAlignment.start, // Alinea a la izquierda
                                children: [
                                  // ─── TÍTULO ───
                                  Padding( // Espaciado del título
                                    padding: const EdgeInsets.only(right: 44, bottom: 16), // Deja espacio para botón X
                                    child: Text(
                                      'Eliminar recomendación', // Texto del título
                                      style: EliminarRecomendacionStyles.titleStyle, // Estilo verde grande bold
                                    ),
                                  ),
                                  // ─── MENSAJE DE CONFIRMACIÓN ───
                                  RichText( // Permite texto con estilos mixtos
                                    text: TextSpan( // Texto principal
                                      style: EliminarRecomendacionStyles.confirmMessage, // Estilo normal
                                      children: [
                                        const TextSpan( // Primera parte (normal)
                                          text:
                                              '¿Está seguro de que desea eliminar la recomendación ',
                                        ),
                                        TextSpan( // Segunda parte (negrita con título de recomendación)
                                          text: '${widget.recomendacion.titulo}?', // Título de la recomendación
                                          style: EliminarRecomendacionStyles
                                              .confirmMessageBold, // Estilo negrita
                                        ),
                                      ],
                                    ),
                                  ),
                                  const SizedBox(height: 12), // Espacio entre mensaje y advertencia
                                  // ─── ADVERTENCIA ───
                                  const Text(
                                    'Esta acción no se puede deshacer.', // Mensaje de advertencia
                                    style: EliminarRecomendacionStyles.confirmWarning, // Estilo rojo/itálica
                                  ),
                                  const SizedBox(height: 22), // Espacio antes de botones
                                  // ─── BOTONES (Cancelar / Eliminar) ───
                                  Row( // Fila horizontal para botones
                                    children: [
                                      // BOTÓN CANCELAR
                                      Expanded( // Botón ocupa espacio proporcional
                                        child: GestureDetector( // Detecta toque
                                          onTap: widget.onCerrar, // Cierra modal sin eliminar
                                          child: Container( // Contenedor del botón
                                            constraints: const BoxConstraints(
                                              minHeight: 54, // Altura mínima
                                            ),
                                            padding: const EdgeInsets.symmetric(
                                              horizontal: 18, // Espaciado horizontal
                                            ),
                                            decoration: EliminarRecomendacionStyles
                                                .cancelBtnDecoration, // Estilo (borde verde, fondo blanco)
                                            child: const Center( // Centra texto
                                              child: Text(
                                                'Cancelar', // Texto del botón
                                                style: EliminarRecomendacionStyles
                                                    .cancelBtnStyle, // Estilo verde
                                              ),
                                            ),
                                          ),
                                        ),
                                      ),
                                      const SizedBox(width: 10), // Espacio entre botones
                                      // BOTÓN ELIMINAR
                                      Expanded( // Botón ocupa espacio proporcional
                                        child: GestureDetector( // Detecta toque
                                          onTap: widget.onConfirmar, // Confirma y ejecuta eliminación
                                          child: Container( // Contenedor del botón
                                            constraints: const BoxConstraints(
                                              minHeight: 54, // Altura mínima
                                            ),
                                            padding: const EdgeInsets.symmetric(
                                              horizontal: 4, // Espaciado horizontal mínimo
                                              vertical: 10, // Espaciado vertical
                                            ),
                                            decoration: EliminarRecomendacionStyles
                                                .deleteBtnDecoration, // Estilo (fondo rojo)
                                            child: const Wrap( // Wrap permite ajustar ícono y texto
                                              alignment: WrapAlignment.center, // Centra contenido
                                              crossAxisAlignment:
                                                  WrapCrossAlignment.center, // Alinea verticalmente
                                              spacing: 8, // Espacio entre ícono y texto
                                              children: [
                                                FaIcon( // Ícono de basurero
                                                  FontAwesomeIcons.trash,
                                                  color: Colors.white, // Color blanco
                                                  size: 16, // Tamaño del ícono
                                                ),
                                                Text(
                                                  'Eliminar', // Texto del botón
                                                  style: EliminarRecomendacionStyles
                                                      .deleteBtnStyle, // Estilo blanco bold
                                                  textAlign: TextAlign.center, // Centra texto
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
                            // ─────────────────────────────────────────────────
                            // BOTÓN CERRAR (X) - Posicionado absolutamente
                            // ─────────────────────────────────────────────────
                            Positioned( // Posición absoluta
                              top: 18, // 18px desde arriba
                              right: 18, // 18px desde la derecha
                              child: GestureDetector( // Detecta toque
                                onTap: widget.onCerrar, // Cierra modal
                                child: Container( // Contenedor del botón X
                                  width: 40, // Ancho fijo
                                  height: 40, // Alto fijo
                                  decoration: BoxDecoration( // Estilo del botón
                                    color: EliminarRecomendacionStyles.backgroundPage, // Color de fondo
                                    borderRadius: BorderRadius.circular(8), // Bordes redondeados
                                  ),
                                  child: const Center( // Centra ícono
                                    child: FaIcon( // Ícono X
                                      FontAwesomeIcons.xmark,
                                      color: EliminarRecomendacionStyles.darkGreen, // Color verde oscuro
                                      size: 18, // Tamaño del ícono
                                    ),
                                  ),
                                ),
                              ),
                            ),
                          ],
                        ), // ← Cierra Stack
                        ), // ← Cierra Container del modal
                      ), // ← Cierra Opacity
                    ), // ← Cierra Transform.translate
                  ), // ← Cierra GestureDetector interno
                ), // ← Cierra Center
              ), // ← Cierra Container del overlay
            ), // ← Cierra GestureDetector externo
          ); // ← Cierra SizedBox.expand
        }, // ← Cierra función builder
      ), // ← Cierra AnimatedBuilder
    ); // ← Cierra Material
  } // ← Cierra método build
} // ← Cierra clase _EliminarRecomendacionState
