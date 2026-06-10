import 'dart:convert';
import 'package:flutter/foundation.dart';
import 'package:shared_preferences/shared_preferences.dart';
import '../../environments/tema-config.dart';

/// Servicio singleton que gestiona la configuración visual de la plataforma.
///
/// Persiste el [TemaConfig] activo en [SharedPreferences] y notifica a los
/// consumidores cada vez que cambia, gracias a [ChangeNotifier].
///
/// Uso básico:
/// ```dart
/// // Obtener la instancia (ya inicializada en main.dart):
/// final service = TemaService.instance;
///
/// // Leer la config actual:
/// final config = service.config;
///
/// // Guardar cambios:
/// await service.guardar(miNuevoConfig);
///
/// // Resetear a valores predeterminados:
/// await service.resetear();
/// ```
class TemaService extends ChangeNotifier {
  TemaService._();

  // ── Singleton ───────────────────────────────────────────────────────────────
  static final TemaService instance = TemaService._();

  static const String _prefKey = 'agrovision_tema_config';

  // ── Estado ──────────────────────────────────────────────────────────────────
  TemaConfig _config = TemaConfig();

  /// Configuración visual activa.
  TemaConfig get config => _config;

  // ── Inicialización ──────────────────────────────────────────────────────────

  /// Carga la configuración desde [SharedPreferences].
  /// Debe llamarse una única vez antes de [runApp].
  Future<void> cargar() async {
    try {
      final prefs = await SharedPreferences.getInstance();
      final raw = prefs.getString(_prefKey);
      if (raw != null && raw.isNotEmpty) {
        final json = jsonDecode(raw) as Map<String, dynamic>;
        _config = TemaConfig.fromJson(json);
      }
    } catch (e) {
      debugPrint('[TemaService] Error al cargar configuración: $e');
      _config = TemaConfig();
    }
  }

  // ── Guardar ─────────────────────────────────────────────────────────────────

  /// Persiste [nuevoConfig] y notifica a los consumidores.
  Future<void> guardar(TemaConfig nuevoConfig) async {
    _config = nuevoConfig;
    notifyListeners();
    try {
      final prefs = await SharedPreferences.getInstance();
      await prefs.setString(_prefKey, jsonEncode(_config.toJson()));
    } catch (e) {
      debugPrint('[TemaService] Error al guardar configuración: $e');
    }
  }

  /// Actualiza solo el nombre de la plataforma y persiste el resto de la config.
  Future<void> actualizarNombre(String nombre) async {
    _config.nombrePlataforma = nombre;
    await guardar(_config);
  }

  // ── Resetear ────────────────────────────────────────────────────────────────

  /// Restaura la configuración a los valores predeterminados y la persiste.
  Future<void> resetear() async {
    await guardar(TemaConfig());
  }
}
