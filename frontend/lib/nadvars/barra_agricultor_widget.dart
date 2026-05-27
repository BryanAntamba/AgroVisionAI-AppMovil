import 'package:flutter/material.dart';
import '../../styles/barra_agricultor_style.dart';

/// Equivalente a barra-agricultor (placeholder Angular).
class BarraAgricultorWidget extends StatelessWidget {
  const BarraAgricultorWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 72,
      padding: const EdgeInsets.symmetric(horizontal: 28),
      alignment: Alignment.centerLeft,
      decoration: BarraAgricultorStyle.navbarDecoration,
      child: Text('barra-agricultor works!', style: BarraAgricultorStyle.brandText),
    );
  }
}
