// ═══════════════════════════════════════════════════════════════════════════
// IMPORTACIONES
// ═══════════════════════════════════════════════════════════════════════════
import 'package:flutter/material.dart'; // Framework de Flutter para widgets
import '../../environments/modales-recomendacion.dart'; // Tipos de datos (DatosRecomendacionForm, PrioridadRecomendacion, ColorRecomendacion)
import '../../styles/admin-styles/modalesRecomendacion-styles/registrar-recomendacion.dart'; // Estilos específicos
import '../../shared/validators/panel-admin/recomendaciones-validaciones.dart'; // Validadores y mensajes de error

// ═══════════════════════════════════════════════════════════════════════════
// WIDGET PRINCIPAL DEL MODAL DE REGISTRAR RECOMENDACIÓN (Editable con validación)
// Permite ingresar datos de una nueva recomendación y validarlos antes de guardar
// ═══════════════════════════════════════════════════════════════════════════
class RegistrarRecomendacion extends StatefulWidget {
  final VoidCallback onCerrar; // Callback para cerrar el modal
  final void Function(DatosRecomendacionForm) onGuardar; // Callback para guardar la recomendación

  const RegistrarRecomendacion({
    super.key,
    required this.onCerrar, // Callback cerrar obligatorio
    required this.onGuardar, // Callback guardar obligatorio
  });

  @override
  State<RegistrarRecomendacion> createState() => _RegistrarRecomendacionState();
}

// ═══════════════════════════════════════════════════════════════════════════
// ESTADO DEL MODAL DE REGISTRAR RECOMENDACIÓN (Editable con validación)
// SingleTickerProviderStateMixin: permite usar AnimationController
// ═══════════════════════════════════════════════════════════════════════════
class _RegistrarRecomendacionState extends State<RegistrarRecomendacion> with SingleTickerProviderStateMixin {
  // ─── CONTROLADORES DE TEXTO (TextEditingController) - Manejan el input del usuario ───
  late final TextEditingController _tituloCtrl; // Controla campo "Título"
  late final TextEditingController _descCtrl; // Controla campo "Descripción"
  late final TextEditingController _accionCtrl; // Controla campo "Acción recomendada"
  
  // ─── NODOS DE FOCO (FocusNode) - Detectan cuando un campo tiene foco ───
  final _tituloFocus = FocusNode();
  final _descFocus = FocusNode();
  final _accionFocus = FocusNode();
  
  // ─── ESTADO DE FOCO (bool) - Indica si cada campo está enfocado ───
  bool _tituloFocused = false;
  bool _descFocused = false;
  bool _accionFocused = false;
  
  // ─── ESTADO DE SELECCIÓN (Dropdown) ───
  PrioridadRecomendacion? _prioridad; // Prioridad seleccionada (null al inicio)
  ColorRecomendacion? _color; // Color seleccionado (null al inicio)
  
  // ─── ESTADO DE EXPANSIÓN DE DROPDOWNS ───
  bool _prioridadExpanded = false; // Controla si dropdown de prioridad está expandido
  bool _colorExpanded = false; // Controla si dropdown de color está expandido

  // ─── ERRORES DE VALIDACIÓN (String? = null si no hay error) ───
  String? _errorTitulo; // Error del campo "Título"
  String? _errorDesc; // Error del campo "Descripción"
  String? _errorAccion; // Error del campo "Acción"
  String? _errorPrioridad; // Error del dropdown "Prioridad"
  String? _errorColor; // Error del dropdown "Color"

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
    
    // ─── Inicializa controladores de texto (vacíos al inicio) ───
    _tituloCtrl = TextEditingController();
    _descCtrl   = TextEditingController();
    _accionCtrl = TextEditingController();
    
    // ─── Agrega listeners para detectar cambios de foco ───
    _tituloFocus.addListener(() => setState(() => _tituloFocused = _tituloFocus.hasFocus));
    _descFocus.addListener(() => setState(() => _descFocused = _descFocus.hasFocus));
    _accionFocus.addListener(() => setState(() => _accionFocused = _accionFocus.hasFocus));
    
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
    _controller.dispose(); // Libera el controlador de animación
    
    // Libera los FocusNodes
    _tituloFocus.dispose();
    _descFocus.dispose();
    _accionFocus.dispose();
    
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
      _errorPrioridad = RecomendacionesValidaciones.mensajeSelect(_prioridad?.toString(), 'La prioridad'); // Valida prioridad seleccionada
      _errorColor = RecomendacionesValidaciones.mensajeSelect(_color?.toString(), 'El color'); // Valida color seleccionado
    });

    // ─── FASE 2: Verificar si hay errores ───
    if (_errorTitulo != null || _errorDesc != null || _errorAccion != null || _errorPrioridad != null || _errorColor != null) {
      return; // Si hay errores, detiene el proceso (no guarda)
    }

    // ─── FASE 3: Sin errores, llama al callback onGuardar ───
    widget.onGuardar(DatosRecomendacionForm( // Crea objeto DatosRecomendacionForm con valores del formulario
      titulo:      _tituloCtrl.text.trim(), // Título sin espacios
      descripcion: _descCtrl.text.trim(), // Descripción sin espacios
      accion:      _accionCtrl.text.trim(), // Acción sin espacios
      prioridad:   _prioridad!, // ! indica que _prioridad NO es null (ya validado)
      color:       _color!, // ! indica que _color NO es null (ya validado)
    ));
  }

  @override
  Widget build(BuildContext context) {
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
                color: const Color.fromRGBO(7, 61, 43, 0.45).withValues(
                  alpha: const Color.fromRGBO(7, 61, 43, 0.45).a * _fadeAnimation.value,
                ),
                child: Center(
                  child: GestureDetector(
                    onTap: () {},
                    child: Transform.translate(
                      offset: _slideAnimation.value,
                      child: Opacity(
                        opacity: _controller.value,
                        child: Container(
                          constraints: const BoxConstraints(maxWidth: 580),
                          margin: const EdgeInsets.all(24),
                          decoration: BoxDecoration(
                          color: Colors.white,
                          border: Border.all(color: RegistrarRecomendacionStyles.borderGrey),
                          borderRadius: BorderRadius.circular(8),
                          boxShadow: const [
                            BoxShadow(
                              color: Color.fromRGBO(7, 61, 43, 0.2),
                              blurRadius: 48,
                              offset: Offset(0, 24),
                            ),
                          ],
                        ),
                        padding: const EdgeInsets.fromLTRB(28, 28, 28, 24),
                        child: SingleChildScrollView(
                          child: Column(
                            mainAxisSize: MainAxisSize.min,
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                            // Header
                            Stack(
                              children: [
                                Padding(
                                  padding: const EdgeInsets.only(right: 44, bottom: 22),
                                  child: Text('Registrar recomendación',
                                      style: RegistrarRecomendacionStyles.h1Text.copyWith(fontSize: 28)),
                                ),
                                Positioned(
                                  top: 0,
                                  right: 0,
                                  child: GestureDetector(
                                    onTap: widget.onCerrar,
                                    child: Container(
                                      width: 40,
                                      height: 40,
                                      decoration: BoxDecoration(
                                        color: RegistrarRecomendacionStyles.backgroundPage,
                                        borderRadius: BorderRadius.circular(8),
                                      ),
                                      child: const Icon(Icons.close,
                                          color: RegistrarRecomendacionStyles.darkGreen, size: 18),
                                    ),
                                  ),
                                ),
                              ],
                            ),
                                    _buildTextField('Título', _tituloCtrl,
                                        hint: 'Ej: Humedad foliar por debajo del óptimo',
                                        errorText: _errorTitulo,
                                        onChanged: (v) => setState(() => _errorTitulo = RecomendacionesValidaciones.mensajeTitulo(v)),
                                        focusNode: _tituloFocus,
                                        focused: _tituloFocused),
                                    const SizedBox(height: 14),
                                    _buildTextField('Descripción', _descCtrl,
                                        hint: 'Descripción del hallazgo',
                                        maxLines: 3,
                                        errorText: _errorDesc,
                                        onChanged: (v) => setState(() => _errorDesc = RecomendacionesValidaciones.mensajeDescripcion(v)),
                                        focusNode: _descFocus,
                                        focused: _descFocused),
                                    const SizedBox(height: 14),
                                    _buildTextField('Acción recomendada', _accionCtrl,
                                        hint: 'Qué debe hacer el agricultor',
                                        maxLines: 2,
                                        errorText: _errorAccion,
                                        onChanged: (v) => setState(() => _errorAccion = RecomendacionesValidaciones.mensajeAccion(v)),
                                        focusNode: _accionFocus,
                                        focused: _accionFocused),
                                    const SizedBox(height: 14),
                                    _buildDropdown<PrioridadRecomendacion>(
                                      label: 'Prioridad',
                                      hint: 'Seleccione prioridad',
                                      value: _prioridad,
                                      errorText: _errorPrioridad,
                                      isExpanded: _prioridadExpanded,
                                      onToggle: () => setState(() {
                                        _prioridadExpanded = !_prioridadExpanded;
                                        _colorExpanded = false;
                                      }),
                                      items: PrioridadRecomendacion.values
                                          .map((p) => DropdownMenuItem(
                                                value: p,
                                                child: Text(p.label),
                                              ))
                                          .toList(),
                                      onChanged: (v) =>
                                          setState(() { _prioridad = v; _errorPrioridad = RecomendacionesValidaciones.mensajeSelect(v?.toString(), 'La prioridad'); }),
                                    ),
                                    const SizedBox(height: 14),
                                    _buildDropdown<ColorRecomendacion>(
                                      label: 'Color',
                                      hint: 'Seleccione color',
                                      value: _color,
                                      errorText: _errorColor,
                                      isExpanded: _colorExpanded,
                                      onToggle: () => setState(() {
                                        _colorExpanded = !_colorExpanded;
                                        _prioridadExpanded = false;
                                      }),
                                      items: ColorRecomendacion.values
                                          .map((c) => DropdownMenuItem(
                                                value: c,
                                                child: Text(c.label),
                                              ))
                                          .toList(),
                                      onChanged: (v) =>
                                          setState(() { _color = v; _errorColor = RecomendacionesValidaciones.mensajeSelect(v?.toString(), 'El color'); }),
                                    ),
                                    const SizedBox(height: 24),
                                    // Footer con botones
                                    Row(
                                      children: [
                                        Expanded(
                                          child: GestureDetector(
                                            onTap: widget.onCerrar,
                                            child: Container(
                                              constraints: const BoxConstraints(minHeight: 50),
                                              padding: const EdgeInsets.symmetric(horizontal: 4),
                                              decoration: BoxDecoration(
                                                color: RegistrarRecomendacionStyles.backgroundInput,
                                                border: Border.all(color: RegistrarRecomendacionStyles.borderGrey),
                                                borderRadius: BorderRadius.circular(8),
                                              ),
                                              child: const Center(
                                                child: Text('Cancelar', style: RegistrarRecomendacionStyles.labelText, textAlign: TextAlign.center),
                                              ),
                                            ),
                                          ),
                                        ),
                                        const SizedBox(width: 10),
                                        Expanded(
                                          child: GestureDetector(
                                            onTap: _submit,
                                            child: Container(
                                              constraints: const BoxConstraints(minHeight: 50),
                                              padding: const EdgeInsets.symmetric(horizontal: 4),
                                              decoration: RegistrarRecomendacionStyles.createBtnDecoration,
                                              child: const Center(
                                                child: Text(
                                                  'Registrar recomendación',
                                                  style: TextStyle(
                                                      color: Colors.white,
                                                      fontSize: 14,
                                                      fontWeight: FontWeight.w800),
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
  // MÉTODO HELPER: _buildTextField - Construye campo de texto editable con validación
  // ═══════════════════════════════════════════════════════════════════════════
  Widget _buildTextField(String label, TextEditingController ctrl,
      {String hint = '', int maxLines = 1, String? errorText, void Function(String)? onChanged, FocusNode? focusNode, bool focused = false}) {
    return Column( // Columna: label + TextField
      crossAxisAlignment: CrossAxisAlignment.start, // Alinea a la izquierda
      children: [
        Text(label, style: RegistrarRecomendacionStyles.labelText), // Label del campo (ej: "Título")
        const SizedBox(height: 8), // Espacio entre label y TextField
        Focus( // Envuelve en Focus para detectar cambios de foco
          onFocusChange: (focus) { // Callback cuando cambia el foco
            if (focusNode != null) {
              // El estado ya se maneja con el listener del FocusNode
            }
          },
          child: AnimatedContainer( // AnimatedContainer para el resplandor
            duration: const Duration(milliseconds: 200), // Duración de la animación
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(8),
              boxShadow: focused && errorText == null
                  ? [
                      const BoxShadow(
                        color: Color.fromRGBO(85, 168, 32, 0.13),
                        blurRadius: 0,
                        spreadRadius: 4,
                      ),
                    ]
                  : null,
            ),
            child: TextField( // Campo de texto editable
              controller: ctrl, // Controlador de texto
              focusNode: focusNode, // Nodo de foco
              maxLines: maxLines, // Número de líneas (1 para texto simple, 2-3 para textarea)
              onChanged: onChanged, // Valida en tiempo real al escribir
              decoration: InputDecoration( // Configuración del TextField
                hintText: hint, // Placeholder (ej: "Ej: Humedad foliar por debajo del óptimo")
                errorText: errorText, // Mensaje de error (aparece debajo del campo)
                hintStyle: const TextStyle(color: Color(0xFF6B8177), fontSize: 14), // Estilo del placeholder (gris)
                contentPadding: const EdgeInsets.symmetric(horizontal: 14, vertical: 12), // Espaciado interno
                filled: true, // Rellena el fondo
                fillColor: RegistrarRecomendacionStyles.backgroundInput, // Color de fondo claro
                enabledBorder: OutlineInputBorder( // Borde cuando NO está enfocado
                  borderRadius: BorderRadius.circular(8), // Bordes redondeados
                  borderSide: BorderSide(color: errorText != null ? Colors.red : RegistrarRecomendacionStyles.borderInput), // Rojo si hay error
                ),
                focusedBorder: OutlineInputBorder( // Borde cuando ESTÁ enfocado
                  borderRadius: BorderRadius.circular(8),
                  borderSide: BorderSide(color: errorText != null ? Colors.red : RegistrarRecomendacionStyles.primaryGreen, width: 1.5), // Verde o rojo
                ),
                errorBorder: OutlineInputBorder( // Borde cuando hay error (no enfocado)
                  borderRadius: BorderRadius.circular(8),
                  borderSide: const BorderSide(color: Colors.red, width: 1.5), // Rojo
                ),
                focusedErrorBorder: OutlineInputBorder( // Borde cuando hay error (enfocado)
                  borderRadius: BorderRadius.circular(8),
                  borderSide: const BorderSide(color: Colors.red, width: 1.5), // Rojo
                ),
              ),
              style: const TextStyle(color: RegistrarRecomendacionStyles.darkGreen, fontSize: 14), // Estilo del texto escrito
            ),
          ),
        ),
      ],
    );
  }

  // ═══════════════════════════════════════════════════════════════════════════
  // MÉTODO HELPER: _buildDropdown - Construye dropdown (select) con validación
  // ═══════════════════════════════════════════════════════════════════════════
  Widget _buildDropdown<T>({
    required String label, // Label del campo
    required T? value, // Valor seleccionado actualmente (null si no hay selección)
    required List<DropdownMenuItem<T>> items, // Lista de opciones
    required ValueChanged<T?> onChanged, // Callback cuando cambia selección
    required String hint, // Texto placeholder
    String? errorText, // Mensaje de error (opcional)
    required bool isExpanded, // Si el dropdown está expandido
    required VoidCallback onToggle, // Callback para alternar expansión
  }) {
    // Obtiene el texto del item seleccionado
    String getSelectedText() {
      if (value == null) return hint;
      final selectedItem = items.firstWhere((item) => item.value == value);
      final child = selectedItem.child;
      if (child is Text) {
        return child.data ?? hint;
      }
      return hint;
    }

    return Column( // Columna: label + Dropdown + opciones + mensaje de error
      crossAxisAlignment: CrossAxisAlignment.start, // Alinea a la izquierda
      children: [
        Text(label, style: RegistrarRecomendacionStyles.labelText), // Label (ej: "Prioridad")
        const SizedBox(height: 8), // Espacio entre label y dropdown
        
        // Campo del dropdown (siempre visible)
        GestureDetector(
          onTap: onToggle,
          child: AnimatedContainer( // AnimatedContainer para transición suave
            duration: const Duration(milliseconds: 200), // Duración de la animación
            height: 48, // Altura fija
            decoration: RegistrarRecomendacionStyles.inputDecoration(focused: isExpanded).copyWith( // Glow si está expandido
              border: Border.all(color: errorText != null ? Colors.red : (isExpanded ? RegistrarRecomendacionStyles.primaryGreen : RegistrarRecomendacionStyles.borderInput)), // Borde rojo si hay error, verde si expandido
            ),
            padding: const EdgeInsets.symmetric(horizontal: 14), // Espaciado horizontal interno
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Expanded(
                  child: Text(
                    getSelectedText(),
                    style: TextStyle(
                      color: value == null ? const Color(0xFF6B8177) : RegistrarRecomendacionStyles.darkGreen,
                      fontSize: 14,
                      fontFamily: 'Arial',
                    ),
                    overflow: TextOverflow.ellipsis,
                  ),
                ),
                Icon(
                  isExpanded ? Icons.keyboard_arrow_up : Icons.keyboard_arrow_down,
                  color: RegistrarRecomendacionStyles.primaryGreen,
                ),
              ],
            ),
          ),
        ),
        
        // Lista de opciones expandible
        AnimatedContainer(
          duration: const Duration(milliseconds: 200),
          height: isExpanded ? (items.length * 48.0).clamp(0, 240) : 0,
          child: isExpanded
              ? Container(
                  margin: const EdgeInsets.only(top: 4),
                  decoration: BoxDecoration(
                    color: RegistrarRecomendacionStyles.backgroundInput,
                    border: Border.all(color: RegistrarRecomendacionStyles.borderInput),
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
                            hoverColor: RegistrarRecomendacionStyles.backgroundInput,
                            splashColor: RegistrarRecomendacionStyles.primaryGreen.withValues(alpha: 0.1),
                            highlightColor: RegistrarRecomendacionStyles.backgroundInput,
                            child: Container(
                              height: 48,
                              padding: const EdgeInsets.symmetric(horizontal: 14),
                              alignment: Alignment.centerLeft,
                              decoration: BoxDecoration(
                                color: isSelected 
                                    ? const Color(0xFFE8EDE6)
                                    : Colors.transparent,
                              ),
                              child: DefaultTextStyle(
                                style: const TextStyle(
                                  color: RegistrarRecomendacionStyles.darkGreen,
                                  fontSize: 14,
                                  fontFamily: 'Arial',
                                ),
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
        
        if (errorText != null) ...[ // Si hay error, muestra mensaje
          const SizedBox(height: 6), // Espacio antes del mensaje
          Text(errorText, style: const TextStyle(color: Colors.red, fontSize: 12)), // Mensaje de error (rojo)
        ],
      ],
    );
  }
} // ← Cierra clase _RegistrarRecomendacionState
