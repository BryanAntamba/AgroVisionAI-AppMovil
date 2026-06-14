import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import '../styles/autenticacion-styles/cambiar-password.dart';

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
  final _formKey = GlobalKey<FormState>();
  final TextEditingController _passwordController = TextEditingController();
  final TextEditingController _confirmPasswordController = TextEditingController();

  bool _showPassword = false;
  bool _showConfirmPassword = false;

  bool _passwordFocus = false;
  bool _confirmPasswordFocus = false;

  String? _passwordErrorMsg;
  String? _confirmErrorMsg;
  
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

    _animationController.forward();
  }

  @override
  void dispose() {
    _animationController.dispose();
    _passwordController.dispose();
    _confirmPasswordController.dispose();
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
    final password = _passwordController.text;
    if (password.isEmpty) {
      _passwordErrorMsg = 'La contraseña es requerida';
      isValid = false;
    } else {
      _passwordErrorMsg = null;
    }

    final confirm = _confirmPasswordController.text;
    if (confirm.isEmpty) {
      _confirmErrorMsg = 'Confirmar contraseña es requerido';
      isValid = false;
    } else if (confirm != password) {
      _confirmErrorMsg = 'Las contraseñas no coinciden';
      isValid = false;
    } else {
      _confirmErrorMsg = null;
    }

    setState(() {});
    return isValid;
  }

  void _confirmarPassword() {
    if (!_validateFields()) {
      return;
    }

    widget.onPasswordCambiado();
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      key: const ValueKey('password'),
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
                color: CambiarPasswordStyles.primaryGreen,
              ),
            ),
          ),
        ),
        const SizedBox(height: 26),

        // Título - Delay 2 (190ms)
        _buildAnimatedWidget(
          index: 1,
          child: const Text(
            'Cambiar contrasena',
            textAlign: TextAlign.center,
            style: CambiarPasswordStyles.heading1,
          ),
        ),
        const SizedBox(height: 14),

        // Descripción - Delay 3 (290ms)
        _buildAnimatedWidget(
          index: 2,
          child: const Text(
            'Crea una nueva contrasena y confirmala para finalizar.',
            textAlign: TextAlign.center,
            style: CambiarPasswordStyles.description,
          ),
        ),
        const SizedBox(height: 24),

        Form(
          key: _formKey,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              // Campo Nueva contraseña - Delay 4 (390ms)
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

              // Campo Confirmar contraseña - Delay 5 (490ms)
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

              // Botón confirmar - Delay 6 (590ms)
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
                    // Enlace "Regresar a iniciar sesión" con animación después del botón
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
