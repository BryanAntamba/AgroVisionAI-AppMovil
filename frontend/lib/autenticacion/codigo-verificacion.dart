import 'dart:async';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import '../styles/autenticacion-styles/codigo-verificacion.dart';

class CodigoVerificacion extends StatefulWidget {
  final String correo;
  final VoidCallback onCodigoVerificado;
  final VoidCallback onReenviarCodigo;

  const CodigoVerificacion({
    super.key,
    required this.correo,
    required this.onCodigoVerificado,
    required this.onReenviarCodigo,
  });

  @override
  State<CodigoVerificacion> createState() => _CodigoVerificacionState();
}

class _CodigoVerificacionState extends State<CodigoVerificacion> with TickerProviderStateMixin {
  final _formKey = GlobalKey<FormState>();
  final TextEditingController _codigoController = TextEditingController();
  bool _isFocused = false;
  String? _codigoErrorMsg;

  String _mensajeReenvio = '';
  int _intentosReenvio = 0;
  bool _limiteReenvioAlcanzado = false;

  int _tiempoRestante = 0;
  Timer? _intervaloCountdown;
  
  // Animaciones
  late AnimationController _animationController;
  late List<Animation<double>> _fadeAnimations;
  late List<Animation<Offset>> _slideAnimations;
  final List<int> _animationDelays = [90, 190, 290, 390, 490, 590];

  @override
  void initState() {
    super.initState();
    _initializeAnimations();
  }

  void _initializeAnimations() {
    _animationController = AnimationController(
      duration: const Duration(milliseconds: 1310), // 590ms + 720ms
      vsync: this,
    );

    _fadeAnimations = List.generate(6, (index) {
      final delayMs = _animationDelays[index];
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

    _slideAnimations = List.generate(6, (index) {
      final delayMs = _animationDelays[index];
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

    _animationController.forward();
  }

  @override
  void dispose() {
    _animationController.dispose();
    _codigoController.dispose();
    _detenerCountdown();
    super.dispose();
  }
  
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

  void _detenerCountdown() {
    _intervaloCountdown?.cancel();
    _intervaloCountdown = null;
  }

  String get _tiempoFormateado {
    final minutos = (_tiempoRestante / 60).floor();
    final segundos = _tiempoRestante % 60;
    return '$minutos:${segundos.toString().padLeft(2, '0')}';
  }

  void _normalizarCodigo(String value) {
    setState(() {
      if (_codigoErrorMsg != null) _codigoErrorMsg = null;
      _mensajeReenvio = '';
      _limiteReenvioAlcanzado = false;
    });
  }

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

  void _verificarCodigo() {
    if (!_validateFields()) {
      return;
    }
    widget.onCodigoVerificado();
  }

  void _solicitarReenvio() {
    // Lógica para limitar a 5 reenvíos antes del countdown
    bool puedeReenviar = _intentosReenvio < 5;

    if (puedeReenviar) {
      setState(() {
        _intentosReenvio++;
        _limiteReenvioAlcanzado = false;
        _detenerCountdown();
        _mensajeReenvio = 'Código reenviado';
      });
      widget.onReenviarCodigo();
      return;
    }

    setState(() {
      _limiteReenvioAlcanzado = true;
    });
    _iniciarCountdown();
  }

  void _iniciarCountdown() {
    _detenerCountdown();
    setState(() {
      _tiempoRestante = 15 * 60; // 15 minutos en segundos
    });

    _intervaloCountdown = Timer.periodic(const Duration(seconds: 1), (timer) {
      setState(() {
        _tiempoRestante--;
        if (_tiempoRestante <= 0) {
          _detenerCountdown();
          _limiteReenvioAlcanzado = false;
          _mensajeReenvio = '';
          _intentosReenvio = 0;
        }
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      key: const ValueKey('codigo'),
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: [
        // Logo - Delay 1 (90ms)
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

        // Título - Delay 2 (190ms)
        _buildAnimatedWidget(
          index: 1,
          child: const Text(
            'Codigo de verificacion',
            textAlign: TextAlign.center,
            style: CodigoVerificacionStyles.heading1,
          ),
        ),
        const SizedBox(height: 14),

        // Descripción - Delay 3 (290ms)
        _buildAnimatedWidget(
          index: 2,
          child: Text(
            'Ingresa el codigo de 6 digitos enviado a ${widget.correo}.',
            textAlign: TextAlign.center,
            style: CodigoVerificacionStyles.description,
          ),
        ),
        const SizedBox(height: 24),

        Form(
          key: _formKey,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              // Campo código - Delay 4 (390ms)
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
                          duration: const Duration(milliseconds: 200),
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

              // Botón verificar - Delay 5 (490ms)
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
              
              // Sección reenvío - Delay 6 (590ms)
              _buildAnimatedWidget(
                index: 5,
                child: Column(
                  children: [
                    const Text('¿No recibiste el codigo?', style: CodigoVerificacionStyles.resendText),
                    const SizedBox(height: 8),
                    InkWell(
                      onTap: _limiteReenvioAlcanzado ? null : _solicitarReenvio,
                      child: Text(
                        'Reenviar codigo',
                        style: _limiteReenvioAlcanzado 
                            ? CodigoVerificacionStyles.resendLinkDisabled 
                            : CodigoVerificacionStyles.resendLink,
                      ),
                    ),
                    if (_mensajeReenvio.isNotEmpty || _limiteReenvioAlcanzado) ...[
                      const SizedBox(height: 10),
                      if (!_limiteReenvioAlcanzado)
                        Text(
                          _mensajeReenvio,
                          textAlign: TextAlign.center,
                          style: CodigoVerificacionStyles.resendFeedback,
                        ),
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
