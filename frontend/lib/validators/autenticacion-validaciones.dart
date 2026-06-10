import 'modales-validaciones.dart';

class AutenticacionValidaciones {
  static const Map<String, String> loginErrors = {
    'emailRequired': 'El correo es obligatorio',
    'emailPattern': 'Ingrese un correo válido',
    'passwordRequired': 'La contraseña es obligatoria',
  };

  static const Map<String, String> cambiarPasswordErrors = {
    'passwordRequired': 'La contraseña es obligatoria',
    'confirmPasswordRequired': 'Confirma la contraseña',
    'passwordsNoCoinciden': 'Las contraseñas no coinciden',
  };

  static const Map<String, String> codigoVerificacionErrors = {
    'codigoRequired': 'El código es obligatorio',
    'codigoPattern': 'Ingresa exactamente 6 números',
    'codigoReenviado': 'Codigo reenviado',
    'limiteReenvios': 'Has alcanzado el límite de reenvíos.\nInténtalo nuevamente en 15 minutos.',
  };

  static const int maxReenviosCodigo = 5;

  static const Map<String, String> restablecerPasswordErrors = {
    'emailRequired': 'El correo es obligatorio',
    'emailPattern': 'Ingrese un correo Gmail válido',
  };

  static String? getLoginEmailError(String? value) {
    if (value == null || value.trim().isEmpty) {
      return loginErrors['emailRequired'];
    }
    if (!value.contains('@')) {
      return loginErrors['emailPattern'];
    }
    return null;
  }

  static String? getLoginPasswordError(String? value) {
    if (value == null || value.isEmpty) {
      return loginErrors['passwordRequired'];
    }
    return null;
  }

  static String? getCambiarPasswordError(String? value) {
    if (value == null || value.isEmpty) {
      return cambiarPasswordErrors['passwordRequired'];
    }
    return null;
  }

  static String? getConfirmarPasswordError(String? password, String? confirmPassword) {
    if (confirmPassword == null || confirmPassword.isEmpty) {
      return cambiarPasswordErrors['confirmPasswordRequired'];
    }
    if (password != confirmPassword) {
      return cambiarPasswordErrors['passwordsNoCoinciden'];
    }
    return null;
  }

  static String? getCodigoVerificacionError(String? value) {
    if (value == null || value.trim().isEmpty) {
      return codigoVerificacionErrors['codigoRequired'];
    }
    if (!ModalesValidaciones.codigoVerificacionPattern.hasMatch(value)) {
      return codigoVerificacionErrors['codigoPattern'];
    }
    return null;
  }

  static bool puedeReenviarCodigo(int intentos) {
    return intentos < maxReenviosCodigo;
  }

  static String getCodigoReenvioMensaje(int intentos) {
    if (intentos <= maxReenviosCodigo) {
      return codigoVerificacionErrors['codigoReenviado']!;
    }
    return codigoVerificacionErrors['limiteReenvios']!;
  }

  static String? getRestablecerPasswordEmailError(String? value) {
    if (value == null || value.trim().isEmpty) {
      return restablecerPasswordErrors['emailRequired'];
    }
    if (!ModalesValidaciones.correoGmailPattern.hasMatch(value)) {
      return restablecerPasswordErrors['emailPattern'];
    }
    return null;
  }

  static String? passwordsNoCoinciden(String? password, String? confirmPassword) {
    return ModalesValidaciones.passwordsCoinciden(password, confirmPassword);
  }
}
