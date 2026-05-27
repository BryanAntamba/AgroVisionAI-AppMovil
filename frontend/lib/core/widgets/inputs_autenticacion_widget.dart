import 'package:flutter/material.dart';
import '../../styles/formulario_autenticacion_style.dart';

class AuthInputField extends StatefulWidget {
  const AuthInputField({
    super.key,
    required this.label,
    required this.controller,
    this.icon = Icons.edit_outlined,
    this.placeholder,
    this.obscureText = false,
    this.readOnly = false,
    this.keyboardType,
    this.maxLength,
    this.errorText,
    this.onChanged,
    this.showToggle = false,
    this.textAlign,
    this.style,
  });

  final String label;
  final TextEditingController controller;
  final IconData icon;
  final String? placeholder;
  final bool obscureText;
  final bool readOnly;
  final TextInputType? keyboardType;
  final int? maxLength;
  final String? errorText;
  final ValueChanged<String>? onChanged;
  final bool showToggle;
  final TextAlign? textAlign;
  final TextStyle? style;

  @override
  State<AuthInputField> createState() => _AuthInputFieldState();
}

class _AuthInputFieldState extends State<AuthInputField> {
  bool _focused = false;
  bool _visible = false;

  @override
  Widget build(BuildContext context) {
    final obscure = widget.obscureText && !_visible;

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(widget.label, style: AuthFormStyle.label()),
        const SizedBox(height: 8),
        Focus(
          onFocusChange: (v) => setState(() => _focused = v),
          child: AnimatedContainer(
            duration: const Duration(milliseconds: 180),
            height: 54,
            decoration: AuthFormStyle.inputShellDecoration(focused: _focused),
            child: Row(
              children: [
                SizedBox(
                  width: 48,
                  child: Icon(widget.icon, color: const Color(0xFF55A820)),
                ),
                Expanded(
                  child: TextField(
                    controller: widget.controller,
                    readOnly: widget.readOnly,
                    obscureText: obscure,
                    keyboardType: widget.keyboardType,
                    maxLength: widget.maxLength,
                    onChanged: widget.onChanged,
                    textAlign: widget.textAlign ?? TextAlign.start,
                    style: widget.style ??
                        const TextStyle(color: Color(0xFF073D2B)),
                    decoration: InputDecoration(
                      counterText: '',
                      border: InputBorder.none,
                      hintText: widget.placeholder,
                      hintStyle: const TextStyle(color: Color(0xFF7D9186)),
                    ),
                  ),
                ),
                if (widget.showToggle && !widget.readOnly)
                  IconButton(
                    onPressed: () => setState(() => _visible = !_visible),
                    icon: Icon(
                      obscure ? Icons.visibility : Icons.visibility_off,
                    ),
                  ),
              ],
            ),
          ),
        ),
        if (widget.errorText != null) ...[
          const SizedBox(height: 7),
          Text(widget.errorText!, style: AuthFormStyle.errorText),
        ],
      ],
    );
  }
}
