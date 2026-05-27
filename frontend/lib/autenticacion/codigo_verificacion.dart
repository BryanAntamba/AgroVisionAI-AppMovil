import 'package:flutter/material.dart';
import '../app/app.dart';
import '../core/validaciones/formulario_validaciones_widget.dart';
import '../core/widgets/inputs_autenticacion_widget.dart';
import '../styles/codigo_verificacion_style.dart';
import '../styles/formulario_autenticacion_style.dart';
import '../styles/login_style.dart';

class CodigoVerificacionScreen extends StatefulWidget {
  const CodigoVerificacionScreen({super.key, required this.correo});

  final String correo;

  @override
  State<CodigoVerificacionScreen> createState() =>
      _CodigoVerificacionScreenState();
}

class _CodigoVerificacionScreenState extends State<CodigoVerificacionScreen> {
  final _codigoController = TextEditingController();
  bool _submitted = false;

  @override
  void dispose() {
    _codigoController.dispose();
    super.dispose();
  }

  void _normalizarCodigo(String value) {
    var limpio = value.replaceAll(RegExp(r'\D'), '');
    if (limpio.length > 6) limpio = limpio.substring(0, 6);
    if (limpio != _codigoController.text) {
      _codigoController.value = TextEditingValue(
        text: limpio,
        selection: TextSelection.collapsed(offset: limpio.length),
      );
    }
  }

  String? _codigoError() {
    if (!_submitted) return null;
    return FormValidators.codigo6Requerido(_codigoController.text);
  }

  void _verificar() {
    _normalizarCodigo(_codigoController.text);
    setState(() => _submitted = true);
    if (_codigoError() != null) return;
    Navigator.pushNamed(context, AgroVisionApp.routeCambiarPassword);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        decoration: CodigoVerificacionStyle.pageBackground,
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
                        width: CodigoVerificacionStyle.logoWidth,
                        errorBuilder: (_, __, ___) => const Icon(
                          Icons.eco,
                          size: 72,
                          color: Color(0xFF55A820),
                        ),
                      ),
                      const SizedBox(height: 26),
                      Text(
                        'Codigo de verificacion',
                        style: CodigoVerificacionStyle.title,
                        textAlign: TextAlign.center,
                      ),
                      const SizedBox(height: 14),
                      Text(
                        'Ingresa el codigo de 6 digitos enviado a ${widget.correo}.',
                        style: CodigoVerificacionStyle.description,
                        textAlign: TextAlign.center,
                      ),
                      const SizedBox(height: 24),
                      AuthInputField(
                        label: 'Codigo de verificacion',
                        controller: _codigoController,
                        icon: Icons.shield_outlined,
                        placeholder: '000000',
                        keyboardType: TextInputType.number,
                        maxLength: 6,
                        textAlign: TextAlign.center,
                        style: CodigoVerificacionStyle.codeInput,
                        errorText: _codigoError(),
                        onChanged: _normalizarCodigo,
                      ),
                      const SizedBox(height: 18),
                      SizedBox(
                        width: double.infinity,
                        child: DecoratedBox(
                          decoration: AuthFormStyle.submitButtonDecoration,
                          child: ElevatedButton(
                            onPressed: _verificar,
                            style: AuthFormStyle.submitButtonStyle,
                            child: const Text('Verificar codigo'),
                          ),
                        ),
                      ),
                      const SizedBox(height: 20),
                      TextButton(
                        onPressed: () => Navigator.pop(context),
                        child: Text(
                          'Volver',
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
