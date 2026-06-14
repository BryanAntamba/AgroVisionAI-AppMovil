// ════════════════════════════════════════════════════════════════════════════════
// VALIDACIONES PARA MODALES DEL SISTEMA
// ════════════════════════════════════════════════════════════════════════════════
// Archivo que contiene patrones regex y validaciones compartidas para los modales
// del sistema (editar usuario, perfil, etc.). Define patrones para nombres, correos
// corporativos, correos Gmail, teléfonos y códigos de verificación.
// ════════════════════════════════════════════════════════════════════════════════

/// Clase que agrupa patrones regex y funciones de validación compartidas
/// Usada por múltiples modales y formularios a lo largo de la aplicación
class ModalesValidaciones {
  // ══════════════════════════════════════════════════════════════════════════════
  // PATRONES REGEX PARA VALIDACIÓN DE CAMPOS
  // ══════════════════════════════════════════════════════════════════════════════
  
  /// Patrón para nombres: solo letras con acentos y espacios
  /// Acepta: a-z, A-Z, áéíóúÁÉÍÓÚ, ñÑ, üÜ, espacios
  /// No acepta: números, caracteres especiales
  static final RegExp nombrePattern = RegExp(r'^[a-zA-ZáéíóúÁÉÍÓÚñÑüÜ\s]*$');
  
  /// Patrón para correos corporativos: debe terminar en @agrovision.com
  /// Formato: usuario@agrovision.com
  /// Acepta antes del @: letras, números, ., _, %, +, -
  static final RegExp correoCorporativoPattern = RegExp(r'^[a-zA-Z0-9._%+-]+@agrovision\.com$');
  
  /// Patrón para correos Gmail: debe terminar en @gmail.com
  /// Formato: usuario@gmail.com
  /// Acepta antes del @: letras, números, ., _, %, +, -
  static final RegExp correoGmailPattern = RegExp(r'^[a-zA-Z0-9._%+-]+@gmail\.com$');
  
  /// Patrón para teléfonos: exactamente 10 dígitos numéricos
  /// Formato: 1234567890 (sin guiones, espacios ni paréntesis)
  static final RegExp telefonoPattern = RegExp(r'^[0-9]{10}$');
  
  /// Patrón para código de verificación: exactamente 6 dígitos numéricos
  /// Formato: 123456
  static final RegExp codigoVerificacionPattern = RegExp(r'^[0-9]{6}$');

  // ══════════════════════════════════════════════════════════════════════════════
  // FUNCIÓN AUXILIAR PARA VALIDAR COINCIDENCIA DE CONTRASEÑAS
  // ══════════════════════════════════════════════════════════════════════════════
  
  /// Valida que dos contraseñas sean idénticas
  /// Usada en cambio de contraseña y restablecimiento de contraseña
  /// 
  /// @param password - Primera contraseña
  /// @param confirmPassword - Segunda contraseña (confirmación)
  /// @return String? - Mensaje de error si no coinciden, null si coinciden
  static String? passwordsCoinciden(String? password, String? confirmPassword) {
    // Si alguna de las dos es null, no valida (retorna null)
    if (password == null || confirmPassword == null) {
      return null;
    }
    
    // Si ambas existen, compara que sean idénticas
    // Retorna null si coinciden, mensaje de error si no coinciden
    return password == confirmPassword ? null : mensajesError['passwordMismatch'];
  }

  // ══════════════════════════════════════════════════════════════════════════════
  // DICCIONARIO DE MENSAJES DE ERROR PREDEFINIDOS
  // ══════════════════════════════════════════════════════════════════════════════
  
  /// Mapa que contiene todos los mensajes de error estándar para validaciones
  /// Usado por múltiples componentes para mantener consistencia en mensajes
  static const Map<String, String> mensajesError = {
    'required': 'Este campo es obligatorio', // Error genérico para campos obligatorios
    'nombrePattern': 'Solo se permiten letras', // Error para nombres con caracteres inválidos
    'correoCorporativoRequired': 'El correo corporativo es obligatorio', // Error campo correo corporativo vacío
    'correoCorporativoPattern': 'Debe terminar en @agrovision.com', // Error correo corporativo con dominio inválido
    'correoElectronicoRequired': 'El correo electrónico es obligatorio', // Error campo correo vacío
    'correoGmailPattern': 'Debe terminar en @gmail.com', // Error correo Gmail con dominio inválido
    'telefonoRequired': 'El teléfono es obligatorio', // Error campo teléfono vacío
    'telefonoPattern': 'Ingrese exactamente 10 dígitos numéricos', // Error teléfono con formato inválido
    'passwordRequired': 'La contraseña es obligatoria', // Error campo contraseña vacío
    'confirmarPasswordRequired': 'Debe confirmar la contraseña', // Error campo confirmación vacío
    'passwordMismatch': 'Las contraseñas no coinciden', // Error contraseñas no idénticas
    'passwordsNoCoinciden': 'Las contraseñas no coinciden', // Error contraseñas no idénticas (alias)
    'codigoPattern': 'El código debe tener 6 dígitos', // Error código verificación con formato inválido
  };
}
