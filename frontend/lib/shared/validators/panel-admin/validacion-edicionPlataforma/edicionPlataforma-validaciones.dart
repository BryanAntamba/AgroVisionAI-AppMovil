// ════════════════════════════════════════════════════════════════════════════════
// VALIDACIONES PARA EDICIÓN DE PLATAFORMA
// ════════════════════════════════════════════════════════════════════════════════
// Archivo que contiene todas las validaciones para la configuración de la plataforma
// en el panel de administración. Valida nombre, logo, favicon e imágenes del carrusel
// con restricciones de formato (MIME type), tamaño y cantidad de caracteres.
// ════════════════════════════════════════════════════════════════════════════════

/// Clase que agrupa todas las validaciones estáticas para la edición de plataforma
/// Incluye validación de nombre, logo, favicon e imágenes del carrusel de autenticación
class EdicionPlataformaValidaciones {
  // ══════════════════════════════════════════════════════════════════════════════
  // PATRÓN REGEX PARA NOMBRE DE PLATAFORMA
  // ══════════════════════════════════════════════════════════════════════════════
  
  /// Expresión regular que permite:
  /// - Letras mayúsculas y minúsculas (A-Z, a-z)
  /// - Números (0-9)
  /// - Espacios (\s)
  /// - Guiones (-) y guiones bajos (_)
  static final RegExp nombrePlataformaPattern = RegExp(r'^[A-Za-z0-9\s\-_]+$');

  // ══════════════════════════════════════════════════════════════════════════════
  // VALIDACIÓN DEL NOMBRE DE PLATAFORMA
  // ══════════════════════════════════════════════════════════════════════════════
  
  /// Valida el nombre de la plataforma con 4 reglas:
  /// 1. No puede estar vacío (obligatorio)
  /// 2. Mínimo 3 caracteres después de trim
  /// 3. Máximo 50 caracteres
  /// 4. Debe coincidir con el patrón regex (solo letras, números, espacios, - y _)
  /// 
  /// @param value - Valor del campo nombre de plataforma
  /// @return String? - Mensaje de error o null si es válido
  static String? mensajeNombrePlataforma(String? value) {
    // Regla 1: Validar que no esté vacío o null
    if (value == null || value.trim().isEmpty) {
      return 'El nombre de la plataforma es obligatorio'; // Error: campo requerido
    }
    
    // Regla 2: Validar longitud mínima de 3 caracteres
    if (value.trim().length < 3) {
      return 'El nombre debe tener al menos 3 caracteres'; // Error: muy corto
    }
    
    // Regla 3: Validar longitud máxima de 50 caracteres
    if (value.length > 50) {
      return 'El nombre no puede superar los 50 caracteres'; // Error: muy largo
    }
    
    // Regla 4: Validar patrón regex (caracteres permitidos)
    if (!nombrePlataformaPattern.hasMatch(value)) {
      return 'Solo se permiten letras, números, espacios, guiones (-) y guiones bajos (_)'; // Error: caracteres inválidos
    }
    
    return null; // ✓ Validación exitosa
  }

  // ══════════════════════════════════════════════════════════════════════════════
  // VALIDACIÓN DEL LOGO DE LA PLATAFORMA
  // ══════════════════════════════════════════════════════════════════════════════
  
  /// Valida el archivo del logo con 2 reglas:
  /// 1. Tipo MIME permitido: PNG, JPG, JPEG o SVG
  /// 2. Tamaño máximo: 2 MB (2,097,152 bytes)
  /// 
  /// @param sizeBytes - Tamaño del archivo en bytes
  /// @param mimeType - Tipo MIME del archivo (ej: "image/png")
  /// @return String? - Mensaje de error o null si es válido
  static String? validarLogo({required int sizeBytes, required String mimeType}) {
    // Tipos MIME permitidos para el logo
    const tiposPermitidos = ['image/png', 'image/jpeg', 'image/jpg', 'image/svg+xml'];
    
    // Regla 1: Validar tipo de archivo
    if (!tiposPermitidos.contains(mimeType)) {
      return 'El logo debe ser una imagen PNG, JPG o SVG'; // Error: formato no permitido
    }
    
    // Regla 2: Validar tamaño máximo (2 MB = 2 * 1024 * 1024 bytes)
    const maxSize = 2 * 1024 * 1024; // 2 MB en bytes
    if (sizeBytes > maxSize) {
      return 'El logo no debe superar los 2MB'; // Error: archivo muy pesado
    }
    
    return null; // ✓ Validación exitosa
  }

  // ══════════════════════════════════════════════════════════════════════════════
  // VALIDACIÓN DEL FAVICON DE LA PLATAFORMA
  // ══════════════════════════════════════════════════════════════════════════════
  
  /// Valida el archivo del favicon con 2 reglas:
  /// 1. Tipo MIME permitido: PNG, ICO (icon), o SVG
  /// 2. Tamaño máximo: 500 KB (512,000 bytes)
  /// 
  /// @param sizeBytes - Tamaño del archivo en bytes
  /// @param mimeType - Tipo MIME del archivo (ej: "image/png")
  /// @return String? - Mensaje de error o null si es válido
  static String? validarFavicon({required int sizeBytes, required String mimeType}) {
    // Tipos MIME permitidos para el favicon (incluye formatos específicos de icon)
    const tiposPermitidos = ['image/png', 'image/x-icon', 'image/vnd.microsoft.icon', 'image/svg+xml'];
    
    // Regla 1: Validar tipo de archivo
    if (!tiposPermitidos.contains(mimeType)) {
      return 'El favicon debe ser una imagen PNG, ICO o SVG'; // Error: formato no permitido
    }
    
    // Regla 2: Validar tamaño máximo (500 KB = 500 * 1024 bytes)
    const maxSize = 500 * 1024; // 500 KB en bytes
    if (sizeBytes > maxSize) {
      return 'El favicon no debe superar los 500KB'; // Error: archivo muy pesado
    }
    
    return null; // ✓ Validación exitosa
  }

  // ══════════════════════════════════════════════════════════════════════════════
  // VALIDACIÓN DEL LISTADO DE IMÁGENES DEL CARRUSEL
  // ══════════════════════════════════════════════════════════════════════════════
  
  /// Valida que el carrusel de autenticación tenga al menos una imagen
  /// Regla: Debe mantener al menos 1 imagen (no puede estar vacío)
  /// 
  /// @param imagenes - Lista de imágenes del carrusel
  /// @return String? - Mensaje de error o null si es válido
  static String? validarImagenesCarrusel(List<dynamic> imagenes) {
    // Regla única: Validar que la lista no esté vacía
    if (imagenes.isEmpty) {
      return 'Debe mantener al menos una imagen en el carrusel de autenticación'; // Error: lista vacía
    }
    
    return null; // ✓ Validación exitosa
  }

  // ══════════════════════════════════════════════════════════════════════════════
  // VALIDACIÓN DE UNA IMAGEN INDIVIDUAL DEL CARRUSEL
  // ══════════════════════════════════════════════════════════════════════════════
  
  /// Valida cada imagen del carrusel con 2 reglas:
  /// 1. Tipo MIME permitido: PNG, JPG o JPEG (no permite SVG para carrusel)
  /// 2. Tamaño máximo: 5 MB (5,242,880 bytes)
  /// 
  /// @param sizeBytes - Tamaño del archivo en bytes
  /// @param mimeType - Tipo MIME del archivo (ej: "image/png")
  /// @return String? - Mensaje de error o null si es válido
  static String? validarImagenCarrusel({required int sizeBytes, required String mimeType}) {
    // Tipos MIME permitidos para imágenes del carrusel (solo formatos raster)
    const tiposPermitidos = ['image/png', 'image/jpeg', 'image/jpg'];
    
    // Regla 1: Validar tipo de archivo
    if (!tiposPermitidos.contains(mimeType)) {
      return 'Las imágenes del carrusel deben ser PNG o JPG'; // Error: formato no permitido
    }
    
    // Regla 2: Validar tamaño máximo (5 MB = 5 * 1024 * 1024 bytes)
    const maxSize = 5 * 1024 * 1024; // 5 MB en bytes
    if (sizeBytes > maxSize) {
      return 'Cada imagen del carrusel no debe superar los 5MB'; // Error: archivo muy pesado
    }
    
    return null; // ✓ Validación exitosa
  }

  // ══════════════════════════════════════════════════════════════════════════════
  // VALIDACIÓN COMPLETA DEL FORMULARIO
  // ══════════════════════════════════════════════════════════════════════════════
  
  /// Valida todo el formulario de edición de plataforma en una sola operación
  /// Ejecuta todas las validaciones individuales y retorna un resumen de errores
  /// 
  /// @param nombrePlataforma - Nombre de la plataforma (requerido)
  /// @param logoFile - Mapa con datos del logo: { 'size': int, 'type': String } (opcional)
  /// @param faviconFile - Mapa con datos del favicon: { 'size': int, 'type': String } (opcional)
  /// @param imagenesCarrusel - Lista de imágenes del carrusel (requerido)
  /// @return Map - { 'valido': bool, 'errores': List<String> }
  static Map<String, dynamic> validarFormularioCompleto({
    required String nombrePlataforma, // Nombre de la plataforma (obligatorio)
    Map<String, dynamic>? logoFile, // Datos del logo: { 'size': int, 'type': String }
    Map<String, dynamic>? faviconFile, // Datos del favicon: { 'size': int, 'type': String }
    required List<dynamic> imagenesCarrusel, // Lista de imágenes del carrusel (obligatorio)
  }) {
    // Lista acumuladora de errores de todas las validaciones
    final errores = <String>[];

    // VALIDACIÓN 1: Nombre de plataforma (obligatorio)
    final errorNombre = mensajeNombrePlataforma(nombrePlataforma);
    if (errorNombre != null) errores.add(errorNombre); // Agregar error si existe

    // VALIDACIÓN 2: Logo (opcional, solo valida si se proporciona)
    if (logoFile != null) {
      final errorLogo = validarLogo(
        sizeBytes: logoFile['size'] as int, // Extrae tamaño en bytes
        mimeType: logoFile['type'] as String, // Extrae tipo MIME
      );
      if (errorLogo != null) errores.add(errorLogo); // Agregar error si existe
    }

    // VALIDACIÓN 3: Favicon (opcional, solo valida si se proporciona)
    if (faviconFile != null) {
      final errorFavicon = validarFavicon(
        sizeBytes: faviconFile['size'] as int, // Extrae tamaño en bytes
        mimeType: faviconFile['type'] as String, // Extrae tipo MIME
      );
      if (errorFavicon != null) errores.add(errorFavicon); // Agregar error si existe
    }

    // VALIDACIÓN 4: Lista de imágenes del carrusel (obligatorio)
    final errorCarrusel = validarImagenesCarrusel(imagenesCarrusel);
    if (errorCarrusel != null) errores.add(errorCarrusel); // Agregar error si existe

    // Retorna objeto con resultado de validación y lista de errores
    return {
      'valido': errores.isEmpty, // true si no hay errores, false si hay al menos 1
      'errores': errores, // Lista de mensajes de error (vacía si es válido)
    };
  }
}
