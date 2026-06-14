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
    final screenWidth = size.width;
    
    // Breakpoints adaptativos
    final bool isMobile = screenWidth < 600;
    final bool isTabletPortrait = screenWidth >= 600 && screenWidth < 900;
    final bool isTabletLandscape = screenWidth >= 900 && screenWidth < 1200;
    final bool isDesktop = screenWidth >= 1200;
    
    // Mostrar carrusel en tablets landscape y desktop
    final bool showCarousel = isTabletLandscape || isDesktop;
    
    // Calcular ancho del panel de login según el tamaño de pantalla
    double loginPanelWidth;
    if (isMobile) {
      loginPanelWidth = screenWidth;
    } else if (isTabletPortrait) {
      loginPanelWidth = screenWidth;
    } else if (isTabletLandscape) {
      // Tablet landscape: panel más estrecho para mostrar el carrusel
      loginPanelWidth = screenWidth * 0.45; // 45% del ancho
    } else {
      // Desktop: anchos fijos según el tamaño total
      loginPanelWidth = screenWidth > 1440 ? 540 : 440;
    }
    
    // Padding adaptativo
    double horizontalPadding;
    double verticalPadding;
    
    if (isMobile) {
      horizontalPadding = 24;
      verticalPadding = 32;
    } else if (isTabletPortrait) {
      horizontalPadding = 48;
      verticalPadding = 48;
    } else if (isTabletLandscape) {
      horizontalPadding = 40;
      verticalPadding = 48;
    } else {
      horizontalPadding = 64;
      verticalPadding = 64;
    }

    return Scaffold(
      backgroundColor: LoginStyles.backgroundLight,
      body: Row(
        children: [
          // Panel del Carrusel (Visible en tablets landscape y desktop)
          if (showCarousel)
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
                  // Botones de control del carrusel
                  // Ajustar tamaño de botones según dispositivo
                  Positioned(
                    left: isTabletLandscape ? 12 : 20,
                    top: 0,
                    bottom: 0,
                    child: Center(
                      child: IconButton(
                        iconSize: isTabletLandscape ? 20 : 24,
                        icon: Icon(
                          Icons.arrow_back_ios, 
                          color: Colors.white70,
                          size: isTabletLandscape ? 20 : 24,
                        ),
                        onPressed: () {
                          setState(() {
                            _currentCarouselIndex = (_currentCarouselIndex - 1 + _carouselImages.length) % _carouselImages.length;
                          });
                        },
                      ),
                    ),
                  ),
                  Positioned(
                    right: isTabletLandscape ? 12 : 20,
                    top: 0,
                    bottom: 0,
                    child: Center(
                      child: IconButton(
                        iconSize: isTabletLandscape ? 20 : 24,
                        icon: Icon(
                          Icons.arrow_forward_ios, 
                          color: Colors.white70,
                          size: isTabletLandscape ? 20 : 24,
                        ),
                        onPressed: () {
                          setState(() {
                            _currentCarouselIndex = (_currentCarouselIndex + 1) % _carouselImages.length;
                          });
                        },
                      ),
                    ),
                  ),
                  // Indicadores de carrusel para tablets
                  if (isTabletLandscape)
                    Positioned(
                      bottom: 20,
                      left: 0,
                      right: 0,
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: List.generate(
                          _carouselImages.length,
                          (index) => Container(
                            margin: const EdgeInsets.symmetric(horizontal: 4),
                            width: 8,
                            height: 8,
                            decoration: BoxDecoration(
                              shape: BoxShape.circle,
                              color: _currentCarouselIndex == index
                                  ? Colors.white
                                  : Colors.white.withValues(alpha: 0.4),
                            ),
                          ),
                        ),
                      ),
                    ),
                ],
              ),
            ),
            
          // Panel de Login
          Container(
            width: loginPanelWidth,
            decoration: LoginStyles.loginPanelDecoration,
            padding: EdgeInsets.symmetric(
              horizontal: horizontalPadding,
              vertical: verticalPadding,
            ),
            child: Center(
              child: SingleChildScrollView(
                child: ConstrainedBox(
                  constraints: BoxConstraints(
                    maxWidth: isTabletLandscape ? 380 : 430,
                  ),
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
            // El paso se maneja internamente en RestablecerPassword
          },
        ),
      ],
    );
  }
}

// Widget helper para animaciones con delay (fade-up)
class _DelayedFadeUp extends StatefulWidget {
  final Widget child;
  final Duration delay;
  
  const _DelayedFadeUp({
    required this.child,
    required this.delay,
  });

  @override
  State<_DelayedFadeUp> createState() => _DelayedFadeUpState();
}

class _DelayedFadeUpState extends State<_DelayedFadeUp> with SingleTickerProviderStateMixin {
  late AnimationController _controller;
  late Animation<double> _fadeAnimation;
  late Animation<Offset> _slideAnimation;

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(
      duration: const Duration(milliseconds: 720),
      vsync: this,
    );

    _fadeAnimation = Tween<double>(begin: 0.0, end: 1.0).animate(
      CurvedAnimation(parent: _controller, curve: Curves.easeOut),
    );

    _slideAnimation = Tween<Offset>(
      begin: const Offset(0, 0.34),
      end: Offset.zero,
    ).animate(
      CurvedAnimation(parent: _controller, curve: Curves.easeOut),
    );

    // Espera el delay antes de iniciar la animación
    Future.delayed(widget.delay, () {
      if (mounted) {
        _controller.forward();
      }
    });
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return FadeTransition(
      opacity: _fadeAnimation,
      child: SlideTransition(
        position: _slideAnimation,
        child: widget.child,
      ),
    );
  }
}
