import 'package:flutter/material.dart';
import '../../styles/panel_agricultor_style.dart';

class PanelAgricultorScreen extends StatelessWidget {
  const PanelAgricultorScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        decoration: PanelAgricultorStyle.pageDecoration,
        alignment: Alignment.center,
        padding: const EdgeInsets.all(32),
        child: Container(
          width: 720,
          constraints: const BoxConstraints(maxWidth: 720),
          padding: const EdgeInsets.all(36),
          decoration: PanelAgricultorStyle.contentCard,
          child: Column(
            mainAxisSize: MainAxisSize.min,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text('AGROVISION AI', style: PanelAgricultorStyle.eyebrow),
              const SizedBox(height: 10),
              Text('Panel Agricultor', style: PanelAgricultorStyle.title),
              const SizedBox(height: 14),
              Text(
                'Bienvenido, agricultor. Desde aqui se revisaran cultivos, '
                'diagnosticos, historial y alertas agricolas.',
                style: PanelAgricultorStyle.body,
              ),
            ],
          ),
        ),
      ),
    );
  }
}
