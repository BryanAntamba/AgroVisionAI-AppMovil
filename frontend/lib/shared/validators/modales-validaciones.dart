class ModalesValidaciones {
  static final RegExp nombrePattern = RegExp(r'^[a-zA-ZáéíóúÁÉÍÓÚñÑüÜ\s]*$');
  static final RegExp correoCorporativoPattern = RegExp(r'^[a-zA-Z0-9._%+-]+@agrovision\.com$');
  static final RegExp correoGmailPattern = RegExp(r'^[a-zA-Z0-9._%+-]+@gmail\.com$');
  static final RegExp telefonoPattern = RegExp(r'^[0-9]{10}$');
  static final RegExp codigoVerificacionPattern = RegExp(r'^[0-9]{6}$');

  static String? passwordsCoinciden(String? password, String? confirmPassword) {
    if (password == null || confirmPassword == null) {
      return null;
    }
    return password == confirmPassword ? null : mensajesError['passwordMismatch'];
  }

  static const Map<String, String> mensajesError = {
    'required': 'Este campo es obligatorio',
    'nombrePattern': 'Solo se permiten letras',
    'correoCorporativoRequired': 'El correo corporativo es obligatorio',
    'correoCorporativoPattern': 'Debe terminar en @agrovision.com',
    'correoElectronicoRequired': 'El correo electrónico es obligatorio',
    'correoGmailPattern': 'Debe terminar en @gmail.com',
    'telefonoRequired': 'El teléfono es obligatorio',
    'telefonoPattern': 'Ingrese exactamente 10 dígitos numéricos',
    'passwordRequired': 'La contraseña es obligatoria',
    'confirmarPasswordRequired': 'Debe confirmar la contraseña',
    'passwordMismatch': 'Las contraseñas no coinciden',
    'passwordsNoCoinciden': 'Las contraseñas no coinciden',
    'codigoPattern': 'El código debe tener 6 dígitos',
  };
}
