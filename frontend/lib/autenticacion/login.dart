import 'dart:async';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import '../styles/autenticacion-styles/login.dart';

import 'restablecer-password.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({super.key});

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> with TickerProviderStateMixin {
  final _formKey = GlobalKey<FormState>();
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();
  
  bool _showPassword = false;
  String _loginError = '';
  bool _showResetPassword = false;
  
  String? _emailError;
  String? _passwordError;
  
  final GlobalKey<RestablecerPasswordState> _resetPasswordKey = GlobalKey();
  String _resetPaso = 'correo';
  
  bool _emailFocus = false;
  bool _passwordFocus = false;
  
  // Lógica del Carrusel
  int _currentCarouselIndex = 0;
  Timer? _carouselTimer;
  final List<String> _carouselImages = [
    'assets/imagesLogin/sosteniendoTomate.jpg',
    'assets/imagesLogin/tomateHumedo.jpg',
    'assets/imagesLogin/tomateIluminado.jpg',
  ];

  // Animaciones
  late AnimationController _animationController;
  late List<Animation<double>> _fadeAnimations;
  late List<Animation<Offset>> _slideAnimations;

  @override
  void initState() {
    super.initState();
    _startCarousel();
    _initializeAnimations();
  }

  void _initializeAnimations() {
    // Duración total: 590ms (último delay) + 720ms (duración animación) = 1310ms
    _animationController = AnimationController(
      duration: const Duration(milliseconds: 1310),
      vsync: this,
    );

    _fadeAnimations = List.generate(6, (index) {
      final delayMs = LoginStyles.animationDelays[index];
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
      final delayMs = LoginStyles.animationDelays[index];
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
    _carouselTimer?.cancel();
    _emailController.dispose();
    _passwordController.dispose();
    super.dispose();
  }

  void _startCarousel() {
    _carouselTimer = Timer.periodic(const Duration(seconds: 6), (timer) {
      setState(() {
        _currentCarouselIndex = (_currentCarouselIndex + 1) % _carouselImages.length;
      });
    });
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
      _emailError = 'El correo es requerido';
      isValid = false;
    } else if (!email.contains('@') || !email.contains('.')) {
      _emailError = 'Formato de correo inválido';
      isValid = false;
    } else {
      _emailError = null;
    }

    if (_passwordController.text.isEmpty) {
      _passwordError = 'La contraseña es requerida';
      isValid = false;
    } else {
      _passwordError = null;
    }

    setState(() {});
    return isValid;
  }

  void _onSubmit() {
    setState(() {
      _loginError = '';
    });

    if (!_validateFields()) {
      return;
    }

    final email = _emailController.text.trim();
    final password = _passwordController.text;

    // Lógica de navegación simulada
    if (email == 'admin@agrovision.com' && password == 'admin123') {
      Navigator.pushReplacementNamed(context, '/panel-admin');
      return;
    }

    if (email == 'agricultor@agrovision.com' && password == 'agricultor123') {
      Navigator.pushReplacementNamed(context, '/boton-iot');
      return;
    }

    setState(() {
      _loginError = 'Credenciales incorrectas. Verifique el correo y la contraseña.';
    });
  }
  
  void _backToLogin() {
    setState(() {
      _showResetPassword = false;
      _resetPaso = 'correo';
      _loginError = '';
      _emailController.clear();
      _passwordController.clear();
      _emailError = null;
      _passwordError = null;
    });
    // Reinicia la animación al regresar al login
    _animationController.reset();
    _animationController.forward();
  }

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    final bool isDesktop = size.width > 900;

    return Scaffold(
      backgroundColor: LoginStyles.backgroundLight,
      body: Row(
        children: [
          // Panel del Carrusel (Solo visible en Desktop)
          if (isDesktop)
            Expanded(
              child: Stack(
                fit: StackFit.expand,
                children: [
                  AnimatedSwitcher(
                    duration: const Duration(milliseconds: 800),
                    transitionBuilder: (Widget child, Animation<double> animation) {
                      return FadeTransition(opacity: animation, child: child);
                    },
                    child: Image.asset(
                      _carouselImages[_currentCarouselIndex],
                      key: ValueKey<int>(_currentCarouselIndex),
                      fit: BoxFit.cover,
                      errorBuilder: (context, error, stackTrace) => Container(
                        color: LoginStyles.darkGreen,
                        alignment: Alignment.center,
                        child: const Text(
                          'Imagen no encontrada', 
                          style: TextStyle(color: Colors.white)
                        ),
                      ),
                    ),
                  ),
                  // Botones de control del carrusel (Opcional)
                  Positioned(
                    left: 20,
                    top: 0,
                    bottom: 0,
                    child: Center(
                      child: IconButton(
                        icon: const Icon(Icons.arrow_back_ios, color: Colors.white70),
                        onPressed: () {
                          setState(() {
                            _currentCarouselIndex = (_currentCarouselIndex - 1 + _carouselImages.length) % _carouselImages.length;
                          });
                        },
                      ),
                    ),
                  ),
                  Positioned(
                    right: 20,
                    top: 0,
                    bottom: 0,
                    child: Center(
                      child: IconButton(
                        icon: const Icon(Icons.arrow_forward_ios, color: Colors.white70),
                        onPressed: () {
                          setState(() {
                            _currentCarouselIndex = (_currentCarouselIndex + 1) % _carouselImages.length;
                          });
                        },
                      ),
                    ),
                  ),
                ],
              ),
            ),
            
          // Panel de Login
          Container(
            width: isDesktop ? (size.width > 1440 ? 540 : 440) : size.width,
            decoration: LoginStyles.loginPanelDecoration,
            padding: EdgeInsets.symmetric(
              horizontal: isDesktop ? 64 : 32,
              vertical: isDesktop ? 64 : 32,
            ),
            child: Center(
              child: SingleChildScrollView(
                child: ConstrainedBox(
                  constraints: const BoxConstraints(maxWidth: 430),
                  child: _showResetPassword ? _buildResetPasswordView() : _buildLoginForm(),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildLoginForm() {
    return Form(
      key: _formKey,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          // Logo - Delay 1 (90ms)
          _buildAnimatedWidget(
            index: 0,
            child: Center(
              child: Image.asset(
                'assets/logotipos/escudo.png',
                height: 140,
                errorBuilder: (context, error, stackTrace) => const Icon(
                  Icons.shield, 
                  size: 140, 
                  color: LoginStyles.primaryGreen
                ),
              ),
            ),
          ),
          const SizedBox(height: 26),
          
          // Título - Delay 2 (190ms)
          _buildAnimatedWidget(
            index: 1,
            child: const Text(
              'Iniciar Sesión',
              textAlign: TextAlign.center,
              style: LoginStyles.heading1,
            ),
          ),
          const SizedBox(height: 28),
          
          // Campo Correo - Delay 3 (290ms)
          _buildAnimatedWidget(
            index: 2,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                const Text('Correo electrónico', style: LoginStyles.label),
                const SizedBox(height: 8),
                FocusScope(
                  child: Focus(
                    onFocusChange: (focus) => setState(() => _emailFocus = focus),
                    child: AnimatedContainer(
                      duration: LoginStyles.transitionDuration,
                      constraints: const BoxConstraints(minHeight: 54),
                      decoration: LoginStyles.inputDecoration(_emailFocus),
                      child: Row(
                        children: [
                          const SizedBox(
                            width: 52, 
                            child: Center(
                              child: FaIcon(FontAwesomeIcons.envelope, color: LoginStyles.primaryGreen, size: 20),
                            ),
                          ),
                          Expanded(
                            child: TextFormField(
                              controller: _emailController,
                              keyboardType: TextInputType.emailAddress,
                              decoration: const InputDecoration(
                                hintText: 'Correo corporativo',
                                hintStyle: TextStyle(color: LoginStyles.placeholderGrey),
                                border: InputBorder.none,
                                isDense: true,
                                contentPadding: EdgeInsets.symmetric(vertical: 16),
                              ),
                              onChanged: (val) {
                                if (_emailError != null) setState(() => _emailError = null);
                              },
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                ),
                if (_emailError != null)
                  Padding(
                    padding: const EdgeInsets.only(top: 4, left: 4),
                    child: Text(_emailError!, style: LoginStyles.errorText),
                  ),
              ],
            ),
          ),
          const SizedBox(height: 18),
          
          // Campo Contraseña - Delay 4 (390ms)
          _buildAnimatedWidget(
            index: 3,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                const Text('Contraseña', style: LoginStyles.label),
                const SizedBox(height: 8),
                FocusScope(
                  child: Focus(
                    onFocusChange: (focus) => setState(() => _passwordFocus = focus),
                    child: AnimatedContainer(
                      duration: LoginStyles.transitionDuration,
                      constraints: const BoxConstraints(minHeight: 54),
                      decoration: LoginStyles.inputDecoration(_passwordFocus),
                      child: Row(
                        children: [
                          const SizedBox(
                            width: 52, 
                            child: Center(
                              child: FaIcon(FontAwesomeIcons.lock, color: LoginStyles.primaryGreen, size: 20),
                            ),
                          ),
                          Expanded(
                            child: TextFormField(
                              controller: _passwordController,
                              obscureText: !_showPassword,
                              decoration: const InputDecoration(
                                hintText: 'Ingresa tu contraseña',
                                hintStyle: TextStyle(color: LoginStyles.placeholderGrey),
                                border: InputBorder.none,
                                isDense: true,
                                contentPadding: EdgeInsets.symmetric(vertical: 16),
                              ),
                              onChanged: (val) {
                                if (_passwordError != null) setState(() => _passwordError = null);
                              },
                            ),
                          ),
                          IconButton(
                            icon: FaIcon(
                              _showPassword ? FontAwesomeIcons.eyeSlash : FontAwesomeIcons.eye,
                              color: LoginStyles.darkGreen,
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
                if (_passwordError != null)
                  Padding(
                    padding: const EdgeInsets.only(top: 4, left: 4),
                    child: Text(_passwordError!, style: LoginStyles.errorText),
                  ),
              ],
            ),
          ),
          
          // Mensaje de Error General
          if (_loginError.isNotEmpty) ...[
            const SizedBox(height: 18),
            Text(
              _loginError,
              textAlign: TextAlign.center,
              style: LoginStyles.errorText,
            ),
          ],
          
          const SizedBox(height: 28),
          
          // Botón Iniciar Sesión - Delay 5 (490ms)
          _buildAnimatedWidget(
            index: 4,
            child: Container(
              decoration: LoginStyles.buttonDecoration,
              child: ElevatedButton(
                onPressed: _onSubmit,
                style: ElevatedButton.styleFrom(
                  backgroundColor: Colors.transparent,
                  shadowColor: Colors.transparent,
                  minimumSize: const Size(double.infinity, 54),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(8)
                  ),
                ),
                child: const Text(
                  'Iniciar Sesión',
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: 16,
                    fontWeight: FontWeight.w800,
                  ),
                ),
              ),
            ),
          ),
          const SizedBox(height: 20),
          
          // Enlace Olvidaste tu contraseña - Delay 6 (590ms)
          _buildAnimatedWidget(
            index: 5,
            child: TextButton(
              onPressed: () {
                setState(() {
                  _showResetPassword = true;
                  _loginError = '';
                  _emailController.clear();
                  _passwordController.clear();
                  _emailError = null;
                  _passwordError = null;
                });
              },
              style: TextButton.styleFrom(
                foregroundColor: LoginStyles.primaryGreen,
              ),
              child: const Text(
                '¿Olvidaste tu contraseña?', 
                style: LoginStyles.forgotLink
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildResetPasswordView() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: [
        RestablecerPassword(
          key: _resetPasswordKey,
          volverLogin: _backToLogin,
          onPasoChanged: (paso) {
            setState(() {
              _resetPaso = paso;
            });
          },
        ),
        // Animación para el enlace "Cambiar correo electrónico"
        AnimatedSize(
          duration: const Duration(milliseconds: 300),
          curve: Curves.easeInOut,
          child: _resetPaso == 'codigo'
              ? Column(
                  children: [
                    const SizedBox(height: 20),
                    TweenAnimationBuilder<double>(
                      duration: const Duration(milliseconds: 400),
                      tween: Tween<double>(begin: 0.0, end: 1.0),
                      curve: Curves.easeOut,
                      builder: (context, value, child) {
                        return Opacity(
                          opacity: value,
                          child: Transform.translate(
                            offset: Offset(0, 20 * (1 - value)),
                            child: child,
                          ),
                        );
                      },
                      child: TextButton(
                        onPressed: () {
                          _resetPasswordKey.currentState?.volverACorreo();
                        },
                        child: const Text(
                          'Cambiar correo electrónico',
                          style: LoginStyles.forgotLink,
                        ),
                      ),
                    ),
                  ],
                )
              : const SizedBox.shrink(),
        ),
      ],
    );
  }
}
