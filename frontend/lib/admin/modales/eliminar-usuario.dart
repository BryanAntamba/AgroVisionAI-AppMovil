// ═══════════════════════════════════════════════════════════════════════════
// IMPORTACIONES
// ═══════════════════════════════════════════════════════════════════════════
import 'package:flutter/material.dart'; // Framework de Flutter para widgets
import '../../styles/admin-styles/modales-styles/eliminar-usuario.dart'; // Estilos específicos de este modal
import '../../environments/datos-simulados-admin.dart'; // Tipos de datos (UsuarioAdmin, RolUsuario)

// ═══════════════════════════════════════════════════════════════════════════
// WIDGET PRINCIPAL DEL MODAL DE CONFIRMACIÓN DE ELIMINACIÓN
// ═══════════════════════════════════════════════════════════════════════════
class EliminarUsuario extends StatefulWidget {
  final UsuarioAdmin usuario; // Usuario que se va a eliminar
  final VoidCallback onCerrar; // Callback para cerrar el modal sin eliminar
  final VoidCallback onConfirmar; // Callback para confirmar la eliminación

  const EliminarUsuario({
    super.key,
    required this.usuario, // Usuario obligatorio
    required this.onCerrar, // Callback cerrar obligatorio
    required this.onConfirmar, // Callback confirmar obligatorio
  });

  @override
  State<EliminarUsuario> createState() => _EliminarUsuarioState();
}

// ═══════════════════════════════════════════════════════════════════════════
// ESTADO DEL MODAL DE ELIMINACIÓN
// SingleTickerProviderStateMixin: permite usar AnimationController
// ═══════════════════════════════════════════════════════════════════════════
class _EliminarUsuarioState extends State<EliminarUsuario> with SingleTickerProviderStateMixin {
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
  // BUILD METHOD - Construye la interfaz del modal de confirmación
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
                color: EliminarUsuarioStyles.overlayColor.withValues( // Color verde oscuro semitransparente
                  alpha: EliminarUsuarioStyles.overlayColor.a * _fadeAnimation.value, // Opacidad animada
                ),
                child: Center( // Centra el modal en la pantalla
                  child: GestureDetector( // Detecta toques DENTRO del modal
                    onTap: () {}, // Toque vacío previene cerrar modal (detiene propagación)
                    child: Transform.translate( // Aplica transformación de posición
                      offset: _slideAnimation.value, // Desplaza verticalmente (slide animation)
                      child: Opacity( // Controla opacidad del modal
                        opacity: _controller.value, // Fade-in del modal card (0.0 a 1.0)
                        child: Container( // ← CONTENEDOR PRINCIPAL DEL MODAL (tarjeta blanca)
                          constraints: const BoxConstraints(maxWidth: EliminarUsuarioStyles.maxWidth), // Ancho máximo
                          margin: EliminarUsuarioStyles.modalMargin, // Márgen exterior
                          padding: EliminarUsuarioStyles.modalPadding, // Espaciado interno
                          decoration: EliminarUsuarioStyles.modalDecoration, // Bordes, sombra, color
                          child: Column( // Columna vertical para organizar contenido
                            mainAxisSize: MainAxisSize.min, // Ocupa solo espacio necesario
                            crossAxisAlignment: CrossAxisAlignment.start, // Alinea a la izquierda
                            children: [ // ← Array de hijos
                              // ───────────────────────────────────────────────
                              // HEADER - Título y botón cerrar
                              // ───────────────────────────────────────────────
                              Row( // Fila horizontal para título y botón
                                children: [
                                  const Expanded( // Título ocupa espacio disponible
                                    child: Text('Eliminar usuario', style: EliminarUsuarioStyles.titleText),
                                  ),
                                  GestureDetector( // Botón cerrar (X)
                                    onTap: widget.onCerrar, // Cierra modal al tocar
                                    child: Container( // Contenedor del botón
                                      width: EliminarUsuarioStyles.closeButtonSize, // Ancho fijo
                                      height: EliminarUsuarioStyles.closeButtonSize, // Alto fijo
                                      decoration: EliminarUsuarioStyles.closeButtonDecoration, // Estilo circular
                                      child: const Icon(Icons.close, // Icono X
                                          color: EliminarUsuarioStyles.closeIconColor, // Color del icono
                                          size: EliminarUsuarioStyles.closeIconSize), // Tamaño del icono
                                    ),
                                  ),
                                ],
                              ),
                              const SizedBox(height: EliminarUsuarioStyles.contentSpacing), // Espacio vertical
                              // ───────────────────────────────────────────────
                              // MENSAJE DE CONFIRMACIÓN (con nombre y rol en negrita)
                              // ───────────────────────────────────────────────
                              RichText( // Permite texto con múltiples estilos
                                text: TextSpan( // Contenedor de spans
                                  style: EliminarUsuarioStyles.bodyText, // Estilo base del texto
                                  children: [ // Array de fragmentos de texto
                                    const TextSpan(text: '¿Estas seguro de que deseas eliminar al usuario '), // Texto normal
                                    TextSpan( // Fragmento con nombre del usuario
                                      text: widget.usuario.nombreCompleto, // Nombre completo del usuario
                                      style: EliminarUsuarioStyles.boldText, // Estilo en negrita
                                    ),
                                    const TextSpan(text: ' con el rol de '), // Texto normal
                                    TextSpan( // Fragmento con rol del usuario
                                      text: widget.usuario.rol.label, // Etiqueta del rol (Admin/Agricultor)
                                      style: EliminarUsuarioStyles.boldText, // Estilo en negrita
                                    ),
                                    const TextSpan(text: '?'), // Signo de interrogación
                                  ],
                                ),
                              ),
                              const SizedBox(height: EliminarUsuarioStyles.warningSpacing), // Espacio vertical
                              // ───────────────────────────────────────────────
                              // MENSAJE DE ADVERTENCIA (acción irreversible)
                              // ───────────────────────────────────────────────
                              const Text(
                                'Esta accion no se puede deshacer.', // Texto de advertencia
                                style: EliminarUsuarioStyles.warningText, // Estilo de advertencia (color rojo/naranja)
                              ),
                              const SizedBox(height: EliminarUsuarioStyles.footerSpacing), // Espacio antes de botones
                              // ───────────────────────────────────────────────
                              // FOOTER - Botones de acción (Cancelar / Eliminar)
                              // ───────────────────────────────────────────────
                              Row( // Fila para botones
                                mainAxisAlignment: MainAxisAlignment.end, // Alinea botones a la derecha
                                children: [
                                  GestureDetector( // Botón Cancelar
                                    onTap: widget.onCerrar, // Cierra modal sin eliminar
                                    child: Container( // Contenedor del botón
                                      constraints: const BoxConstraints(minHeight: EliminarUsuarioStyles.minButtonHeight), // Altura mínima
                                      padding: EliminarUsuarioStyles.cancelButtonPadding, // Espaciado interno
                                      decoration: EliminarUsuarioStyles.cancelButtonDecoration, // Estilo (borde)
                                      child: const Center( // Centra texto
                                        child: Text('Cancelar', style: EliminarUsuarioStyles.cancelButtonText), // Texto del botón
                                      ),
                                    ),
                                  ),
                                  const SizedBox(width: EliminarUsuarioStyles.buttonSpacing), // Espacio entre botones
                                  GestureDetector( // Botón Eliminar usuario
                                    onTap: widget.onConfirmar, // Ejecuta eliminación al tocar
                                    child: Container( // Contenedor del botón
                                      constraints: const BoxConstraints(minHeight: EliminarUsuarioStyles.minButtonHeight), // Altura mínima
                                      padding: EliminarUsuarioStyles.deleteButtonPadding, // Espaciado interno
                                      decoration: EliminarUsuarioStyles.deleteButtonDecoration, // Estilo (fondo rojo)
                                      child: const Row( // Fila para ícono + texto
                                        mainAxisSize: MainAxisSize.min, // Ocupa solo espacio necesario
                                        children: [
                                          Icon(Icons.delete, color: Colors.white, size: EliminarUsuarioStyles.deleteIconSize), // Ícono papelera
                                          SizedBox(width: EliminarUsuarioStyles.iconTextSpacing), // Espacio entre ícono y texto
                                          Text('Eliminar usuario', style: EliminarUsuarioStyles.deleteButtonText), // Texto blanco
                                        ],
                                      ),
                                    ),
                                  ),
                                ],
                              ),
                            ], // ← Fin del array de hijos de Column
                          ), // ← Cierra Column
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
} // ← Cierra clase _EliminarUsuarioState
