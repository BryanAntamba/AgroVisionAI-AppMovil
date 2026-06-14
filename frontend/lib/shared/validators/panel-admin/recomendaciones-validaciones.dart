// ════════════════════════════════════════════════════════════════════════════════
// VALIDACIONES PARA RECOMENDACIONES AGRÍCOLAS
// ════════════════════════════════════════════════════════════════════════════════
// Archivo que contiene todas las validaciones para el módulo de recomendaciones
// del panel de administración. Valida título, descripción, acción recomendada y
// campos de selección con restricciones de longitud y caracteres permitidos.
// ════════════════════════════════════════════════════════════════════════════════

/// Clase que agrupa todas las validaciones estáticas para el CRUD de recomendaciones
/// Incluye validación de texto descriptivo con caracteres especiales y campos de selección
class RecomendacionesValidaciones {
  // ══════════════════════════════════════════════════════════════════════════════
  // PATRONES REGEX PARA VALIDACIÓN DE CAMPOS
  // ══════════════════════════════════════════════════════════════════════════════
  
  /// Patrón para títulos: solo letras (con acentos), números y espacios
  /// Acepta: a-z, A-Z, áéíóúÁÉÍÓÚ, ñÑ, üÜ, 0-9, espacios
  static final RegExp tituloPattern = RegExp(r'^[a-zA-ZáéíóúÁÉÍÓÚñÑüÜ0-9\s]+$');
  
  /// Patrón para texto descriptivo: letras, números, espacios y caracteres especiales comunes
  /// Acepta: caracteres de tituloPattern + (), ., ,, :, %, °
  /// Máximo: 500 caracteres (definido en el regex con {1,500})
  static final RegExp textoDescriptivoPattern =
      RegExp(r'^[a-zA-ZáéíóúÁÉÍÓÚñÑüÜ0-9\s().,:%°]{1,500}$');
  
  /// Patrón para acciones recomendadas: similar a textoDescriptivo pero sin límite de caracteres en regex
  /// Acepta: letras, números, espacios y caracteres especiales (), ., ,, :, %, °
  static final RegExp accionPattern =
      RegExp(r'^[a-zA-ZáéíóúÁÉÍÓÚñÑüÜ0-9\s().,:%°]+$');

  // ══════════════════════════════════════════════════════════════════════════════
  // VALIDACIÓN DEL TÍTULO DE RECOMENDACIÓN
  // ══════════════════════════════════════════════════════════════════════════════
  
  /// Valida el título de la recomendación con 3 reglas:
  /// 1. No puede estar vacío (obligatorio)
  /// 2. Máximo 100 caracteres
  /// 3. Solo letras (con acentos), números y espacios
  /// 
  /// @param value - Valor del campo título
  /// @return String? - Mensaje de error o null si es válido
  static String? mensajeTitulo(String? value) {
    // Regla 1: Validar que no esté vacío o null
    if (value == null || value.trim().isEmpty) {
      return 'El título es obligatorio.'; // Error: campo requerido
    }
    
    // Regla 2: Validar longitud máxima de 100 caracteres
    if (value.length > 100) {
      return 'Máximo se permite 100 caracteres de ingreso.'; // Error: muy largo
    }
    
    // Regla 3: Validar patrón regex (solo letras, números y espacios)
    if (!tituloPattern.hasMatch(value)) {
      return 'Solo se permiten letras, números y espacios.'; // Error: caracteres inválidos
    }
    
    return null; // ✓ Validación exitosa
  }

  // ══════════════════════════════════════════════════════════════════════════════
  // VALIDACIÓN DE LA DESCRIPCIÓN DE RECOMENDACIÓN
  // ══════════════════════════════════════════════════════════════════════════════
  
  /// Valida la descripción de la recomendación con 3 reglas:
  /// 1. No puede estar vacía (obligatorio)
  /// 2. Máximo 500 caracteres
  /// 3. Debe cumplir con patrón de texto descriptivo (incluye caracteres especiales)
  /// 
  /// @param value - Valor del campo descripción
  /// @return String? - Mensaje de error o null si es válido
  static String? mensajeDescripcion(String? value) {
    // Regla 1: Validar que no esté vacío o null
    if (value == null || value.trim().isEmpty) {
      return 'La descripción es obligatoria.'; // Error: campo requerido
    }
    
    // Regla 2: Validar longitud máxima de 500 caracteres
    if (value.length > 500) {
      return 'Máximo 500 caracteres.'; // Error: muy largo
    }
    
    // Regla 3: Validar patrón regex (texto descriptivo con caracteres especiales)
    if (!textoDescriptivoPattern.hasMatch(value)) {
      return 'Ingrese una descripcion valida en el campo requerido'; // Error: caracteres inválidos
    }
    
    return null; // ✓ Validación exitosa
  }

  // ══════════════════════════════════════════════════════════════════════════════
  // VALIDACIÓN DE LA ACCIÓN RECOMENDADA
  // ══════════════════════════════════════════════════════════════════════════════
  
  /// Valida la acción recomendada con 2 reglas:
  /// 1. No puede estar vacía (obligatorio)
  /// 2. Debe cumplir con patrón de texto descriptivo (incluye caracteres especiales)
  /// 
  /// @param value - Valor del campo acción recomendada
  /// @return String? - Mensaje de error o null si es válido
  static String? mensajeAccion(String? value) {
    // Regla 1: Validar que no esté vacío o null
    if (value == null || value.trim().isEmpty) {
      return 'La acción recomendada es obligatoria.'; // Error: campo requerido
    }
    
    // Regla 2: Validar patrón regex (texto con caracteres especiales permitidos)
    if (!accionPattern.hasMatch(value)) {
      return 'Ingrese una descripcion valida en el campo requerido'; // Error: caracteres inválidos
    }
    
    return null; // ✓ Validación exitosa
  }

  // ══════════════════════════════════════════════════════════════════════════════
  // VALIDACIÓN GENÉRICA DE CAMPOS DE SELECCIÓN (DROPDOWNS)
  // ══════════════════════════════════════════════════════════════════════════════
  
  /// Valida campos de selección (dropdowns) con 1 regla:
  /// 1. No puede estar vacío o null (obligatorio)
  /// 
  /// @param value - Valor del campo select
  /// @param nombre - Nombre del campo para personalizar el mensaje de error
  /// @return String? - Mensaje de error o null si es válido
  static String? mensajeSelect(String? value, String nombre) {
    // Regla única: Validar que no esté vacío o null
    if (value == null || value.trim().isEmpty) {
      return '$nombre es obligatorio.'; // Error: campo requerido (incluye nombre dinámico)
    }
    
    return null; // ✓ Validación exitosa
  }
}
