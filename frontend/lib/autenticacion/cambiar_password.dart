import 'package:flutter/material.dart';
import '../app/app.dart';
import '../core/validaciones/formulario_validaciones_widget.dart';
import '../core/widgets/inputs_autenticacion_widget.dart';
import '../styles/cambiar_password_style.dart';
import '../styles/formulario_autenticacion_style.dart';
import '../styles/login_style.dart';

class CambiarPasswordScreen extends StatefulWidget {
  const CambiarPasswordScreen({super.key});

  @override
  State<CambiarPasswordScreen> createState() => _CambiarPasswordScreenState();
}

class _CambiarPasswordScreenState extends State<CambiarPasswordScreen> {
  final _passwordController = TextEditingController();
  final _confirmController = TextEditingController();
  bool _submitted = false;
  bool _finalizado = false;

  @override
  void dispose() {
    _passwordController.dispose();
    _confirmController.dispose();
    super.dispose();
  }

  String? _passwordError() {
    if (!_submitted) return null;
    return FormValidators.requerido(
      _passwordController.text,
      'La contrasena es obligatoria',
    );
  }

  String? _confirmError() {
    if (!_submitted) return null;
    final req = FormValidators.requerido(
      _confirmController.text,
      'Confirma la contrasena',
    );
    if (req != null) return req;
    return FormValidators.contrasenasCoinciden(
      _passwordController.text,
      _confirmController.text,
    );
  }

  void _confirmar() {
    setState(() => _submitted = true);
    if (_passwordError() != null || _confirmError() != null) return;
    setState(() => _finalizado = true);
  }

  void _volverAlLogin() {
    Navigator.pushNamedAndRemoveUntil(
      context,
      AgroVisionApp.routeLogin,
      (_) => false,
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        decoration: CambiarPasswordStyle.pageBackground,
        child: SafeArea(
          child: Center(
            child: SingleChildScrollView(
              physics: const ClampingScrollPhysics(),
              padding: EdgeInsets.fromLTRB(
                20,
                32,
                20,
                MediaQuery.viewInsetsOf(context).bottom + 32,
              ),
              child: ConstrainedBox(
                constraints:
                    const BoxConstraints(maxWidth: LoginStyle.cardMaxWidth),
                child: Container(
                  decoration: LoginStyle.loginPanelDecoration,
                  padding: const EdgeInsets.symmetric(
                    horizontal: 20,
                    vertical: 32,
                  ),
                  child: _finalizado ? _pasoFinalizado() : _formulario(),
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }

  Widget _formulario() {
    return Column(
      mainAxisSize: MainAxisSize.min,
      children: [
        Image.asset(
          'assets/logotipos/escudo.png',
          width: CambiarPasswordStyle.logoWidth,
          errorBuilder: (_, __, ___) =>
              const Icon(Icons.eco, size: 72, color: Color(0xFF55A820)),
        ),
        const SizedBox(height: 26),
        Text(
          'Cambiar contrasena',
          style: CambiarPasswordStyle.title,
          textAlign: TextAlign.center,
        ),
        const SizedBox(height: 14),
        Text(
          'Crea una nueva contrasena y confirmala para finalizar.',
          style: CambiarPasswordStyle.description,
          textAlign: TextAlign.center,
        ),
        const SizedBox(height: 24),
        AuthInputField(
          label: 'Nueva contrasena',
          controller: _passwordController,
          icon: Icons.lock_outline,
          placeholder: 'Nueva contrasena',
          obscureText: true,
          showToggle: true,
          errorText: _passwordError(),
        ),
        const SizedBox(height: 18),
        AuthInputField(
          label: 'Confirmar contrasena',
          controller: _confirmController,
          icon: Icons.shield_outlined,
          placeholder: 'Confirma tu contrasena',
          obscureText: true,
          showToggle: true,
          errorText: _confirmError(),
        ),
        const SizedBox(height: 18),
        SizedBox(
          width: double.infinity,
          child: DecoratedBox(
            decoration: AuthFormStyle.submitButtonDecoration,
            child: ElevatedButton(
              onPressed: _confirmar,
              style: AuthFormStyle.submitButtonStyle,
              child: const Text('Confirmar contrasena'),
            ),
          ),
        ),
      ],
    );
  }

  Widget _pasoFinalizado() {
    return Column(
      mainAxisSize: MainAxisSize.min,
      children: [
        Image.asset(
          'assets/logotipos/escudo.png',
          width: CambiarPasswordStyle.logoWidth,
          errorBuilder: (_, __, ___) =>
              const Icon(Icons.eco, size: 72, color: Color(0xFF55A820)),
        ),
        const SizedBox(height: 26),
        Text(
          'Contrasena actualizada',
          style: CambiarPasswordStyle.title,
          textAlign: TextAlign.center,
        ),
        const SizedBox(height: 14),
        Text(
          'Tu nueva contrasena fue registrada correctamente.',
          style: CambiarPasswordStyle.description,
          textAlign: TextAlign.center,
        ),
        const SizedBox(height: 24),
        SizedBox(
          width: double.infinity,
          child: DecoratedBox(
            decoration: AuthFormStyle.submitButtonDecoration,
            child: ElevatedButton(
              onPressed: _volverAlLogin,
              style: AuthFormStyle.submitButtonStyle,
              child: const Text('Ir al inicio de sesion'),
            ),
          ),
        ),
      ],
    );
  }
}
