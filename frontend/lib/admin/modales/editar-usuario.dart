// Importaciones necesarias para el modal
import 'package:flutter/material.dart'; // Framework de Flutter para widgets
import '../../styles/admin-styles/panel-admin.dart'; // Estilos globales del panel admin
import '../../styles/admin-styles/modales-styles/editar-usuario.dart'; // Estilos específicos de este modal
import '../../environments/datos-simulados-admin.dart'; // Datos y tipos de usuario (UsuarioAdmin, RolUsuario, etc.)
import 'registro-usuario.dart'; // Importa DatosUsuario que se usa para retornar los datos editados
import '../../shared/validators/modales-validaciones.dart'; // Validaciones compartidas (patrones regex, mensajes de error)

// Widget principal del modal (StatefulWidget porque maneja estado mutable)
class EditarUsuario extends StatefulWidget {
  final UsuarioAdmin usuario; // Usuario que se va a editar (datos originales)
  final VoidCallback onCerrar; // Callback para cerrar el modal
  final void Function(DatosUsuario) onGuardar; // Callback para guardar cambios, recibe los datos editados

  const EditarUsuario({
    super.key,
    required this.usuario, // Usuario obligatorio
    required this.onCerrar, // Callback cerrar obligatorio
    required this.onGuardar, // Callback guardar obligatorio
  });

  @override
  State<EditarUsuario> createState() => _EditarUsuarioState(); // Crea el estado del widget
}

// Estado privado del modal EditarUsuario
// SingleTickerProviderStateMixin: permite usar AnimationController para las animaciones
class _EditarUsuarioState extends State<EditarUsuario> with SingleTickerProviderStateMixin {
  // ═══════════════════════════════════════════════════════════════════════════
  // CONTROLADORES DE CAMPOS DE TEXTO
  // ═══════════════════════════════════════════════════════════════════════════
  late final TextEditingController _nombreCtrl; // Controlador para el campo "Nombre"
  late final TextEditingController _segundoNombreCtrl; // Controlador para "Segundo nombre"
  late final TextEditingController _apellidoCtrl; // Controlador para "Apellido"
  late final TextEditingController _segundoApellidoCtrl; // Controlador para "Segundo apellido"
  late final TextEditingController _correoCorpCtrl; // Controlador para "Correo corporativo"
  late final TextEditingController _correoElecCtrl; // Controlador para "Correo electrónico"
  late final TextEditingController _telefonoCtrl; // Controlador para "Teléfono"
  late final TextEditingController _passwordCtrl; // Controlador para "Contraseña"
  late final TextEditingController _confirmPassCtrl; // Controlador para "Confirmar contraseña"

  // ═══════════════════════════════════════════════════════════════════════════
  // VARIABLES DE ESTADO DEL FORMULARIO
  // ═══════════════════════════════════════════════════════════════════════════
  bool _showPassword = false; // Controla si se muestra la contraseña (false = oculta)
  bool _showConfirmPassword = false; // Controla si se muestra la confirmación de contraseña
  RolUsuario? _rol; // Rol seleccionado (admin o agricultor), nullable porque puede no estar seleccionado

  // ═══════════════════════════════════════════════════════════════════════════
  // CONTROLADORES DE ANIMACIÓN
  // ═══════════════════════════════════════════════════════════════════════════
  late AnimationController _controller; // Controla el progreso de las animaciones (0.0 a 1.0)
  late Animation<double> _fadeAnimation; // Animación de fade-in para el fondo oscuro
  late Animation<Offset> _slideAnimation; // Animación de deslizamiento del modal desde abajo

  // ═══════════════════════════════════════════════════════════════════════════
  // MENSAJES DE ERROR DE VALIDACIÓN
  // ═══════════════════════════════════════════════════════════════════════════
  String? _nombreError; // Mensaje de error para el campo "Nombre" (null = sin error)
  String? _segundoNombreError; // Mensaje de error para "Segundo nombre"
  String? _apellidoError; // Mensaje de error para "Apellido"
  String? _segundoApellidoError; // Mensaje de error para "Segundo apellido"
  String? _correoCorpError; // Mensaje de error para "Correo corporativo"
  String? _correoElecError; // Mensaje de error para "Correo electrónico"
  String? _telefonoError; // Mensaje de error para "Teléfono"
  String? _passwordError; // Mensaje de error para "Contraseña"
  String? _confirmPassError; // Mensaje de error para "Confirmar contraseña"
  String? _rolError; // Mensaje de error para el campo "Rol"

  // ═══════════════════════════════════════════════════════════════════════════
  // INICIALIZACIÓN DEL ESTADO
  // ═══════════════════════════════════════════════════════════════════════════
  @override
  void initState() {
    super.initState(); // Llama al initState del padre
    final u = widget.usuario; // Referencia al usuario que se está editando
    
    // Inicializa todos los controladores con los valores actuales del usuario
    _nombreCtrl = TextEditingController(text: u.nombre); // Pre-llena el nombre
    _segundoNombreCtrl = TextEditingController(text: u.segundoNombre); // Pre-llena segundo nombre
    _apellidoCtrl = TextEditingController(text: u.apellido); // Pre-llena apellido
    _segundoApellidoCtrl = TextEditingController(text: u.segundoApellido); // Pre-llena segundo apellido
    _correoCorpCtrl = TextEditingController(text: u.correoCorporativo); // Pre-llena correo corporativo
    _correoElecCtrl = TextEditingController(text: u.correoElectronico); // Pre-llena correo electrónico
    _telefonoCtrl = TextEditingController(text: u.telefono); // Pre-llena teléfono
    _passwordCtrl = TextEditingController(text: 'AgroVision2026!'); // Contraseña por defecto (placeholder)
    _confirmPassCtrl = TextEditingController(text: 'AgroVision2026!'); // Confirmación por defecto
    _rol = u.rol; // Establece el rol actual del usuario

    // ─────────────────────────────────────────────────────────────────────────
    // CONFIGURACIÓN DE ANIMACIONES
    // ─────────────────────────────────────────────────────────────────────────
    _controller = AnimationController(
      vsync: this, // Sincroniza con el tick del frame (requiere SingleTickerProviderStateMixin)
      duration: const Duration(milliseconds: 300), // Duración total de la animación: 300ms
    );
    
    // Animación de fade (opacidad) para el fondo oscuro
    // Se completa en los primeros 200ms (66% del tiempo total)
    _fadeAnimation = CurvedAnimation(
      parent: _controller, // Usa el controlador principal
      curve: const Interval(0.0, 0.66, curve: Curves.easeOut), // 0% a 66% del tiempo con curva suave
    );

    // Animación de deslizamiento (slide) del modal desde abajo
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
  // LIMPIEZA DE RECURSOS (dispose)
  // Se ejecuta cuando el widget se elimina del árbol de widgets
  // ═══════════════════════════════════════════════════════════════════════════
  @override
  void dispose() {
    // Libera la memoria de cada controlador para evitar fugas de memoria
    _nombreCtrl.dispose();
    _segundoNombreCtrl.dispose();
    _apellidoCtrl.dispose();
    _segundoApellidoCtrl.dispose();
    _correoCorpCtrl.dispose();
    _correoElecCtrl.dispose();
    _telefonoCtrl.dispose();
    _passwordCtrl.dispose();
    _confirmPassCtrl.dispose();
    _controller.dispose(); // Libera el controlador de animación
    super.dispose(); // Llama al dispose del padre
  }

  // ═══════════════════════════════════════════════════════════════════════════
  // MÉTODOS DE VALIDACIÓN (se ejecutan cuando el usuario escribe en los campos)
  // ═══════════════════════════════════════════════════════════════════════════
  
  // Valida el campo "Nombre"
  void _validarNombre() {
    final valor = _nombreCtrl.text.trim(); // Obtiene el texto del campo y elimina espacios al inicio/fin
    setState(() { // Actualiza el estado del widget para reflejar cambios en la UI
      // Nombre es opcional, pero si tiene valor debe ser válido
      if (valor.isNotEmpty && !ModalesValidaciones.nombrePattern.hasMatch(valor)) { // Si hay texto y NO cumple el patrón regex
        _nombreError = ModalesValidaciones.mensajesError['nombrePattern']; // Asigna mensaje de error
      } else { // Si está vacío O cumple el patrón
        _nombreError = null; // No hay error
      }
    });
  }

  // Valida el campo "Segundo nombre"
  void _validarSegundoNombre() {
    final valor = _segundoNombreCtrl.text.trim(); // Obtiene el texto del campo y elimina espacios
    setState(() { // Actualiza el estado para mostrar/ocultar error
      // Segundo nombre es opcional, pero si tiene valor debe ser válido
      if (valor.isNotEmpty && !ModalesValidaciones.nombrePattern.hasMatch(valor)) { // Valida solo si no está vacío
        _segundoNombreError = ModalesValidaciones.mensajesError['nombrePattern']; // Muestra error si el patrón no coincide
      } else {
        _segundoNombreError = null; // Limpia el error
      }
    });
  }

  // Valida el campo "Apellido"
  void _validarApellido() {
    final valor = _apellidoCtrl.text.trim(); // Extrae texto del controlador sin espacios
    setState(() { // Reconstruye el widget con el nuevo estado
      // Apellido es opcional, pero si tiene valor debe ser válido
      if (valor.isNotEmpty && !ModalesValidaciones.nombrePattern.hasMatch(valor)) { // Verifica patrón solo si hay texto
        _apellidoError = ModalesValidaciones.mensajesError['nombrePattern']; // Establece mensaje de error
      } else {
        _apellidoError = null; // Sin error
      }
    });
  }

  // Valida el campo "Segundo apellido"
  void _validarSegundoApellido() {
    final valor = _segundoApellidoCtrl.text.trim(); // Lee valor del campo
    setState(() { // Dispara reconstrucción del widget
      // Segundo apellido es opcional, pero si tiene valor debe ser válido
      if (valor.isNotEmpty && !ModalesValidaciones.nombrePattern.hasMatch(valor)) { // Valida formato si no está vacío
        _segundoApellidoError = ModalesValidaciones.mensajesError['nombrePattern']; // Error de formato
      } else {
        _segundoApellidoError = null; // Campo válido
      }
    });
  }

  // Valida el campo "Correo corporativo" (campo REQUERIDO)
  void _validarCorreoCorporativo() {
    final valor = _correoCorpCtrl.text.trim(); // Obtiene valor sin espacios
    setState(() { // Actualiza UI
      if (valor.isEmpty) { // Si el campo está vacío
        _correoCorpError = ModalesValidaciones.mensajesError['correoCorporativoRequired']; // Error: campo obligatorio
      } else if (!ModalesValidaciones.correoCorporativoPattern.hasMatch(valor)) { // Si no cumple formato @agrovision.com
        _correoCorpError = ModalesValidaciones.mensajesError['correoCorporativoPattern']; // Error: formato inválido
      } else { // Si está lleno Y cumple el formato
        _correoCorpError = null; // No hay error
      }
    });
  }

  // Valida el campo "Correo electrónico" (campo REQUERIDO)
  void _validarCorreoElectronico() {
    final valor = _correoElecCtrl.text.trim(); // Lee texto del input
    setState(() { // Redibuja widget
      if (valor.isEmpty) { // Verifica si está vacío
        _correoElecError = ModalesValidaciones.mensajesError['correoElectronicoRequired']; // Error: campo requerido
      } else if (!ModalesValidaciones.correoGmailPattern.hasMatch(valor)) { // Verifica formato @gmail.com
        _correoElecError = ModalesValidaciones.mensajesError['correoGmailPattern']; // Error: debe ser @gmail.com
      } else { // Valor válido
        _correoElecError = null; // Sin error
      }
    });
  }

  // Valida el campo "Teléfono" (campo REQUERIDO)
  void _validarTelefono() {
    final valor = _telefonoCtrl.text.trim(); // Extrae número sin espacios
    setState(() { // Actualiza estado
      if (valor.isEmpty) { // Si no hay número
        _telefonoError = ModalesValidaciones.mensajesError['telefonoRequired']; // Error: campo obligatorio
      } else if (!ModalesValidaciones.telefonoPattern.hasMatch(valor)) { // Si no cumple formato (10 dígitos)
        _telefonoError = ModalesValidaciones.mensajesError['telefonoPattern']; // Error: formato inválido
      } else { // Formato correcto
        _telefonoError = null; // No hay error
      }
    });
  }

  // Valida el campo "Contraseña" (campo REQUERIDO)
  void _validarPassword() {
    final valor = _passwordCtrl.text; // Obtiene contraseña (sin trim para preservar espacios si los hay)
    setState(() { // Reconstruye widget
      if (valor.isEmpty) { // Si no hay contraseña
        _passwordError = ModalesValidaciones.mensajesError['passwordRequired']; // Error: contraseña requerida
      } else { // Hay contraseña
        _passwordError = null; // Sin error (no valida complejidad, solo que no esté vacía)
      }
    });
  }

  // Valida el campo "Confirmar contraseña" (campo REQUERIDO)
  void _validarConfirmPassword() {
    final valor = _confirmPassCtrl.text; // Lee valor de confirmación
    setState(() { // Actualiza UI
      if (valor.isEmpty) { // Si está vacío
        _confirmPassError = ModalesValidaciones.mensajesError['confirmarPasswordRequired']; // Error: campo requerido
      } else if (valor != _passwordCtrl.text) { // Si NO coincide con la contraseña original
        _confirmPassError = ModalesValidaciones.mensajesError['passwordMismatch']; // Error: las contraseñas no coinciden
      } else { // Coincide con la contraseña
        _confirmPassError = null; // Sin error
      }
    });
  }

  // ═══════════════════════════════════════════════════════════════════════════
  // MÉTODO SUBMIT - Se ejecuta cuando el usuario hace clic en "Guardar cambios"
  // ═══════════════════════════════════════════════════════════════════════════
  void _submit() {
    // ─── PASO 1: Validar todos los campos ───
    _validarNombre(); // Valida campo nombre
    _validarSegundoNombre(); // Valida segundo nombre
    _validarApellido(); // Valida apellido
    _validarSegundoApellido(); // Valida segundo apellido
    _validarCorreoCorporativo(); // Valida correo corporativo (requerido)
    _validarCorreoElectronico(); // Valida correo electrónico (requerido)
    _validarTelefono(); // Valida teléfono (requerido)
    _validarPassword(); // Valida contraseña (requerido)
    _validarConfirmPassword(); // Valida confirmación de contraseña (requerido)

    // ─── PASO 2: Validar el campo de rol ───
    setState(() { // Actualiza estado para mostrar error si es necesario
      if (_rol == null) { // Si no se ha seleccionado ningún rol
        _rolError = ModalesValidaciones.mensajesError['required']; // Muestra error de campo requerido
      } else { // Si hay un rol seleccionado
        _rolError = null; // Limpia cualquier error previo
      }
    });

    // ─── PASO 3: Verificar si hay algún error en cualquier campo ───
    if (_nombreError != null || // Si hay error en nombre
        _segundoNombreError != null || // O error en segundo nombre
        _apellidoError != null || // O error en apellido
        _segundoApellidoError != null || // O error en segundo apellido
        _correoCorpError != null || // O error en correo corporativo
        _correoElecError != null || // O error en correo electrónico
        _telefonoError != null || // O error en teléfono
        _passwordError != null || // O error en contraseña
        _confirmPassError != null || // O error en confirmación
        _rolError != null) { // O error en rol
      return; // DETIENE el guardado - no continúa si hay errores
    }

    // ─── PASO 4: Si no hay errores, llama al callback onGuardar ───
    widget.onGuardar(DatosUsuario( // Crea objeto con los datos del formulario
      nombre: _nombreCtrl.text.trim(), // Nombre sin espacios al inicio/fin
      segundoNombre: _segundoNombreCtrl.text.trim(), // Segundo nombre limpio
      apellido: _apellidoCtrl.text.trim(), // Apellido limpio
      segundoApellido: _segundoApellidoCtrl.text.trim(), // Segundo apellido limpio
      correoCorporativo: _correoCorpCtrl.text.trim(), // Correo corporativo limpio
      correoElectronico: _correoElecCtrl.text.trim(), // Correo electrónico limpio
      telefono: _telefonoCtrl.text.trim(), // Teléfono limpio
      password: _passwordCtrl.text, // Contraseña (sin trim para preservar espacios)
      rol: _rol!, // Rol seleccionado (! indica que sabemos que no es null porque ya lo validamos)
    ));
    // El callback onGuardar es manejado por el componente padre (panel-admin.dart)
    // que cerrará el modal y actualizará la lista de usuarios
  }

  // ═══════════════════════════════════════════════════════════════════════════
  // BUILD METHOD - Construye la interfaz del modal
  // ═══════════════════════════════════════════════════════════════════════════
  @override
  Widget build(BuildContext context) {
    // Determina si es vista móvil (ancho menor o igual al breakpoint definido en estilos)
    final bool isMobile = MediaQuery.of(context).size.width <= EditarUsuarioStyles.mobileBreakpoint;

    return Material( // Widget base para efectos materiales (necesario para transparency)
      type: MaterialType.transparency, // Fondo transparente para mostrar el overlay oscuro debajo
      child: AnimatedBuilder( // Reconstruye cuando la animación cambia
        animation: _controller, // Escucha cambios en el controlador de animación
        builder: (context, child) { // Se ejecuta cada vez que _controller cambia (60fps)
          return SizedBox.expand( // Expande para ocupar toda la pantalla (width/height: double.infinity)
            child: GestureDetector( // Detecta toques del usuario
              onTap: widget.onCerrar, // Al tocar el fondo oscuro, cierra el modal
              child: Container( // Contenedor del fondo oscuro (overlay)
                width: double.infinity, // Ancho completo de la pantalla
                height: double.infinity, // Alto completo de la pantalla
                color: EditarUsuarioStyles.overlayColor.withValues( // Color verde oscuro semitransparente
                  alpha: EditarUsuarioStyles.overlayColor.a * _fadeAnimation.value, // Opacidad animada (0.0 a valor final)
                ),
                child: Center( // Centra el modal en la pantalla
                  child: GestureDetector( // Detecta toques DENTRO del modal
                    onTap: () {}, // onTap vacío previene que el toque cierre el modal (detiene propagación)
                    child: Transform.translate( // Aplica transformación de posición
                      offset: _slideAnimation.value, // Desplaza el modal verticalmente (animación slide)
                      child: Opacity( // Controla la opacidad del modal
                        opacity: _controller.value, // Fade-in general del modal card (0.0 a 1.0)
                        child: Container( // ← CONTENEDOR PRINCIPAL DEL MODAL (tarjeta blanca)
                          constraints: const BoxConstraints(maxWidth: EditarUsuarioStyles.maxWidth), // Ancho máximo del modal
                          margin: EditarUsuarioStyles.modalMargin, // Márgen exterior del modal
                          decoration: EditarUsuarioStyles.modalDecoration, // Bordes redondeados, sombra, color blanco
                          child: Column( // Columna que organiza: header, formulario, footer
                mainAxisSize: MainAxisSize.min, // Ocupa solo el espacio necesario (no toda la altura)
                children: [ // ← Array de hijos de la columna
                  // ─────────────────────────────────────────────────────────────
                  // HEADER - Título y botón de cerrar
                  // ─────────────────────────────────────────────────────────────
                  Padding( // Agrega espaciado interno al header
                    padding: EditarUsuarioStyles.headerPadding, // Espaciado definido en estilos
                    child: Row( // Fila horizontal para título y botón cerrar
                      children: [ // Hijos de la fila
                        const Expanded( // Expanded hace que el título ocupe todo el espacio disponible
                          child: Text('Editar usuario', style: EditarUsuarioStyles.titleText), // Texto del título
                        ),
                        GestureDetector( // Detecta toque en botón cerrar
                          onTap: widget.onCerrar, // Al tocar, ejecuta callback para cerrar modal
                          child: Container( // Contenedor del botón X
                            width: EditarUsuarioStyles.closeButtonSize, // Ancho fijo del botón
                            height: EditarUsuarioStyles.closeButtonSize, // Alto fijo del botón
                            decoration: EditarUsuarioStyles.closeButtonDecoration, // Estilo del botón (circular, borde)
                            child: const Icon(Icons.close, // Icono X de Material Icons
                                color: EditarUsuarioStyles.closeIconColor, // Color del icono
                                size: EditarUsuarioStyles.closeIconSize), // Tamaño del icono
                          ),
                        ),
                      ],
                    ),
                  ),
                  const SizedBox(height: 22), // Espaciado vertical de 22px entre header y formulario
                  // ─────────────────────────────────────────────────────────────
                  // FORMULARIO - Campos de entrada scrolleables
                  // ─────────────────────────────────────────────────────────────
                  Flexible( // Permite que el contenido sea scrolleable si no cabe en pantalla
                    child: SingleChildScrollView( // Hace el contenido scrolleable verticalmente
                      padding: EditarUsuarioStyles.formPadding, // Espaciado interno del formulario
                      child: Column( // Columna para organizar los campos
                        children: [ // Hijos de la columna
                          _buildGrid( // Método helper que organiza campos en grid (2 columnas desktop, 1 columna mobile)
                            isMobile: isMobile, // Pasa si es vista móvil
                            children: [ // Lista de campos del formulario
                              _buildTextField('Nombre', Icons.person, _nombreCtrl, // Campo nombre
                                error: _nombreError, onChanged: _validarNombre), // Pasa error y validación
                              _buildTextField('Segundo nombre', Icons.person, _segundoNombreCtrl, // Campo segundo nombre
                                error: _segundoNombreError, onChanged: _validarSegundoNombre),
                              _buildTextField('Apellido', Icons.person, _apellidoCtrl, // Campo apellido
                                error: _apellidoError, onChanged: _validarApellido),
                              _buildTextField('Segundo apellido', Icons.person, _segundoApellidoCtrl, // Campo segundo apellido
                                error: _segundoApellidoError, onChanged: _validarSegundoApellido),
                              _buildTextField('Correo corporativo *', Icons.email, _correoCorpCtrl, // Campo correo corp
                                  isFull: true, error: _correoCorpError, onChanged: _validarCorreoCorporativo), // isFull=true ocupa ancho completo
                              _buildTextField('Correo electronico *', Icons.email, _correoElecCtrl, // Campo correo personal
                                  isFull: true, error: _correoElecError, onChanged: _validarCorreoElectronico),
                              _buildTextField('Numero de telefono *', Icons.phone, _telefonoCtrl, // Campo teléfono
                                  isFull: true, keyboardType: TextInputType.phone, // Teclado numérico
                                  error: _telefonoError, onChanged: _validarTelefono),
                              _buildPasswordField('Contraseña *', _passwordCtrl, _showPassword, () { // Campo contraseña
                                setState(() => _showPassword = !_showPassword); // Toggle mostrar/ocultar contraseña
                              }, error: _passwordError, onChanged: _validarPassword),
                              _buildPasswordField('Confirmar contraseña *', _confirmPassCtrl, _showConfirmPassword, () { // Confirmar contraseña
                                setState(() => _showConfirmPassword = !_showConfirmPassword); // Toggle visibilidad
                              }, error: _confirmPassError, onChanged: _validarConfirmPassword),
                              _buildRolField(), // Campo de selección de rol (radio buttons)
                            ],
                          ),
                        ],
                      ),
                    ),
                  ),
                  // ─────────────────────────────────────────────────────────────
                  // FOOTER - Botones de acción (Cancelar / Guardar cambios)
                  // ─────────────────────────────────────────────────────────────
                  Padding( // Espaciado del footer
                    padding: EditarUsuarioStyles.footerPadding, // Padding definido en estilos
                    child: Row( // Fila para botones
                      mainAxisAlignment: MainAxisAlignment.end, // Alinea botones a la derecha
                      children: [ // Botones
                        GestureDetector( // Botón Cancelar (clickeable)
                          onTap: widget.onCerrar, // Al hacer clic, cierra el modal sin guardar
                          child: Container( // Contenedor del botón
                            constraints: const BoxConstraints(minHeight: EditarUsuarioStyles.minButtonHeight), // Altura mínima
                            padding: EditarUsuarioStyles.cancelButtonPadding, // Espaciado interno
                            decoration: EditarUsuarioStyles.cancelButtonDecoration, // Estilo (borde, color)
                            child: const Center( // Centra el texto
                              child: Text('Cancelar', style: EditarUsuarioStyles.cancelButtonText), // Texto del botón
                            ),
                          ),
                        ),
                        const SizedBox(width: EditarUsuarioStyles.buttonSpacing), // Espacio entre botones
                        GestureDetector( // Botón Guardar cambios (clickeable)
                          onTap: _submit, // Al hacer clic, valida y guarda los cambios
                          child: Container( // Contenedor del botón
                            constraints: const BoxConstraints(minHeight: EditarUsuarioStyles.minButtonHeight), // Altura mínima
                            padding: EditarUsuarioStyles.submitButtonPadding, // Espaciado interno
                            decoration: EditarUsuarioStyles.submitButtonDecoration, // Estilo (fondo verde, bordes)
                            child: const Center( // Centra el texto
                              child: Text('Guardar cambios', style: EditarUsuarioStyles.submitButtonText), // Texto blanco
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
        }, // ← Cierra función builder de AnimatedBuilder
      ), // ← Cierra AnimatedBuilder
    ); // ← Cierra Material
  } // ← Cierra método build

  // ═══════════════════════════════════════════════════════════════════════════
  // MÉTODO HELPER: _buildGrid
  // Organiza los campos en grid responsive (2 columnas desktop, 1 columna móvil)
  // ═══════════════════════════════════════════════════════════════════════════
  Widget _buildGrid({required bool isMobile, required List<Widget> children}) {
    // ─── LAYOUT MÓVIL: Una sola columna ───
    if (isMobile) { // Si es vista móvil
      return Column( // Retorna columna simple
        crossAxisAlignment: CrossAxisAlignment.stretch, // Campos ocupan ancho completo
        children: children.map((w) => Padding( // Itera sobre cada campo
          padding: const EdgeInsets.only(bottom: EditarUsuarioStyles.fieldSpacing), // Espacio entre campos
          child: w) // El widget del campo
        ).toList(), // Convierte el iterable en lista
      );
    }
    
    // ─── LAYOUT DESKTOP: Grid de 2 columnas ───
    List<Widget> rows = []; // Lista para almacenar las filas del grid
    List<Widget> currentRow = []; // Almacena campos de la fila actual (máximo 2)
    
    for (int i = 0; i < children.length; i++) { // Itera sobre cada campo
      final child = children[i]; // Obtiene el campo actual
      // Verifica si el campo debe ocupar ancho completo (marcado con key='full')
      bool isFull = child is Container && child.key == const ValueKey('full');
      
      if (isFull) { // Si el campo es de ancho completo
        if (currentRow.isNotEmpty) { // Si hay campos en la fila actual
          // Agrega la fila actual al grid antes de agregar el campo completo
          rows.add(Row(crossAxisAlignment: CrossAxisAlignment.start, children: currentRow));
          rows.add(const SizedBox(height: EditarUsuarioStyles.fieldSpacing)); // Espaciado vertical
          currentRow = []; // Limpia la fila actual
        }
        rows.add(child); // Agrega el campo de ancho completo
        rows.add(const SizedBox(height: EditarUsuarioStyles.fieldSpacing)); // Espaciado después del campo
      } else { // Si el campo es de media columna
        currentRow.add(Expanded(child: child)); // Agrega campo a fila actual (Expanded reparte espacio equitativamente)
        if (currentRow.length == 2) { // Si ya hay 2 campos en la fila (fila completa)
          rows.add(Row( // Crea la fila
            crossAxisAlignment: CrossAxisAlignment.start, // Alinea campos al inicio verticalmente
            children: [currentRow[0], const SizedBox(width: EditarUsuarioStyles.columnSpacing), currentRow[1]], // Campo1 | Espacio | Campo2
          ));
          rows.add(const SizedBox(height: EditarUsuarioStyles.fieldSpacing)); // Espaciado vertical después de fila
          currentRow = []; // Limpia fila para siguiente iteración
        }
      }
    }
    
    // Si queda un campo sin pareja en la última fila
    if (currentRow.isNotEmpty) {
      rows.add(Row( // Crea fila con campo solo + espacio vacío
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [currentRow[0], const SizedBox(width: EditarUsuarioStyles.columnSpacing), Expanded(child: Container())], // Campo | Espacio | Vacío
      ));
    }
    
    return Column(crossAxisAlignment: CrossAxisAlignment.stretch, children: rows); // Retorna columna con todas las filas
  }

  // ═══════════════════════════════════════════════════════════════════════════
  // MÉTODO HELPER: _buildTextField
  // Construye un campo de texto con validación (nombre, correo, teléfono, etc.)
  // ═══════════════════════════════════════════════════════════════════════════
  Widget _buildTextField(String label, IconData icon, TextEditingController ctrl,
      {bool isFull = false, TextInputType? keyboardType, String? error, VoidCallback? onChanged}) {
    return Container( // Contenedor principal del campo
      key: isFull ? const ValueKey('full') : null, // Key para identificar campos de ancho completo
      constraints: const BoxConstraints(minHeight: EditarUsuarioStyles.minFieldHeight), // Altura mínima
      child: Column( // Columna vertical: label + input + error (si hay)
        crossAxisAlignment: CrossAxisAlignment.start, // Alinea contenido a la izquierda
        children: [
          Text(label, style: EditarUsuarioStyles.labelText), // Etiqueta del campo
          const SizedBox(height: EditarUsuarioStyles.labelSpacing), // Espacio entre label e input
          Container( // Contenedor del input con ícono
            height: EditarUsuarioStyles.inputHeight, // Altura fija del input
            decoration: error != null  // Cambia decoración si hay error
                ? EditarUsuarioStyles.inputErrorDecoration  // Borde rojo si hay error
                : EditarUsuarioStyles.inputDecoration, // Borde normal
            child: Row( // Fila horizontal: ícono + campo de texto
              children: [
                SizedBox( // Contenedor del ícono (ancho fijo)
                  width: EditarUsuarioStyles.iconContainerWidth,
                  child: Center(child: Icon(icon, color: EditarUsuarioStyles.iconColor, size: EditarUsuarioStyles.iconSize)),
                ),
                Expanded( // TextField ocupa espacio restante
                  child: TextField( // Campo de texto editable
                    controller: ctrl, // Controlador que maneja el texto
                    keyboardType: keyboardType, // Tipo de teclado (numérico para teléfono, etc.)
                    onChanged: onChanged != null ? (_) => onChanged() : null, // Ejecuta validación al escribir
                    decoration: const InputDecoration( // Configuración visual del input
                      border: InputBorder.none, // Sin borde (ya está en el Container)
                      contentPadding: EditarUsuarioStyles.inputContentPadding, // Padding interno del texto
                    ),
                    style: EditarUsuarioStyles.inputTextStyle, // Estilo del texto
                  ),
                ),
              ],
            ),
          ),
          if (error != null) ...[ // Si hay error, muestra mensaje (operador spread ...)
            const SizedBox(height: EditarUsuarioStyles.errorSpacing), // Espacio antes del mensaje
            Text(error, style: EditarUsuarioStyles.errorText), // Mensaje de error en rojo
          ],
        ],
      ),
    );
  }

  // ═══════════════════════════════════════════════════════════════════════════
  // MÉTODO HELPER: _buildPasswordField
  // Construye un campo de contraseña con toggle para mostrar/ocultar
  // ═══════════════════════════════════════════════════════════════════════════
  Widget _buildPasswordField(String label, TextEditingController ctrl, bool showPass, VoidCallback onToggle, {String? error, VoidCallback? onChanged}) {
    return Container( // Contenedor del campo
      constraints: const BoxConstraints(minHeight: EditarUsuarioStyles.minFieldHeight), // Altura mínima
      child: Column( // Organiza verticalmente: label + input + error
        crossAxisAlignment: CrossAxisAlignment.start, // Alinea a la izquierda
        children: [
          Text(label, style: EditarUsuarioStyles.labelText), // Etiqueta del campo
          const SizedBox(height: EditarUsuarioStyles.labelSpacing), // Espacio
          Container( // Contenedor del input
            height: EditarUsuarioStyles.inputHeight, // Altura fija
            decoration: error != null // Cambia estilo si hay error
                ? EditarUsuarioStyles.inputErrorDecoration // Borde rojo
                : EditarUsuarioStyles.inputDecoration, // Borde normal
            child: Row( // Fila: ícono candado + input + botón ojo
              children: [
                const SizedBox( // Contenedor del ícono candado
                  width: EditarUsuarioStyles.iconContainerWidth,
                  child: Center(child: Icon(Icons.lock, color: EditarUsuarioStyles.iconColor, size: EditarUsuarioStyles.iconSize)),
                ),
                Expanded( // Campo de texto (ocupa espacio disponible)
                  child: TextField(
                    controller: ctrl, // Controlador del campo
                    obscureText: !showPass, // Si showPass=false, oculta texto con •••
                    onChanged: onChanged != null ? (_) => onChanged() : null, // Valida al escribir
                    decoration: const InputDecoration( // Configuración del input
                      border: InputBorder.none, // Sin borde adicional
                      contentPadding: EditarUsuarioStyles.inputContentPadding, // Padding interno
                    ),
                    style: EditarUsuarioStyles.inputTextStyle, // Estilo del texto
                  ),
                ),
                GestureDetector( // Botón para mostrar/ocultar contraseña
                  onTap: onToggle, // Al tocar, cambia estado showPass
                  child: SizedBox( // Contenedor del ícono ojo
                    width: EditarUsuarioStyles.passwordToggleWidth, // Ancho fijo
                    child: Center(
                      child: Icon( // Ícono que cambia según estado
                        showPass ? Icons.visibility_off : Icons.visibility, // Ojo tachado o normal
                        color: PanelAdminStyles.darkGreen, // Color verde
                        size: EditarUsuarioStyles.passwordIconSize, // Tamaño del ícono
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ),
          if (error != null) ...[ // Muestra error si existe
            const SizedBox(height: EditarUsuarioStyles.errorSpacing), // Espacio
            Text(error, style: EditarUsuarioStyles.errorText), // Mensaje de error
          ],
        ],
      ),
    );
  }

  // ═══════════════════════════════════════════════════════════════════════════
  // MÉTODO HELPER: _buildRolField
  // Construye el campo de selección de rol con radio buttons
  // ═══════════════════════════════════════════════════════════════════════════
  Widget _buildRolField() {
    return Container( // Contenedor del campo de rol
      key: const ValueKey('full'), // Marca campo como ancho completo
      constraints: const BoxConstraints(minHeight: EditarUsuarioStyles.minFieldHeight), // Altura mínima
      child: Column( // Organiza verticalmente: label + radio buttons + error
        crossAxisAlignment: CrossAxisAlignment.start, // Alinea a la izquierda
        children: [
          const Text('Rol *', style: EditarUsuarioStyles.rolLabelText), // Etiqueta "Rol *" (asterisco indica requerido)
          const SizedBox(height: EditarUsuarioStyles.labelSpacing), // Espacio entre label y radios
          RadioGroup<RolUsuario?>( // Agrupa los radio buttons (maneja selección)
            groupValue: _rol, // Valor actualmente seleccionado
            onChanged: (v) => setState(() { // Cuando cambia la selección
              _rol = v; // Actualiza el rol seleccionado
              _rolError = null; // Limpia error al seleccionar
            }),
            child: Wrap( // Organiza radio buttons con wrap (se adapta al espacio disponible)
              spacing: EditarUsuarioStyles.rolSpacing, // Espacio horizontal entre opciones
              runSpacing: EditarUsuarioStyles.rolSpacing, // Espacio vertical si hace wrap
              children: [ // Opciones de rol
                _buildRadioOption(RolUsuario.admin), // Radio button para "Admin"
                _buildRadioOption(RolUsuario.agricultor), // Radio button para "Agricultor"
              ],
            ),
          ),
          if (_rolError != null) ...[ // Muestra error si no se seleccionó rol
            const SizedBox(height: EditarUsuarioStyles.errorSpacing), // Espacio antes del error
            Text(_rolError!, style: EditarUsuarioStyles.errorText), // Mensaje de error
          ],
        ],
      ),
    );
  }

  // ═══════════════════════════════════════════════════════════════════════════
  // MÉTODO HELPER: _buildRadioOption
  // Construye una opción de radio button individual (Admin o Agricultor)
  // ═══════════════════════════════════════════════════════════════════════════
  Widget _buildRadioOption(RolUsuario rol) {
    return GestureDetector( // Hace toda la tarjeta clickeable (no solo el radio)
      onTap: () => setState(() { // Al hacer clic en la tarjeta
        _rol = rol; // Selecciona este rol
        _rolError = null; // Limpia error
      }),
      child: Container( // Contenedor de la tarjeta del radio button
        height: EditarUsuarioStyles.rolOptionHeight, // Altura fija
        padding: EditarUsuarioStyles.rolOptionPadding, // Espaciado interno
        decoration: _rolError != null // Cambia decoración si hay error
            ? EditarUsuarioStyles.rolOptionErrorDecoration // Borde rojo
            : EditarUsuarioStyles.rolOptionDecoration, // Borde normal
        child: Row( // Fila horizontal: radio + texto
          mainAxisSize: MainAxisSize.min, // Ocupa solo espacio necesario
          children: [
            Radio<RolUsuario>( // Widget de radio button nativo de Flutter
              value: rol, // Valor que representa este radio (admin o agricultor)
              groupValue: _rol, // Valor actualmente seleccionado (para marcar/desmarcar)
              activeColor: EditarUsuarioStyles.radioActiveColor, // Color cuando está seleccionado
              onChanged: (v) => setState(() { // Callback cuando se selecciona
                _rol = v; // Actualiza rol seleccionado
                _rolError = null; // Limpia error
              }),
            ),
            const SizedBox(width: EditarUsuarioStyles.radioSpacing), // Espacio entre radio y texto
            Text(rol.label, style: EditarUsuarioStyles.rolOptionText), // Texto "Admin" o "Agricultor"
          ],
        ),
      ),
    );
  }
} // ← Cierra clase _EditarUsuarioState
