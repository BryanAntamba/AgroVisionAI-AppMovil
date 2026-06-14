// ═══════════════════════════════════════════════════════════════════════════
// CÓDIGO DE VERIFICACIÓN - VALIDACIÓN DE IDENTIDAD POR EMAIL
// ═══════════════════════════════════════════════════════════════════════════
// Pantalla que solicita un código de verificación de 6 dígitos enviado al
// correo electrónico del usuario durante el proceso de restablecimiento.
//
// Características principales:
// - Campo numérico de 6 dígitos con formato centrado
// - Sistema de reenvío limitado: 5 intentos gratuitos
// - Countdown de 15 minutos después de alcanzar el límite
// - Opción para cambiar el correo electrónico
// - Animaciones fade-up escalonadas (6 elementos)
// - Validación en tiempo real del código
// ═══════════════════════════════════════════════════════════════════════════

import 'dart:async';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import '../styles/autenticacion-styles/codigo-verificacion.dart';

/// Widget Stateful que presenta el formulario de verificación por código
/// 
/// Parámetros requeridos:
/// - [correo]: Dirección de correo donde se envió el código
/// - [onCodigoVerificado]: Callback ejecutado cuando el código es verificado
/// - [onReenviarCodigo]: Callback ejecutado para reenviar el código
/// 
/// Parámetros opcionales:
/// - [onCambiarCorreo]: Callback para cambiar el correo electrónico
/// - [onVolverLogin]: Callback para regresar a la pantalla de login
class CodigoVerificacion extends StatefulWidget {
  final String correo;
  final VoidCallback onCodigoVerificado;
  final VoidCallback onReenviarCodigo;
  final VoidCallback? onCambiarCorreo;
  final VoidCallback? onVolverLogin;

  const CodigoVerificacion({
    super.key,
    required this.correo,
    required this.onCodigoVerificado,
    required this.onReenviarCodigo,
    this.onCambiarCorreo,
    this.onVolverLogin,
  });

  @override
  State<CodigoVerificacion> createState() => _CodigoVerificacionState();
}

class _CodigoVerificacionState extends State<CodigoVerificacion> with TickerProviderStateMixin {
  // ═══════════════════════════════════════════════════════════════════════════
  // CONTROLADORES Y ESTADO DEL FORMULARIO
  // ═══════════════════════════════════════════════════════════════════════════
  
  /// Clave global para validación del formulario
  final _formKey = GlobalKey<FormState>();
  
  /// Controlador para el campo de código de 6 dígitos
  final TextEditingController _codigoController = TextEditingController();
  
  /// Indica si el campo de código tiene foco
  bool _isFocused = false;
  
  /// Mensaje de error para validación del código
  String? _codigoErrorMsg;

  // ═══════════════════════════════════════════════════════════════════════════
  // SISTEMA DE REENVÍO DE CÓDIGO
  // ═══════════════════════════════════════════════════════════════════════════
  
  /// Mensaje de feedback al usuario sobre el reenvío (vacío, éxito o error)
  String _mensajeReenvio = '';
  
  /// Contador de intentos de reenvío (máximo 5 antes del countdown)
  int _intentosReenvio = 0;
  
  /// Indica si se alcanzó el límite de reenvíos (activa countdown de 15 min)
  bool _limiteReenvioAlcanzado = false;

  // ═══════════════════════════════════════════════════════════════════════════
  // SISTEMA DE COUNTDOWN
  // ═══════════════════════════════════════════════════════════════════════════
  
  /// Tiempo restante en segundos para poder reenviar nuevamente (15 min = 900s)
  int _tiempoRestante = 0;
  
  /// Timer que actualiza el countdown cada segundo
  Timer? _intervaloCountdown;
  
  // ═══════════════════════════════════════════════════════════════════════════
  // CONTROLADORES Y ANIMACIONES
  // ═══════════════════════════════════════════════════════════════════════════
  // Sistema de animaciones fade-up con delays escalonados para 6 elementos:
  // 1. Logo (90ms)
  // 2. Título (190ms)
  // 3. Descripción (290ms)
  // 4. Campo código (390ms)
  // 5. Botón verificar (490ms)
  // 6. Sección reenvío (590ms)
  
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
      final delayMs = CodigoVerificacionStyles.animationDelays[index];
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
      final delayMs = CodigoVerificacionStyles.animationDelays[index];
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
    // Libera recursos de animación, controladores y timer
    _animationController.dispose();
    _codigoController.dispose();
    _detenerCountdown();
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
  // GESTIÓN DEL COUNTDOWN
  // ═══════════════════════════════════════════════════════════════════════════
  
  /// Detiene y cancela el timer del countdown
  void _detenerCountdown() {
    _intervaloCountdown?.cancel();
    _intervaloCountdown = null;
  }

  /// Formatea el tiempo restante en formato MM:SS
  /// 
  /// Ejemplo: 905 segundos → "15:05"
  String get _tiempoFormateado {
    final minutos = (_tiempoRestante / 60).floor();
    final segundos = _tiempoRestante % 60;
    return '$minutos:${segundos.toString().padLeft(2, '0')}';
  }

  // ═══════════════════════════════════════════════════════════════════════════
  // NORMALIZACIÓN Y VALIDACIÓN
  // ═══════════════════════════════════════════════════════════════════════════
  
  /// Limpia errores y mensajes al escribir en el campo de código
  /// 
  /// Se ejecuta en cada cambio del TextField
  void _normalizarCodigo(String value) {
    setState(() {
      if (_codigoErrorMsg != null) _codigoErrorMsg = null;
      _mensajeReenvio = '';
      _limiteReenvioAlcanzado = false;
    });
  }

  /// Valida el campo de código de verificación
  /// 
  /// Validaciones:
  /// 1. Verifica que no esté vacío
  /// 2. Verifica que tenga exactamente 6 dígitos
  /// 
  /// Retorna [true] si es válido, [false] en caso contrario
  bool _validateFields() {
    bool isValid = true;
    final value = _codigoController.text;
    
    if (value.isEmpty) {
      _codigoErrorMsg = 'El código es requerido';
      isValid = false;
    } else if (value.length < 6) {
      _codigoErrorMsg = 'El código debe tener 6 dígitos';
      isValid = false;
    } else {
      _codigoErrorMsg = null;
    }
    
    setState(() {});
    return isValid;
  }

  // ═══════════════════════════════════════════════════════════════════════════
  // ACCIONES DEL USUARIO
  // ═══════════════════════════════════════════════════════════════════════════
  
  /// Verifica el código ingresado por el usuario
  /// 
  /// Flujo:
  /// 1. Valida el formato del código (6 dígitos)
  /// 2. Si hay errores, detiene el proceso
  /// 3. Si es válido, ejecuta el callback onCodigoVerificado
  void _verificarCodigo() {
    if (!_validateFields()) {
      return;
    }
    
    // Notifica al componente padre que el código fue verificado
    widget.onCodigoVerificado();
  }

  /// Solicita el reenvío del código de verificación
  /// 
  /// Sistema de límites:
  /// - Permite 5 reenvíos gratuitos
  /// - Después del 5to intento, activa countdown de 15 minutos
  /// - Durante el countdown, el botón de reenvío se deshabilita
  void _solicitarReenvio() {
    // Verifica si aún hay reenvíos disponibles (< 5 intentos)
    bool puedeReenviar = _intentosReenvio < 5;

    if (puedeReenviar) {
      setState(() {
        _intentosReenvio++;
        _limiteReenvioAlcanzado = false;
        _detenerCountdown();
        _mensajeReenvio = 'Código reenviado';
      });
      
      // Ejecuta el callback para reenviar el código
      widget.onReenviarCodigo();
      return;
    }

    // Si alcanzó el límite, activa el countdown de 15 minutos
    setState(() {
      _limiteReenvioAlcanzado = true;
    });
    _iniciarCountdown();
  }

  /// Inicia el countdown de 15 minutos después de alcanzar el límite de reenvíos
  /// 
  /// Proceso:
  /// 1. Detiene cualquier countdown previo
  /// 2. Establece el tiempo en 900 segundos (15 minutos)
  /// 3. Crea un timer que cuenta regresivamente cada segundo
  /// 4. Al llegar a 0, resetea los intentos y permite reenviar nuevamente
  void _iniciarCountdown() {
    _detenerCountdown();
    
    setState(() {
      _tiempoRestante = 15 * 60; // 15 minutos en segundos
    });

    // Timer periódico que se ejecuta cada segundo
    _intervaloCountdown = Timer.periodic(const Duration(seconds: 1), (timer) {
      setState(() {
        _tiempoRestante--;
        
        // Cuando llega a 0, resetea todo el sistema de reenvío
        if (_tiempoRestante <= 0) {
          _detenerCountdown();
          _limiteReenvioAlcanzado = false;
          _mensajeReenvio = '';
          _intentosReenvio = 0;
        }
      });
    });
  }

  // ═══════════════════════════════════════════════════════════════════════════
  // CONSTRUCCIÓN DE LA INTERFAZ
  // ═══════════════════════════════════════════════════════════════════════════
  
  @override
  Widget build(BuildContext context) {
    return Column(
      key: const ValueKey('codigo'), // Clave única para transiciones
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
                color: CodigoVerificacionStyles.primaryGreen,
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
            'Codigo de verificacion',
            textAlign: TextAlign.center,
            style: CodigoVerificacionStyles.heading1,
          ),
        ),
        const SizedBox(height: 14),

        // ═══════════════════════════════════════════════════════════════════════
        // ELEMENTO 3: Descripción con correo (Delay 290ms)
        // ═══════════════════════════════════════════════════════════════════════
        _buildAnimatedWidget(
          index: 2,
          child: Text(
            'Ingresa el codigo de 6 digitos enviado a ${widget.correo}.',
            textAlign: TextAlign.center,
            style: CodigoVerificacionStyles.description,
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
              // ELEMENTO 4: Campo Código (Delay 390ms)
              // ═══════════════════════════════════════════════════════════════════
              // Campo de texto numérico de 6 dígitos
              // - Centrado visualmente
              // - Solo acepta números (FilteringTextInputFormatter.digitsOnly)
              // - Icono de escudo decorativo
              // - Placeholder "000000"
              // - Validación de longitud
              _buildAnimatedWidget(
                index: 3,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.stretch,
                  children: [
                    const Text('Codigo de verificacion', style: CodigoVerificacionStyles.label),
                    const SizedBox(height: 8),

                    FocusScope(
                      child: Focus(
                        onFocusChange: (focus) => setState(() => _isFocused = focus),
                        child: AnimatedContainer(
                          duration: CodigoVerificacionStyles.transitionDuration,
                          constraints: const BoxConstraints(minHeight: 54),
                          decoration: CodigoVerificacionStyles.inputDecoration(_isFocused),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              const Padding(
                                padding: EdgeInsets.only(left: 16),
                                child: SizedBox(
                                  width: 28,
                                  child: Center(
                                    child: FaIcon(
                                      FontAwesomeIcons.shieldHalved,
                                      color: CodigoVerificacionStyles.primaryGreen,
                                      size: 20,
                                    ),
                                  ),
                                ),
                              ),
                              Expanded(
                                child: TextFormField(
                                  controller: _codigoController,
                                  keyboardType: TextInputType.number,
                                  textAlign: TextAlign.center,
                                  maxLength: 6,
                                  style: CodigoVerificacionStyles.codeInput,
                                  inputFormatters: [FilteringTextInputFormatter.digitsOnly],
                                  onChanged: _normalizarCodigo,
                                  decoration: const InputDecoration(
                                    hintText: '000000',
                                    hintStyle: TextStyle(color: CodigoVerificacionStyles.placeholderGrey),
                                    border: InputBorder.none,
                                    counterText: '',
                                    isDense: true,
                                    contentPadding: EdgeInsets.symmetric(vertical: 16, horizontal: 8),
                                  ),
                                ),
                              ),
                              const SizedBox(width: 48),
                            ],
                          ),
                        ),
                      ),
                    ),
                    
                    if (_codigoErrorMsg != null)
                      Padding(
                        padding: const EdgeInsets.only(top: 4, left: 4),
                        child: Text(_codigoErrorMsg!, style: CodigoVerificacionStyles.errorText),
                      ),
                  ],
                ),
              ),
                
              const SizedBox(height: 18),

              // ═══════════════════════════════════════════════════════════════════
              // ELEMENTO 5: Botón Verificar (Delay 490ms)
              // ═══════════════════════════════════════════════════════════════════
              _buildAnimatedWidget(
                index: 4,
                child: Container(
                  decoration: CodigoVerificacionStyles.buttonDecoration,
                  child: ElevatedButton(
                    onPressed: _verificarCodigo,
                    style: ElevatedButton.styleFrom(
                      backgroundColor: Colors.transparent,
                      shadowColor: Colors.transparent,
                      minimumSize: const Size(double.infinity, 54),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(8)
                      ),
                    ),
                    child: const Text(
                      'Verificar codigo',
                      style: TextStyle(
                        color: Colors.white,
                        fontSize: 16,
                        fontWeight: FontWeight.w800,
                      ),
                    ),
                  ),
                ),
              ),

              const SizedBox(height: 16),
              
              // ═══════════════════════════════════════════════════════════════════
              // ELEMENTO 6: Sección de Reenvío (Delay 590ms)
              // ═══════════════════════════════════════════════════════════════════
              // Lógica de reenvío con límites:
              // - Primeros 5 intentos: reenvío inmediato
              // - Después del 5to: countdown de 15 minutos
              // - Opción para cambiar correo (si está disponible)
              _buildAnimatedWidget(
                index: 5,
                child: Column(
                  children: [
                    const Text('¿No recibiste el codigo?', style: CodigoVerificacionStyles.resendText),
                    const SizedBox(height: 8),
                    
                    // Enlace de reenvío (deshabilitado durante countdown)
                    InkWell(
                      onTap: _limiteReenvioAlcanzado ? null : _solicitarReenvio,
                      child: Text(
                        'Reenviar codigo',
                        style: _limiteReenvioAlcanzado 
                            ? CodigoVerificacionStyles.resendLinkDisabled 
                            : CodigoVerificacionStyles.resendLink,
                      ),
                    ),
                    
                    // Mensajes de feedback (éxito o countdown activo)
                    if (_mensajeReenvio.isNotEmpty || _limiteReenvioAlcanzado) ...[
                      const SizedBox(height: 10),
                      
                      // Mensaje de éxito
                      if (!_limiteReenvioAlcanzado)
                        Text(
                          _mensajeReenvio,
                          textAlign: TextAlign.center,
                          style: CodigoVerificacionStyles.resendFeedback,
                        ),
                      
                      // Mensaje de countdown con tiempo formateado
                      if (_limiteReenvioAlcanzado)
                        RichText(
                          textAlign: TextAlign.center,
                          text: TextSpan(
                            style: CodigoVerificacionStyles.resendFeedbackError,
                            children: [
                              const TextSpan(text: 'Has alcanzado el límite de reenvíos.\nInténtalo nuevamente en '),
                              TextSpan(
                                text: _tiempoFormateado,
                                style: const TextStyle(fontSize: 15, fontWeight: FontWeight.bold),
                              ),
                            ],
                          ),
                        ),
                    ],
                    
                    // Enlace opcional para cambiar el correo electrónico
                    if (widget.onCambiarCorreo != null) ...[
                      const SizedBox(height: 16),
                      TextButton(
                        onPressed: widget.onCambiarCorreo,
                        style: TextButton.styleFrom(
                          foregroundColor: CodigoVerificacionStyles.linkGreen,
                        ),
                        child: const Text(
                          'Cambiar correo electrónico',
                          style: CodigoVerificacionStyles.changeEmailLink,
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
