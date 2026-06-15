// ═══════════════════════════════════════════════════════════════════════════
// LOGIN - PANTALLA PRINCIPAL DE AUTENTICACIÓN
// ═══════════════════════════════════════════════════════════════════════════
// Pantalla de inicio de sesión con diseño responsivo adaptable a diferentes
// tamaños de pantalla (móvil, tablet portrait, tablet landscape, desktop).
//
// Características principales:
// - Autenticación con correo y contraseña
// - Navegación basada en roles (admin vs agricultor)
// - Carrusel de imágenes (3 imágenes, 6 segundos por slide)
// - Layout adaptativo con breakpoints responsivos
// - Animaciones fade-up escalonadas (6 elementos)
// - Integración con flujo de restablecimiento de contraseña
// - Toggle para mostrar/ocultar contraseña
// - Validación en tiempo real
//
// Credenciales de prueba:
// - Admin: admin@agrovision.com / admin123
// - Agricultor: agricultor@agrovision.com / agricultor123
// ═══════════════════════════════════════════════════════════════════════════

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
  // ═══════════════════════════════════════════════════════════════════════════
  // CONTROLADORES Y ESTADO DEL FORMULARIO
  // ═══════════════════════════════════════════════════════════════════════════
  
  /// Clave global para validación del formulario
  final _formKey = GlobalKey<FormState>();
  
  /// Controlador para el campo de correo electrónico
  final TextEditingController _emailController = TextEditingController();
  
  /// Controlador para el campo de contraseña
  final TextEditingController _passwordController = TextEditingController();
  
  /// Controla si la contraseña es visible (true) u oculta (false)
  bool _showPassword = false;
  
  /// Mensaje de error general de autenticación
  String _loginError = '';
  
  /// Controla si se muestra el flujo de restablecimiento de contraseña
  bool _showResetPassword = false;
  
  /// Mensaje de error para el campo de correo
  String? _emailError;
  
  /// Mensaje de error para el campo de contraseña
  String? _passwordError;
  
  /// Clave global para el componente de restablecimiento de contraseña
  final GlobalKey<RestablecerPasswordState> _resetPasswordKey = GlobalKey();
  
  /// Indica si el campo de correo tiene foco
  bool _emailFocus = false;
  
  /// Indica si el campo de contraseña tiene foco
  bool _passwordFocus = false;
  
  // ═══════════════════════════════════════════════════════════════════════════
  // LÓGICA DEL CARRUSEL DE IMÁGENES
  // ═══════════════════════════════════════════════════════════════════════════
  
  /// Índice actual de la imagen mostrada en el carrusel (0-2)
  int _currentCarouselIndex = 0;
  
  /// Timer que controla el cambio automático de imágenes cada 6 segundos
  Timer? _carouselTimer;
  
  /// Lista de rutas de las 3 imágenes del carrusel
  final List<String> _carouselImages = [
    'assets/imagesLogin/sosteniendoTomate.jpg',
    'assets/imagesLogin/tomateHumedo.jpg',
    'assets/imagesLogin/tomateIluminado.jpg',
  ];

  // ═══════════════════════════════════════════════════════════════════════════
  // CONTROLADORES Y ANIMACIONES
  // ═══════════════════════════════════════════════════════════════════════════
  // Sistema de animaciones fade-up con delays escalonados para 6 elementos:
  // 1. Logo (90ms)
  // 2. Título (190ms)
  // 3. Campo correo (290ms)
  // 4. Campo contraseña (390ms)
  // 5. Botón iniciar sesión (490ms)
  // 6. Enlace olvidaste contraseña (590ms)
  
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
    _startCarousel();
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

    // Genera animaciones de slide-up para cada uno de los 6 elementos
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

    // Inicia las animaciones automáticamente
    _animationController.forward();
  }
  
  @override
  void dispose() {
    // Libera recursos de animación, timer del carrusel y controladores
    _animationController.dispose();
    _carouselTimer?.cancel();
    _emailController.dispose();
    _passwordController.dispose();
    super.dispose();
  }

  // ═══════════════════════════════════════════════════════════════════════════
  // GESTIÓN DEL CARRUSEL
  // ═══════════════════════════════════════════════════════════════════════════
  
  /// Inicia el carrusel automático de imágenes
  /// 
  /// Cambia a la siguiente imagen cada 6 segundos de forma cíclica
  void _startCarousel() {
    _carouselTimer = Timer.periodic(const Duration(seconds: 6), (timer) {
      setState(() {
        _currentCarouselIndex = (_currentCarouselIndex + 1) % _carouselImages.length;
      });
    });
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
  // VALIDACIÓN Y AUTENTICACIÓN
  // ═══════════════════════════════════════════════════════════════════════════
  
  /// Valida los campos del formulario de login
  /// 
  /// Validaciones:
  /// 1. Correo: no vacío, contiene '@' y '.'
  /// 2. Contraseña: no vacía
  /// 
  /// Retorna [true] si todos los campos son válidos, [false] en caso contrario
  bool _validateFields() {
    bool isValid = true;
    final email = _emailController.text.trim();
    
    // Validación de correo
    if (email.isEmpty) {
      _emailError = 'El correo es requerido';
      isValid = false;
    } else if (!email.contains('@') || !email.contains('.')) {
      _emailError = 'Formato de correo inválido';
      isValid = false;
    } else {
      _emailError = null;
    }

    // Validación de contraseña
    if (_passwordController.text.isEmpty) {
      _passwordError = 'La contraseña es requerida';
      isValid = false;
    } else {
      _passwordError = null;
    }

    setState(() {});
    return isValid;
  }

  /// Maneja el envío del formulario y autenticación
  /// 
  /// Flujo:
  /// 1. Limpia errores previos
  /// 2. Valida los campos
  /// 3. Verifica credenciales hardcodeadas
  /// 4. Navega según el rol (admin o agricultor)
  /// 5. Si las credenciales son incorrectas, muestra error
  void _onSubmit() {
    setState(() {
      _loginError = '';
    });

    if (!_validateFields()) {
      return;
    }

    final email = _emailController.text.trim();
    final password = _passwordController.text;

    // Autenticación simulada con credenciales hardcodeadas
    // Admin: redirige a panel de administración
    if (email == 'admin@agrovision.com' && password == 'admin123') {
      Navigator.pushReplacementNamed(context, '/panel-admin');
      return;
    }

    // Agricultor: redirige a botón IoT (pantalla de conexión)
    if (email == 'agricultor@agrovision.com' && password == 'agricultor123') {
      Navigator.pushReplacementNamed(context, '/boton-iot');
      return;
    }

    // Credenciales incorrectas
    setState(() {
      _loginError = 'Credenciales incorrectas. Verifique el correo y la contraseña.';
    });
  }
  
  /// Regresa del flujo de restablecimiento de contraseña al login
  /// 
  /// Resetea:
  /// - La vista actual
  /// - Mensajes de error
  /// - Campos de texto
  /// - Reinicia las animaciones
  void _backToLogin() {
    setState(() {
      _showResetPassword = false;
      _loginError = '';
      _emailController.clear();
      _passwordController.clear();
      _emailError = null;
      _passwordError = null;
    });
    
    // Reinicia las animaciones al regresar al login
    _animationController.reset();
    _animationController.forward();
  }

  // ═══════════════════════════════════════════════════════════════════════════
  // CONSTRUCCIÓN DE LA INTERFAZ PRINCIPAL (LAYOUT RESPONSIVO)
  // ═══════════════════════════════════════════════════════════════════════════
  
  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    final screenWidth = size.width;
    
    // ═══════════════════════════════════════════════════════════════════════
    // BREAKPOINTS ADAPTATIVOS
    // ═══════════════════════════════════════════════════════════════════════
    // Define el comportamiento según el ancho de pantalla:
    // - Móvil: < 600px
    // - Tablet Portrait: 600px - 900px
    // - Tablet Landscape: 900px - 1200px
    // - Desktop: >= 1200px
    
    final bool isMobile = screenWidth < 600;
    final bool isTabletPortrait = screenWidth >= 600 && screenWidth < 900;
    final bool isTabletLandscape = screenWidth >= 900 && screenWidth < 1200;
    final bool isDesktop = screenWidth >= 1200;
    
    // Carrusel visible solo en tablets landscape y desktop
    final bool showCarousel = isTabletLandscape || isDesktop;
    
    // ═══════════════════════════════════════════════════════════════════════
    // CÁLCULO DE ANCHO DEL PANEL DE LOGIN
    // ═══════════════════════════════════════════════════════════════════════
    
    double loginPanelWidth;
    if (isMobile) {
      loginPanelWidth = screenWidth; // Ancho completo
    } else if (isTabletPortrait) {
      loginPanelWidth = screenWidth; // Ancho completo
    } else if (isTabletLandscape) {
      loginPanelWidth = screenWidth * 0.42; // 42% del ancho (carrusel más ancho)
    } else {
      // Desktop: anchos fijos según tamaño total
      loginPanelWidth = screenWidth > 1440 ? 540 : 440;
    }
    
    // ═══════════════════════════════════════════════════════════════════════
    // PADDING ADAPTATIVO
    // ═══════════════════════════════════════════════════════════════════════
    
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
      verticalPadding = 8;
    } else {
      horizontalPadding = 64;
      verticalPadding = 64;
    }

    return Scaffold(
      backgroundColor: LoginStyles.backgroundLight,
      body: Row(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          // ═══════════════════════════════════════════════════════════════════
          // PANEL DEL CARRUSEL (Visible solo en tablet landscape y desktop)
          // ═══════════════════════════════════════════════════════════════════
          if (showCarousel)
            Expanded(
              child: Stack(
                fit: StackFit.expand,
                children: [
                  // ═══════════════════════════════════════════════════════════
                  // Imagen del carrusel con transición fade
                  // ═══════════════════════════════════════════════════════════
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
                  
                  // ═══════════════════════════════════════════════════════════
                  // Botón de navegación izquierda (imagen anterior)
                  // ═══════════════════════════════════════════════════════════
                  Positioned(
                    left: isTabletLandscape ? 16 : 20,
                    top: 0,
                    bottom: 0,
                    child: Center(
                      child: IconButton(
                        iconSize: isTabletLandscape ? 24 : 24,
                        icon: Icon(
                          Icons.arrow_back_ios, 
                          color: Colors.white70,
                          size: isTabletLandscape ? 24 : 24,
                        ),
                        onPressed: () {
                          setState(() {
                            _currentCarouselIndex = (_currentCarouselIndex - 1 + _carouselImages.length) % _carouselImages.length;
                          });
                        },
                      ),
                    ),
                  ),
                  
                  // ═══════════════════════════════════════════════════════════
                  // Botón de navegación derecha (siguiente imagen)
                  // ═══════════════════════════════════════════════════════════
                  Positioned(
                    right: isTabletLandscape ? 16 : 20,
                    top: 0,
                    bottom: 0,
                    child: Center(
                      child: IconButton(
                        iconSize: isTabletLandscape ? 24 : 24,
                        icon: Icon(
                          Icons.arrow_forward_ios, 
                          color: Colors.white70,
                          size: isTabletLandscape ? 24 : 24,
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
                      bottom: 24,
                      left: 0,
                      right: 0,
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: List.generate(
                          _carouselImages.length,
                          (index) => Container(
                            margin: const EdgeInsets.symmetric(horizontal: 6),
                            width: 10,
                            height: 10,
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
            
          // ═══════════════════════════════════════════════════════════════════
          // PANEL DE LOGIN (derecha o completo si no hay carrusel)
          // ═══════════════════════════════════════════════════════════════════
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
                    maxWidth: isTabletLandscape ? 360 : 430,
                  ),
                  // Alterna entre formulario de login y restablecimiento
                  child: _showResetPassword ? _buildResetPasswordView() : _buildLoginForm(),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }

  // ═══════════════════════════════════════════════════════════════════════════
  // FORMULARIO DE LOGIN
  // ═══════════════════════════════════════════════════════════════════════════
  
  /// Construye el formulario principal de inicio de sesión
  /// 
  /// Elementos animados (6 total):
  /// 1. Logo (90ms)
  /// 2. Título (190ms)
  /// 3. Campo de correo (290ms)
  /// 4. Campo de contraseña (390ms)
  /// 5. Botón de inicio de sesión (490ms)
  /// 6. Enlace "¿Olvidaste tu contraseña?" (590ms)
  Widget _buildLoginForm() {
    return Form(
      key: _formKey,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          // ═══════════════════════════════════════════════════════════════════
          // ELEMENTO 1: Logo (Delay 90ms)
          // ═══════════════════════════════════════════════════════════════════
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
          
          // ═══════════════════════════════════════════════════════════════════
          // ELEMENTO 2: Título (Delay 190ms)
          // ═══════════════════════════════════════════════════════════════════
          _buildAnimatedWidget(
            index: 1,
            child: const Text(
              'Iniciar Sesión',
              textAlign: TextAlign.center,
              style: LoginStyles.heading1,
            ),
          ),
          const SizedBox(height: 28),
          
          // ═══════════════════════════════════════════════════════════════════
          // ELEMENTO 3: Campo de Correo (Delay 290ms)
          // ═══════════════════════════════════════════════════════════════════
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
          
          // ═══════════════════════════════════════════════════════════════════
          // ELEMENTO 4: Campo de Contraseña (Delay 390ms)
          // ═══════════════════════════════════════════════════════════════════
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
          
          // Mensaje de error general (si hay credenciales incorrectas)
          if (_loginError.isNotEmpty) ...[
            const SizedBox(height: 18),
            Text(
              _loginError,
              textAlign: TextAlign.center,
              style: LoginStyles.errorText,
            ),
          ],
          
          const SizedBox(height: 28),
          
          // ═══════════════════════════════════════════════════════════════════
          // ELEMENTO 5: Botón Iniciar Sesión (Delay 490ms)
          // ═══════════════════════════════════════════════════════════════════
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
          
          // ═══════════════════════════════════════════════════════════════════
          // ELEMENTO 6: Enlace "¿Olvidaste tu contraseña?" (Delay 590ms)
          // ═══════════════════════════════════════════════════════════════════
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

  // ═══════════════════════════════════════════════════════════════════════════
  // VISTA DE RESTABLECIMIENTO DE CONTRASEÑA
  // ═══════════════════════════════════════════════════════════════════════════
  
  /// Construye la vista del flujo de restablecimiento de contraseña
  /// 
  /// Integra el componente RestablecerPassword que maneja los 4 pasos
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

// ═══════════════════════════════════════════════════════════════════════════
// WIDGET HELPER PARA ANIMACIONES CON DELAY (FADE-UP) - NO UTILIZADO
// ═══════════════════════════════════════════════════════════════════════════
// Este widget fue reemplazado por el sistema de animaciones centralizado
// en _buildAnimatedWidget, pero se conserva por compatibilidad
// ═══════════════════════════════════════════════════════════════════════════

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
