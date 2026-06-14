// ═══════════════════════════════════════════════════════════════════════════
// MODALES RECOMENDACIÓN - GESTIÓN DE RECOMENDACIONES DEL SISTEMA
// ═══════════════════════════════════════════════════════════════════════════
// Define tipos, modelos y lógica de negocio para el sistema de recomendaciones
// Incluye CRUD completo y transformaciones para el dashboard
// ═══════════════════════════════════════════════════════════════════════════

import 'recomendaciones-registradas.dart'; // Importa datos simulados iniciales

/// Enumeración de niveles de prioridad para recomendaciones
enum PrioridadRecomendacion { 
  baja,      // Prioridad baja: informativo, sin urgencia
  media,     // Prioridad media: requiere atención moderada
  alta,      // Prioridad alta: requiere atención pronta
  critica    // Prioridad crítica: requiere acción inmediata
}

/// Enumeración de colores visuales para categorizar recomendaciones
enum ColorRecomendacion { 
  verde,     // Verde: situación normal o positiva
  amarillo,  // Amarillo: advertencia leve
  naranja,   // Naranja: precaución, atención requerida
  rojo       // Rojo: alerta, situación crítica
}

/// Extensión que agrega método para obtener etiqueta legible de prioridad
extension PrioridadRecomendacionLabel on PrioridadRecomendacion {
  String get label {
    switch (this) {
      case PrioridadRecomendacion.baja: return 'Baja';        // Etiqueta para baja
      case PrioridadRecomendacion.media: return 'Media';      // Etiqueta para media
      case PrioridadRecomendacion.alta: return 'Alta';        // Etiqueta para alta
      case PrioridadRecomendacion.critica: return 'Critica';  // Etiqueta para crítica
    }
  }
}

/// Extensión que agrega método para obtener etiqueta legible de color
extension ColorRecomendacionLabel on ColorRecomendacion {
  String get label {
    switch (this) {
      case ColorRecomendacion.verde: return 'Verde';          // Etiqueta para verde
      case ColorRecomendacion.amarillo: return 'Amarillo';    // Etiqueta para amarillo
      case ColorRecomendacion.naranja: return 'Naranja';      // Etiqueta para naranja
      case ColorRecomendacion.rojo: return 'Rojo';            // Etiqueta para rojo
    }
  }
}

/// Clase que representa una recomendación completa en el sistema
/// Incluye información, prioridad, color y metadata
class RecomendacionRegistrada {
  final int id;                          // Identificador único (inmutable)
  String titulo;                         // Título breve de la recomendación (modificable)
  String descripcion;                    // Descripción detallada del problema (modificable)
  String accion;                         // Acción sugerida o pasos a seguir (modificable)
  PrioridadRecomendacion prioridad;      // Nivel de prioridad (modificable)
  ColorRecomendacion color;              // Color visual asociado (modificable)
  final String fechaRegistro;            // Fecha de creación ISO 8601 (inmutable)

  /// Constructor con todos los parámetros nombrados requeridos
  RecomendacionRegistrada({
    required this.id,               // ID obligatorio
    required this.titulo,           // Título obligatorio
    required this.descripcion,      // Descripción obligatoria
    required this.accion,           // Acción obligatoria
    required this.prioridad,        // Prioridad obligatoria
    required this.color,            // Color obligatorio
    required this.fechaRegistro,    // Fecha obligatoria
  });

  /// Método para crear una copia modificada de la recomendación
  /// Útil para actualizaciones inmutables
  RecomendacionRegistrada copyWith({
    int? id,                          // ID opcional para reemplazar
    String? titulo,                   // Título opcional para reemplazar
    String? descripcion,              // Descripción opcional para reemplazar
    String? accion,                   // Acción opcional para reemplazar
    PrioridadRecomendacion? prioridad, // Prioridad opcional para reemplazar
    ColorRecomendacion? color,        // Color opcional para reemplazar
    String? fechaRegistro,            // Fecha opcional para reemplazar
  }) {
    return RecomendacionRegistrada(
      id: id ?? this.id,                           // Usa nuevo ID o mantiene el actual
      titulo: titulo ?? this.titulo,               // Usa nuevo título o mantiene el actual
      descripcion: descripcion ?? this.descripcion, // Usa nueva descripción o mantiene la actual
      accion: accion ?? this.accion,               // Usa nueva acción o mantiene la actual
      prioridad: prioridad ?? this.prioridad,      // Usa nueva prioridad o mantiene la actual
      color: color ?? this.color,                  // Usa nuevo color o mantiene el actual
      fechaRegistro: fechaRegistro ?? this.fechaRegistro, // Usa nueva fecha o mantiene la actual
    );
  }
}

/// Convierte color de recomendación a tipo para el dashboard
/// Mapea colores visuales a categorías de alerta
String colorATipoDashboard(ColorRecomendacion color) {
  switch (color) {
    case ColorRecomendacion.verde: return 'ok';    // Verde se convierte en 'ok'
    case ColorRecomendacion.rojo: return 'crit';   // Rojo se convierte en 'crit' (crítico)
    default: return 'warn';                        // Amarillo y naranja se convierten en 'warn'
  }
}

/// Convierte color de recomendación a icono de FontAwesome
/// Asigna iconos visuales según la severidad
String colorAIcono(ColorRecomendacion color) {
  switch (color) {
    case ColorRecomendacion.verde: return 'fa-circle-check';         // Verde: check (correcto)
    case ColorRecomendacion.amarillo: return 'fa-triangle-exclamation'; // Amarillo: triángulo de advertencia
    case ColorRecomendacion.naranja: return 'fa-triangle-exclamation';  // Naranja: triángulo de advertencia
    case ColorRecomendacion.rojo: return 'fa-circle-exclamation';    // Rojo: círculo de exclamación
  }
}

/// Clase que representa una recomendación formateada para el dashboard
/// Versión simplificada con iconos y tipos procesados
class RecomendacionDashboard {
  final String tipo;      // Tipo de alerta: 'ok', 'warn', 'crit'
  final String titulo;    // Título de la recomendación
  final String mensaje;   // Mensaje descriptivo
  final String accion;    // Acción recomendada
  final String icono;     // Clase CSS del icono FontAwesome

  /// Constructor con todos los parámetros nombrados requeridos
  RecomendacionDashboard({
    required this.tipo,      // Tipo obligatorio
    required this.titulo,    // Título obligatorio
    required this.mensaje,   // Mensaje obligatorio
    required this.accion,    // Acción obligatoria
    required this.icono,     // Icono obligatorio
  });
}

/// DTO (Data Transfer Object) para formularios de recomendaciones
/// Usado para crear o editar recomendaciones sin incluir ID ni fecha
class DatosRecomendacionForm {
  final String titulo;                    // Título de la recomendación
  final String descripcion;               // Descripción detallada
  final String accion;                    // Acción sugerida
  final PrioridadRecomendacion prioridad; // Nivel de prioridad
  final ColorRecomendacion color;         // Color visual

  /// Constructor const para crear instancias inmutables
  const DatosRecomendacionForm({
    required this.titulo,       // Título obligatorio
    required this.descripcion,  // Descripción obligatoria
    required this.accion,       // Acción obligatoria
    required this.prioridad,    // Prioridad obligatoria
    required this.color,        // Color obligatorio
  });
}

/// Store (almacén) que gestiona el estado y operaciones CRUD de recomendaciones
/// Implementa patrón singleton con métodos estáticos
class RecomendacionesStore {
  /// Lista privada que almacena todas las recomendaciones
  /// Inicializada con datos simulados desde recomendaciones-registradas.dart
  static final List<RecomendacionRegistrada> _lista = [...recomendacionesSimuladas];

  /// Obtiene todas las recomendaciones ordenadas por fecha (más reciente primero)
  /// Retorna una copia para evitar modificaciones externas
  static List<RecomendacionRegistrada> obtenerTodas() {
    final copy = [..._lista];                                           // Crea copia de la lista
    copy.sort((a, b) => DateTime.parse(b.fechaRegistro)                 // Ordena por fecha
        .compareTo(DateTime.parse(a.fechaRegistro)));                   // De más reciente a más antiguo
    return copy;                                                        // Retorna lista ordenada
  }

  /// Obtiene una recomendación específica por su ID
  /// Retorna null si no existe
  static RecomendacionRegistrada? obtenerPorId(int id) {
    try {
      return _lista.firstWhere((r) => r.id == id);                      // Busca por ID
    } catch (_) {
      return null;                                                      // Retorna null si no encuentra
    }
  }

  /// Agrega una nueva recomendación al sistema
  /// Genera automáticamente un ID único y establece la fecha actual
  static RecomendacionRegistrada agregar(DatosRecomendacionForm datos) {
    final maxId = _lista.isEmpty ? 0                                    // Si lista vacía, ID = 0
        : _lista.map((r) => r.id).reduce((a, b) => a > b ? a : b);     // Busca ID máximo
    final nuevo = RecomendacionRegistrada(
      id: maxId + 1,                                                    // Nuevo ID = máximo + 1
      titulo: datos.titulo,                                             // Asigna título del formulario
      descripcion: datos.descripcion,                                   // Asigna descripción del formulario
      accion: datos.accion,                                             // Asigna acción del formulario
      prioridad: datos.prioridad,                                       // Asigna prioridad del formulario
      color: datos.color,                                               // Asigna color del formulario
      fechaRegistro: DateTime.now().toIso8601String(),                  // Establece fecha actual ISO 8601
    );
    _lista.insert(0, nuevo);                                            // Inserta al inicio de la lista
    return nuevo;                                                       // Retorna la recomendación creada
  }

  /// Actualiza una recomendación existente por su ID
  /// No modifica el ID ni la fecha de registro
  static void actualizar(int id, DatosRecomendacionForm datos) {
    final idx = _lista.indexWhere((r) => r.id == id);                   // Busca índice por ID
    if (idx != -1) {                                                    // Si encuentra la recomendación
      final old = _lista[idx];                                          // Obtiene recomendación actual
      _lista[idx] = old.copyWith(                                       // Reemplaza con copia modificada
        titulo: datos.titulo,                                           // Actualiza título
        descripcion: datos.descripcion,                                 // Actualiza descripción
        accion: datos.accion,                                           // Actualiza acción
        prioridad: datos.prioridad,                                     // Actualiza prioridad
        color: datos.color,                                             // Actualiza color
      );
    }
  }

  /// Elimina una recomendación por su ID
  /// No hace nada si el ID no existe
  static void eliminar(int id) {
    _lista.removeWhere((r) => r.id == id);                              // Elimina elementos con ese ID
  }

  /// Convierte todas las recomendaciones a formato para el dashboard
  /// Transforma cada recomendación con iconos y tipos procesados
  static List<RecomendacionDashboard> paraDashboard() {
    return obtenerTodas().map((r) => RecomendacionDashboard(            // Itera sobre todas las recomendaciones
      tipo: colorATipoDashboard(r.color),                               // Convierte color a tipo ('ok', 'warn', 'crit')
      titulo: r.titulo,                                                 // Mantiene título
      mensaje: r.descripcion,                                           // Usa descripción como mensaje
      accion: r.accion,                                                 // Mantiene acción
      icono: colorAIcono(r.color),                                      // Convierte color a icono FontAwesome
    )).toList();                                                        // Convierte a lista
  }
}
