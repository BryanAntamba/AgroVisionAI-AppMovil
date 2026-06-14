import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import '../styles/autenticacion-styles/password-confirmacion.dart';

class PasswordConfirmacion extends StatefulWidget {
  final VoidCallback? onVolverLogin;
  
  const PasswordConfirmacion({
    super.key,
    this.onVolverLogin,
  });

  @override
  State<PasswordConfirmacion> createState() => _PasswordConfirmacionState();
}

class _PasswordConfirmacionState extends State<PasswordConfirmacion> with TickerProviderStateMixin {
  late AnimationController _animationController;
  late List<Animation<double>> _fadeAnimations;
  late List<Animation<Offset>> _slideAnimations;

  @override
  void initState() {
    super.initState();
    _initializeAnimations();
  }

  void _initializeAnimations() {
    // Duración total: 390ms (último delay) + 720ms (duración animación) = 1110ms
    _animationController = AnimationController(
      duration: const Duration(milliseconds: 1110),
      vsync: this,
    );

    _fadeAnimations = List.generate(4, (index) {
      final delayMs = PasswordConfirmacionStyles.animationDelays[index];
      final startFraction = delayMs / 1110.0;
      final endFraction = (delayMs + 720) / 1110.0;

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

    _slideAnimations = List.generate(4, (index) {
      final delayMs = PasswordConfirmacionStyles.animationDelays[index];
      final startFraction = delayMs / 1110.0;
      final endFraction = (delayMs + 720) / 1110.0;

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

  @override
  Widget build(BuildContext context) {
    return Column(
      key: const ValueKey('finalizado'),
      mainAxisAlignment: MainAxisAlignment.center,
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        // Logo - Delay 1 (90ms)
        _buildAnimatedWidget(
          index: 0,
          child: Image.asset(
            'assets/logotipos/escudo.png',
            height: 140,
            errorBuilder: (context, error, stackTrace) => const FaIcon(
              FontAwesomeIcons.shield,
              size: 140,
              color: PasswordConfirmacionStyles.primaryGreen,
            ),
          ),
        ),
        const SizedBox(height: 24),
        
        // Título - Delay 2 (190ms)
        _buildAnimatedWidget(
          index: 1,
          child: ConstrainedBox(
            constraints: const BoxConstraints(maxWidth: 280),
            child: const Text(
              'Contrasena actualizada',
              textAlign: TextAlign.center,
              style: PasswordConfirmacionStyles.heading1,
            ),
          ),
        ),
        const SizedBox(height: 18),
        
        // Descripción - Delay 3 (290ms)
        _buildAnimatedWidget(
          index: 2,
          child: ConstrainedBox(
            constraints: const BoxConstraints(maxWidth: 320),
            child: const Text(
              'Tu nueva contrasena fue registrada correctamente.',
              textAlign: TextAlign.center,
              style: PasswordConfirmacionStyles.description,
            ),
          ),
        ),
        
        // Enlace "Regresar a iniciar sesión" - Delay 4 (390ms)
        if (widget.onVolverLogin != null)
          _buildAnimatedWidget(
            index: 3,
            child: Padding(
              padding: const EdgeInsets.only(top: 26),
              child: TextButton(
                onPressed: widget.onVolverLogin,
                style: TextButton.styleFrom(
                  foregroundColor: PasswordConfirmacionStyles.linkGreen,
                ),
                child: const Text(
                  'Regresar a iniciar sesión',
                  style: PasswordConfirmacionStyles.confirmationLink,
                ),
              ),
            ),
          ),
      ],
    );
  }
}
