import 'package:flutter/material.dart';
import '../../app/app.dart';
import '../../core/validaciones/formulario_validaciones_widget.dart';
import '../../core/widgets/inputs_autenticacion_widget.dart';
import '../../styles/formulario_autenticacion_style.dart';
import '../../styles/login_style.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({super.key});

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  final _formKey = GlobalKey<FormState>();
  final _emailController = TextEditingController();
  final _passwordController = TextEditingController();

  String _loginError = '';
  bool _submitted = false;

  @override
  void dispose() {
    _emailController.dispose();
    _passwordController.dispose();
    super.dispose();
  }

  void _openResetPassword() {
    Navigator.pushNamed(context, AgroVisionApp.routeRestablecerPassword);
  }

  String? _emailError() {
    if (!_submitted) return null;
    return FormValidators.correoGmailLogin(_emailController.text);
  }

  String? _passwordError() {
    if (!_submitted) return null;
    return FormValidators.requerido(
      _passwordController.text,
      'La contrasena es obligatoria',
    );
  }

  void _onSubmit() {
    setState(() {
      _submitted = true;
      _loginError = '';
    });

    if (_emailError() != null || _passwordError() != null) return;

    final email = _emailController.text.trim();
    final password = _passwordController.text;

    if (email == 'admin@agrovision.com' && password == 'admin123') {
      Navigator.pushReplacementNamed(context, AgroVisionApp.routePanelAdmin);
      return;
    }

    if (email == 'agricultor@agrovision.com' && password == 'agricultor123') {
      Navigator.pushReplacementNamed(context, AgroVisionApp.routePanelAgricultor);
      return;
    }

    setState(() {
      _loginError =
          'Credenciales incorrectas. Verifique el correo y la contrasena.';
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        decoration: LoginStyle.pageBackground,
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
                  child: _loginForm(),
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }

  Widget _loginForm() {
    return Form(
      key: _formKey,
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
            Image.asset(
              'assets/logotipos/escudo.png',
              width: LoginStyle.brandLogoWidth,
              errorBuilder: (_, __, ___) => const Icon(
                Icons.eco,
                size: 80,
                color: Color(0xFF55A820),
              ),
            ),
            const SizedBox(height: 26),
            Text(
              'Iniciar Sesion',
              style: LoginStyle.title,
              textAlign: TextAlign.center,
            ),
            const SizedBox(height: 28),
            AuthInputField(
              label: 'Correo electronico',
              controller: _emailController,
              icon: Icons.email_outlined,
              placeholder: 'Correo corporativo',
              keyboardType: TextInputType.emailAddress,
              errorText: _emailError(),
            ),
            const SizedBox(height: 18),
            AuthInputField(
              label: 'Contrasena',
              controller: _passwordController,
              icon: Icons.lock_outline,
              placeholder: 'Ingresa tu contrasena',
              obscureText: true,
              showToggle: true,
              errorText: _passwordError(),
            ),
            if (_loginError.isNotEmpty) ...[
              const SizedBox(height: 8),
              Text(
                _loginError,
                style: AuthFormStyle.errorText.copyWith(fontSize: 13),
                textAlign: TextAlign.center,
              ),
            ],
            const SizedBox(height: 18),
            SizedBox(
              width: double.infinity,
              child: DecoratedBox(
                decoration: AuthFormStyle.submitButtonDecoration,
                child: ElevatedButton(
                  onPressed: _onSubmit,
                  style: AuthFormStyle.submitButtonStyle,
                  child: const Text('Iniciar Sesion'),
                ),
              ),
            ),
            const SizedBox(height: 20),
            TextButton(
              onPressed: _openResetPassword,
              child: Text(
                '¿Olvidaste tu contrasena?',
                style: AuthFormStyle.linkButton,
              ),
          ),
        ],
      ),
    );
  }
}
