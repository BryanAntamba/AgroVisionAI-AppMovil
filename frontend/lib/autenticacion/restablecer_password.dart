import 'package:flutter/material.dart';
import '../app/app.dart';
import '../core/validaciones/formulario_validaciones_widget.dart';
import '../core/widgets/inputs_autenticacion_widget.dart';
import '../styles/formulario_autenticacion_style.dart';
import '../styles/login_style.dart';
import '../styles/restablecer_password_style.dart';

class RestablecerPasswordScreen extends StatefulWidget {
  const RestablecerPasswordScreen({super.key});

  @override
  State<RestablecerPasswordScreen> createState() =>
      _RestablecerPasswordScreenState();
}

class _RestablecerPasswordScreenState extends State<RestablecerPasswordScreen> {
  final _emailController = TextEditingController();
  String _resetError = '';
  bool _submitted = false;

  static const _correoSimulado = 'usuario@gmail.com';

  @override
  void dispose() {
    _emailController.dispose();
    super.dispose();
  }

  String? _emailError() {
    if (!_submitted) return null;
    return FormValidators.correoGmailRequerido(
      _emailController.text,
      mensajeReq: 'El correo es obligatorio',
    );
  }

  void _enviarCodigo() {
    setState(() {
      _submitted = true;
      _resetError = '';
    });

    if (_emailError() != null) return;

    if (_emailController.text.trim() != _correoSimulado) {
      setState(() {
        _resetError = 'El correo no coincide con el usuario simulado.';
      });
      return;
    }

    Navigator.pushNamed(
      context,
      AgroVisionApp.routeCodigoVerificacion,
      arguments: _emailController.text.trim(),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        decoration: RestablecerPasswordStyle.pageBackground,
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
                  child: Column(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      Image.asset(
                        'assets/logotipos/escudo.png',
                        width: RestablecerPasswordStyle.logoWidth,
                        errorBuilder: (_, __, ___) => const Icon(
                          Icons.eco,
                          size: 72,
                          color: Color(0xFF55A820),
                        ),
                      ),
                      const SizedBox(height: 26),
                      Text(
                        'Restablecer contrasena',
                        style: RestablecerPasswordStyle.title,
                        textAlign: TextAlign.center,
                      ),
                      const SizedBox(height: 14),
                      Text(
                        'Se enviara un codigo de verificacion a tu correo electronico.',
                        style: RestablecerPasswordStyle.description,
                        textAlign: TextAlign.center,
                      ),
                      const SizedBox(height: 24),
                      AuthInputField(
                        label: 'Correo electronico',
                        controller: _emailController,
                        icon: Icons.email_outlined,
                        placeholder: 'usuario@gmail.com',
                        keyboardType: TextInputType.emailAddress,
                        errorText: _emailError(),
                      ),
                      if (_resetError.isNotEmpty) ...[
                        const SizedBox(height: 8),
                        Text(
                          _resetError,
                          style: AuthFormStyle.errorText.copyWith(
                            fontWeight: FontWeight.w800,
                          ),
                          textAlign: TextAlign.center,
                        ),
                      ],
                      const SizedBox(height: 18),
                      SizedBox(
                        width: double.infinity,
                        child: DecoratedBox(
                          decoration: AuthFormStyle.submitButtonDecoration,
                          child: ElevatedButton(
                            onPressed: _enviarCodigo,
                            style: AuthFormStyle.submitButtonStyle,
                            child: const Text('Enviar codigo'),
                          ),
                        ),
                      ),
                      const SizedBox(height: 20),
                      TextButton(
                        onPressed: () => Navigator.pop(context),
                        child: Text(
                          'Volver al inicio de sesion',
                          style: AuthFormStyle.linkButton,
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
  }
}
