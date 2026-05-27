/// Validaciones migradas desde los FormGroup de Angular.
class FormValidators {
  FormValidators._();

  static final RegExp nombre = RegExp(r'^[a-zA-ZáéíóúÁÉÍÓÚñÑüÜ\s]*$');
  static final RegExp correoAgrovision =
      RegExp(r'^[a-zA-Z0-9._%+-]+@agrovision\.com$');
  static final RegExp correoGmail = RegExp(r'^[a-zA-Z0-9._%+-]+@gmail\.com$');
  static final RegExp telefono10 = RegExp(r'^[0-9]{10}$');
  static final RegExp codigo6 = RegExp(r'^[0-9]{6}$');

  static String? nombreOpcional(String? value) {
    if (value == null || value.isEmpty) return null;
    return nombre.hasMatch(value) ? null : 'Solo se permiten letras';
  }

  static String? requerido(String? value, String mensaje) {
    if (value == null || value.trim().isEmpty) return mensaje;
    return null;
  }

  static String? correoAgrovisionRequerido(String? value) {
    final req = requerido(value, 'El correo corporativo es obligatorio');
    if (req != null) return req;
    return correoAgrovision.hasMatch(value!.trim())
        ? null
        : 'Debe terminar en @agrovision.com';
  }

  static String? correoGmailRequerido(String? value, {String? mensajeReq}) {
    final req = requerido(
      value,
      mensajeReq ?? 'El correo electronico es obligatorio',
    );
    if (req != null) return req;
    return correoGmail.hasMatch(value!.trim())
        ? null
        : 'Debe terminar en @gmail.com';
  }

  static String? correoGmailLogin(String? value) {
    final req = requerido(value, 'El correo es obligatorio');
    if (req != null) return req;
    return correoAgrovision.hasMatch(value!.trim())
        ? null
        : 'Ingrese un correo valido';
  }

  static String? telefono10Requerido(String? value) {
    final req = requerido(value, 'El telefono es obligatorio');
    if (req != null) return req;
    return telefono10.hasMatch(value!.trim())
        ? null
        : 'Ingrese exactamente 10 digitos numericos';
  }

  static String? codigo6Requerido(String? value) {
    final req = requerido(value, 'El codigo es obligatorio');
    if (req != null) return req;
    return codigo6.hasMatch(value!.trim())
        ? null
        : 'Ingresa exactamente 6 numeros';
  }

  static String? contrasenasCoinciden(String? password, String? confirm) {
    if (password == null || confirm == null) return null;
    if (password.isEmpty || confirm.isEmpty) return null;
    return password == confirm ? null : 'Las contrasenas no coinciden';
  }

  static String telefonoParaCartilla(String telefono) {
    final digitos = telefono.replaceAll(RegExp(r'\D'), '');
    if (digitos.length == 10 && digitos.startsWith('0')) {
      return digitos.substring(1);
    }
    return digitos.length > 9 ? digitos.substring(0, 9) : digitos;
  }

  static String telefonoParaFormulario(String telefono) {
    final digitos = telefono.replaceAll(RegExp(r'\D'), '');
    return digitos.length == 9 ? '0$digitos' : digitos;
  }

  static String normalizar(String valor) {
    return valor
        .toLowerCase()
        .replaceAll(RegExp(r'[\u0300-\u036f]'), '')
        .trim();
  }
}
