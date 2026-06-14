// ═══════════════════════════════════════════════════════════════════════════
// CONFIRMACIÓN DE CAMBIO DE CONTRASEÑA - PANTALLA DE ÉXITO
// ═══════════════════════════════════════════════════════════════════════════
// Pantalla final que confirma al usuario que su contraseña ha sido actualizada
// exitosamente. Marca el final del flujo de restablecimiento de contraseña.
//
// Características principales:
// - Diseño minimalista centrado
// - Logo, título y mensaje de confirmación
// - Animaciones fade-up escalonadas (4 elementos)
// - Enlace opcional para regresar al login
// - Sin interacciones adicionales (pantalla de solo lectura)
// ═══════════════════════════════════════════════════════════════════════════

import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import '../styles/autenticacion-styles/password-confirmacion.dart';

/// Widget Stateful que presenta la confirmación de cambio exitoso
/// 
/// Parámetros opcionales:
/// - [onVolverLogin]: Callback para regresar a la pantalla de login
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
  // ═══════════════════════════════════════════════════════════════════════════
  // CONTROLADORES Y ANIMACIONES
  // ═══════════════════════════════════════════════════════════════════════════
  // Sistema de animaciones fade-up con delays escalonados para 4 elementos:
  // 1. Logo (90ms)
  // 2. Título (190ms)
  // 3. Descripción (290ms)
  // 4. Enlace a login (390ms)
  
  /// Controlador principal de animaciones (duración total: 1110ms)
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
  /// 1. Crea el AnimationController con duración total de 1110ms
  /// 2. Genera 4 animaciones de fade (opacidad 0 → 1)
  /// 3. Genera 4 animaciones de slide (offset 0.34 → 0)
  /// 4. Cada animación tiene su propio delay y usa Interval para timing
  /// 5. Inicia todas las animaciones automáticamente
  void _initializeAnimations() {
    // Duración total: 390ms (último delay) + 720ms (duración animación) = 1110ms
    _animationController = AnimationController(
      duration: const Duration(milliseconds: 1110),
      vsync: this,
    );

    // Genera animaciones de fade-in para cada uno de los 4 elementos
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

    // Genera animaciones de slide-up para cada uno de los 4 elementos
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

    // Inicia las animaciones automáticamente
    _animationController.forward();
  }

  @override
  void dispose() {
    // Libera recursos de animación
    _animationController.dispose();
    super.dispose();
  }

  // ═══════════════════════════════════════════════════════════════════════════
  // BUILDER DE ANIMACIONES
  // ═══════════════════════════════════════════════════════════════════════════
  
  /// Construye un widget con animaciones de fade y slide aplicadas
  /// 
  /// Parámetros:
  /// - [index]: Índice del elemento (0-3) que determina qué animación usar
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
  // CONSTRUCCIÓN DE LA INTERFAZ
  // ═══════════════════════════════════════════════════════════════════════════
  
  @override
  Widget build(BuildContext context) {
    return Column(
      key: const ValueKey('finalizado'), // Clave única para transiciones
      mainAxisAlignment: MainAxisAlignment.center,
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        // ═══════════════════════════════════════════════════════════════════════
        // ELEMENTO 1: Logo (Delay 90ms)
        // ═══════════════════════════════════════════════════════════════════════
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
        
        // ═══════════════════════════════════════════════════════════════════════
        // ELEMENTO 2: Título (Delay 190ms)
        // ═══════════════════════════════════════════════════════════════════════
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
        
        // ═══════════════════════════════════════════════════════════════════════
        // ELEMENTO 3: Mensaje de Confirmación (Delay 290ms)
        // ═══════════════════════════════════════════════════════════════════════
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
        
        // ═══════════════════════════════════════════════════════════════════════
        // ELEMENTO 4: Enlace a Login (Delay 390ms)
        // ═══════════════════════════════════════════════════════════════════════
        // Solo se muestra si se proporcionó el callback onVolverLogin
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
