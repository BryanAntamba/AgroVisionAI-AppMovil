// ═══════════════════════════════════════════════════════════════════════════
// IMPORTACIONES
// ═══════════════════════════════════════════════════════════════════════════
import 'package:flutter/material.dart'; // Framework de Flutter para widgets
import 'package:font_awesome_flutter/font_awesome_flutter.dart'; // Iconos de FontAwesome
import '../../environments/modales-recomendacion.dart'; // Tipos de datos (RecomendacionRegistrada, DatosRecomendacionForm, Prioridad, Color)
import '../../styles/admin-styles/modalesRecomendacion-styles/editar-recomendacion.dart'; // Estilos específicos
import '../../shared/validators/panel-admin/recomendaciones-validaciones.dart'; // Validadores y mensajes de error


// ═══════════════════════════════════════════════════════════════════════════
// WIDGET PRINCIPAL DEL MODAL DE EDITAR RECOMENDACIÓN (Editable con validación)
// Permite editar los datos de una recomendación existente con validación en tiempo real
// ═══════════════════════════════════════════════════════════════════════════
class EditarRecomendacion extends StatefulWidget {
  final RecomendacionRegistrada recomendacion; // Recomendación a editar (con valores iniciales)
  final VoidCallback onCerrar; // Callback para cerrar el modal
  final void Function(DatosRecomendacionForm) onGuardar; // Callback para guardar cambios

  const EditarRecomendacion({
    super.key,
    required this.recomendacion, // Recomendación obligatoria
    required this.onCerrar, // Callback cerrar obligatorio
    required this.onGuardar, // Callback guardar obligatorio
  });

  @override
  State<EditarRecomendacion> createState() => _EditarRecomendacionState();
}

// ═══════════════════════════════════════════════════════════════════════════
// ESTADO DEL MODAL DE EDITAR RECOMENDACIÓN (Editable con validación en tiempo real)
// SingleTickerProviderStateMixin: permite usar AnimationController
// ═══════════════════════════════════════════════════════════════════════════
class _EditarRecomendacionState extends State<EditarRecomendacion> with SingleTickerProviderStateMixin {
  // ─── CONTROLADORES DE TEXTO (TextEditingController) - Manejan el input del usuario ───
  late final TextEditingController _tituloCtrl; // Controla campo "Título"
  late final TextEditingController _descCtrl; // Controla campo "Descripción"
  late final TextEditingController _accionCtrl; // Controla campo "Acción recomendada"
  
  // ─── ESTADO DE SELECCIÓN (Dropdown) - Inicializados con valores de la recomendación existente ───
  late PrioridadRecomendacion _prioridad; // Prioridad seleccionada
  late ColorRecomendacion _color; // Color seleccionado
  
  // ─── ESTADO DE EXPANSIÓN DE DROPDOWNS ───
  bool _prioridadExpanded = false; // Controla si dropdown de prioridad está expandido
  bool _colorExpanded = false; // Controla si dropdown de color está expandido

  // ─── CONTROLADORES DE ANIMACIÓN ───
  late AnimationController _controller; // Controla el progreso de las animaciones (0.0 a 1.0)
  late Animation<double> _fadeAnimation; // Animación de fade-in para el fondo oscuro
  late Animation<Offset> _slideAnimation; // Animación de deslizamiento del modal desde abajo

  // ─── CONTROLADORES DE FOCO (FocusNode) - Manejan el foco de los TextField ───
  final FocusNode _tituloFocus = FocusNode(); // FocusNode para campo "Título"
  final FocusNode _descFocus = FocusNode(); // FocusNode para campo "Descripción"
  final FocusNode _accionFocus = FocusNode(); // FocusNode para campo "Acción"

  // ─── ESTADO DE FOCO (bool) - Indica si cada campo está enfocado ───
  bool _tituloFocused = false; // true si "Título" está enfocado
  bool _descFocused = false; // true si "Descripción" está enfocado
  bool _accionFocused = false; // true si "Acción" está enfocado

  // ─── ERRORES DE VALIDACIÓN (String? = null si no hay error) ───
  String? _errorTitulo; // Error del campo "Título"
  String? _errorDesc; // Error del campo "Descripción"
  String? _errorAccion; // Error del campo "Acción"

  // ═══════════════════════════════════════════════════════════════════════════
  // INICIALIZACIÓN - Inicializa controladores con valores existentes de la recomendación
  // ═══════════════════════════════════════════════════════════════════════════
  @override
  void initState() {
    super.initState(); // Llama al initState del padre
    
    // ─── Obtiene valores iniciales de la recomendación existente ───
    final ini = widget.recomendacion;
    
    // ─── Inicializa controladores de texto CON valores existentes ───
    _tituloCtrl = TextEditingController(text: ini.titulo); // Título existente
    _descCtrl   = TextEditingController(text: ini.descripcion); // Descripción existente
    _accionCtrl = TextEditingController(text: ini.accion); // Acción existente
    _prioridad  = ini.prioridad; // Prioridad existente
    _color      = ini.color; // Color existente

    // ─── Configura el controlador de animación ───
    _controller = AnimationController(
      vsync: this, // Sincroniza con el tick del frame
      duration: const Duration(milliseconds: 300), // Duración total: 300ms
    );

    // ─── Animación de fade (opacidad) - se completa en los primeros 200ms (66%) ───
    _fadeAnimation = CurvedAnimation(
      parent: _controller, // Usa el controlador principal
      curve: const Interval(0.0, 0.66, curve: Curves.easeOut), // 0% a 66% con curva suave
    );

    // ─── Animación de deslizamiento desde abajo ───
    _slideAnimation = Tween<Offset>(
      begin: const Offset(0, 20), // Comienza 20 píxeles abajo
      end: Offset.zero, // Termina en posición final (0, 0)
    ).animate(CurvedAnimation(
      parent: _controller, // Usa el controlador principal
      curve: Curves.easeOut, // Curva de desaceleración suave
    ));

    // ─── Agrega listeners a FocusNodes para detectar cambios de foco ───
    _tituloFocus.addListener(() => setState(() => _tituloFocused = _tituloFocus.hasFocus)); // Actualiza estado de foco
    _descFocus.addListener(() => setState(() => _descFocused = _descFocus.hasFocus));
    _accionFocus.addListener(() => setState(() => _accionFocused = _accionFocus.hasFocus));

    _controller.forward(); // Inicia las animaciones (de 0.0 a 1.0)
  }

  // ═══════════════════════════════════════════════════════════════════════════
  // LIMPIEZA DE RECURSOS
  // ═══════════════════════════════════════════════════════════════════════════
  @override
  void dispose() {
    // Libera todos los controladores de texto (previene memory leaks)
    _tituloCtrl.dispose();
    _descCtrl.dispose();
    _accionCtrl.dispose();
    // Libera todos los FocusNodes
    _tituloFocus.dispose();
    _descFocus.dispose();
    _accionFocus.dispose();
    _controller.dispose(); // Libera el controlador de animación
    super.dispose(); // Llama al dispose del padre
  }

  // ═══════════════════════════════════════════════════════════════════════════
  // MÉTODO DE ENVÍO: _submit - Valida todos los campos y guarda si no hay errores
  // ═══════════════════════════════════════════════════════════════════════════
  void _submit() {
    // ─── FASE 1: Ejecutar todas las validaciones ───
    setState(() {
      _errorTitulo = RecomendacionesValidaciones.mensajeTitulo(_tituloCtrl.text); // Valida título
      _errorDesc = RecomendacionesValidaciones.mensajeDescripcion(_descCtrl.text); // Valida descripción
      _errorAccion = RecomendacionesValidaciones.mensajeAccion(_accionCtrl.text); // Valida acción
    });

    // ─── FASE 2: Verificar si hay errores ───
    if (_errorTitulo != null || _errorDesc != null || _errorAccion != null) {
      return; // Si hay errores, detiene el proceso (no guarda)
    }

    // ─── FASE 3: Sin errores, llama al callback onGuardar ───
    widget.onGuardar(DatosRecomendacionForm( // Crea objeto DatosRecomendacionForm con valores actualizados
      titulo:      _tituloCtrl.text.trim(), // Título sin espacios
      descripcion: _descCtrl.text.trim(), // Descripción sin espacios
      accion:      _accionCtrl.text.trim(), // Acción sin espacios
      prioridad:   _prioridad, // Prioridad seleccionada
      color:       _color, // Color seleccionado
    ));
  }

  @override
  Widget build(BuildContext context) {
    final isMobile = MediaQuery.of(context).size.width < 700;

    return Material(
      type: MaterialType.transparency,
      child: AnimatedBuilder(
        animation: _controller,
        builder: (context, child) {
          return SizedBox.expand(
            child: GestureDetector(
              onTap: widget.onCerrar,
              child: Container(
                width: double.infinity,
                height: double.infinity,
                color: EditarRecomendacionStyles.overlayColor.withValues(
                  alpha: EditarRecomendacionStyles.overlayColor.a * _fadeAnimation.value,
                ),
                child: Center(
                  child: GestureDetector(
                    onTap: () {}, // Prevent tap from bubbling up
                    child: Transform.translate(
                      offset: _slideAnimation.value,
                      child: Opacity(
                        opacity: _controller.value,
                        child: Container(
                          constraints: const BoxConstraints(maxWidth: 760),
                          margin: const EdgeInsets.symmetric(horizontal: 16, vertical: 24),
                          padding: const EdgeInsets.only(left: 28, right: 28, top: 28, bottom: 24),
                          decoration: EditarRecomendacionStyles.modalDecoration,
                          child: SingleChildScrollView(
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            mainAxisSize: MainAxisSize.min,
                            children: [
                              Stack(
                                children: [
                                  Padding(
                                    padding: const EdgeInsets.only(right: 44, bottom: 22),
                                    child: Text(
                                      'Editar recomendación',
                                      style: EditarRecomendacionStyles.titleStyle,
                                    ),
                                  ),
                                  Positioned(
                                    top: 0,
                                    right: 0,
                                    child: GestureDetector(
                                      onTap: widget.onCerrar,
                                      child: Container(
                                        width: 40,
                                        height: 40,
                                        decoration: EditarRecomendacionStyles.closeBtnDecoration,
                                        child: const Center(
                                          child: Icon(
                                            Icons.close,
                                            color: EditarRecomendacionStyles.darkGreen,
                                            size: 18,
                                          ),
                                        ),
                                      ),
                                    ),
                                  ),
                                ],
                              ),
                              _buildTextField(
                                label: 'Título',
                                ctrl: _tituloCtrl,
                                icon: FontAwesomeIcons.heading,
                                focusNode: _tituloFocus,
                                isFocused: _tituloFocused,
                                errorText: _errorTitulo,
                                onChanged: (v) => setState(() => _errorTitulo = RecomendacionesValidaciones.mensajeTitulo(v)),
                              ),
                              const SizedBox(height: 14),
                              _buildTextField(
                                label: 'Descripción',
                                ctrl: _descCtrl,
                                focusNode: _descFocus,
                                isFocused: _descFocused,
                                maxLines: 3,
                                errorText: _errorDesc,
                                onChanged: (v) => setState(() => _errorDesc = RecomendacionesValidaciones.mensajeDescripcion(v)),
                              ),
                              const SizedBox(height: 14),
                              _buildTextField(
                                label: 'Acción recomendada',
                                ctrl: _accionCtrl,
                                focusNode: _accionFocus,
                                isFocused: _accionFocused,
                                maxLines: 2,
                                errorText: _errorAccion,
                                onChanged: (v) => setState(() => _errorAccion = RecomendacionesValidaciones.mensajeAccion(v)),
                              ),
                              const SizedBox(height: 14),
                              if (isMobile) ...[
                                _buildDropdown<PrioridadRecomendacion>(
                                  label: 'Prioridad de la recomendación',
                                  value: _prioridad,
                                  isExpanded: _prioridadExpanded,
                                  onToggle: () => setState(() {
                                    _prioridadExpanded = !_prioridadExpanded;
                                    _colorExpanded = false;
                                  }),
                                  items: PrioridadRecomendacion.values.map((p) => DropdownMenuItem(value: p, child: Text(p.label))).toList(),
                                  onChanged: (v) => setState(() => _prioridad = v!),
                                ),
                                const SizedBox(height: 14),
                                _buildDropdown<ColorRecomendacion>(
                                  label: 'Color de la recomendación',
                                  value: _color,
                                  isExpanded: _colorExpanded,
                                  onToggle: () => setState(() {
                                    _colorExpanded = !_colorExpanded;
                                    _prioridadExpanded = false;
                                  }),
                                  items: ColorRecomendacion.values.map((c) => DropdownMenuItem(value: c, child: Text(c.label))).toList(),
                                  onChanged: (v) => setState(() => _color = v!),
                                ),
                              ] else ...[
                                Row(
                                  children: [
                                    Expanded(
                                      child: _buildDropdown<PrioridadRecomendacion>(
                                        label: 'Prioridad de la recomendación',
                                        value: _prioridad,
                                        isExpanded: _prioridadExpanded,
                                        onToggle: () => setState(() {
                                          _prioridadExpanded = !_prioridadExpanded;
                                          _colorExpanded = false;
                                        }),
                                        items: PrioridadRecomendacion.values.map((p) => DropdownMenuItem(value: p, child: Text(p.label))).toList(),
                                        onChanged: (v) => setState(() => _prioridad = v!),
                                      ),
                                    ),
                                    const SizedBox(width: 16),
                                    Expanded(
                                      child: _buildDropdown<ColorRecomendacion>(
                                        label: 'Color de la recomendación',
                                        value: _color,
                                        isExpanded: _colorExpanded,
                                        onToggle: () => setState(() {
                                          _colorExpanded = !_colorExpanded;
                                          _prioridadExpanded = false;
                                        }),
                                        items: ColorRecomendacion.values.map((c) => DropdownMenuItem(value: c, child: Text(c.label))).toList(),
                                        onChanged: (v) => setState(() => _color = v!),
                                      ),
                                    ),
                                  ],
                                ),
                              ],
                              const SizedBox(height: 18),
                              Row(
                                children: [
                                  Expanded(
                                    child: GestureDetector(
                                      onTap: widget.onCerrar,
                                      child: Container(
                                        constraints: const BoxConstraints(minHeight: 54),
                                        padding: const EdgeInsets.symmetric(horizontal: 4),
                                        decoration: EditarRecomendacionStyles.cancelBtnDecoration,
                                        child: const Center(
                                          child: Text(
                                            'Cancelar',
                                            style: EditarRecomendacionStyles.cancelBtnStyle,
                                            textAlign: TextAlign.center,
                                          ),
                                        ),
                                      ),
                                    ),
                                  ),
                                  const SizedBox(width: 10),
                                  Expanded(
                                    child: GestureDetector(
                                      onTap: _submit,
                                      child: Container(
                                        constraints: const BoxConstraints(minHeight: 54),
                                        padding: const EdgeInsets.symmetric(horizontal: 4),
                                        decoration: EditarRecomendacionStyles.submitBtnDecoration,
                                        child: const Center(
                                          child: Text(
                                            'Guardar cambios',
                                            style: EditarRecomendacionStyles.submitBtnStyle,
                                            textAlign: TextAlign.center,
                                          ),
                                        ),
                                      ),
                                    ),
                                  ),
                                ],
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
            ),
          );
        },
      ),
    );
  }

  // ═══════════════════════════════════════════════════════════════════════════
  // MÉTODO HELPER: _buildTextField - Construye campo de texto editable con validación y estado de foco
  // ═══════════════════════════════════════════════════════════════════════════
  Widget _buildTextField({
    required String label, // Label del campo (ej: "Título")
    required TextEditingController ctrl, // Controlador de texto
    FaIconData? icon, // Ícono opcional (FontAwesome)
    required FocusNode focusNode, // FocusNode para detectar foco
    required bool isFocused, // Estado actual de foco (true/false)
    int maxLines = 1, // Número de líneas (1 para texto simple, 2-3 para textarea)
    String? errorText, // Mensaje de error (opcional)
    void Function(String)? onChanged, // Callback para validación en tiempo real
  }) {
    return Column( // Columna: label + contenedor input + mensaje de error
      crossAxisAlignment: CrossAxisAlignment.start, // Alinea a la izquierda
      children: [
        Text(label, style: EditarRecomendacionStyles.labelStyle), // Label del campo
        const SizedBox(height: 8), // Espacio entre label e input
        Container( // Contenedor del input con borde personalizado
          constraints: BoxConstraints(minHeight: maxLines == 1 ? 54 : 72), // Altura mínima según líneas
          decoration: errorText != null  // Cambia decoración si hay error
              ? EditarRecomendacionStyles.inputShellDecoration(focused: isFocused).copyWith(
                  border: Border.all(color: Colors.red, width: 1.5)) // Borde rojo si hay error
              : EditarRecomendacionStyles.inputShellDecoration(focused: isFocused), // Borde normal o enfocado
          child: Row( // Fila: ícono (opcional) + TextField
            crossAxisAlignment: maxLines == 1 ? CrossAxisAlignment.center : CrossAxisAlignment.start, // Alineación según líneas
            children: [
              if (icon != null) // Si hay ícono, lo muestra
                Container( // Contenedor del ícono
                  width: 48, // Ancho fijo
                  height: 54, // Alto fijo
                  alignment: Alignment.center, // Centra ícono
                  child: FaIcon( // Ícono de FontAwesome
                    icon,
                    color: errorText != null ? Colors.red : EditarRecomendacionStyles.primaryGreen, // Rojo si error, verde si no
                    size: 18, // Tamaño del ícono
                  ),
                ),
              Expanded( // TextField ocupa espacio restante
                child: Padding( // Espaciado alrededor del TextField
                  padding: EdgeInsets.only(
                    left: icon == null ? 14 : 0, // Espaciado izquierdo si no hay ícono
                    right: 14, // Espaciado derecho
                    top: maxLines == 1 ? 0 : 12, // Espaciado superior si es textarea
                    bottom: maxLines == 1 ? 0 : 12, // Espaciado inferior si es textarea
                  ),
                  child: TextField( // Campo de texto editable
                    controller: ctrl, // Controlador de texto
                    focusNode: focusNode, // FocusNode para detectar foco
                    maxLines: maxLines, // Número de líneas
                    onChanged: onChanged, // Valida en tiempo real al escribir
                    decoration: const InputDecoration( // Configuración del TextField
                      border: InputBorder.none, // Sin borde (el borde lo tiene el Container)
                      isDense: true, // Reduce espaciado interno
                      contentPadding: EdgeInsets.zero, // Sin padding interno
                    ),
                    style: EditarRecomendacionStyles.inputTextStyle, // Estilo del texto escrito
                  ),
                ),
              ),
            ],
          ),
        ),
        if (errorText != null) ...[ // Si hay error, muestra mensaje
          const SizedBox(height: 6), // Espacio antes del mensaje
          Text(errorText, style: const TextStyle(color: Colors.red, fontSize: 12)), // Mensaje de error (rojo)
        ],
      ],
    );
  }

  // ═══════════════════════════════════════════════════════════════════════════
  // MÉTODO HELPER: _buildDropdown - Construye dropdown (select) sin validación (siempre tiene valor)
  // ═══════════════════════════════════════════════════════════════════════════
  // MÉTODO HELPER: _buildDropdown - Construye dropdown (select) sin validación (siempre tiene valor)
  // ═══════════════════════════════════════════════════════════════════════════
  Widget _buildDropdown<T>({
    required String label, // Label del campo
    required T value, // Valor seleccionado (nunca null en edición)
    required List<DropdownMenuItem<T>> items, // Lista de opciones
    required ValueChanged<T?> onChanged, // Callback cuando cambia selección
    required bool isExpanded, // Si el dropdown está expandido
    required VoidCallback onToggle, // Callback para alternar expansión
  }) {
    // Obtiene el texto del item seleccionado
    String getSelectedText() {
      final selectedItem = items.firstWhere((item) => item.value == value);
      final child = selectedItem.child;
      if (child is Text) {
        return child.data ?? '';
      }
      return '';
    }

    return Column( // Columna: label + Dropdown + opciones
      crossAxisAlignment: CrossAxisAlignment.start, // Alinea a la izquierda
      children: [
        Text(label, style: EditarRecomendacionStyles.labelStyle), // Label (ej: "Prioridad de la recomendación")
        const SizedBox(height: 8), // Espacio entre label y dropdown
        
        // Campo del dropdown (siempre visible)
        GestureDetector(
          onTap: onToggle,
          child: AnimatedContainer( // AnimatedContainer para transición suave
            duration: const Duration(milliseconds: 200), // Duración de la animación
            height: 54, // Altura fija
            decoration: EditarRecomendacionStyles.inputShellDecoration(focused: isExpanded), // Glow si está expandido
            padding: const EdgeInsets.symmetric(horizontal: 14), // Espaciado horizontal interno
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Expanded(
                  child: Text(
                    getSelectedText(),
                    style: EditarRecomendacionStyles.inputTextStyle,
                    overflow: TextOverflow.ellipsis,
                  ),
                ),
                FaIcon(
                  isExpanded ? FontAwesomeIcons.chevronUp : FontAwesomeIcons.chevronDown,
                  color: EditarRecomendacionStyles.darkGreen,
                  size: 16,
                ),
              ],
            ),
          ),
        ),
        
        // Lista de opciones expandible
        AnimatedContainer(
          duration: const Duration(milliseconds: 200),
          height: isExpanded ? (items.length * 54.0).clamp(0, 270) : 0,
          child: isExpanded
              ? Container(
                  margin: const EdgeInsets.only(top: 4),
                  decoration: BoxDecoration(
                    color: EditarRecomendacionStyles.backgroundModal,
                    border: Border.all(color: EditarRecomendacionStyles.borderInput),
                    borderRadius: BorderRadius.circular(8),
                  ),
                  child: ClipRRect(
                    borderRadius: BorderRadius.circular(8),
                    child: Material(
                      color: Colors.transparent,
                      child: ListView.builder(
                        padding: EdgeInsets.zero,
                        itemCount: items.length,
                        itemBuilder: (context, index) {
                          final item = items[index];
                          final isSelected = item.value == value;
                          
                          return InkWell(
                            onTap: () {
                              onChanged(item.value);
                              onToggle();
                            },
                            hoverColor: EditarRecomendacionStyles.backgroundInput,
                            splashColor: EditarRecomendacionStyles.primaryGreen.withValues(alpha: 0.1),
                            highlightColor: EditarRecomendacionStyles.backgroundInput,
                            child: Container(
                              height: 54,
                              padding: const EdgeInsets.symmetric(horizontal: 14),
                              alignment: Alignment.centerLeft,
                              decoration: BoxDecoration(
                                color: isSelected 
                                    ? const Color(0xFFE8EDE6)
                                    : Colors.transparent,
                              ),
                              child: DefaultTextStyle(
                                style: EditarRecomendacionStyles.inputTextStyle,
                                child: item.child,
                              ),
                            ),
                          );
                        },
                      ),
                    ),
                  ),
                )
              : null,
        ),
      ],
    );
  }
} // ← Cierra clase _EditarRecomendacionState
