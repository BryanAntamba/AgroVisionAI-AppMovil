// ═══════════════════════════════════════════════════════════════════════════
// IMPORTACIONES
// ═══════════════════════════════════════════════════════════════════════════
import 'dart:async'; // Para Timer y operaciones asíncronas
import 'dart:math'; // Para funciones matemáticas (sin para animación)
import 'package:flutter/material.dart'; // Framework de Flutter
import '../styles/agricultor-styles/boton-iot.dart'; // Estilos del botón IoT
import 'package:shared_preferences/shared_preferences.dart'; // Almacenamiento local
import '../navbars/barra-agricultor.dart'; // Barra de navegación
import '../styles/navbars-styles/barra-agricultor.dart'; // Estilos de barra

// ═══════════════════════════════════════════════════════════════════════════
// ENUM: ConexionState - Estados posibles del dispositivo IoT
// ═══════════════════════════════════════════════════════════════════════════
/// Define los 5 estados del proceso de conexión del dispositivo:
/// - inicial: Estado por defecto, listo para conectar
/// - conectando: Intentando establecer conexión (animación activa)
/// - conectado: Conexión exitosa establecida
/// - errorConexion: Fallo en la conexión (con opción de reintentar)
/// - desconectado: Dispositivo desconectado intencionalmente
enum ConexionState {
  inicial,
  conectando,
  conectado,
  errorConexion,
  desconectado,
}

// ═══════════════════════════════════════════════════════════════════════════
// WIDGET: BotonIOT - Botón inteligente de conexión de dispositivo IoT
// ═══════════════════════════════════════════════════════════════════════════
/// Widget interactivo para conectar/desconectar el dispositivo IoT de monitoreo.
/// 
/// Características:
/// - Animaciones según estado (pulsar, sacudir, parpadear)
/// - Navegación automática al panel tras conectar
/// - Persistencia de estado en SharedPreferences
/// - Dos modos: fullScreen (con navbar) o embebido
/// - Feedback visual con colores y mensajes dinámicos
class BotonIOT extends StatefulWidget {
  final ValueChanged<bool>? onConectado; // Callback opcional al cambiar estado de conexión
  final bool isFullScreen; // true = pantalla completa con navbar, false = embebido

  /// Constructor del botón IoT
  /// @param onConectado: Callback que recibe true/false al conectar/desconectar
  /// @param isFullScreen: Si es true, muestra navbar y ocupa pantalla completa
  const BotonIOT({
    super.key,
    this.onConectado,
    this.isFullScreen = false,
  });

  @override
  State<BotonIOT> createState() => _BotonIOTState();
}

// ═══════════════════════════════════════════════════════════════════════════
// ESTADO: _BotonIOTState - Gestiona estado, animaciones y lógica de conexión
// ═══════════════════════════════════════════════════════════════════════════
class _BotonIOTState extends State<BotonIOT> with TickerProviderStateMixin {
  // ─── ESTADO DE CONEXIÓN ───
  ConexionState _estado = ConexionState.inicial; // Estado actual del dispositivo
  String _descripcion = ''; // Mensaje descriptivo según el estado

  // ─── MENSAJES POR ESTADO ───
  /// Mapa que asocia cada estado con su mensaje correspondiente
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

  // ─── CONSTANTES DE SIMULACIÓN ───
  static const int tiempoConexionMs = 2000; // Tiempo simulado de conexión (2 segundos)

  // ─── CONTROLADORES DE ANIMACIONES ───
  late AnimationController _pulsarController; // Animación de pulsar durante "conectando" (1.5s loop)
  late AnimationController _shakeController; // Animación de sacudida en error (500ms)
  late AnimationController _blinkController; // Animación de parpadeo cuando conectado (1s loop)

  @override
  void initState() {
    super.initState();
    _descripcion = _mensajes[ConexionState.inicial]!; // Inicializa mensaje

    // Configura controladores de animaciones
    _pulsarController = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 1500), // Pulsar: 1.5s por ciclo
    );

    _shakeController = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 500), // Sacudir: 0.5s
    );

    _blinkController = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 1000), // Parpadear: 1s por ciclo
    );
  }

  @override
  void dispose() {
    // Libera recursos de los controladores
    _pulsarController.dispose();
    _shakeController.dispose();
    _blinkController.dispose();
    super.dispose();
  }

  // ═══════════════════════════════════════════════════════════════════════════
  // MÉTODOS DE CONTROL DE CONEXIÓN
  // ═══════════════════════════════════════════════════════════════════════════
  
  /// Inicia el proceso de conexión del dispositivo IoT
  /// Proceso:
  /// 1. Valida que no esté ya conectando o conectado
  /// 2. Cambia a estado "conectando" con animación de pulsar
  /// 3. Simula conexión por 2 segundos
  /// 4. Guarda estado en SharedPreferences
  /// 5. Navega al panel o ejecuta callback según configuración
  void _onConectarDispositivo() {
    // Evita múltiples clicks durante conexión
    if (_estado == ConexionState.conectando ||
        _estado == ConexionState.conectado) {
      return;
    }

    // Cambia a estado "conectando"
    setState(() {
      _estado = ConexionState.conectando;
      _descripcion = _mensajes[ConexionState.conectando]!;
    });

    _pulsarController.repeat(reverse: true); // Inicia animación de pulsar (loop)

    // Simula tiempo de conexión (2 segundos)
    Timer(const Duration(milliseconds: tiempoConexionMs), () async {
      if (!mounted) return; // Verifica que el widget siga montado

      // Detiene animación
      _pulsarController.stop();
      _pulsarController.reset();

      if (widget.onConectado != null) {
        // Modo embebido: ejecuta callback
        widget.onConectado!(true);
      } else if (widget.isFullScreen) {
        // Modo fullScreen: guarda estado y navega
        try {
          final prefs = await SharedPreferences.getInstance();
          await prefs.setString('dispositivoConectado', 'true');
          await prefs.setString('dispositivoDesconectado', 'false');
        } catch (e) {
          debugPrint('Error guardando en SharedPreferences: $e');
        }

        // Navega al panel del agricultor
        if (mounted) {
          Navigator.pushReplacementNamed(context, '/panel-agricultor');
        }
      }
    });
  }

  /// Reinicia el estado a inicial tras un error de conexión
  void _reintentar() {
    setState(() {
      _estado = ConexionState.inicial;
      _descripcion = _mensajes[ConexionState.inicial]!;
    });
  }

  /// Resetea la conexión al estado inicial (usado externamente)
  /// Detiene animaciones y ejecuta callback si existe
  void resetConexion() {
    _blinkController.stop(); // Detiene parpadeo si estaba activo
    setState(() {
      _estado = ConexionState.inicial;
      _descripcion = _mensajes[ConexionState.inicial]!;
    });
    if (widget.onConectado != null) {
      widget.onConectado!(false); // Notifica desconexión
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
