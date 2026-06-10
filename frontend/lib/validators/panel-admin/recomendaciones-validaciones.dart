class RecomendacionesValidaciones {
  static final RegExp tituloPattern = RegExp(r'^[a-zA-ZáéíóúÁÉÍÓÚñÑüÜ0-9\s]+$');
  static final RegExp textoDescriptivoPattern =
      RegExp(r'^[a-zA-ZáéíóúÁÉÍÓÚñÑüÜ0-9\s().,:%°]{1,500}$');
  static final RegExp accionPattern =
      RegExp(r'^[a-zA-ZáéíóúÁÉÍÓÚñÑüÜ0-9\s().,:%°]+$');

  static String? mensajeTitulo(String? value) {
    if (value == null || value.trim().isEmpty) {
      return 'El título es obligatorio.';
    }
    if (value.length > 100) {
      return 'Máximo se permite 100 caracteres de ingreso.';
    }
    if (!tituloPattern.hasMatch(value)) {
      return 'Solo se permiten letras, números y espacios.';
    }
    return null;
  }

  static String? mensajeDescripcion(String? value) {
    if (value == null || value.trim().isEmpty) {
      return 'La descripción es obligatoria.';
    }
    if (value.length > 500) {
      return 'Máximo 500 caracteres.';
    }
    if (!textoDescriptivoPattern.hasMatch(value)) {
      return 'Ingrese una descripcion valida en el campo requerido';
    }
    return null;
  }

  static String? mensajeAccion(String? value) {
    if (value == null || value.trim().isEmpty) {
      return 'La acción recomendada es obligatoria.';
    }
    if (!accionPattern.hasMatch(value)) {
      return 'Ingrese una descripcion valida en el campo requerido';
    }
    return null;
  }

  static String? mensajeSelect(String? value, String nombre) {
    if (value == null || value.trim().isEmpty) {
      return '$nombre es obligatorio.';
    }
    return null;
  }
}
