// ═══════════════════════════════════════════════════════════════════════════
// RESTABLECER CONTRASEÑA - FLUJO COMPLETO DE RECUPERACIÓN
// ═══════════════════════════════════════════════════════════════════════════
// Componente maestro que orquesta el flujo completo de restablecimiento de
// contraseña mediante un wizard de 4 pasos secuenciales.
//
// Pasos del flujo:
// 1. 'correo': Ingreso del correo electrónico
// 2. 'codigo': Verificación del código de 6 dígitos
// 3. 'password': Creación de nueva contraseña
// 4. 'finalizado': Confirmación de cambio exitoso
//
// Características principales:
// - Navegación secuencial entre pasos
// - Validación de correo simulado (usuario@gmail.com)
// - Integración con componentes especializados
// - Animaciones independientes por paso
// - Callbacks para comunicación con componentes padre
// ═══════════════════════════════════════════════════════════════════════════

import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import '../app.dart';
import '../styles/autenticacion-styles/restablecer-password.dart';

/// Widget Stateful que maneja el flujo completo de restablecimiento
/// 
/// Parámetros requeridos:
/// - [volverLogin]: Callback para regresar a la pantalla de login
class RestablecerPassword extends StatefulWidget {
  final VoidCallback volverLogin;

  const RestablecerPassword({
    super.key,
    required this.volverLogin,
  });

  @override
  State<RestablecerPassword> createState() => _RestablecerPasswordState();
}

class _RestablecerPasswordState extends State<RestablecerPassword> with TickerProviderStateMixin {
  // ═══════════════════════════════════════════════════════════════════════════
  // CONTROLADORES Y ESTADO DEL FORMULARIO (PASO 1: CORREO)
  // ═══════════════════════════════════════════════════════════════════════════
  
  /// Clave global para validación del formulario de correo
  final _formKey = GlobalKey<FormState>();
  
  /// Controlador para el campo de correo electrónico
  final TextEditingController _emailController = TextEditingController();
  
  /// Mensaje de error general del proceso de restablecimiento
  String _resetError = '';
  
  /// Mensaje de error específico del campo de correo
  String? _emailErrorMsg;
  
  /// Indica si el campo de correo tiene foco
  bool _emailFocus = false;
  
  // ═══════════════════════════════════════════════════════════════════════════
  // VALIDACIÓN SIMULADA
  // ═══════════════════════════════════════════════════════════════════════════
  
  /// Correo simulado para pruebas (debe coincidir para avanzar)
  final String _correoSimulado = 'usuario@gmail.com';
  
  // ═══════════════════════════════════════════════════════════════════════════
  // CONTROLADORES Y ANIMACIONES (SOLO PARA PASO 1: CORREO)
  // ═══════════════════════════════════════════════════════════════════════════
  // Los otros pasos (codigo, password, finalizado) manejan sus propias animaciones
  // Sistema de animaciones fade-up con delays escalonados para 6 elementos:
  // 1. Logo (90ms)
  // 2. Título (190ms)
  // 3. Descripción (290ms)
  // 4. Campo correo (390ms)
  // 5. Botón enviar (490ms)
  // 6. Enlace regresar (590ms)
  
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

  /// Inicializa el sistema de animaciones fade-up escalonadas para el paso de correo
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
      final delayMs = RestablecerPasswordStyles.animationDelays[index];
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
      final delayMs = RestablecerPasswordStyles.animationDelays[index];
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
    // Libera recursos de animación y controladores
    _animationController.dispose();
    _emailController.dispose();
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
  // VALIDACIÓN DEL FORMULARIO
  // ═══════════════════════════════════════════════════════════════════════════
  
  /// Valida el campo de correo electrónico
  /// 
  /// Validaciones:
  /// 1. Verifica que no esté vacío
  /// 2. Verifica que contenga "@gmail.com"
  /// 
  /// Retorna [true] si es válido, [false] en caso contrario
  bool _validateFields() {
    bool isValid = true;
    final email = _emailController.text.trim();
    
    if (email.isEmpty) {
      _emailErrorMsg = 'El correo es requerido';
      isValid = false;
    } else if (!email.contains('@gmail.com')) {
      _emailErrorMsg = 'Debe ser un correo gmail válido';
      isValid = false;
    } else {
      _emailErrorMsg = null;
    }
    
    setState(() {});
    return isValid;
  }

  // ═══════════════════════════════════════════════════════════════════════════
  // NAVEGACIÓN ENTRE PASOS
  // ═══════════════════════════════════════════════════════════════════════════
  
  /// PASO 1 → PASO 2: Envía código de verificación y navega a la pantalla de código
  void _enviarCodigo() {
    setState(() {
      _resetError = '';
    });

    if (!_validateFields()) {
      return;
    }

    final correo = _emailController.text.trim();

    if (correo != _correoSimulado) {
      setState(() {
        _resetError = 'El correo no coincide con el usuario simulado.';
      });
      return;
    }

    Navigator.pushNamed(
      context,
      AppRoutes.codigoVerificacion,
      arguments: correo,
    );
  }

  @override
  Widget build(BuildContext context) {
    return _buildCorreoPaso();
  }

  // ═══════════════════════════════════════════════════════════════════════════
  // PASO 1: INGRESO DE CORREO ELECTRÓNICO
  // ═══════════════════════════════════════════════════════════════════════════
  
  /// Construye la interfaz del primer paso (ingreso de correo)
  /// 
  /// Elementos:
  /// - Logo
  /// - Título y descripción
  /// - Campo de correo con validación
  /// - Botón de enviar código
  /// - Enlace para regresar a login
  Widget _buildCorreoPaso() {
    return Column(
      key: const ValueKey('correo'), // Clave única para transiciones
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
                color: RestablecerPasswordStyles.primaryGreen,
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
            'Restablecer contrasena',
            textAlign: TextAlign.center,
            style: RestablecerPasswordStyles.heading1,
          ),
        ),
        const SizedBox(height: 14),
        
        // ═══════════════════════════════════════════════════════════════════════
        // ELEMENTO 3: Descripción (Delay 290ms)
        // ═══════════════════════════════════════════════════════════════════════
        _buildAnimatedWidget(
          index: 2,
          child: const Text(
            'Se enviara un codigo de verificacion a tu correo electronico.',
            textAlign: TextAlign.center,
            style: RestablecerPasswordStyles.description,
          ),
        ),
        const SizedBox(height: 24),

        // ═══════════════════════════════════════════════════════════════════════
        // FORMULARIO DE CORREO
        // ═══════════════════════════════════════════════════════════════════════
        Form(
          key: _formKey,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              // ═══════════════════════════════════════════════════════════════════
              // ELEMENTO 4: Campo de Correo (Delay 390ms)
              // ═══════════════════════════════════════════════════════════════════
              _buildAnimatedWidget(
                index: 3,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.stretch,
                  children: [
                    const Text('Correo electronico', style: RestablecerPasswordStyles.label),
                    const SizedBox(height: 8),
                    FocusScope(
                      child: Focus(
                        onFocusChange: (focus) => setState(() => _emailFocus = focus),
                        child: AnimatedContainer(
                          duration: RestablecerPasswordStyles.transitionDuration,
                          constraints: const BoxConstraints(minHeight: 54),
                          decoration: RestablecerPasswordStyles.inputDecoration(_emailFocus),
                          child: Row(
                            children: [
                              const SizedBox(
                                width: 52,
                                child: Center(
                                  child: FaIcon(
                                    FontAwesomeIcons.envelope,
                                    color: RestablecerPasswordStyles.primaryGreen,
                                    size: 20,
                                  ),
                                ),
                              ),
                              Expanded(
                                child: TextFormField(
                                  controller: _emailController,
                                  keyboardType: TextInputType.emailAddress,
                                  decoration: const InputDecoration(
                                    hintText: 'usuario@gmail.com',
                                    hintStyle: TextStyle(color: RestablecerPasswordStyles.placeholderGrey),
                                    border: InputBorder.none,
                                    isDense: true,
                                    contentPadding: EdgeInsets.symmetric(vertical: 16),
                                  ),
                                  onChanged: (val) {
                                    if (_emailErrorMsg != null) setState(() => _emailErrorMsg = null);
                                  },
                                ),
                              ),
                            ],
                          ),
                        ),
                      ),
                    ),
                    
                    if (_emailErrorMsg != null)
                      Padding(
                        padding: const EdgeInsets.only(top: 4, left: 4),
                        child: Text(_emailErrorMsg!, style: RestablecerPasswordStyles.errorText),
                      ),
                  ],
                ),
              ),
              
              // Mensaje de error general
              // ═══════════════════════════════════════════════════════════════════
              // ELEMENTO 5: Mensaje de Error (Delay 490ms)
              // ═══════════════════════════════════════════════════════════════════
              // Solo se muestra si hay un error de validación
              if (_resetError.isNotEmpty)
                _buildAnimatedWidget(
                  index: 4,
                  child: Padding(
                    padding: const EdgeInsets.only(top: 18),
                    child: Text(
                      _resetError,
                      textAlign: TextAlign.center,
                      style: RestablecerPasswordStyles.errorText,
                    ),
                  ),
                ),
              
              const SizedBox(height: 18),
              
              // ═══════════════════════════════════════════════════════════════════
              // ELEMENTO 5: Botón Enviar (Delay 490ms)
              // ═══════════════════════════════════════════════════════════════════
              _buildAnimatedWidget(
                index: 4,
                child: Container(
                  decoration: RestablecerPasswordStyles.buttonDecoration,
                  child: ElevatedButton(
                    onPressed: _enviarCodigo,
                    style: ElevatedButton.styleFrom(
                      backgroundColor: Colors.transparent,
                      shadowColor: Colors.transparent,
                      minimumSize: const Size(double.infinity, 54),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(8)
                      ),
                    ),
                    child: const Text(
                      'Enviar codigo',
                      style: TextStyle(
                        color: Colors.white,
                        fontSize: 16,
                        fontWeight: FontWeight.w800,
                      ),
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
        
        const SizedBox(height: 20),
        
        // ═══════════════════════════════════════════════════════════════════════
        // ELEMENTO 6: Enlace Regresar a Login (Delay 590ms)
        // ═══════════════════════════════════════════════════════════════════════
        _buildAnimatedWidget(
          index: 5,
          child: TextButton(
            onPressed: widget.volverLogin,
            child: const Text('Regresar a iniciar sesión', style: RestablecerPasswordStyles.resetLink),
          ),
        ),
      ],
    );
  }
}
