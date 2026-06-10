class EdicionPlataformaValidaciones {
  static final RegExp nombrePlataformaPattern = RegExp(r'^[A-Za-z0-9\s\-_]+$');

  static String? mensajeNombrePlataforma(String? value) {
    if (value == null || value.trim().isEmpty) {
      return 'El nombre de la plataforma es obligatorio';
    }
    if (value.trim().length < 3) {
      return 'El nombre debe tener al menos 3 caracteres';
    }
    if (value.length > 50) {
      return 'El nombre no puede superar los 50 caracteres';
    }
    if (!nombrePlataformaPattern.hasMatch(value)) {
      return 'Solo se permiten letras, números, espacios, guiones (-) y guiones bajos (_)';
    }
    return null;
  }

  static String? validarLogo({required int sizeBytes, required String mimeType}) {
    const tiposPermitidos = ['image/png', 'image/jpeg', 'image/jpg', 'image/svg+xml'];
    if (!tiposPermitidos.contains(mimeType)) {
      return 'El logo debe ser una imagen PNG, JPG o SVG';
    }
    const maxSize = 2 * 1024 * 1024; // 2MB
    if (sizeBytes > maxSize) {
      return 'El logo no debe superar los 2MB';
    }
    return null;
  }

  static String? validarFavicon({required int sizeBytes, required String mimeType}) {
    const tiposPermitidos = ['image/png', 'image/x-icon', 'image/vnd.microsoft.icon', 'image/svg+xml'];
    if (!tiposPermitidos.contains(mimeType)) {
      return 'El favicon debe ser una imagen PNG, ICO o SVG';
    }
    const maxSize = 500 * 1024; // 500KB
    if (sizeBytes > maxSize) {
      return 'El favicon no debe superar los 500KB';
    }
    return null;
  }

  static String? validarImagenesCarrusel(List<dynamic> imagenes) {
    if (imagenes.isEmpty) {
      return 'Debe mantener al menos una imagen en el carrusel de autenticación';
    }
    return null;
  }

  static String? validarImagenCarrusel({required int sizeBytes, required String mimeType}) {
    const tiposPermitidos = ['image/png', 'image/jpeg', 'image/jpg'];
    if (!tiposPermitidos.contains(mimeType)) {
      return 'Las imágenes del carrusel deben ser PNG o JPG';
    }
    const maxSize = 5 * 1024 * 1024; // 5MB
    if (sizeBytes > maxSize) {
      return 'Cada imagen del carrusel no debe superar los 5MB';
    }
    return null;
  }

  static Map<String, dynamic> validarFormularioCompleto({
    required String nombrePlataforma,
    Map<String, dynamic>? logoFile, // { 'size': int, 'type': String }
    Map<String, dynamic>? faviconFile,
    required List<dynamic> imagenesCarrusel,
  }) {
    final errores = <String>[];

    final errorNombre = mensajeNombrePlataforma(nombrePlataforma);
    if (errorNombre != null) errores.add(errorNombre);

    if (logoFile != null) {
      final errorLogo = validarLogo(
        sizeBytes: logoFile['size'] as int,
        mimeType: logoFile['type'] as String,
      );
      if (errorLogo != null) errores.add(errorLogo);
    }

    if (faviconFile != null) {
      final errorFavicon = validarFavicon(
        sizeBytes: faviconFile['size'] as int,
        mimeType: faviconFile['type'] as String,
      );
      if (errorFavicon != null) errores.add(errorFavicon);
    }

    final errorCarrusel = validarImagenesCarrusel(imagenesCarrusel);
    if (errorCarrusel != null) errores.add(errorCarrusel);

    return {
      'valido': errores.isEmpty,
      'errores': errores,
    };
  }
}
