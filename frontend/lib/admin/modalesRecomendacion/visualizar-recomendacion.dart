// ═══════════════════════════════════════════════════════════════════════════
// IMPORTACIONES
// ═══════════════════════════════════════════════════════════════════════════
import 'package:flutter/material.dart'; // Framework de Flutter para widgets
import 'package:font_awesome_flutter/font_awesome_flutter.dart'; // Iconos de FontAwesome
import '../../environments/modales-recomendacion.dart'; // Tipos de datos (RecomendacionRegistrada)
import '../../styles/admin-styles/modalesRecomendacion-styles/visualizar-recomendacion.dart'; // Estilos específicos

// ═══════════════════════════════════════════════════════════════════════════
// WIDGET PRINCIPAL DEL MODAL DE VISUALIZAR RECOMENDACIÓN (Solo lectura)
// Muestra los detalles completos de una recomendación sin permitir edición
// ═══════════════════════════════════════════════════════════════════════════
class VisualizarRecomendacion extends StatefulWidget {
  final RecomendacionRegistrada recomendacion; // Recomendación a visualizar
  final VoidCallback onCerrar; // Callback para cerrar el modal

  const VisualizarRecomendacion({
    super.key,
    required this.recomendacion, // Recomendación obligatoria
    required this.onCerrar, // Callback cerrar obligatorio
  });

  @override
  State<VisualizarRecomendacion> createState() => _VisualizarRecomendacionState();
}

// ═══════════════════════════════════════════════════════════════════════════
// ESTADO DEL MODAL DE VISUALIZAR RECOMENDACIÓN (Vista de solo lectura)
// SingleTickerProviderStateMixin: permite usar AnimationController
// ═══════════════════════════════════════════════════════════════════════════
class _VisualizarRecomendacionState extends State<VisualizarRecomendacion> with SingleTickerProviderStateMixin {
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
  // MÉTODO HELPER: formatearFecha - Convierte fecha ISO a formato legible
  // Ejemplo: "2024-01-15T10:30:00" → "15 ene 2024, 10:30"
  // ═══════════════════════════════════════════════════════════════════════════
  String formatearFecha(String iso) {
    try {
      final d = DateTime.parse(iso); // Parsea string ISO a DateTime
      final meses = ['ene', 'feb', 'mar', 'abr', 'may', 'jun', 'jul', 'ago', 'sep', 'oct', 'nov', 'dic']; // Array de meses
      final dia = d.day.toString().padLeft(2, '0'); // Día con cero al inicio (ej: "05")
      final mes = meses[d.month - 1]; // Obtiene abreviatura del mes (índice 0-11)
      final ano = d.year; // Año completo
      final hora = d.hour.toString().padLeft(2, '0'); // Hora con cero al inicio
      final min = d.minute.toString().padLeft(2, '0'); // Minutos con cero al inicio
      return '$dia $mes $ano, $hora:$min'; // Retorna fecha formateada
    } catch (e) {
      return iso; // Si falla el parseo, retorna string original
    }
  }

  // ═══════════════════════════════════════════════════════════════════════════
  // BUILD METHOD - Construye la interfaz del modal de visualización (solo lectura)
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
                color: VisualizarRecomendacionStyles.backdropColor.withValues( // Color verde oscuro semitransparente
                  alpha: VisualizarRecomendacionStyles.backdropColor.a * _fadeAnimation.value, // Opacidad animada
                ),
                child: Center( // Centra el modal en la pantalla
                  child: GestureDetector( // Detecta toques DENTRO del modal
                    onTap: () {}, // Toque vacío previene cerrar modal (detiene propagación)
                    child: Transform.translate( // Aplica transformación de posición
                      offset: _slideAnimation.value, // Desplaza verticalmente (slide animation)
                      child: Opacity( // Controla opacidad del modal
                        opacity: _controller.value, // Fade-in del modal card (0.0 a 1.0)
                        child: Container( // ← CONTENEDOR PRINCIPAL DEL MODAL (tarjeta blanca)
                          constraints: const BoxConstraints(maxWidth: 760, maxHeight: 920), // Ancho máx 760px, alto máx 920px
                          margin: const EdgeInsets.symmetric(horizontal: 16, vertical: 24), // Márgen exterior
                          decoration: VisualizarRecomendacionStyles.cardDecoration, // Bordes, sombra, color
                          child: Stack( // Stack permite posicionar botón X absoluto
                          children: [
                            // ─────────────────────────────────────────────────
                            // CONTENIDO PRINCIPAL - Campos de información (scrolleable)
                            // ─────────────────────────────────────────────────
                            Padding( // Espaciado del contenido
                              padding: const EdgeInsets.only(left: 28, right: 28, top: 28, bottom: 24), // Espaciado en todos los lados
                              child: SingleChildScrollView( // Hace el contenido scrolleable
                                child: Column( // Columna: título + campos + botón Cerrar
                                  crossAxisAlignment: CrossAxisAlignment.start, // Alinea a la izquierda
                                  mainAxisSize: MainAxisSize.min, // Ocupa solo espacio necesario
                                  children: [
                                    // ─── TÍTULO ───
                                    Padding( // Espaciado del título
                                      padding: const EdgeInsets.only(right: 44, bottom: 22), // Deja espacio para botón X
                                      child: Text(
                                        'Detalle de recomendación', // Texto del título
                                        style: VisualizarRecomendacionStyles.titleStyle, // Estilo verde grande bold
                                      ),
                                    ),
                                    // ─── CAMPOS DE INFORMACIÓN ───
                                    Column( // Columna para campos
                                      crossAxisAlignment: CrossAxisAlignment.start, // Alinea a la izquierda
                                      children: [
                                        _buildField('Título:', widget.recomendacion.titulo), // Campo "Título"
                                        const SizedBox(height: 18), // Espacio entre campos
                                        _buildField('Descripción:', widget.recomendacion.descripcion), // Campo "Descripción"
                                        const SizedBox(height: 18),
                                        _buildField('Acción recomendada:', widget.recomendacion.accion), // Campo "Acción"
                                        const SizedBox(height: 18),
                                        _buildField('Prioridad:', widget.recomendacion.prioridad.label), // Campo "Prioridad"
                                        const SizedBox(height: 18),
                                        _buildField('Color:', widget.recomendacion.color.label), // Campo "Color"
                                        const SizedBox(height: 18),
                                        _buildField('Registrada:', formatearFecha(widget.recomendacion.fechaRegistro)), // Campo "Fecha" formateada
                                      ],
                                    ),
                                    const SizedBox(height: 22), // Espacio antes del botón
                                    // ─── BOTÓN CERRAR ───
                                    Row( // Fila para alinear botón
                                      mainAxisAlignment: MainAxisAlignment.end, // Alinea a la derecha
                                      children: [
                                        GestureDetector( // Botón "Cerrar"
                                          onTap: widget.onCerrar, // Cierra modal al tocar
                                          child: Container( // Contenedor del botón
                                            constraints: const BoxConstraints(minHeight: 54), // Altura mínima
                                            padding: const EdgeInsets.symmetric(horizontal: 22), // Espaciado horizontal
                                            decoration: VisualizarRecomendacionStyles.submitBtnDecoration, // Estilo (fondo verde)
                                            child: const Center( // Centra texto
                                              child: Text('Cerrar', style: VisualizarRecomendacionStyles.submitBtnStyle), // Texto blanco
                                            ),
                                          ),
                                        ),
                                      ],
                                    ),
                                  ],
                                ),
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
                                  decoration: VisualizarRecomendacionStyles.closeBtnDecoration, // Estilo (fondo, bordes)
                                  child: const Center( // Centra ícono
                                    child: FaIcon( // Ícono X
                                      FontAwesomeIcons.xmark,
                                      color: VisualizarRecomendacionStyles.darkGreen, // Color verde oscuro
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

  // ═══════════════════════════════════════════════════════════════════════════
  // MÉTODO HELPER: _buildField - Construye un campo de información (label + valor)
  // ═══════════════════════════════════════════════════════════════════════════
  Widget _buildField(String label, String value) {
    return RichText( // Permite texto con estilos mixtos
      text: TextSpan( // Texto raíz
        children: [
          TextSpan(text: '$label ', style: VisualizarRecomendacionStyles.formTextBoldStyle), // Label en negrita (ej: "Título:")
          TextSpan(text: value, style: VisualizarRecomendacionStyles.formTextStyle), // Valor en estilo normal
        ],
      ),
    );
  }
} // ← Cierra clase _VisualizarRecomendacionState
