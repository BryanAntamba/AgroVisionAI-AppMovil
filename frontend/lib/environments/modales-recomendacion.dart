import 'recomendaciones-registradas.dart';

enum PrioridadRecomendacion { baja, media, alta, critica }
enum ColorRecomendacion { verde, amarillo, naranja, rojo }

extension PrioridadRecomendacionLabel on PrioridadRecomendacion {
  String get label {
    switch (this) {
      case PrioridadRecomendacion.baja: return 'Baja';
      case PrioridadRecomendacion.media: return 'Media';
      case PrioridadRecomendacion.alta: return 'Alta';
      case PrioridadRecomendacion.critica: return 'Critica';
    }
  }
}

extension ColorRecomendacionLabel on ColorRecomendacion {
  String get label {
    switch (this) {
      case ColorRecomendacion.verde: return 'Verde';
      case ColorRecomendacion.amarillo: return 'Amarillo';
      case ColorRecomendacion.naranja: return 'Naranja';
      case ColorRecomendacion.rojo: return 'Rojo';
    }
  }
}

class RecomendacionRegistrada {
  final int id;
  String titulo;
  String descripcion;
  String accion;
  PrioridadRecomendacion prioridad;
  ColorRecomendacion color;
  final String fechaRegistro;

  RecomendacionRegistrada({
    required this.id,
    required this.titulo,
    required this.descripcion,
    required this.accion,
    required this.prioridad,
    required this.color,
    required this.fechaRegistro,
  });

  RecomendacionRegistrada copyWith({
    int? id,
    String? titulo,
    String? descripcion,
    String? accion,
    PrioridadRecomendacion? prioridad,
    ColorRecomendacion? color,
    String? fechaRegistro,
  }) {
    return RecomendacionRegistrada(
      id: id ?? this.id,
      titulo: titulo ?? this.titulo,
      descripcion: descripcion ?? this.descripcion,
      accion: accion ?? this.accion,
      prioridad: prioridad ?? this.prioridad,
      color: color ?? this.color,
      fechaRegistro: fechaRegistro ?? this.fechaRegistro,
    );
  }
}

String colorATipoDashboard(ColorRecomendacion color) {
  switch (color) {
    case ColorRecomendacion.verde: return 'ok';
    case ColorRecomendacion.rojo: return 'crit';
    default: return 'warn';
  }
}

String colorAIcono(ColorRecomendacion color) {
  switch (color) {
    case ColorRecomendacion.verde: return 'fa-circle-check';
    case ColorRecomendacion.amarillo: return 'fa-triangle-exclamation';
    case ColorRecomendacion.naranja: return 'fa-triangle-exclamation';
    case ColorRecomendacion.rojo: return 'fa-circle-exclamation';
  }
}

class RecomendacionDashboard {
  final String tipo;
  final String titulo;
  final String mensaje;
  final String accion;
  final String icono;

  RecomendacionDashboard({
    required this.tipo,
    required this.titulo,
    required this.mensaje,
    required this.accion,
    required this.icono,
  });
}

/// DTO para registrar o editar una recomendación desde los modales.
class DatosRecomendacionForm {
  final String titulo;
  final String descripcion;
  final String accion;
  final PrioridadRecomendacion prioridad;
  final ColorRecomendacion color;

  const DatosRecomendacionForm({
    required this.titulo,
    required this.descripcion,
    required this.accion,
    required this.prioridad,
    required this.color,
  });
}

class RecomendacionesStore {
  static final List<RecomendacionRegistrada> _lista = [...recomendacionesSimuladas];

  static List<RecomendacionRegistrada> obtenerTodas() {
    final copy = [..._lista];
    copy.sort((a, b) => DateTime.parse(b.fechaRegistro).compareTo(DateTime.parse(a.fechaRegistro)));
    return copy;
  }

  static RecomendacionRegistrada? obtenerPorId(int id) {
    try {
      return _lista.firstWhere((r) => r.id == id);
    } catch (_) {
      return null;
    }
  }

  static RecomendacionRegistrada agregar(DatosRecomendacionForm datos) {
    final maxId = _lista.isEmpty ? 0 : _lista.map((r) => r.id).reduce((a, b) => a > b ? a : b);
    final nuevo = RecomendacionRegistrada(
      id: maxId + 1,
      titulo: datos.titulo,
      descripcion: datos.descripcion,
      accion: datos.accion,
      prioridad: datos.prioridad,
      color: datos.color,
      fechaRegistro: DateTime.now().toIso8601String(),
    );
    _lista.insert(0, nuevo);
    return nuevo;
  }

  static void actualizar(int id, DatosRecomendacionForm datos) {
    final idx = _lista.indexWhere((r) => r.id == id);
    if (idx != -1) {
      final old = _lista[idx];
      _lista[idx] = old.copyWith(
        titulo: datos.titulo,
        descripcion: datos.descripcion,
        accion: datos.accion,
        prioridad: datos.prioridad,
        color: datos.color,
      );
    }
  }

  static void eliminar(int id) {
    _lista.removeWhere((r) => r.id == id);
  }

  static List<RecomendacionDashboard> paraDashboard() {
    return obtenerTodas().map((r) => RecomendacionDashboard(
      tipo: colorATipoDashboard(r.color),
      titulo: r.titulo,
      mensaje: r.descripcion,
      accion: r.accion,
      icono: colorAIcono(r.color),
    )).toList();
  }
}
