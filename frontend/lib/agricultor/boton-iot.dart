import 'dart:async';
import 'dart:math';
import 'package:flutter/material.dart';
import '../styles/agricultor-styles/boton-iot.dart';
import 'package:shared_preferences/shared_preferences.dart';
import '../navbars/barra-agricultor.dart';
import '../styles/navbars-styles/barra-agricultor.dart';

enum ConexionState {
  inicial,
  conectando,
  conectado,
  errorConexion,
  desconectado,
}

class BotonIOT extends StatefulWidget {
  final ValueChanged<bool>? onConectado;
  final bool isFullScreen;

  const BotonIOT({
    super.key,
    this.onConectado,
    this.isFullScreen = false,
  });

  @override
  State<BotonIOT> createState() => _BotonIOTState();
}

class _BotonIOTState extends State<BotonIOT> with TickerProviderStateMixin {
  ConexionState _estado = ConexionState.inicial;
  String _descripcion = '';

  static const Map<ConexionState, String> _mensajes = {
    ConexionState.inicial:
        'Apriete el botón para conectar el dispositivo AgroVision AI',
    ConexionState.conectando:
        'Conectando con el dispositivo, por favor espere...',
    ConexionState.conectado: 'Dispositivo conectado exitosamente',
    ConexionState.errorConexion:
        'No se pudo conectar con el dispositivo AgroVision AI. Verifique que el dispositivo esté encendido y dentro del alcance de la red.',
    ConexionState.desconectado: 'Dispositivo desconectado',
  };

  // Constantes de simulación
  static const int tiempoConexionMs = 2000;

  late AnimationController _pulsarController;
  late AnimationController _shakeController;
  late AnimationController _blinkController;

  @override
  void initState() {
    super.initState();
    _descripcion = _mensajes[ConexionState.inicial]!;

    _pulsarController = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 1500),
    );

    _shakeController = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 500),
    );

    _blinkController = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 1000),
    );
  }

  @override
  void dispose() {
    _pulsarController.dispose();
    _shakeController.dispose();
    _blinkController.dispose();
    super.dispose();
  }

  void _onConectarDispositivo() {
    if (_estado == ConexionState.conectando ||
        _estado == ConexionState.conectado) {
      return;
    }

    setState(() {
      _estado = ConexionState.conectando;
      _descripcion = _mensajes[ConexionState.conectando]!;
    });

    _pulsarController.repeat(reverse: true);

    // Navegar directamente después de un breve delay
    Timer(const Duration(milliseconds: tiempoConexionMs), () async {
      if (!mounted) return;

      _pulsarController.stop();
      _pulsarController.reset();

      if (widget.onConectado != null) {
        widget.onConectado!(true);
      } else if (widget.isFullScreen) {
        // Guardar estado de conexión
        try {
          final prefs = await SharedPreferences.getInstance();
          await prefs.setString('dispositivoConectado', 'true');
          await prefs.setString('dispositivoDesconectado', 'false');
        } catch (e) {
          debugPrint('Error guardando en SharedPreferences: $e');
        }

        // Navegar inmediatamente al panel del agricultor
        if (mounted) {
          Navigator.pushReplacementNamed(context, '/panel-agricultor');
        }
      }
    });
  }

  void _reintentar() {
    setState(() {
      _estado = ConexionState.inicial;
      _descripcion = _mensajes[ConexionState.inicial]!;
    });
  }

  void resetConexion() {
    _blinkController.stop();
    setState(() {
      _estado = ConexionState.inicial;
      _descripcion = _mensajes[ConexionState.inicial]!;
    });
    if (widget.onConectado != null) {
      widget.onConectado!(false);
    }
  }

  @override
  Widget build(BuildContext context) {
    Widget buttonContent = Center(
      child: Container(
        width: double.infinity,
        constraints: const BoxConstraints(maxWidth: 600),
        padding: const EdgeInsets.symmetric(vertical: 60, horizontal: 20),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            // Logo con sombra
            Container(
              decoration: BoxDecoration(
                boxShadow: [
                  BoxShadow(
                    color: BotonIotStyles.darkGreen.withValues(alpha: 0.1),
                    blurRadius: 20,
                    offset: const Offset(0, 10),
                  ),
                ],
              ),
              child: Image.asset(
                'assets/logotipos/escudo.png',
                width: 200,
                height: 200,
                fit: BoxFit.contain,
                errorBuilder: (context, error, stackTrace) => const Icon(
                  Icons.shield,
                  size: 200,
                  color: BotonIotStyles.primaryGreen,
                ),
              ),
            ),
            const SizedBox(height: 24),

            // Título AgroVisionAI
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: const [
                Text('AgroVision', style: BotonIotStyles.titleText),
                Text('AI', style: BotonIotStyles.titleText),
              ],
            ),
            const SizedBox(height: 32),

            // Botón de conexión
            _buildBotonConexion(),

            const SizedBox(height: 24),

            // Descripción del estado
            Container(
              constraints: const BoxConstraints(maxWidth: 400),
              child: Text(
                _descripcion,
                textAlign: TextAlign.center,
                style: _estado == ConexionState.errorConexion
                    ? BotonIotStyles.descriptionErrorText
                    : BotonIotStyles.descriptionText,
              ),
            ),

            // Botón reintentar (solo en error)
            if (_estado == ConexionState.errorConexion) ...[
              const SizedBox(height: 20),
              _buildBotonReintentar(),
            ],

            // Indicador de conexión exitosa
            if (_estado == ConexionState.conectado) ...[
              const SizedBox(height: 18),
              _buildIndicadorConexion(),
            ],
          ],
        ),
      ),
    );

    if (widget.isFullScreen) {
      return Scaffold(
        backgroundColor: const Color(0xFFF5FAF3),
        body: Stack(
          children: [
            Positioned.fill(
              child: Column(
                children: [
                  SizedBox(
                    height: MediaQuery.of(context).size.width > 991
                        ? BarraAgricultorStyles.navbarHeight +
                            BarraAgricultorStyles.contentPaddingTop +
                            (BarraAgricultorStyles.navbarPaddingVertical * 2)
                        : BarraAgricultorStyles.navbarHeight +
                            BarraAgricultorStyles.contentPaddingTop +
                            (BarraAgricultorStyles.navbarPaddingVertical * 2),
                  ),
                  Expanded(
                    child: SingleChildScrollView(
                      child: buttonContent,
                    ),
                  ),
                ],
              ),
            ),
            Positioned(
              top: 0,
              left: 0,
              right: 0,
              child: const BarraAgricultor(),
            ),
          ],
        ),
      );
    }

    return buttonContent;
  }

  Widget _buildBotonConexion() {
    BoxDecoration decoration;
    Color iconColor;

    switch (_estado) {
      case ConexionState.conectando:
        decoration = BoxDecoration(
          shape: BoxShape.circle,
          gradient: const LinearGradient(
            colors: [BotonIotStyles.orange, BotonIotStyles.orangeDark],
            begin: Alignment.topLeft,
            end: Alignment.bottomRight,
          ),
          border: Border.all(color: BotonIotStyles.orange, width: 4),
          boxShadow: const [
            BoxShadow(
              color: Color.fromRGBO(255, 152, 0, 0.25),
              blurRadius: 24,
              offset: Offset(0, 8),
            ),
          ],
        );
        iconColor = Colors.white;
        break;
      case ConexionState.conectado:
        decoration = BoxDecoration(
          shape: BoxShape.circle,
          gradient: const LinearGradient(
            colors: [BotonIotStyles.darkGreen, BotonIotStyles.primaryGreen],
            begin: Alignment.topLeft,
            end: Alignment.bottomRight,
          ),
          border: Border.all(color: BotonIotStyles.primaryGreen, width: 4),
          boxShadow: const [
            BoxShadow(
              color: Color.fromRGBO(85, 168, 32, 0.25),
              blurRadius: 24,
              offset: Offset(0, 8),
            ),
          ],
        );
        iconColor = Colors.white;
        break;
      case ConexionState.errorConexion:
        decoration = BoxDecoration(
          shape: BoxShape.circle,
          gradient: const LinearGradient(
            colors: [BotonIotStyles.errorRed, Color(0xFF9A2424)],
            begin: Alignment.topLeft,
            end: Alignment.bottomRight,
          ),
          border: Border.all(color: BotonIotStyles.errorRed, width: 4),
          boxShadow: const [
            BoxShadow(
              color: Color.fromRGBO(198, 40, 40, 0.25),
              blurRadius: 24,
              offset: Offset(0, 8),
            ),
          ],
        );
        iconColor = Colors.white;
        break;
      default: // inicial o desconectado
        decoration = BoxDecoration(
          shape: BoxShape.circle,
          color: const Color(0xFFFDFEFE),
          border: Border.all(color: const Color(0xFFC8D8CE), width: 4),
          boxShadow: const [
            BoxShadow(
              color: Color.fromRGBO(7, 61, 43, 0.05),
              blurRadius: 12,
              offset: Offset(0, 4),
            ),
          ],
        );
        iconColor = BotonIotStyles.darkGreen;
    }

    Widget button = GestureDetector(
      onTap: _onConectarDispositivo,
      child: AnimatedContainer(
        duration: const Duration(milliseconds: 300),
        curve: Curves.easeInOut,
        width: 100,
        height: 100,
        decoration: decoration,
        child: Center(
          child: Icon(Icons.power_settings_new, color: iconColor, size: 40),
        ),
      ),
    );

    // Animación de pulsar cuando está conectando
    if (_estado == ConexionState.conectando) {
      button = ScaleTransition(
        scale: Tween<double>(begin: 1.0, end: 1.05).animate(
          CurvedAnimation(parent: _pulsarController, curve: Curves.easeInOut),
        ),
        child: button,
      );
    }

    // Animación de sacudida cuando hay error
    if (_estado == ConexionState.errorConexion) {
      button = AnimatedBuilder(
        animation: _shakeController,
        builder: (context, child) {
          final sineValue = sin(3 * pi * _shakeController.value);
          return Transform.translate(
            offset: Offset(sineValue * 10, 0),
            child: child,
          );
        },
        child: button,
      );
    }

    return button;
  }

  Widget _buildBotonReintentar() {
    return InkWell(
      onTap: _reintentar,
      borderRadius: BorderRadius.circular(8),
      child: Container(
        padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 12),
        decoration: BoxDecoration(
          color: Colors.white,
          border: Border.all(color: BotonIotStyles.primaryGreen, width: 2),
          borderRadius: BorderRadius.circular(8),
          boxShadow: const [
            BoxShadow(
              color: Color.fromRGBO(85, 168, 32, 0.1),
              blurRadius: 12,
              offset: Offset(0, 4),
            ),
          ],
        ),
        child: Row(
          mainAxisSize: MainAxisSize.min,
          children: const [
            Icon(Icons.refresh, color: BotonIotStyles.primaryGreen, size: 20),
            SizedBox(width: 8),
            Text(
              'Reintentar',
              style: TextStyle(
                color: BotonIotStyles.primaryGreen,
                fontSize: 16,
                fontWeight: FontWeight.w800,
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildIndicadorConexion() {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
      decoration: BoxDecoration(
        color: const Color(0xFFEDF5E9),
        borderRadius: BorderRadius.circular(20),
      ),
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          FadeTransition(
            opacity: Tween<double>(begin: 1.0, end: 0.4).animate(
              CurvedAnimation(
                parent: _blinkController,
                curve: Curves.easeInOut,
              ),
            ),
            child: Container(
              width: 10,
              height: 10,
              decoration: const BoxDecoration(
                color: BotonIotStyles.primaryGreen,
                shape: BoxShape.circle,
              ),
            ),
          ),
          const SizedBox(width: 8),
          const Text(
            'Dispositivo conectado',
            style: BotonIotStyles.indicatorText,
          ),
        ],
      ),
    );
  }
}
