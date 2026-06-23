// ═══════════════════════════════════════════════════════════════════════════
// IMPORTACIONES
// ═══════════════════════════════════════════════════════════════════════════
import 'package:flutter/material.dart'; // Framework de Flutter para widgets
import '../../styles/admin-styles/panel-admin.dart'; // Estilos generales del panel admin
import '../../styles/admin-styles/modales-styles/registro-usuario.dart'; // Estilos específicos de este modal
import '../../environments/datos-simulados-admin.dart'; // Tipos de datos (UsuarioAdmin, RolUsuario)
import '../../shared/validators/modales-validaciones.dart'; // Validadores y mensajes de error

// ═══════════════════════════════════════════════════════════════════════════
// CLASE DE DATOS: DatosUsuario - Almacena información del usuario a registrar
// ═══════════════════════════════════════════════════════════════════════════
class DatosUsuario {
  final String nombre; // Nombre (opcional)
  final String segundoNombre; // Segundo nombre (opcional)
  final String apellido; // Apellido (opcional)
  final String segundoApellido; // Segundo apellido (opcional)
  final String correoCorporativo; // Correo corporativo (obligatorio)
  final String correoElectronico; // Correo personal Gmail (obligatorio)
  final String telefono; // Número telefónico (obligatorio)
  final String password; // Contraseña (obligatoria)
  final RolUsuario rol; // Rol del usuario (Admin o Agricultor) (obligatorio)

  DatosUsuario({
    required this.nombre,
    required this.segundoNombre,
    required this.apellido,
    required this.segundoApellido,
    required this.correoCorporativo,
    required this.correoElectronico,
    required this.telefono,
    required this.password,
    required this.rol,
  });
}

// ═══════════════════════════════════════════════════════════════════════════
// WIDGET PRINCIPAL DEL MODAL DE REGISTRO DE USUARIO (Editable con validación)
// Permite ingresar datos de un nuevo usuario y validarlos antes de guardar
// ═══════════════════════════════════════════════════════════════════════════
class RegistroUsuario extends StatefulWidget {
  final VoidCallback onCerrar; // Callback para cerrar el modal
  final void Function(DatosUsuario) onGuardar; // Callback para guardar el usuario

  const RegistroUsuario({
    super.key,
    required this.onCerrar, // Callback cerrar obligatorio
    required this.onGuardar, // Callback guardar obligatorio
  });

  @override
  State<RegistroUsuario> createState() => _RegistroUsuarioState();
}

// ═══════════════════════════════════════════════════════════════════════════
// ESTADO DEL MODAL DE REGISTRO (Editable con validación en tiempo real)
// SingleTickerProviderStateMixin: permite usar AnimationController
// ═══════════════════════════════════════════════════════════════════════════
class _RegistroUsuarioState extends State<RegistroUsuario> with SingleTickerProviderStateMixin {
  // ─── CONTROLADORES DE TEXTO (TextEditingController) - Manejan el input del usuario ───
  late final TextEditingController _nombreCtrl; // Controla campo "Nombre"
  late final TextEditingController _segundoNombreCtrl; // Controla campo "Segundo nombre"
  late final TextEditingController _apellidoCtrl; // Controla campo "Apellido"
  late final TextEditingController _segundoApellidoCtrl; // Controla campo "Segundo apellido"
  late final TextEditingController _correoCorpCtrl; // Controla campo "Correo corporativo"
  late final TextEditingController _correoElecCtrl; // Controla campo "Correo electrónico"
  late final TextEditingController _telefonoCtrl; // Controla campo "Teléfono"
  late final TextEditingController _passwordCtrl; // Controla campo "Contraseña"
  late final TextEditingController _confirmPassCtrl; // Controla campo "Confirmar contraseña"

  // ─── NODOS DE FOCO (FocusNode) - Detectan cuando un campo tiene foco ───
  final _nombreFocus = FocusNode();
  final _segundoNombreFocus = FocusNode();
  final _apellidoFocus = FocusNode();
  final _segundoApellidoFocus = FocusNode();
  final _correoCorpFocus = FocusNode();
  final _correoElecFocus = FocusNode();
  final _telefonoFocus = FocusNode();
  final _passwordFocus = FocusNode();
  final _confirmPassFocus = FocusNode();

  // ─── ESTADO DE FOCO (bool) - Indica si cada campo está enfocado ───
  bool _nombreFocused = false;
  bool _segundoNombreFocused = false;
  bool _apellidoFocused = false;
  bool _segundoApellidoFocused = false;
  bool _correoCorpFocused = false;
  bool _correoElecFocused = false;
  bool _telefonoFocused = false;
  bool _passwordFocused = false;
  bool _confirmPassFocused = false;

  // ─── ESTADO DE VISIBILIDAD DE CONTRASEÑAS ───
  bool _showPassword = false; // Si true, muestra contraseña (ícono ojo)
  bool _showConfirmPassword = false; // Si true, muestra confirmación de contraseña
  
  // ─── ESTADO DE ROL SELECCIONADO ───
  RolUsuario? _rol; // Rol seleccionado (Admin o Agricultor), null al inicio

  // ─── CONTROLADORES DE ANIMACIÓN ───
  late AnimationController _controller; // Controla el progreso de las animaciones (0.0 a 1.0)
  late Animation<double> _fadeAnimation; // Animación de fade-in para el fondo oscuro
  late Animation<Offset> _slideAnimation; // Animación de deslizamiento del modal desde abajo

  // ─── ERRORES DE VALIDACIÓN (String? = null si no hay error) ───
  String? _nombreError; // Error del campo "Nombre"
  String? _segundoNombreError; // Error del campo "Segundo nombre"
  String? _apellidoError; // Error del campo "Apellido"
  String? _segundoApellidoError; // Error del campo "Segundo apellido"
  String? _correoCorpError; // Error del campo "Correo corporativo"
  String? _correoElecError; // Error del campo "Correo electrónico"
  String? _telefonoError; // Error del campo "Teléfono"
  String? _passwordError; // Error del campo "Contraseña"
  String? _confirmPassError; // Error del campo "Confirmar contraseña"
  String? _rolError; // Error del campo "Rol"

  // ═══════════════════════════════════════════════════════════════════════════
  // INICIALIZACIÓN
  // ═══════════════════════════════════════════════════════════════════════════
  @override
  void initState() {
    super.initState(); // Llama al initState del padre
    
    // ─── Inicializa controladores de texto (vacíos al inicio) ───
    _nombreCtrl = TextEditingController();
    _segundoNombreCtrl = TextEditingController();
    _apellidoCtrl = TextEditingController();
    _segundoApellidoCtrl = TextEditingController();
    _correoCorpCtrl = TextEditingController();
    _correoElecCtrl = TextEditingController();
    _telefonoCtrl = TextEditingController();
    _passwordCtrl = TextEditingController();
    _confirmPassCtrl = TextEditingController();

    // ─── Agrega listeners para detectar cambios de foco ───
    _nombreFocus.addListener(() => setState(() => _nombreFocused = _nombreFocus.hasFocus));
    _segundoNombreFocus.addListener(() => setState(() => _segundoNombreFocused = _segundoNombreFocus.hasFocus));
    _apellidoFocus.addListener(() => setState(() => _apellidoFocused = _apellidoFocus.hasFocus));
    _segundoApellidoFocus.addListener(() => setState(() => _segundoApellidoFocused = _segundoApellidoFocus.hasFocus));
    _correoCorpFocus.addListener(() => setState(() => _correoCorpFocused = _correoCorpFocus.hasFocus));
    _correoElecFocus.addListener(() => setState(() => _correoElecFocused = _correoElecFocus.hasFocus));
    _telefonoFocus.addListener(() => setState(() => _telefonoFocused = _telefonoFocus.hasFocus));
    _passwordFocus.addListener(() => setState(() => _passwordFocused = _passwordFocus.hasFocus));
    _confirmPassFocus.addListener(() => setState(() => _confirmPassFocused = _confirmPassFocus.hasFocus));

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
    
    // ─── Libera FocusNodes ───
    _nombreFocus.dispose();
    _segundoNombreFocus.dispose();
    _apellidoFocus.dispose();
    _segundoApellidoFocus.dispose();
    _correoCorpFocus.dispose();
    _correoElecFocus.dispose();
    _telefonoFocus.dispose();
    _passwordFocus.dispose();
    _confirmPassFocus.dispose();
    
    super.dispose(); // Llama al dispose del padre
  }

  // ═══════════════════════════════════════════════════════════════════════════
  // MÉTODO DE VALIDACIÓN: _validarNombre - Valida campo "Nombre" (OPCIONAL)
  // ═══════════════════════════════════════════════════════════════════════════
  void _validarNombre() {
    final valor = _nombreCtrl.text.trim(); // Obtiene texto sin espacios al inicio/final
    setState(() { // Actualiza estado (reconstruye UI)
      // Nombre es opcional, pero si tiene valor debe ser válido (solo letras y espacios)
      if (valor.isNotEmpty && !ModalesValidaciones.nombrePattern.hasMatch(valor)) {
        _nombreError = ModalesValidaciones.mensajesError['nombrePattern']; // Asigna mensaje de error
      } else {
        _nombreError = null; // Sin error
      }
    });
  }

  // ═══════════════════════════════════════════════════════════════════════════
  // MÉTODO DE VALIDACIÓN: _validarSegundoNombre - Valida "Segundo nombre" (OPCIONAL)
  // ═══════════════════════════════════════════════════════════════════════════
  void _validarSegundoNombre() {
    final valor = _segundoNombreCtrl.text.trim(); // Obtiene texto sin espacios
    setState(() { // Actualiza estado
      // Segundo nombre es opcional, pero si tiene valor debe ser válido
      if (valor.isNotEmpty && !ModalesValidaciones.nombrePattern.hasMatch(valor)) {
        _segundoNombreError = ModalesValidaciones.mensajesError['nombrePattern']; // Error de patrón
      } else {
        _segundoNombreError = null; // Sin error
      }
    });
  }

  // ═══════════════════════════════════════════════════════════════════════════
  // MÉTODO DE VALIDACIÓN: _validarApellido - Valida "Apellido" (OPCIONAL)
  // ═══════════════════════════════════════════════════════════════════════════
  void _validarApellido() {
    final valor = _apellidoCtrl.text.trim(); // Obtiene texto sin espacios
    setState(() { // Actualiza estado
      // Apellido es opcional, pero si tiene valor debe ser válido
      if (valor.isNotEmpty && !ModalesValidaciones.nombrePattern.hasMatch(valor)) {
        _apellidoError = ModalesValidaciones.mensajesError['nombrePattern']; // Error de patrón
      } else {
        _apellidoError = null; // Sin error
      }
    });
  }

  // ═══════════════════════════════════════════════════════════════════════════
  // MÉTODO DE VALIDACIÓN: _validarSegundoApellido - Valida "Segundo apellido" (OPCIONAL)
  // ═══════════════════════════════════════════════════════════════════════════
  void _validarSegundoApellido() {
    final valor = _segundoApellidoCtrl.text.trim(); // Obtiene texto sin espacios
    setState(() { // Actualiza estado
      // Segundo apellido es opcional, pero si tiene valor debe ser válido
      if (valor.isNotEmpty && !ModalesValidaciones.nombrePattern.hasMatch(valor)) {
        _segundoApellidoError = ModalesValidaciones.mensajesError['nombrePattern']; // Error de patrón
      } else {
        _segundoApellidoError = null; // Sin error
      }
    });
  }

  // ═══════════════════════════════════════════════════════════════════════════
  // MÉTODO DE VALIDACIÓN: _validarCorreoCorporativo - Valida correo @agrovision.com (OBLIGATORIO)
  // ═══════════════════════════════════════════════════════════════════════════
  void _validarCorreoCorporativo() {
    final valor = _correoCorpCtrl.text.trim(); // Obtiene texto sin espacios
    setState(() { // Actualiza estado
      if (valor.isEmpty) { // Si está vacío
        _correoCorpError = ModalesValidaciones.mensajesError['correoCorporativoRequired']; // Error: campo obligatorio
      } else if (!ModalesValidaciones.correoCorporativoPattern.hasMatch(valor)) { // Si no coincide con patrón @agrovision.com
        _correoCorpError = ModalesValidaciones.mensajesError['correoCorporativoPattern']; // Error: formato inválido
      } else {
        _correoCorpError = null; // Sin error
      }
    });
  }

  // ═══════════════════════════════════════════════════════════════════════════
  // MÉTODO DE VALIDACIÓN: _validarCorreoElectronico - Valida correo @gmail.com (OBLIGATORIO)
  // ═══════════════════════════════════════════════════════════════════════════
  void _validarCorreoElectronico() {
    final valor = _correoElecCtrl.text.trim(); // Obtiene texto sin espacios
    setState(() { // Actualiza estado
      if (valor.isEmpty) { // Si está vacío
        _correoElecError = ModalesValidaciones.mensajesError['correoElectronicoRequired']; // Error: campo obligatorio
      } else if (!ModalesValidaciones.correoGmailPattern.hasMatch(valor)) { // Si no coincide con patrón @gmail.com
        _correoElecError = ModalesValidaciones.mensajesError['correoGmailPattern']; // Error: formato inválido
      } else {
        _correoElecError = null; // Sin error
      }
    });
  }

  // ═══════════════════════════════════════════════════════════════════════════
  // MÉTODO DE VALIDACIÓN: _validarTelefono - Valida teléfono de 10 dígitos (OBLIGATORIO)
  // ═══════════════════════════════════════════════════════════════════════════
  void _validarTelefono() {
    final valor = _telefonoCtrl.text.trim(); // Obtiene texto sin espacios
    setState(() { // Actualiza estado
      if (valor.isEmpty) { // Si está vacío
        _telefonoError = ModalesValidaciones.mensajesError['telefonoRequired']; // Error: campo obligatorio
      } else if (!ModalesValidaciones.telefonoPattern.hasMatch(valor)) { // Si no tiene exactamente 10 dígitos
        _telefonoError = ModalesValidaciones.mensajesError['telefonoPattern']; // Error: formato inválido
      } else {
        _telefonoError = null; // Sin error
      }
    });
  }

  // ═══════════════════════════════════════════════════════════════════════════
  // MÉTODO DE VALIDACIÓN: _validarPassword - Valida contraseña no vacía (OBLIGATORIO)
  // ═══════════════════════════════════════════════════════════════════════════
  void _validarPassword() {
    final valor = _passwordCtrl.text; // Obtiene texto (NO trim, contraseña puede tener espacios)
    setState(() { // Actualiza estado
      if (valor.isEmpty) { // Si está vacía
        _passwordError = ModalesValidaciones.mensajesError['passwordRequired']; // Error: campo obligatorio
      } else {
        _passwordError = null; // Sin error
      }
    });
  }

  // ═══════════════════════════════════════════════════════════════════════════
  // MÉTODO DE VALIDACIÓN: _validarConfirmPassword - Valida que contraseñas coincidan (OBLIGATORIO)
  // ═══════════════════════════════════════════════════════════════════════════
  void _validarConfirmPassword() {
    final valor = _confirmPassCtrl.text; // Obtiene texto (NO trim)
    setState(() { // Actualiza estado
      if (valor.isEmpty) { // Si está vacía
        _confirmPassError = ModalesValidaciones.mensajesError['confirmarPasswordRequired']; // Error: campo obligatorio
      } else if (valor != _passwordCtrl.text) { // Si no coincide con la contraseña
        _confirmPassError = ModalesValidaciones.mensajesError['passwordMismatch']; // Error: contraseñas no coinciden
      } else {
        _confirmPassError = null; // Sin error
      }
    });
  }

  // ═══════════════════════════════════════════════════════════════════════════
  // MÉTODO DE ENVÍO: _submit - Valida todos los campos y guarda si no hay errores
  // ═══════════════════════════════════════════════════════════════════════════
  void _submit() {
    // ─── FASE 1: Ejecutar todas las validaciones ───
    _validarNombre();
    _validarSegundoNombre();
    _validarApellido();
    _validarSegundoApellido();
    _validarCorreoCorporativo();
    _validarCorreoElectronico();
    _validarTelefono();
    _validarPassword();
    _validarConfirmPassword();

    // ─── FASE 2: Validar rol ───
    setState(() {
      if (_rol == null) { // Si no se seleccionó rol
        _rolError = ModalesValidaciones.mensajesError['required']; // Error: campo obligatorio
      } else {
        _rolError = null; // Sin error
      }
    });

    // ─── FASE 3: Verificar si hay errores ───
    if (_nombreError != null ||
        _segundoNombreError != null ||
        _apellidoError != null ||
        _segundoApellidoError != null ||
        _correoCorpError != null ||
        _correoElecError != null ||
        _telefonoError != null ||
        _passwordError != null ||
        _confirmPassError != null ||
        _rolError != null) {
      return; // Si hay errores, detiene el proceso (no guarda)
    }

    // ─── FASE 4: Sin errores, llama al callback onGuardar ───
    widget.onGuardar(DatosUsuario( // Crea objeto DatosUsuario con valores del formulario
      nombre: _nombreCtrl.text.trim(),
      segundoNombre: _segundoNombreCtrl.text.trim(),
      apellido: _apellidoCtrl.text.trim(),
      segundoApellido: _segundoApellidoCtrl.text.trim(),
      correoCorporativo: _correoCorpCtrl.text.trim(),
      correoElectronico: _correoElecCtrl.text.trim(),
      telefono: _telefonoCtrl.text.trim(),
      password: _passwordCtrl.text, // Contraseña sin trim
      rol: _rol!, // ! indica que _rol NO es null (ya validado)
    ));
  }

  // ═══════════════════════════════════════════════════════════════════════════
  // BUILD METHOD - Construye la interfaz del modal de registro (editable con validación)
  // ═══════════════════════════════════════════════════════════════════════════
  @override
  Widget build(BuildContext context) {
    // Determina si es vista móvil basado en el ancho de pantalla
    final bool isMobile = MediaQuery.of(context).size.width <= RegistroUsuarioStyles.mobileBreakpoint;

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
                color: RegistroUsuarioStyles.overlayColor.withValues( // Color verde oscuro semitransparente
                  alpha: RegistroUsuarioStyles.overlayColor.a * _fadeAnimation.value, // Opacidad animada
                ),
                child: Center( // Centra el modal en la pantalla
                  child: GestureDetector( // Detecta toques DENTRO del modal
                    onTap: () {}, // Toque vacío previene cerrar modal (detiene propagación)
                    child: Transform.translate( // Aplica transformación de posición
                      offset: _slideAnimation.value, // Desplaza verticalmente (slide animation)
                      child: Opacity( // Controla opacidad del modal
                        opacity: _controller.value, // Fade-in del modal card (0.0 a 1.0)
                        child: Container( // ← CONTENEDOR PRINCIPAL DEL MODAL (tarjeta blanca)
                          constraints: const BoxConstraints(maxWidth: RegistroUsuarioStyles.maxWidth), // Ancho máximo
                          margin: RegistroUsuarioStyles.modalMargin, // Márgen exterior
                          decoration: RegistroUsuarioStyles.modalDecoration, // Bordes, sombra, color
                          child: Column( // Columna: header + formulario + footer
                            mainAxisSize: MainAxisSize.min, // Ocupa solo espacio necesario
                            children: [ // ← Array de hijos
                  // ─────────────────────────────────────────────────
                  // HEADER - Título y botón cerrar
                  // ─────────────────────────────────────────────────
                  Padding( // Espaciado del header
                    padding: RegistroUsuarioStyles.headerPadding,
                    child: Row( // Fila horizontal para título y botón
                      children: [
                        const Expanded( // Título ocupa espacio disponible
                          child: Text('Registro de usuario', style: RegistroUsuarioStyles.titleText),
                        ),
                        GestureDetector( // Botón cerrar (X)
                          onTap: widget.onCerrar, // Cierra modal al tocar
                          child: Container( // Contenedor del botón
                            width: RegistroUsuarioStyles.closeButtonSize, // Ancho fijo
                            height: RegistroUsuarioStyles.closeButtonSize, // Alto fijo
                            decoration: RegistroUsuarioStyles.closeButtonDecoration, // Estilo circular
                            child: const Icon(Icons.close, // Icono X
                                color: RegistroUsuarioStyles.closeIconColor, // Color del icono
                                size: RegistroUsuarioStyles.closeIconSize), // Tamaño del icono
                          ),
                        ),
                      ],
                    ),
                  ),
                  const SizedBox(height: 22), // Espacio vertical entre header y formulario
                  // ─────────────────────────────────────────────────
                  // FORMULARIO - Campos editables con validación (scrolleable)
                  // ─────────────────────────────────────────────────
                  Flexible( // Permite que el contenido sea scrolleable
                    child: SingleChildScrollView( // Hace el contenido scrolleable
                      padding: RegistroUsuarioStyles.formPadding, // Espaciado interno
                      child: Column( // Columna para campos
                        children: [
                          _buildGrid( // Método helper que organiza campos en grid responsive
                            isMobile: isMobile, // Pasa si es vista móvil
                            children: [ // Lista de campos editables con validación
                              _buildTextField('Nombre', Icons.person, _nombreCtrl, // Campo "Nombre" (opcional)
                                error: _nombreError, onChanged: _validarNombre, focusNode: _nombreFocus, focused: _nombreFocused), // Validación en tiempo real
                              _buildTextField('Segundo nombre', Icons.person, _segundoNombreCtrl, // "Segundo nombre" (opcional)
                                error: _segundoNombreError, onChanged: _validarSegundoNombre, focusNode: _segundoNombreFocus, focused: _segundoNombreFocused),
                              _buildTextField('Apellido', Icons.person, _apellidoCtrl, // "Apellido" (opcional)
                                error: _apellidoError, onChanged: _validarApellido, focusNode: _apellidoFocus, focused: _apellidoFocused),
                              _buildTextField('Segundo apellido', Icons.person, _segundoApellidoCtrl, // "Segundo apellido" (opcional)
                                error: _segundoApellidoError, onChanged: _validarSegundoApellido, focusNode: _segundoApellidoFocus, focused: _segundoApellidoFocused),
                              _buildTextField('Correo corporativo *', Icons.email, _correoCorpCtrl, // "Correo corporativo" (OBLIGATORIO)
                                  isFull: true, placeholder: 'usuario@agrovision.com', // Ocupa ancho completo con placeholder
                                  error: _correoCorpError, onChanged: _validarCorreoCorporativo, focusNode: _correoCorpFocus, focused: _correoCorpFocused),
                              _buildTextField('Correo electronico *', Icons.email, _correoElecCtrl, // "Correo electrónico" (OBLIGATORIO)
                                  isFull: true, placeholder: 'usuario@gmail.com',
                                  error: _correoElecError, onChanged: _validarCorreoElectronico, focusNode: _correoElecFocus, focused: _correoElecFocused),
                              _buildTextField('Numero de telefono *', Icons.phone, _telefonoCtrl, // "Teléfono" (OBLIGATORIO)
                                  isFull: true, placeholder: '10 digitos', keyboardType: TextInputType.phone, // Teclado numérico
                                  error: _telefonoError, onChanged: _validarTelefono, focusNode: _telefonoFocus, focused: _telefonoFocused),
                              _buildPasswordField('Contraseña *', _passwordCtrl, _showPassword, () { // Campo contraseña con toggle visibilidad
                                setState(() => _showPassword = !_showPassword); // Alterna visibilidad
                              }, error: _passwordError, onChanged: _validarPassword, focusNode: _passwordFocus, focused: _passwordFocused),
                              _buildPasswordField('Confirmar contraseña *', _confirmPassCtrl, _showConfirmPassword, () { // Confirmación contraseña
                                setState(() => _showConfirmPassword = !_showConfirmPassword); // Alterna visibilidad
                              }, error: _confirmPassError, onChanged: _validarConfirmPassword, focusNode: _confirmPassFocus, focused: _confirmPassFocused),
                              _buildRolField(), // Campo rol (radio buttons: Admin / Agricultor)
                            ],
                          ),
                        ],
                      ),
                    ),
                  ),
                  // ─────────────────────────────────────────────────
                  // FOOTER - Botones Cancelar y Registrar
                  // ─────────────────────────────────────────────────
                  Padding( // Espaciado del footer
                    padding: RegistroUsuarioStyles.footerPadding,
                    child: Row( // Fila para botones
                      mainAxisAlignment: MainAxisAlignment.end, // Alinea botones a la derecha
                      children: [
                        GestureDetector( // Botón "Cancelar"
                          onTap: widget.onCerrar, // Cierra modal sin guardar
                          child: Container( // Contenedor del botón
                            constraints: const BoxConstraints(minHeight: RegistroUsuarioStyles.minButtonHeight), // Altura mínima
                            padding: RegistroUsuarioStyles.cancelButtonPadding, // Espaciado interno
                            decoration: RegistroUsuarioStyles.cancelButtonDecoration, // Estilo (fondo blanco, borde verde)
                            child: const Center( // Centra texto
                              child: Text('Cancelar', style: RegistroUsuarioStyles.cancelButtonText), // Texto verde
                            ),
                          ),
                        ),
                        const SizedBox(width: RegistroUsuarioStyles.buttonSpacing), // Espacio entre botones
                        GestureDetector( // Botón "Registrar usuario"
                          onTap: _submit, // Valida y guarda si no hay errores
                          child: Container( // Contenedor del botón
                            constraints: const BoxConstraints(minHeight: RegistroUsuarioStyles.minButtonHeight), // Altura mínima
                            padding: RegistroUsuarioStyles.submitButtonPadding, // Espaciado interno
                            decoration: RegistroUsuarioStyles.submitButtonDecoration, // Estilo (fondo verde)
                            child: const Center( // Centra texto
                              child: Text('Registrar usuario', style: RegistroUsuarioStyles.submitButtonText), // Texto blanco
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
          padding: const EdgeInsets.only(bottom: RegistroUsuarioStyles.fieldSpacing), // Espacio inferior
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
      
      if (isFull) { // ← Campo ocupa ancho completo (correos, teléfono, rol)
        if (currentRow.isNotEmpty) { // Si hay fila incompleta (1 elemento)
          rows.add(Row(crossAxisAlignment: CrossAxisAlignment.start, children: currentRow)); // Agrega fila incompleta
          rows.add(const SizedBox(height: RegistroUsuarioStyles.fieldSpacing)); // Espacio vertical
          currentRow = []; // Limpia fila actual
        }
        rows.add(child); // Agrega campo de ancho completo
        rows.add(const SizedBox(height: RegistroUsuarioStyles.fieldSpacing)); // Espacio vertical
      } else { // ← Campo normal (nombres, apellidos)
        currentRow.add(Expanded(child: child)); // Agrega campo a fila actual (Expanded divide espacio equitativamente)
        if (currentRow.length == 2) { // Si ya hay 2 elementos en la fila
          rows.add(Row( // Crea fila completa
            crossAxisAlignment: CrossAxisAlignment.start, // Alinea arriba
            children: [
              currentRow[0], // Campo izquierdo
              const SizedBox(width: RegistroUsuarioStyles.columnSpacing), // Espacio horizontal entre columnas
              currentRow[1], // Campo derecho
            ],
          ));
          rows.add(const SizedBox(height: RegistroUsuarioStyles.fieldSpacing)); // Espacio vertical
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
          const SizedBox(width: RegistroUsuarioStyles.columnSpacing), // Espacio entre columnas
          Expanded(child: Container()), // Espacio vacío a la derecha
        ],
      ));
    }
    return Column(crossAxisAlignment: CrossAxisAlignment.stretch, children: rows); // Retorna columna con todas las filas
  }

  // ═══════════════════════════════════════════════════════════════════════════
  // MÉTODO HELPER: _buildTextField - Construye campo de texto editable con validación
  // ═══════════════════════════════════════════════════════════════════════════
  Widget _buildTextField(String label, IconData icon, TextEditingController ctrl,
      {bool isFull = false, String placeholder = '', TextInputType? keyboardType, String? error, VoidCallback? onChanged, FocusNode? focusNode, bool focused = false}) {
    return Container( // Contenedor principal del campo
      key: isFull ? const ValueKey('full') : null, // Key 'full' indica ancho completo en grid
      constraints: const BoxConstraints(minHeight: RegistroUsuarioStyles.minFieldHeight), // Altura mínima
      child: Column( // Columna: label + input + mensaje de error (si hay)
        crossAxisAlignment: CrossAxisAlignment.start, // Alinea a la izquierda
        children: [
          Text(label, style: RegistroUsuarioStyles.labelText), // Label del campo (ej: "Nombre *")
          const SizedBox(height: RegistroUsuarioStyles.labelSpacing), // Espacio entre label e input
          Focus( // Envuelve en Focus para detectar cambios de foco
            onFocusChange: (focus) { // Callback cuando cambia el foco
              if (focusNode != null) {
                // El estado ya se maneja con el listener del FocusNode
              }
            },
            child: AnimatedContainer( // AnimatedContainer para transición suave
              duration: const Duration(milliseconds: 200), // Duración de la animación
              height: RegistroUsuarioStyles.inputHeight, // Altura fija del input
              decoration: error != null  // Cambia estilo si hay error
                  ? RegistroUsuarioStyles.inputErrorDecoration // Borde rojo si hay error
                  : RegistroUsuarioStyles.inputDecoration(focused: focused), // Borde normal con glow si focused
              child: Row( // Fila: icono + TextField
                children: [
                  SizedBox( // Contenedor del icono (ancho fijo)
                    width: RegistroUsuarioStyles.iconContainerWidth, // Ancho para centrar icono
                    child: Center(child: Icon(icon, // Icono del campo (person, email, phone)
                        color: RegistroUsuarioStyles.iconColor, // Color del icono
                        size: RegistroUsuarioStyles.iconSize)), // Tamaño del icono
                  ),
                  Expanded( // TextField ocupa espacio restante
                    child: TextField( // Campo de texto editable
                      controller: ctrl, // Controlador de texto
                      focusNode: focusNode, // Nodo de foco
                      keyboardType: keyboardType, // Tipo de teclado (text, phone, email)
                      onChanged: onChanged != null ? (_) => onChanged() : null, // Valida en tiempo real al escribir
                      decoration: InputDecoration( // Configuración del TextField
                        hintText: placeholder.isEmpty ? label : placeholder, // Placeholder (ej: "usuario@gmail.com")
                        hintStyle: RegistroUsuarioStyles.hintTextStyle, // Estilo del placeholder (gris)
                        border: InputBorder.none, // Sin borde (el borde lo tiene el Container)
                        contentPadding: RegistroUsuarioStyles.inputContentPadding, // Espaciado interno
                      ),
                      style: RegistroUsuarioStyles.inputTextStyle, // Estilo del texto escrito
                    ),
                  ),
                ],
              ),
            ),
          ),
          if (error != null) ...[ // Si hay error, muestra mensaje
            const SizedBox(height: RegistroUsuarioStyles.errorSpacing), // Espacio antes del mensaje
            Text(error, style: RegistroUsuarioStyles.errorText), // Mensaje de error (rojo)
          ],
        ],
      ),
    );
  }

  // ═══════════════════════════════════════════════════════════════════════════
  // MÉTODO HELPER: _buildPasswordField - Construye campo de contraseña con toggle visibilidad
  // ═══════════════════════════════════════════════════════════════════════════
  Widget _buildPasswordField(String label, TextEditingController ctrl, bool showPass, VoidCallback onToggle, {String? error, VoidCallback? onChanged, FocusNode? focusNode, bool focused = false}) {
    return Container( // Contenedor principal del campo
      constraints: const BoxConstraints(minHeight: RegistroUsuarioStyles.minFieldHeight), // Altura mínima
      child: Column( // Columna: label + input + mensaje de error (si hay)
        crossAxisAlignment: CrossAxisAlignment.start, // Alinea a la izquierda
        children: [
          Text(label, style: RegistroUsuarioStyles.labelText), // Label (ej: "Contraseña *")
          const SizedBox(height: RegistroUsuarioStyles.labelSpacing), // Espacio entre label e input
          Focus( // Envuelve en Focus para detectar cambios de foco
            onFocusChange: (focus) { // Callback cuando cambia el foco
              if (focusNode != null) {
                // El estado ya se maneja con el listener del FocusNode
              }
            },
            child: AnimatedContainer( // AnimatedContainer para transición suave
              duration: const Duration(milliseconds: 200), // Duración de la animación
              height: RegistroUsuarioStyles.inputHeight, // Altura fija
              decoration: error != null  // Cambia estilo si hay error
                  ? RegistroUsuarioStyles.inputErrorDecoration // Borde rojo si hay error
                  : RegistroUsuarioStyles.inputDecoration(focused: focused), // Borde normal con glow si focused
              child: Row( // Fila: icono candado + TextField + botón ojo
                children: [
                  const SizedBox( // Contenedor del icono candado
                    width: RegistroUsuarioStyles.iconContainerWidth, // Ancho fijo
                    child: Center(child: Icon(Icons.lock, // Icono de candado
                        color: RegistroUsuarioStyles.iconColor, // Color del icono
                        size: RegistroUsuarioStyles.iconSize)), // Tamaño del icono
                  ),
                  Expanded( // TextField ocupa espacio central
                    child: TextField( // Campo de texto para contraseña
                      controller: ctrl, // Controlador de texto
                      focusNode: focusNode, // Nodo de foco
                      obscureText: !showPass, // Oculta texto si showPass = false (muestra ••••)
                      onChanged: onChanged != null ? (_) => onChanged() : null, // Valida en tiempo real
                      decoration: const InputDecoration( // Configuración del TextField
                        hintText: 'Contraseña', // Placeholder
                        hintStyle: RegistroUsuarioStyles.hintTextStyle, // Estilo del placeholder (gris)
                        border: InputBorder.none, // Sin borde (el borde lo tiene el Container)
                        contentPadding: RegistroUsuarioStyles.inputContentPadding, // Espaciado interno
                      ),
                      style: RegistroUsuarioStyles.inputTextStyle, // Estilo del texto escrito
                    ),
                  ),
                  GestureDetector( // Botón toggle visibilidad (ojo)
                    onTap: onToggle, // Alterna entre mostrar/ocultar contraseña
                    child: SizedBox( // Contenedor del ícono ojo
                      width: RegistroUsuarioStyles.passwordToggleWidth, // Ancho del área tocable
                      child: Center( // Centra ícono
                        child: Icon( // Ícono de ojo
                          showPass ? Icons.visibility_off : Icons.visibility, // Cambia según estado
                          color: PanelAdminStyles.darkGreen, // Color verde
                          size: RegistroUsuarioStyles.passwordIconSize, // Tamaño del ícono
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
          if (error != null) ...[ // Si hay error, muestra mensaje
            const SizedBox(height: RegistroUsuarioStyles.errorSpacing), // Espacio antes del mensaje
            Text(error, style: RegistroUsuarioStyles.errorText), // Mensaje de error (rojo)
          ],
        ],
      ),
    );
  }

  // ═══════════════════════════════════════════════════════════════════════════
  // MÉTODO HELPER: _buildRolField - Construye campo de selección de rol (radio buttons)
  // ═══════════════════════════════════════════════════════════════════════════
  Widget _buildRolField() {
    return Container( // Contenedor principal
      key: const ValueKey('full'), // Ocupa ancho completo en grid
      constraints: const BoxConstraints(minHeight: RegistroUsuarioStyles.minFieldHeight), // Altura mínima
      child: Column( // Columna: label + radio buttons + mensaje de error (si hay)
        crossAxisAlignment: CrossAxisAlignment.start, // Alinea a la izquierda
        children: [
          const Text('Rol *', style: RegistroUsuarioStyles.rolLabelText), // Label (con asterisco = obligatorio)
          const SizedBox(height: RegistroUsuarioStyles.labelSpacing), // Espacio entre label y radios
          RadioGroup<RolUsuario?>( // Grupo de radio buttons (Flutter)
            groupValue: _rol, // Valor seleccionado actualmente (null al inicio)
            onChanged: (v) => setState(() { // Callback cuando cambia selección
              _rol = v; // Actualiza rol seleccionado
              _rolError = null; // Limpia error al seleccionar
            }),
            child: Wrap( // Wrap permite que radios se ajusten en múltiples líneas si es necesario
              spacing: RegistroUsuarioStyles.rolSpacing, // Espacio horizontal entre radios
              runSpacing: RegistroUsuarioStyles.rolSpacing, // Espacio vertical entre líneas
              children: [
                _buildRadioOption(RolUsuario.admin), // Opción "Admin"
                _buildRadioOption(RolUsuario.agricultor), // Opción "Agricultor"
              ],
            ),
          ),
          if (_rolError != null) ...[ // Si hay error, muestra mensaje
            const SizedBox(height: RegistroUsuarioStyles.errorSpacing), // Espacio antes del mensaje
            Text(_rolError!, style: RegistroUsuarioStyles.errorText), // Mensaje de error (rojo)
          ],
        ],
      ),
    );
  }

  // ═══════════════════════════════════════════════════════════════════════════
  // MÉTODO HELPER: _buildRadioOption - Construye un radio button de rol (clickeable)
  // ═══════════════════════════════════════════════════════════════════════════
  Widget _buildRadioOption(RolUsuario rol) {
    return GestureDetector( // Hace toda la opción clickeable (no solo el radio)
      onTap: () => setState(() { // Al tocar, actualiza estado
        _rol = rol; // Selecciona este rol
        _rolError = null; // Limpia error
      }),
      child: Container( // Contenedor de la opción de radio
        height: RegistroUsuarioStyles.rolOptionHeight, // Altura fija
        padding: RegistroUsuarioStyles.rolOptionPadding, // Espaciado interno
        decoration: _rolError != null  // Cambia estilo si hay error
            ? RegistroUsuarioStyles.rolOptionErrorDecoration // Borde rojo si hay error
            : RegistroUsuarioStyles.rolOptionDecoration, // Borde normal
        child: Row( // Fila: radio + label
          mainAxisSize: MainAxisSize.min, // Ocupa solo espacio necesario (no se expande)
          children: [
            Radio<RolUsuario>( // Widget de radio button
              value: rol, // Valor de esta opción (Admin o Agricultor)
              groupValue: _rol, // Valor seleccionado actualmente
              activeColor: RegistroUsuarioStyles.radioActiveColor, // Color cuando está seleccionado (verde)
              onChanged: (v) => setState(() { // Callback al cambiar
                _rol = v; // Actualiza rol
                _rolError = null; // Limpia error
              }),
            ),
            const SizedBox(width: RegistroUsuarioStyles.radioSpacing), // Espacio entre radio y texto
            Text(rol.label, style: RegistroUsuarioStyles.rolOptionText), // Texto del rol (ej: "Admin")
          ],
        ),
      ),
    );
  }
} // ← Cierra clase _RegistroUsuarioState
