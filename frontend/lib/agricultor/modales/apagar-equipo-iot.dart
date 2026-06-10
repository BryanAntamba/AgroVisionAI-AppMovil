import 'package:flutter/material.dart';
import '../../styles/agricultor-styles/modales-styles/apagar-equipo-iot.dart';

class ApagarEquipoIOT extends StatelessWidget {
  final VoidCallback onCerrar;
  final VoidCallback onConfirmar;

  const ApagarEquipoIOT({
    super.key,
    required this.onCerrar,
    required this.onConfirmar,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onCerrar,
      child: Container(
        color: ApagarEquipoStyles.backdropColor,
        child: Center(
          child: GestureDetector(
            // Evita que el tap se propague al backdrop
            onTap: () {},
            child: Container(
              constraints: const BoxConstraints(maxWidth: 480),
              margin: const EdgeInsets.symmetric(horizontal: 16, vertical: 24),
              padding: const EdgeInsets.fromLTRB(28, 28, 28, 24),
              decoration: ApagarEquipoStyles.cardDecoration,
              child: Column(
                mainAxisSize: MainAxisSize.min,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  _buildHeader(),
                  const SizedBox(height: 16),
                  _buildMensaje(),
                  const SizedBox(height: 22),
                  _buildActions(),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildHeader() {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Expanded(
          child: Text(
            '¿Apagar el dispositivo?',
            style: ApagarEquipoStyles.tituloStyle,
          ),
        ),
        const SizedBox(width: 8),
        GestureDetector(
          onTap: onCerrar,
          child: Container(
            width: 40,
            height: 40,
            decoration: ApagarEquipoStyles.closeBtnDecoration,
            child: const Icon(
              Icons.close,
              color: ApagarEquipoStyles.darkGreen,
              size: 18,
            ),
          ),
        ),
      ],
    );
  }

  Widget _buildMensaje() {
    return Text(
      'El monitoreo en tiempo real se detendrá. '
      'Podrá reconectar el dispositivo cuando lo necesite.',
      style: ApagarEquipoStyles.mensajeStyle,
    );
  }

  Widget _buildActions() {
    return Row(
      mainAxisAlignment: MainAxisAlignment.end,
      children: [
        // ─── Cancelar ──────────────────────────────────────────────────────
        _CancelButton(onPressed: onCerrar),
        const SizedBox(width: 10),
        // ─── Apagar ────────────────────────────────────────────────────────
        _ApagarButton(onPressed: onConfirmar),
      ],
    );
  }
}

// ─── Botón Cancelar ────────────────────────────────────────────────────────────
class _CancelButton extends StatefulWidget {
  final VoidCallback onPressed;
  const _CancelButton({required this.onPressed});

  @override
  State<_CancelButton> createState() => _CancelButtonState();
}

class _CancelButtonState extends State<_CancelButton> {
  bool _hovered = false;

  @override
  Widget build(BuildContext context) {
    return MouseRegion(
      onEnter: (_) => setState(() => _hovered = true),
      onExit: (_) => setState(() => _hovered = false),
      child: GestureDetector(
        onTap: widget.onPressed,
        child: AnimatedContainer(
          duration: const Duration(milliseconds: 150),
          constraints: const BoxConstraints(minHeight: 54),
          padding: const EdgeInsets.symmetric(horizontal: 18),
          decoration: BoxDecoration(
            color: _hovered
                ? ApagarEquipoStyles.backgroundHover
                : ApagarEquipoStyles.cancelBg,
            border: Border.all(color: ApagarEquipoStyles.borderGrey),
            borderRadius: BorderRadius.circular(8),
          ),
          child: const Center(
            child: Text('Cancelar', style: ApagarEquipoStyles.cancelBtnText),
          ),
        ),
      ),
    );
  }
}

// ─── Botón Apagar ──────────────────────────────────────────────────────────────
class _ApagarButton extends StatefulWidget {
  final VoidCallback onPressed;
  const _ApagarButton({required this.onPressed});

  @override
  State<_ApagarButton> createState() => _ApagarButtonState();
}

class _ApagarButtonState extends State<_ApagarButton> {
  bool _hovered = false;

  @override
  Widget build(BuildContext context) {
    return MouseRegion(
      onEnter: (_) => setState(() => _hovered = true),
      onExit: (_) => setState(() => _hovered = false),
      child: GestureDetector(
        onTap: widget.onPressed,
        child: AnimatedContainer(
          duration: const Duration(milliseconds: 150),
          constraints: const BoxConstraints(minHeight: 54),
          padding: const EdgeInsets.symmetric(horizontal: 22),
          decoration: BoxDecoration(
            color: _hovered
                ? ApagarEquipoStyles.destructivoHover
                : ApagarEquipoStyles.destructivoBg,
            borderRadius: BorderRadius.circular(8),
            boxShadow: _hovered
                ? []
                : const [
                    BoxShadow(
                      color: Color.fromRGBO(163, 38, 38, 0.24),
                      blurRadius: 24,
                      offset: Offset(0, 12),
                    ),
                  ],
          ),
          child: const Row(
            mainAxisSize: MainAxisSize.min,
            children: [
              Icon(Icons.power_settings_new, color: Colors.white, size: 18),
              SizedBox(width: 8),
              Text('Apagar', style: ApagarEquipoStyles.apagarBtnText),
            ],
          ),
        ),
      ),
    );
  }
}
