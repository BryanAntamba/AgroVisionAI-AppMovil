import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

class DesconectarDispositivo extends StatelessWidget {
  const DesconectarDispositivo({super.key});

  @override
  Widget build(BuildContext context) {
    return Material(
      type: MaterialType.transparency,
      child: GestureDetector(
        onTap: () => Navigator.pop(context, false),
        child: Container(
          color: const Color.fromRGBO(7, 61, 43, 0.45),
          child: Center(
            child: GestureDetector(
              onTap: () {}, // Evita que se cierre al tocar la tarjeta
              child: Container(
              width: MediaQuery.of(context).size.width > 500 
                  ? 480 
                  : MediaQuery.of(context).size.width * 0.9,
              margin: const EdgeInsets.symmetric(horizontal: 16),
              padding: const EdgeInsets.all(28),
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(8),
                border: Border.all(color: const Color(0xFFD7E4DC)),
                boxShadow: const [
                  BoxShadow(
                    color: Color.fromRGBO(7, 61, 43, 0.2),
                    blurRadius: 48,
                    offset: Offset(0, 24),
                  ),
                ],
              ),
              child: Column(
                mainAxisSize: MainAxisSize.min,
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: [
                  // Botón cerrar (X)
                  Row(
                    mainAxisAlignment: MainAxisAlignment.end,
                    children: [
                      InkWell(
                        onTap: () => Navigator.pop(context, false),
                        borderRadius: BorderRadius.circular(8),
                        child: Container(
                          width: 40,
                          height: 40,
                          decoration: BoxDecoration(
                            color: const Color(0xFFF5FAF3),
                            borderRadius: BorderRadius.circular(8),
                          ),
                          child: const Icon(
                            Icons.close,
                            color: Color(0xFF073D2B),
                            size: 18,
                          ),
                        ),
                      ),
                    ],
                  ),
                  
                  const SizedBox(height: 8),
                  
                  // Título
                  const Text(
                    '¿Desconectar el dispositivo?',
                    textAlign: TextAlign.left,
                    style: TextStyle(
                      fontSize: 28,
                      fontWeight: FontWeight.w800,
                      color: Color(0xFF073D2B),
                      height: 1.15,
                    ),
                  ),
                  
                  const SizedBox(height: 16),
                  
                  // Mensaje
                  const Text(
                    'El monitoreo en tiempo real se detendrá. Podrá conectar el dispositivo nuevamente cuando lo necesite.',
                    style: TextStyle(
                      fontSize: 15,
                      color: Color(0xFF456657),
                      height: 1.5,
                    ),
                  ),
                  
                  const SizedBox(height: 24),
                  
                  // Botones de acción
                  Row(
                    mainAxisAlignment: MainAxisAlignment.end,
                    children: [
                      // Botón Cancelar
                      TextButton(
                        onPressed: () => Navigator.pop(context, false),
                        style: TextButton.styleFrom(
                          minimumSize: const Size(100, 54),
                          padding: const EdgeInsets.symmetric(horizontal: 18),
                          backgroundColor: const Color(0xFFFBFDF9),
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(8),
                            side: const BorderSide(color: Color(0xFFD7E4DC)),
                          ),
                        ),
                        child: const Text(
                          'Cancelar',
                          style: TextStyle(
                            fontSize: 16,
                            fontWeight: FontWeight.w800,
                            color: Color(0xFF073D2B),
                          ),
                        ),
                      ),
                      
                      const SizedBox(width: 10),
                      
                      // Botón Desconectar
                      ElevatedButton(
                        onPressed: () => Navigator.pop(context, true),
                        style: ElevatedButton.styleFrom(
                          minimumSize: const Size(150, 54),
                          padding: const EdgeInsets.symmetric(horizontal: 22),
                          backgroundColor: const Color(0xFFA32626),
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(8),
                          ),
                          elevation: 0,
                          shadowColor: Colors.transparent,
                        ),
                        child: Row(
                          mainAxisSize: MainAxisSize.min,
                          children: const [
                            FaIcon(
                              FontAwesomeIcons.plug,
                              size: 16,
                              color: Colors.white,
                            ),
                            SizedBox(width: 8),
                            Text(
                              'Desconectar',
                              style: TextStyle(
                                fontSize: 16,
                                fontWeight: FontWeight.w800,
                                color: Colors.white,
                              ),
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    ));
  }
}
