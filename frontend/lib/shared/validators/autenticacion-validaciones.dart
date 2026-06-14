// ════════════════════════════════════════════════════════════════════════════════
// VALIDACIONES PARA FLUJO DE AUTENTICACIÓN
// ════════════════════════════════════════════════════════════════════════════════
// Archivo que contiene todas las validaciones para el módulo de autenticación.
// Incluye validación para login, cambio de contraseña, código de verificación
// y restablecimiento de contraseña con límite de intentos y temporizador.
// ════════════════════════════════════════════════════════════════════════════════

// Importa validaciones compartidas (modales-validaciones.dart) para usar patrones regex
import 'modales-validaciones.dart';

/// Clase que agrupa todas las validaciones estáticas para el flujo de autenticación
/// Incluye mensajes de error predefinidos y funciones de validación para cada pantalla
class AutenticacionValidaciones {
  // ══════════════════════════════════════════════════════════════════════════════
  // MENSAJES DE ERROR PREDEFINIDOS PARA LOGIN
  // ══════════════════════════════════════════════════════════════════════════════
  
  /// Diccionario de mensajes de error para la pantalla de login
  /// Contiene claves: emailRequired, emailPattern, passwordRequired
  static const Map<String, String> loginErrors = {
    'emailRequired': 'El correo es obligatorio', // Error cuando el campo email está vacío
    'emailPattern': 'Ingrese un correo válido', // Error cuando el formato de email es inválido
    'passwordRequired': 'La contraseña es obligatoria', // Error cuando el campo password está vacío
  };

  // ══════════════════════════════════════════════════════════════════════════════
  // MENSAJES DE ERROR PARA CAMBIO DE CONTRASEÑA
  // ══════════════════════════════════════════════════════════════════════════════
  
  /// Diccionario de mensajes de error para la pantalla de cambio de contraseña
  /// Contiene claves: passwordRequired, confirmPasswordRequired, passwordsNoCoinciden
  static const Map<String, String> cambiarPasswordErrors = {
    'passwordRequired': 'La contraseña es obligatoria', // Error cuando el campo password está vacío
    'confirmPasswordRequired': 'Confirma la contraseña', // Error cuando el campo confirmación está vacío
    'passwordsNoCoinciden': 'Las contraseñas no coinciden', // Error cuando password ≠ confirmPassword
  };

  // ══════════════════════════════════════════════════════════════════════════════
  // MENSAJES Y CONFIGURACIÓN PARA CÓDIGO DE VERIFICACIÓN
  // ══════════════════════════════════════════════════════════════════════════════
  
  /// Diccionario de mensajes de error para la pantalla de código de verificación
  /// Incluye validación de código, reenvío exitoso y límite de reenvíos alcanzado
  static const Map<String, String> codigoVerificacionErrors = {
    'codigoRequired': 'El código es obligatorio', // Error cuando el campo código está vacío
    'codigoPattern': 'Ingresa exactamente 6 números', // Error cuando el código no tiene formato 6 dígitos
    'codigoReenviado': 'Codigo reenviado', // Mensaje de éxito al reenviar código
    'limiteReenvios': 'Has alcanzado el límite de reenvíos.\nInténtalo nuevamente en 15 minutos.', // Error cuando se excede límite
  };

  /// Límite máximo de reenvíos de código de verificación antes del bloqueo temporal
  /// Valor: 5 intentos permitidos
  static const int maxReenviosCodigo = 5;

  // ══════════════════════════════════════════════════════════════════════════════
  // MENSAJES DE ERROR PARA RESTABLECER CONTRASEÑA
  // ══════════════════════════════════════════════════════════════════════════════
  
  /// Diccionario de mensajes de error para la pantalla de restablecer contraseña
  /// Requiere correo Gmail específicamente (no permite otros dominios)
  static const Map<String, String> restablecerPasswordErrors = {
    'emailRequired': 'El correo es obligatorio', // Error cuando el campo email está vacío
    'emailPattern': 'Ingrese un correo Gmail válido', // Error cuando el correo no es @gmail.com
  };

  // ══════════════════════════════════════════════════════════════════════════════
  // FUNCIÓN DE VALIDACIÓN PARA EMAIL DE LOGIN
  // ══════════════════════════════════════════════════════════════════════════════
  
  /// Valida el email en la pantalla de login con 2 reglas:
  /// 1. No puede estar vacío (obligatorio)
  /// 2. Debe contener el símbolo @ (validación básica de formato email)
  /// 
  /// @param value - Valor del campo email
  /// @return String? - Mensaje de error o null si es válido
  static String? getLoginEmailError(String? value) {
    // Regla 1: Validar que no esté vacío o null
    if (value == null || value.trim().isEmpty) {
      return loginErrors['emailRequired']; // Error: campo requerido
    }
    
    // Regla 2: Validar formato básico de email (contiene @)
    if (!value.contains('@')) {
      return loginErrors['emailPattern']; // Error: formato inválido
    }
    
    return null; // ✓ Validación exitosa
  }

  // ══════════════════════════════════════════════════════════════════════════════
  // FUNCIÓN DE VALIDACIÓN PARA PASSWORD DE LOGIN
  // ══════════════════════════════════════════════════════════════════════════════
  
  /// Valida la contraseña en la pantalla de login con 1 regla:
  /// 1. No puede estar vacía (obligatorio)
  /// Nota: No valida longitud mínima ni complejidad en login
  /// 
  /// @param value - Valor del campo password
  /// @return String? - Mensaje de error o null si es válido
  static String? getLoginPasswordError(String? value) {
    // Regla única: Validar que no esté vacío o null
    if (value == null || value.isEmpty) {
      return loginErrors['passwordRequired']; // Error: campo requerido
    }
    
    return null; // ✓ Validación exitosa
  }

  // ══════════════════════════════════════════════════════════════════════════════
  // FUNCIONES DE VALIDACIÓN PARA CAMBIO DE CONTRASEÑA
  // ══════════════════════════════════════════════════════════════════════════════
  
  /// Valida la nueva contraseña en la pantalla de cambio de contraseña con 1 regla:
  /// 1. No puede estar vacía (obligatorio)
  /// 
  /// @param value - Valor del campo nueva contraseña
  /// @return String? - Mensaje de error o null si es válido
  static String? getCambiarPasswordError(String? value) {
    // Regla única: Validar que no esté vacío o null
    if (value == null || value.isEmpty) {
      return cambiarPasswordErrors['passwordRequired']; // Error: campo requerido
    }
    
    return null; // ✓ Validación exitosa
  }

  /// Valida la confirmación de contraseña con 2 reglas:
  /// 1. No puede estar vacía (obligatorio)
  /// 2. Debe coincidir exactamente con la contraseña principal
  /// 
  /// @param password - Valor del campo contraseña principal
  /// @param confirmPassword - Valor del campo confirmar contraseña
  /// @return String? - Mensaje de error o null si es válido
  static String? getConfirmarPasswordError(String? password, String? confirmPassword) {
    // Regla 1: Validar que no esté vacío o null
    if (confirmPassword == null || confirmPassword.isEmpty) {
      return cambiarPasswordErrors['confirmPasswordRequired']; // Error: campo requerido
    }
    
    // Regla 2: Validar que ambas contraseñas sean idénticas
    if (password != confirmPassword) {
      return cambiarPasswordErrors['passwordsNoCoinciden']; // Error: no coinciden
    }
    
    return null; // ✓ Validación exitosa
  }

  // ══════════════════════════════════════════════════════════════════════════════
  // FUNCIONES DE VALIDACIÓN PARA CÓDIGO DE VERIFICACIÓN
  // ══════════════════════════════════════════════════════════════════════════════
  
  /// Valida el código de verificación de 6 dígitos con 2 reglas:
  /// 1. No puede estar vacío (obligatorio)
  /// 2. Debe tener exactamente 6 dígitos numéricos (patrón regex de modales-validaciones)
  /// 
  /// @param value - Valor del campo código de verificación
  /// @return String? - Mensaje de error o null si es válido
  static String? getCodigoVerificacionError(String? value) {
    // Regla 1: Validar que no esté vacío o null
    if (value == null || value.trim().isEmpty) {
      return codigoVerificacionErrors['codigoRequired']; // Error: campo requerido
    }
    
    // Regla 2: Validar patrón regex (exactamente 6 dígitos)
    if (!ModalesValidaciones.codigoVerificacionPattern.hasMatch(value)) {
      return codigoVerificacionErrors['codigoPattern']; // Error: formato inválido
    }
    
    return null; // ✓ Validación exitosa
  }

  /// Verifica si aún se puede reenviar el código de verificación
  /// Compara el número de intentos contra el límite máximo permitido
  /// 
  /// @param intentos - Número de intentos de reenvío realizados
  /// @return bool - true si puede reenviar, false si alcanzó el límite
  static bool puedeReenviarCodigo(int intentos) {
    return intentos < maxReenviosCodigo; // true si intentos < 5, false si intentos >= 5
  }

  /// Retorna el mensaje apropiado según el número de intentos de reenvío
  /// Si está dentro del límite: mensaje de éxito
  /// Si excedió el límite: mensaje de bloqueo temporal (15 minutos)
  /// 
  /// @param intentos - Número de intentos de reenvío realizados
  /// @return String - Mensaje de éxito o error según intentos
  static String getCodigoReenvioMensaje(int intentos) {
    // Si aún puede reenviar (< 5 intentos)
    if (intentos <= maxReenviosCodigo) {
      return codigoVerificacionErrors['codigoReenviado']!; // Mensaje: "Codigo reenviado"
    }
    
    // Si alcanzó el límite (>= 5 intentos)
    return codigoVerificacionErrors['limiteReenvios']!; // Mensaje: "Has alcanzado el límite..."
  }

  // ══════════════════════════════════════════════════════════════════════════════
  // FUNCIONES DE VALIDACIÓN PARA RESTABLECER CONTRASEÑA
  // ══════════════════════════════════════════════════════════════════════════════
  
  /// Valida el email para restablecer contraseña con 2 reglas:
  /// 1. No puede estar vacío (obligatorio)
  /// 2. Debe ser un correo Gmail válido (terminar en @gmail.com)
  /// Usa patrón regex de ModalesValidaciones.correoGmailPattern
  /// 
  /// @param value - Valor del campo email
  /// @return String? - Mensaje de error o null si es válido
  static String? getRestablecerPasswordEmailError(String? value) {
    // Regla 1: Validar que no esté vacío o null
    if (value == null || value.trim().isEmpty) {
      return restablecerPasswordErrors['emailRequired']; // Error: campo requerido
    }
    
    // Regla 2: Validar patrón de Gmail (debe terminar en @gmail.com)
    if (!ModalesValidaciones.correoGmailPattern.hasMatch(value)) {
      return restablecerPasswordErrors['emailPattern']; // Error: no es Gmail
    }
    
    return null; // ✓ Validación exitosa
  }

  /// Alias de la función passwordsCoinciden de ModalesValidaciones
  /// Mantiene compatibilidad con código que usa este nombre de función
  /// Valida que dos contraseñas sean idénticas
  /// 
  /// @param password - Primera contraseña
  /// @param confirmPassword - Segunda contraseña (confirmación)
  /// @return String? - Mensaje de error o null si coinciden
  static String? passwordsNoCoinciden(String? password, String? confirmPassword) {
    return ModalesValidaciones.passwordsCoinciden(password, confirmPassword);
  }
}
