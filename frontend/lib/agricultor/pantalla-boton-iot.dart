import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import '../navbars/barra-agricultor.dart';
import 'boton-iot.dart';

class PantallaBotonIOT extends StatefulWidget {
  const PantallaBotonIOT({super.key});

  @override
  State<PantallaBotonIOT> createState() => _PantallaBotonIOTState();
}

class _PantallaBotonIOTState extends State<PantallaBotonIOT> {
  void _onConectadoDispositivo(bool conectado) async {
    if (conectado) {
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
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFF5FAF3),
      body: Column(
        children: [
          const BarraAgricultor(),
          Expanded(
            child: Center(
              child: SingleChildScrollView(
                child: BotonIOT(onConectado: _onConectadoDispositivo),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
