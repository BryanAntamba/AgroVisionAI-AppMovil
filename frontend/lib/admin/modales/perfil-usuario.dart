// ═══════════════════════════════════════════════════════════════════════════
// IMPORTACIONES
// ═══════════════════════════════════════════════════════════════════════════
import 'package:flutter/material.dart'; // Framework de Flutter para widgets
import '../../styles/admin-styles/modales-styles/perfil-usuario.dart'; // Estilos específicos de este modal
import '../../environments/datos-simulados-admin.dart'; // Tipos de datos (UsuarioAdmin, RolUsuario)

// ═══════════════════════════════════════════════════════════════════════════
// WIDGET PRINCIPAL DEL MODAL DE PERFIL DE USUARIO (Solo lectura)
// Este modal muestra los datos del usuario pero NO permite editarlos
// ═══════════════════════════════════════════════════════════════════════════
class PerfilUsuario extends StatefulWidget {
  final UsuarioAdmin usuario; // Usuario cuyos datos se van a mostrar
  final VoidCallback onCerrar; // Callback para cerrar el modal

  const PerfilUsuario({
    super.key,
    required this.usuario, // Usuario obligatorio
    required this.onCerrar, // Callback cerrar obligatorio
  });

  @override
  State<PerfilUsuario> createState() => _PerfilUsuarioState();
}

// ═══════════════════════════════════════════════════════════════════════════
// ESTADO DEL MODAL DE PERFIL (Vista de solo lectura)
// SingleTickerProviderStateMixin: permite usar AnimationController
// ═══════════════════════════════════════════════════════════════════════════
class _PerfilUsuarioState extends State<PerfilUsuario> with SingleTickerProviderStateMixin {
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
  // BUILD METHOD - Construye la interfaz del modal de perfil (solo lectura)
  // ═══════════════════════════════════════════════════════════════════════════
  @override
  Widget build(BuildContext context) {
    // Determina si es vista móvil basado en el ancho de pantalla
    final bool isMobile = MediaQuery.of(context).size.width <= PerfilUsuarioStyles.mobileBreakpoint;

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
                color: PerfilUsuarioStyles.overlayColor.withValues( // Color verde oscuro semitransparente
                  alpha: PerfilUsuarioStyles.overlayColor.a * _fadeAnimation.value, // Opacidad animada
                ),
                child: Center( // Centra el modal en la pantalla
                  child: GestureDetector( // Detecta toques DENTRO del modal
                    onTap: () {}, // Toque vacío previene cerrar modal (detiene propagación)
                    child: Transform.translate( // Aplica transformación de posición
                      offset: _slideAnimation.value, // Desplaza verticalmente (slide animation)
                      child: Opacity( // Controla opacidad del modal
                        opacity: _controller.value, // Fade-in del modal card (0.0 a 1.0)
                        child: Container( // ← CONTENEDOR PRINCIPAL DEL MODAL (tarjeta blanca)
                          constraints: const BoxConstraints(maxWidth: PerfilUsuarioStyles.maxWidth), // Ancho máximo
                          margin: PerfilUsuarioStyles.modalMargin, // Márgen exterior
                          decoration: PerfilUsuarioStyles.modalDecoration, // Bordes, sombra, color
                          child: Column( // Columna: header + formulario + footer
                            mainAxisSize: MainAxisSize.min, // Ocupa solo espacio necesario
                            children: [ // ← Array de hijos
                              // ─────────────────────────────────────────────────
                              // HEADER - Título y botón cerrar
                              // ─────────────────────────────────────────────────
                              Padding( // Espaciado del header
                                padding: PerfilUsuarioStyles.headerPadding,
                                child: Row( // Fila horizontal para título y botón
                                  children: [
                                    const Expanded( // Título ocupa espacio disponible
                                      child: Text('Perfil de usuario', style: PerfilUsuarioStyles.titleText),
                                    ),
                                    GestureDetector( // Botón cerrar (X)
                                      onTap: widget.onCerrar, // Cierra modal al tocar
                                      child: Container( // Contenedor del botón
                                        width: PerfilUsuarioStyles.closeButtonSize, // Ancho fijo
                                        height: PerfilUsuarioStyles.closeButtonSize, // Alto fijo
                                        decoration: PerfilUsuarioStyles.closeButtonDecoration, // Estilo circular
                                        child: const Icon(Icons.close, // Icono X
                                            color: PerfilUsuarioStyles.closeIconColor, // Color del icono
                                            size: PerfilUsuarioStyles.closeIconSize), // Tamaño del icono
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                              const SizedBox(height: 22), // Espacio vertical entre header y formulario
                              // ─────────────────────────────────────────────────
                              // FORMULARIO - Campos de solo lectura (scrolleable)
                              // ─────────────────────────────────────────────────
                              Flexible( // Permite que el contenido sea scrolleable
                                child: SingleChildScrollView( // Hace el contenido scrolleable
                                  padding: PerfilUsuarioStyles.formPadding, // Espaciado interno
                                  child: Column( // Columna para campos
                                    children: [
                                      _buildGrid( // Método helper que organiza campos en grid responsive
                                        isMobile: isMobile, // Pasa si es vista móvil
                                        children: [ // Lista de campos de solo lectura
                                          _buildTextField('Nombre', Icons.person, widget.usuario.nombre), // Campo nombre
                                          _buildTextField('Segundo nombre', Icons.person, widget.usuario.segundoNombre), // Segundo nombre
                                          _buildTextField('Apellido', Icons.person, widget.usuario.apellido), // Apellido
                                          _buildTextField('Segundo apellido', Icons.person, widget.usuario.segundoApellido), // Segundo apellido
                                          _buildTextField('Correo corporativo', Icons.email, widget.usuario.correoCorporativo, isFull: true), // Correo corp (ancho completo)
                                          _buildTextField('Correo electronico', Icons.email, widget.usuario.correoElectronico, isFull: true), // Correo personal
                                          _buildTextField('Numero de telefono', Icons.phone, widget.usuario.telefono, isFull: true), // Teléfono
                                          _buildPasswordField('Contraseña'), // Campo contraseña (oculta con ••••)
                                          _buildPasswordField('Confirmar contraseña'), // Confirmación contraseña
                                          _buildRolField(widget.usuario.rol), // Campo rol (radio buttons deshabilitados)
                                        ],
                                      ),
                                    ],
                                  ),
                                ),
                              ),
                              // ─────────────────────────────────────────────────
                              // FOOTER - Botón Cerrar
                              // ─────────────────────────────────────────────────
                              Padding( // Espaciado del footer
                                padding: PerfilUsuarioStyles.footerPadding,
                                child: Row( // Fila para botón
                                  children: [
                                    Expanded( // Botón ocupa ancho completo
                                      child: GestureDetector( // Botón Cerrar
                                        onTap: widget.onCerrar, // Cierra modal al tocar
                                        child: Container( // Contenedor del botón
                                          constraints: const BoxConstraints(minHeight: PerfilUsuarioStyles.minButtonHeight), // Altura mínima
                                          decoration: PerfilUsuarioStyles.closeFooterButtonDecoration, // Estilo (fondo verde)
                                          child: const Center( // Centra texto
                                            child: Text('Cerrar', style: PerfilUsuarioStyles.closeFooterButtonText), // Texto blanco
                                          ),
                                        ),
                                      ),
                                    ),
                                  ],
                                ),
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

  // ═══════════════════════════════════════════════════════════════════════════
  // MÉTODO HELPER: _buildGrid - Organiza campos en grid responsive
  // En móvil: 1 columna (vertical) | En desktop: 2 columnas (grid)
  // ═══════════════════════════════════════════════════════════════════════════
  Widget _buildGrid({required bool isMobile, required List<Widget> children}) {
    // ─── CASO MÓVIL: Layout de 1 columna ───
    if (isMobile) {
      return Column( // Columna vertical simple
        crossAxisAlignment: CrossAxisAlignment.stretch, // Campos ocupan ancho completo
        children: children.map((w) => Padding( // Por cada campo
          padding: const EdgeInsets.only(bottom: PerfilUsuarioStyles.fieldSpacing), // Espacio inferior
          child: w) // Widget del campo
        ).toList(), // Convierte iterador a lista
      );
    }
    // ─── CASO DESKTOP: Layout de 2 columnas (grid) ───
    List<Widget> rows = []; // Lista para acumular filas del grid
    List<Widget> currentRow = []; // Fila actual en construcción (máximo 2 elementos)
    
    for (int i = 0; i < children.length; i++) { // Recorre todos los campos
      final child = children[i]; // Campo actual
      bool isFull = child is Container && child.key == const ValueKey('full'); // Verifica si ocupa ancho completo
      
      if (isFull) { // ← Campo ocupa ancho completo (correos, teléfono)
        if (currentRow.isNotEmpty) { // Si hay fila incompleta (1 elemento)
          rows.add(Row(crossAxisAlignment: CrossAxisAlignment.start, children: currentRow)); // Agrega fila incompleta
          rows.add(const SizedBox(height: PerfilUsuarioStyles.fieldSpacing)); // Espacio vertical
          currentRow = []; // Limpia fila actual
        }
        rows.add(child); // Agrega campo de ancho completo
        rows.add(const SizedBox(height: PerfilUsuarioStyles.fieldSpacing)); // Espacio vertical
      } else { // ← Campo normal (nombres, apellidos)
        currentRow.add(Expanded(child: child)); // Agrega campo a fila actual (Expanded divide espacio equitativamente)
        if (currentRow.length == 2) { // Si ya hay 2 elementos en la fila
          rows.add(Row( // Crea fila completa
            crossAxisAlignment: CrossAxisAlignment.start, // Alinea arriba
            children: [
              currentRow[0], // Campo izquierdo
              const SizedBox(width: PerfilUsuarioStyles.columnSpacing), // Espacio horizontal entre columnas
              currentRow[1] // Campo derecho
            ],
          ));
          rows.add(const SizedBox(height: PerfilUsuarioStyles.fieldSpacing)); // Espacio vertical
          currentRow = []; // Limpia fila para siguiente par
        }
      }
    }
    // ─── Si quedó fila incompleta (1 elemento) al final ───
    if (currentRow.isNotEmpty) {
      rows.add(Row( // Crea fila con 1 campo a la izquierda
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          currentRow[0], // Campo único
          const SizedBox(width: PerfilUsuarioStyles.columnSpacing), // Espacio entre columnas
          Expanded(child: Container()) // Espacio vacío a la derecha
        ],
      ));
    }
    return Column(crossAxisAlignment: CrossAxisAlignment.stretch, children: rows); // Retorna columna con todas las filas
  }

  // ═══════════════════════════════════════════════════════════════════════════
  // MÉTODO HELPER: _buildTextField - Construye campo de texto de solo lectura
  // ═══════════════════════════════════════════════════════════════════════════
  Widget _buildTextField(String label, IconData icon, String text, {bool isFull = false}) {
    return Container( // Contenedor principal del campo
      key: isFull ? const ValueKey('full') : null, // Key 'full' indica ancho completo en grid
      constraints: const BoxConstraints(minHeight: PerfilUsuarioStyles.minFieldHeight), // Altura mínima
      child: Column( // Columna: label + input
        crossAxisAlignment: CrossAxisAlignment.start, // Alinea a la izquierda
        children: [
          Text(label, style: PerfilUsuarioStyles.labelText), // Label del campo (ej: "Nombre")
          const SizedBox(height: PerfilUsuarioStyles.labelSpacing), // Espacio entre label e input
          Container( // Contenedor del input (simulado con Text)
            height: PerfilUsuarioStyles.inputHeight, // Altura fija del input
            decoration: PerfilUsuarioStyles.inputDecoration, // Borde y fondo del input
            child: Row( // Fila: icono + texto
              children: [
                SizedBox( // Contenedor del icono (ancho fijo)
                  width: PerfilUsuarioStyles.iconContainerWidth, // Ancho para centrar icono
                  child: Center(child: Icon(icon, // Icono del campo (person, email, phone)
                      color: PerfilUsuarioStyles.iconColor, // Color del icono
                      size: PerfilUsuarioStyles.iconSize)), // Tamaño del icono
                ),
                Expanded( // Texto del campo ocupa espacio restante
                  child: Text( // Muestra valor del campo (NO editable)
                    text.isEmpty ? PerfilUsuarioStyles.emptyValue : text, // Si vacío muestra "(Vacío)"
                    style: PerfilUsuarioStyles.inputTextStyle, // Estilo del texto
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  // ═══════════════════════════════════════════════════════════════════════════
  // MÉTODO HELPER: _buildPasswordField - Campo de contraseña (siempre oculto)
  // ═══════════════════════════════════════════════════════════════════════════
  Widget _buildPasswordField(String label) {
    return Container( // Contenedor principal del campo
      constraints: const BoxConstraints(minHeight: PerfilUsuarioStyles.minFieldHeight), // Altura mínima
      child: Column( // Columna: label + input
        crossAxisAlignment: CrossAxisAlignment.start, // Alinea a la izquierda
        children: [
          Text(label, style: PerfilUsuarioStyles.labelText), // Label (ej: "Contraseña")
          const SizedBox(height: PerfilUsuarioStyles.labelSpacing), // Espacio entre label e input
          Container( // Contenedor del input
            height: PerfilUsuarioStyles.inputHeight, // Altura fija
            decoration: PerfilUsuarioStyles.inputDecoration, // Borde y fondo
            child: const Row( // Fila: icono + texto oculto
              children: [
                SizedBox( // Contenedor del icono
                  width: PerfilUsuarioStyles.iconContainerWidth, // Ancho fijo
                  child: Center(child: Icon(Icons.lock, // Icono de candado
                      color: PerfilUsuarioStyles.iconColor, // Color del icono
                      size: PerfilUsuarioStyles.iconSize)), // Tamaño del icono
                ),
                Expanded( // Texto ocupa espacio restante
                  child: Text('********', style: PerfilUsuarioStyles.inputTextStyle), // Siempre muestra asteriscos (seguridad)
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  // ═══════════════════════════════════════════════════════════════════════════
  // MÉTODO HELPER: _buildRolField - Campo de selección de rol (deshabilitado)
  // ═══════════════════════════════════════════════════════════════════════════
  Widget _buildRolField(RolUsuario rol) {
    return Container( // Contenedor principal
      key: const ValueKey('full'), // Ocupa ancho completo en grid
      constraints: const BoxConstraints(minHeight: PerfilUsuarioStyles.minFieldHeight), // Altura mínima
      child: Column( // Columna: label + radio buttons
        crossAxisAlignment: CrossAxisAlignment.start, // Alinea a la izquierda
        children: [
          const Text('Rol', style: PerfilUsuarioStyles.rolLabelText), // Label del campo
          const SizedBox(height: PerfilUsuarioStyles.labelSpacing), // Espacio entre label y radios
          RadioGroup<RolUsuario>( // Grupo de radio buttons (Flutter)
            groupValue: rol, // Valor seleccionado (Admin o Agricultor)
            onChanged: (_) {}, // Callback vacío = DESHABILITADO (solo lectura)
            child: Wrap( // Wrap permite que radios se ajusten en múltiples líneas si es necesario
              spacing: PerfilUsuarioStyles.rolSpacing, // Espacio horizontal entre radios
              runSpacing: PerfilUsuarioStyles.rolSpacing, // Espacio vertical entre líneas
              children: [
                _buildRadioOption(RolUsuario.admin, rol), // Opción "Admin"
                _buildRadioOption(RolUsuario.agricultor, rol), // Opción "Agricultor"
              ],
            ),
          ),
        ],
      ),
    );
  }

  // ═══════════════════════════════════════════════════════════════════════════
  // MÉTODO HELPER: _buildRadioOption - Construye un radio button de rol
  // ═══════════════════════════════════════════════════════════════════════════
  Widget _buildRadioOption(RolUsuario option, RolUsuario selected) {
    return Container( // Contenedor de la opción de radio
      height: PerfilUsuarioStyles.rolOptionHeight, // Altura fija del radio button
      padding: PerfilUsuarioStyles.rolOptionPadding, // Espaciado interno
      decoration: PerfilUsuarioStyles.rolOptionDecoration, // Borde y fondo
      child: Row( // Fila: radio + label
        mainAxisSize: MainAxisSize.min, // Ocupa solo espacio necesario (no se expande)
        children: [
          Opacity( // Reduce opacidad para indicar deshabilitado
            opacity: PerfilUsuarioStyles.radioOpacity, // Opacidad reducida (ej: 0.5)
            child: Radio<RolUsuario>( // Widget de radio button
              value: option, // Valor de esta opción (Admin o Agricultor)
              activeColor: PerfilUsuarioStyles.radioActiveColor, // Color cuando está seleccionado
              // groupValue y onChanged heredados de RadioGroup padre
            ),
          ),
          const SizedBox(width: PerfilUsuarioStyles.radioSpacing), // Espacio entre radio y texto
          Text(option.label, style: PerfilUsuarioStyles.rolOptionText), // Texto del rol (ej: "Admin")
        ],
      ),
    );
  }
}
