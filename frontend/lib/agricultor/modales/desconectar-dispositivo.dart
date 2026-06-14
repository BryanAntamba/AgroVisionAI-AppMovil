import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import '../../styles/agricultor-styles/modales-styles/desconectar-dispositivo.dart';

class DesconectarDispositivo extends StatefulWidget {
  const DesconectarDispositivo({super.key});

  @override
  State<DesconectarDispositivo> createState() => _DesconectarDispositivoState();
}

class _DesconectarDispositivoState extends State<DesconectarDispositivo> with SingleTickerProviderStateMixin {
  late AnimationController _controller;
  late Animation<double> _fadeAnimation;
  late Animation<Offset> _slideAnimation;

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 300),
    );
    
    _fadeAnimation = CurvedAnimation(
      parent: _controller,
      curve: const Interval(0.0, 0.66, curve: Curves.easeOut),
    );

    _slideAnimation = Tween<Offset>(
      begin: const Offset(0, 20),
      end: Offset.zero,
    ).animate(CurvedAnimation(
      parent: _controller,
      curve: Curves.easeOut,
    ));

    _controller.forward();
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Material(
      type: MaterialType.transparency,
      child: AnimatedBuilder(
        animation: _controller,
        builder: (context, child) {
          return GestureDetector(
            onTap: () => Navigator.pop(context, false),
            child: Container(
              color: DesconectarDispositivoStyles.overlayColor.withValues(
                alpha: DesconectarDispositivoStyles.overlayColor.a * _fadeAnimation.value,
              ),
              child: Center(
                child: GestureDetector(
                  onTap: () {},
                  child: Transform.translate(
                    offset: _slideAnimation.value,
                    child: Opacity(
                      opacity: _controller.value,
                      child: Container(
                        constraints: BoxConstraints(
                          maxWidth: DesconectarDispositivoStyles.maxWidth,
                          maxHeight: MediaQuery.of(context).size.height * 0.9,
                        ),
                        margin: const EdgeInsets.symmetric(horizontal: 16, vertical: 24),
                        padding: const EdgeInsets.only(left: 28, right: 28, top: 28, bottom: 24),
                        decoration: DesconectarDispositivoStyles.modalDecoration,
                        child: Stack(
                          children: [
                            Column(
                              mainAxisSize: MainAxisSize.min,
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                const Text(
                                  '¿Desconectar el dispositivo?',
                                  style: DesconectarDispositivoStyles.titleStyle,
                                ),
                                const SizedBox(height: 16),
                                const Text(
                                  'El monitoreo en tiempo real se detendrá. Podrá conectar el dispositivo nuevamente cuando lo necesite.',
                                  style: DesconectarDispositivoStyles.messageStyle,
                                ),
                                const SizedBox(height: 22),
                                Row(
                                  mainAxisAlignment: MainAxisAlignment.end,
                                  children: [
                                    Expanded(
                                      child: Material(
                                        color: Colors.transparent,
                                        child: InkWell(
                                          onTap: () => Navigator.pop(context, false),
                                          borderRadius: BorderRadius.circular(8),
                                          child: Container(
                                            height: 54,
                                            decoration: DesconectarDispositivoStyles.cancelBtnDecoration,
                                            child: const Center(
                                              child: Text(
                                                'Cancelar',
                                                style: DesconectarDispositivoStyles.cancelBtnStyle,
                                              ),
                                            ),
                                          ),
                                        ),
                                      ),
                                    ),
                                    const SizedBox(width: 10),
                                    Expanded(
                                      child: Material(
                                        color: Colors.transparent,
                                        child: InkWell(
                                          onTap: () => Navigator.pop(context, true),
                                          borderRadius: BorderRadius.circular(8),
                                          child: Container(
                                            height: 54,
                                            decoration: DesconectarDispositivoStyles.disconnectBtnDecoration,
                                            child: Center(
                                              child: Row(
                                                mainAxisAlignment: MainAxisAlignment.center,
                                                children: [
                                                  const FaIcon(
                                                    FontAwesomeIcons.plug,
                                                    color: Colors.white,
                                                    size: 16,
                                                  ),
                                                  const SizedBox(width: 8),
                                                  const Text(
                                                    'Desconectar',
                                                    style: DesconectarDispositivoStyles.disconnectBtnStyle,
                                                  ),
                                                ],
                                              ),
                                            ),
                                          ),
                                        ),
                                      ),
                                    ),
                                  ],
                                ),
                              ],
                            ),
                            Positioned(
                              top: 0,
                              right: 0,
                              child: GestureDetector(
                                onTap: () => Navigator.pop(context, false),
                                child: Container(
                                  width: 40,
                                  height: 40,
                                  decoration: DesconectarDispositivoStyles.closeBtnDecoration,
                                  child: const Center(
                                    child: FaIcon(
                                      FontAwesomeIcons.xmark,
                                      color: DesconectarDispositivoStyles.closeBtnColor,
                                      size: 18,
                                    ),
                                  ),
                                ),
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                  ),
                ),
              ),
            ),
          );
        },
      ),
    );
  }
}