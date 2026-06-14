// ═══════════════════════════════════════════════════════════════════════════
// CAMBIAR CONTRASEÑA - PANTALLA DE RESTABLECIMIENTO DE CONTRASEÑA
// ═══════════════════════════════════════════════════════════════════════════
// Pantalla que permite al usuario establecer una nueva contraseña después de
// haber verificado su identidad mediante el código de verificación.
//
// Características principales:
// - Formulario con dos campos: nueva contraseña y confirmación
// - Validación de coincidencia entre ambas contraseñas
// - Toggle para mostrar/ocultar contraseñas
// - Animaciones fade-up escalonadas (6 elementos)
// - Validación en tiempo real
// - Integración con el flujo de restablecimiento de contraseña
// ═══════════════════════════════════════════════════════════════════════════

import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import '../styles/autenticacion-styles/cambiar-password.dart';

/// Widget Stateful que presenta el formulario de cambio de contraseña
/// 
/// Parámetros requeridos:
/// - [onPasswordCambiado]: Callback ejecutado cuando la contraseña se cambia exitosamente
/// 
/// Parámetros opcionales:
/// - [onVolverLogin]: Callback para regresar a la pantalla de login (opcional)
class CambiarPassword extends StatefulWidget {
  final VoidCallback onPasswordCambiado;
  final VoidCallback? onVolverLogin;

  const CambiarPassword({
    super.key,
    required this.onPasswordCambiado,
    this.onVolverLogin,
  });

  @override
  State<CambiarPassword> createState() => _CambiarPasswordState();
}

class _CambiarPasswordState extends State<CambiarPassword> with TickerProviderStateMixin {
  // ═══════════════════════════════════════════════════════════════════════════
  // CONTROLADORES Y ESTADO DEL FORMULARIO
  // ═══════════════════════════════════════════════════════════════════════════
  
  /// Clave global para validación del formulario
  final _formKey = GlobalKey<FormState>();
  
  /// Controlador para el campo de nueva contraseña
  final TextEditingController _passwordController = TextEditingController();
  
  /// Controlador para el campo de confirmación de contraseña
  final TextEditingController _confirmPasswordController = TextEditingController();

  // ═══════════════════════════════════════════════════════════════════════════
  // ESTADO DE VISIBILIDAD DE CONTRASEÑAS
  // ═══════════════════════════════════════════════════════════════════════════
  
  /// Controla si la nueva contraseña es visible (true) u oculta (false)
  bool _showPassword = false;
  
  /// Controla si la confirmación de contraseña es visible (true) u oculta (false)
  bool _showConfirmPassword = false;

  // ═══════════════════════════════════════════════════════════════════════════
  // ESTADO DE FOCO DE CAMPOS
  // ═══════════════════════════════════════════════════════════════════════════
  
  /// Indica si el campo de nueva contraseña tiene foco
  bool _passwordFocus = false;
  
  /// Indica si el campo de confirmación tiene foco
  bool _confirmPasswordFocus = false;

  // ═══════════════════════════════════════════════════════════════════════════
  // MENSAJES DE ERROR
  // ═══════════════════════════════════════════════════════════════════════════
  
  /// Mensaje de error para el campo de nueva contraseña
  String? _passwordErrorMsg;
  
  /// Mensaje de error para el campo de confirmación
  String? _confirmErrorMsg;
  
  // ═══════════════════════════════════════════════════════════════════════════
  // CONTROLADORES Y ANIMACIONES
  // ═══════════════════════════════════════════════════════════════════════════
  // Sistema de animaciones fade-up con delays escalonados para 6 elementos:
  // 1. Logo (90ms)
  // 2. Título (190ms)
  // 3. Descripción (290ms)
  // 4. Campo nueva contraseña (390ms)
  // 5. Campo confirmación (490ms)
  // 6. Botón confirmar y enlace (590ms)
  
  /// Controlador principal de animaciones (duración total: 1310ms)
  late AnimationController _animationController;
  
  /// Lista de animaciones de opacidad (fade-in) para cada elemento
  late List<Animation<double>> _fadeAnimations;
  
  /// Lista de animaciones de desplazamiento (slide-up) para cada elemento
  late List<Animation<Offset>> _slideAnimations;

  // ═══════════════════════════════════════════════════════════════════════════
  // CICLO DE VIDA DEL WIDGET
  // ═══════════════════════════════════════════════════════════════════════════
  
  @override
  void initState() {
    super.initState();
    _initializeAnimations();
  }

  /// Inicializa el sistema de animaciones fade-up escalonadas
  /// 
  /// Proceso:
  /// 1. Crea el AnimationController con duración total de 1310ms
  /// 2. Genera 6 animaciones de fade (opacidad 0 → 1)
  /// 3. Genera 6 animaciones de slide (offset 0.34 → 0)
  /// 4. Cada animación tiene su propio delay y usa Interval para timing
  /// 5. Inicia todas las animaciones automáticamente
  void _initializeAnimations() {
    // Duración total: 590ms (último delay) + 720ms (duración animación) = 1310ms
    _animationController = AnimationController(
      duration: const Duration(milliseconds: 1310),
      vsync: this,
    );

    // Genera animaciones de fade-in para cada uno de los 6 elementos
    _fadeAnimations = List.generate(6, (index) {
      final delayMs = CambiarPasswordStyles.animationDelays[index];
      final startFraction = delayMs / 1310.0;
      final endFraction = (delayMs + 720) / 1310.0;

      return Tween<double>(begin: 0.0, end: 1.0).animate(
        CurvedAnimation(
          parent: _animationController,
          curve: Interval(
            startFraction,
            endFraction.clamp(0.0, 1.0),
            curve: Curves.easeOut,
          ),
        ),
      );
    });

    // Genera animaciones de slide-up para cada uno de los 6 elementos
    _slideAnimations = List.generate(6, (index) {
      final delayMs = CambiarPasswordStyles.animationDelays[index];
      final startFraction = delayMs / 1310.0;
      final endFraction = (delayMs + 720) / 1310.0;

      return Tween<Offset>(begin: const Offset(0, 0.34), end: Offset.zero).animate(
        CurvedAnimation(
          parent: _animationController,
          curve: Interval(
            startFraction,
            endFraction.clamp(0.0, 1.0),
            curve: Curves.easeOut,
          ),
        ),
      );
    });

    // Inicia las animaciones automáticamente
    _animationController.forward();
  }

  @override
  void dispose() {
    // Libera recursos de animación y controladores de texto
    _animationController.dispose();
    _passwordController.dispose();
    _confirmPasswordController.dispose();
    super.dispose();
  }
  
  // ═══════════════════════════════════════════════════════════════════════════
  // BUILDER DE ANIMACIONES
  // ═══════════════════════════════════════════════════════════════════════════
  
  /// Construye un widget con animaciones de fade y slide aplicadas
  /// 
  /// Parámetros:
  /// - [index]: Índice del elemento (0-5) que determina qué animación usar
  /// - [child]: Widget hijo que se animará
  Widget _buildAnimatedWidget({
    required int index,
    required Widget child,
  }) {
    return FadeTransition(
      opacity: _fadeAnimations[index],
      child: SlideTransition(
        position: _slideAnimations[index],
        child: child,
      ),
    );
  }

  // ═══════════════════════════════════════════════════════════════════════════
  // MÉTODOS DE VALIDACIÓN
  // ═══════════════════════════════════════════════════════════════════════════
  
  /// Valida los campos del formulario de cambio de contraseña
  /// 
  /// Validaciones aplicadas:
  /// 1. Nueva contraseña: verifica que no esté vacía
  /// 2. Confirmación: verifica que no esté vacía
  /// 3. Coincidencia: verifica que ambas contraseñas sean idénticas
  /// 
  /// Retorna [true] si todos los campos son válidos, [false] en caso contrario
  bool _validateFields() {
    bool isValid = true;
    final password = _passwordController.text;
    
    // Validación de nueva contraseña
    if (password.isEmpty) {
      _passwordErrorMsg = 'La contraseña es requerida';
      isValid = false;
    } else {
      _passwordErrorMsg = null;
    }

    final confirm = _confirmPasswordController.text;
    
    // Validación de confirmación de contraseña
    if (confirm.isEmpty) {
      _confirmErrorMsg = 'Confirmar contraseña es requerido';
      isValid = false;
    } else if (confirm != password) {
      // Validación de coincidencia entre ambas contraseñas
      _confirmErrorMsg = 'Las contraseñas no coinciden';
      isValid = false;
    } else {
      _confirmErrorMsg = null;
    }

    // Actualiza el estado para mostrar mensajes de error
    setState(() {});
    return isValid;
  }

  // ═══════════════════════════════════════════════════════════════════════════
  // ACCIONES DEL USUARIO
  // ═══════════════════════════════════════════════════════════════════════════
  
  /// Maneja la confirmación de la nueva contraseña
  /// 
  /// Flujo:
  /// 1. Valida los campos del formulario
  /// 2. Si hay errores, detiene el proceso
  /// 3. Si es válido, ejecuta el callback onPasswordCambiado
  void _confirmarPassword() {
    if (!_validateFields()) {
      return;
    }

    // Notifica al componente padre que la contraseña fue cambiada exitosamente
    widget.onPasswordCambiado();
  }

  // ═══════════════════════════════════════════════════════════════════════════
  // CONSTRUCCIÓN DE LA INTERFAZ
  // ═══════════════════════════════════════════════════════════════════════════
  
  @override
  Widget build(BuildContext context) {
    return Column(
      key: const ValueKey('password'), // Clave única para transiciones
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: [
        // ═══════════════════════════════════════════════════════════════════════
        // ELEMENTO 1: Logo (Delay 90ms)
        // ═══════════════════════════════════════════════════════════════════════
        _buildAnimatedWidget(
          index: 0,
          child: Center(
            child: Image.asset(
              'assets/logotipos/escudo.png',
              height: 140,
              errorBuilder: (context, error, stackTrace) => const FaIcon(
                FontAwesomeIcons.shield,
                size: 140,
                color: CambiarPasswordStyles.primaryGreen,
              ),
            ),
          ),
        ),
        const SizedBox(height: 26),

        // ═══════════════════════════════════════════════════════════════════════
        // ELEMENTO 2: Título (Delay 190ms)
        // ═══════════════════════════════════════════════════════════════════════
        _buildAnimatedWidget(
          index: 1,
          child: const Text(
            'Cambiar contrasena',
            textAlign: TextAlign.center,
            style: CambiarPasswordStyles.heading1,
          ),
        ),
        const SizedBox(height: 14),

        // ═══════════════════════════════════════════════════════════════════════
        // ELEMENTO 3: Descripción (Delay 290ms)
        // ═══════════════════════════════════════════════════════════════════════
        _buildAnimatedWidget(
          index: 2,
          child: const Text(
            'Crea una nueva contrasena y confirmala para finalizar.',
            textAlign: TextAlign.center,
            style: CambiarPasswordStyles.description,
          ),
        ),
        const SizedBox(height: 24),

        // ═══════════════════════════════════════════════════════════════════════
        // FORMULARIO PRINCIPAL
        // ═══════════════════════════════════════════════════════════════════════
        Form(
          key: _formKey,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              // ═══════════════════════════════════════════════════════════════════
              // ELEMENTO 4: Campo Nueva Contraseña (Delay 390ms)
              // ═══════════════════════════════════════════════════════════════════
              // Campo de texto para ingresar la nueva contraseña
              // - Icono de candado decorativo
              // - Botón para mostrar/ocultar la contraseña
              // - Validación en tiempo real
              // - Mensaje de error dinámico
              _buildAnimatedWidget(
                index: 3,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.stretch,
                  children: [
                    const Text('Nueva contrasena', style: CambiarPasswordStyles.label),
                    const SizedBox(height: 8),

                    FocusScope(
                      child: Focus(
                        onFocusChange: (focus) => setState(() => _passwordFocus = focus),
                        child: AnimatedContainer(
                          duration: CambiarPasswordStyles.transitionDuration,
                          constraints: const BoxConstraints(minHeight: 54),
                          decoration: CambiarPasswordStyles.inputDecoration(_passwordFocus),
                          child: Row(
                            children: [
                              const SizedBox(
                                width: 52,
                                child: Center(
                                  child: FaIcon(
                                    FontAwesomeIcons.lock,
                                    color: CambiarPasswordStyles.primaryGreen,
                                    size: 20,
                                  ),
                                ),
                              ),
                              Expanded(
                                child: TextFormField(
                                  controller: _passwordController,
                                  obscureText: !_showPassword,
                                  decoration: const InputDecoration(
                                    hintText: 'Nueva contrasena',
                                    hintStyle: TextStyle(color: CambiarPasswordStyles.placeholderGrey),
                                    border: InputBorder.none,
                                    isDense: true,
                                    contentPadding: EdgeInsets.symmetric(vertical: 16),
                                  ),
                                  onChanged: (val) {
                                    if (_passwordErrorMsg != null) setState(() => _passwordErrorMsg = null);
                                  },
                                ),
                              ),
                              IconButton(
                                icon: FaIcon(
                                  _showPassword ? FontAwesomeIcons.eyeSlash : FontAwesomeIcons.eye,
                                  color: CambiarPasswordStyles.darkGreen,
                                  size: 18,
                                ),
                                onPressed: () {
                                  setState(() {
                                    _showPassword = !_showPassword;
                                  });
                                },
                              ),
                            ],
                          ),
                        ),
                      ),
                    ),
                    
                    if (_passwordErrorMsg != null)
                      Padding(
                        padding: const EdgeInsets.only(top: 4, left: 4),
                        child: Text(_passwordErrorMsg!, style: CambiarPasswordStyles.errorText),
                      ),
                  ],
                ),
              ),
                
              const SizedBox(height: 18),

              // ═══════════════════════════════════════════════════════════════════
              // ELEMENTO 5: Campo Confirmar Contraseña (Delay 490ms)
              // ═══════════════════════════════════════════════════════════════════
              // Campo de texto para confirmar la nueva contraseña
              // - Icono de escudo decorativo
              // - Botón para mostrar/ocultar la contraseña
              // - Validación de coincidencia con el campo anterior
              // - Mensaje de error si las contraseñas no coinciden
              _buildAnimatedWidget(
                index: 4,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.stretch,
                  children: [
                    const Text('Confirmar contrasena', style: CambiarPasswordStyles.label),
                    const SizedBox(height: 8),

                    FocusScope(
                      child: Focus(
                        onFocusChange: (focus) => setState(() => _confirmPasswordFocus = focus),
                        child: AnimatedContainer(
                          duration: CambiarPasswordStyles.transitionDuration,
                          constraints: const BoxConstraints(minHeight: 54),
                          decoration: CambiarPasswordStyles.inputDecoration(_confirmPasswordFocus),
                          child: Row(
                            children: [
                              const SizedBox(
                                width: 52,
                                child: Center(
                                  child: FaIcon(
                                    FontAwesomeIcons.shieldHalved,
                                    color: CambiarPasswordStyles.primaryGreen,
                                    size: 20,
                                  ),
                                ),
                              ),
                              Expanded(
                                child: TextFormField(
                                  controller: _confirmPasswordController,
                                  obscureText: !_showConfirmPassword,
                                  decoration: const InputDecoration(
                                    hintText: 'Confirma tu contrasena',
                                    hintStyle: TextStyle(color: CambiarPasswordStyles.placeholderGrey),
                                    border: InputBorder.none,
                                    isDense: true,
                                    contentPadding: EdgeInsets.symmetric(vertical: 16),
                                  ),
                                  onChanged: (val) {
                                    if (_confirmErrorMsg != null) setState(() => _confirmErrorMsg = null);
                                  },
                                ),
                              ),
                              IconButton(
                                icon: FaIcon(
                                  _showConfirmPassword ? FontAwesomeIcons.eyeSlash : FontAwesomeIcons.eye,
                                  color: CambiarPasswordStyles.darkGreen,
                                  size: 18,
                                ),
                                onPressed: () {
                                  setState(() {
                                    _showConfirmPassword = !_showConfirmPassword;
                                  });
                                },
                              ),
                            ],
                          ),
                        ),
                      ),
                    ),
                    
                    if (_confirmErrorMsg != null)
                      Padding(
                        padding: const EdgeInsets.only(top: 4, left: 4),
                        child: Text(_confirmErrorMsg!, style: CambiarPasswordStyles.errorText),
                      ),
                  ],
                ),
              ),
                
              const SizedBox(height: 28),

              // ═══════════════════════════════════════════════════════════════════
              // ELEMENTO 6: Botón Confirmar y Enlace (Delay 590ms)
              // ═══════════════════════════════════════════════════════════════════
              // - Botón principal para confirmar el cambio de contraseña
              // - Enlace opcional para regresar a login (si está disponible)
              _buildAnimatedWidget(
                index: 5,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.stretch,
                  children: [
                    Container(
                      decoration: CambiarPasswordStyles.buttonDecoration,
                      child: ElevatedButton(
                        onPressed: _confirmarPassword,
                        style: ElevatedButton.styleFrom(
                          backgroundColor: Colors.transparent,
                          shadowColor: Colors.transparent,
                          minimumSize: const Size(double.infinity, 54),
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(8)
                          ),
                        ),
                        child: const Text(
                          'Confirmar contrasena',
                          style: TextStyle(
                            color: Colors.white,
                            fontSize: 16,
                            fontWeight: FontWeight.w800,
                          ),
                        ),
                      ),
                    ),
                    
                    // Enlace opcional para regresar a la pantalla de login
                    // Solo se muestra si se proporcionó el callback onVolverLogin
                    if (widget.onVolverLogin != null) ...[
                      const SizedBox(height: 20),
                      TextButton(
                        onPressed: widget.onVolverLogin,
                        style: TextButton.styleFrom(
                          foregroundColor: CambiarPasswordStyles.linkGreen,
                        ),
                        child: const Text(
                          'Regresar a iniciar sesión',
                          style: CambiarPasswordStyles.changeLink,
                        ),
                      ),
                    ],
                  ],
                ),
              ),
            ],
          ),
        ),
      ],
    );
  }
}
