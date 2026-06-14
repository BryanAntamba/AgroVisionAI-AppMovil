import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import '../styles/autenticacion-styles/restablecer-password.dart';
import 'password-confirmacion.dart';
import 'codigo-verificacion.dart';
import 'cambiar-password.dart';

class RestablecerPassword extends StatefulWidget {
  final VoidCallback volverLogin;
  final Function(String)? onPasoChanged;

  const RestablecerPassword({
    super.key,
    required this.volverLogin,
    this.onPasoChanged,
  });

  @override
  State<RestablecerPassword> createState() => RestablecerPasswordState();
}

class RestablecerPasswordState extends State<RestablecerPassword> with TickerProviderStateMixin {
  final _formKey = GlobalKey<FormState>();
  final TextEditingController _emailController = TextEditingController();
  
  String _resetError = '';
  String? _emailErrorMsg;
  String _correoVerificado = '';
  String paso = 'correo'; // 'correo', 'codigo', 'password', 'finalizado'
  bool _emailFocus = false;
  
  final String _correoSimulado = 'usuario@gmail.com';
  
  // Animaciones
  late AnimationController _animationController;
  late List<Animation<double>> _fadeAnimations;
  late List<Animation<Offset>> _slideAnimations;

  @override
  void initState() {
    super.initState();
    _initializeAnimations();
  }

  void _initializeAnimations() {
    // Duración total: 590ms (último delay) + 720ms (duración animación) = 1310ms
    _animationController = AnimationController(
      duration: const Duration(milliseconds: 1310),
      vsync: this,
    );

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

    _animationController.forward();
  }

  @override
  void dispose() {
    _animationController.dispose();
    _emailController.dispose();
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

  void _enviarCodigo() {
    setState(() {
      _resetError = '';
    });

    if (!_validateFields()) {
      return;
    }

    if (_emailController.text.trim() != _correoSimulado) {
      setState(() {
        _resetError = 'El correo no coincide con el usuario simulado.';
      });
      return;
    }

    setState(() {
      _correoVerificado = _emailController.text.trim();
      paso = 'codigo';
    });
    widget.onPasoChanged?.call(paso);
  }

  void mostrarCambioPassword() {
    setState(() {
      paso = 'password';
    });
    widget.onPasoChanged?.call(paso);
  }

  void finalizarCambio() {
    setState(() {
      paso = 'finalizado';
    });
    widget.onPasoChanged?.call(paso);
  }

  void volverACorreo() {
    setState(() {
      paso = 'correo';
      _correoVerificado = '';
      _resetError = '';
      _emailController.clear();
    });
    widget.onPasoChanged?.call(paso);
    // Reinicia la animación al volver al paso de correo
    _animationController.reset();
    _animationController.forward();
  }

  void reenviarCodigoVerificacion() {
    debugPrint('Reenviando código de verificación a: $_correoVerificado');
  }

  @override
  Widget build(BuildContext context) {
    // ngSwitch simple, cada paso maneja sus propias animaciones internas
    switch (paso) {
      case 'correo':
        return _buildCorreoPaso();
      case 'codigo':
        return _buildCodigoPaso();
      case 'password':
        return _buildCambiarPasswordPaso();
      case 'finalizado':
        return _buildFinalizadoPaso();
      default:
        return _buildCorreoPaso();
    }
  }

  Widget _buildCorreoPaso() {
    return Column(
      key: const ValueKey('correo'),
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
                color: RestablecerPasswordStyles.primaryGreen,
              ),
            ),
          ),
        ),
        const SizedBox(height: 26),
        
        // Título - Delay 2 (190ms)
        _buildAnimatedWidget(
          index: 1,
          child: const Text(
            'Restablecer contrasena',
            textAlign: TextAlign.center,
            style: RestablecerPasswordStyles.heading1,
          ),
        ),
        const SizedBox(height: 14),
        
        // Descripción - Delay 3 (290ms)
        _buildAnimatedWidget(
          index: 2,
          child: const Text(
            'Se enviara un codigo de verificacion a tu correo electronico.',
            textAlign: TextAlign.center,
            style: RestablecerPasswordStyles.description,
          ),
        ),
        const SizedBox(height: 24),

        Form(
          key: _formKey,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              // Campo de correo - Delay 4 (390ms)
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
              
              // Mensaje de error - Delay 5 (490ms)
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
              
              // Botón enviar - Delay 5 (490ms)
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
        
        // Enlace regresar - Delay 6 (590ms)
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

  Widget _buildCodigoPaso() {
    return CodigoVerificacion(
      key: ValueKey('codigo_$_correoVerificado'),
      correo: _correoVerificado,
      onCodigoVerificado: mostrarCambioPassword,
      onReenviarCodigo: reenviarCodigoVerificacion,
      onCambiarCorreo: volverACorreo,
      onVolverLogin: widget.volverLogin,
    );
  }

  Widget _buildCambiarPasswordPaso() {
    return CambiarPassword(
      key: const ValueKey('password_change'),
      onPasswordCambiado: finalizarCambio,
      onVolverLogin: widget.volverLogin,
    );
  }

  Widget _buildFinalizadoPaso() {
    return PasswordConfirmacion(
      key: const ValueKey('confirmacion_final'),
      onVolverLogin: widget.volverLogin,
    );
  }
}
