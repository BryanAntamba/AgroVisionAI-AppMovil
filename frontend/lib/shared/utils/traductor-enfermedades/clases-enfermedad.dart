// ════════════════════════════════════════════════════════════════════════════════
// TRADUCTOR DE CLASES DE ENFERMEDAD DEL MODELO CNN
// ════════════════════════════════════════════════════════════════════════════════
// Este archivo gestiona el mapeo completo de las 14 clases de enfermedad detectadas
// por el modelo CNN de diagnóstico agrícola. Traduce códigos en inglés a nombres
// en español comprensibles para los agricultores. Incluye enfermedades del tomate
// y condiciones del invernadero con alias múltiples para compatibilidad con API.
// ════════════════════════════════════════════════════════════════════════════════

// ══════════════════════════════════════════════════════════════════════════════
// CLASE MODELO PARA ENFERMEDAD
// ══════════════════════════════════════════════════════════════════════════════

/// Clase que representa una enfermedad o condición del cultivo detectada por el modelo CNN
/// Contiene el código original, nombre en español, descripción y bandera de salud
class ClaseEnfermedad {
  /// Código original de la clase (puede ser en inglés, snake_case o con espacios)
  final String codigo;
  
  /// Nombre de la enfermedad traducido al español para mostrar al usuario
  final String nombre;
  
  /// Descripción detallada de la enfermedad o condición en español
  final String descripcion;
  
  /// Bandera que indica si esta clase representa una planta sana (true = sana, false = enferma)
  final bool esSano;

  /// Constructor constante para crear instancias inmutables de ClaseEnfermedad
  const ClaseEnfermedad({
    required this.codigo, // Código requerido
    required this.nombre, // Nombre en español requerido
    required this.descripcion, // Descripción requerida
    this.esSano = false, // Por defecto es false (enfermedad), se marca true solo para clases sanas
  });
}

// ══════════════════════════════════════════════════════════════════════════════
// CATÁLOGO COMPLETO DE LAS 14 CLASES DEL MODELO CNN
// ══════════════════════════════════════════════════════════════════════════════
// Mapeo completo con todos los formatos posibles (originales, alias simplificados, variantes)
// Total: 10 clases de tomate + 4 condiciones de invernadero + múltiples alias = ~30 entradas

/// Diccionario exhaustivo de todas las clases de enfermedad con alias múltiples
/// Incluye formatos originales del modelo, alias simplificados para API y variantes con espacios
const Map<String, ClaseEnfermedad> clasesEnfermedad = {
  // ════════════════════════════════════════════════════════════════════════════
  // ENFERMEDADES DEL TOMATE (10 clases en formato original del modelo CNN)
  // ════════════════════════════════════════════════════════════════════════════
  
  /// 1. Mancha bacteriana del tomate (enfermedad bacteriana)
  'Tomato_Bacterial_spot': ClaseEnfermedad(
    codigo: 'Tomato_Bacterial_spot', // Código original del modelo
    nombre: 'Mancha bacteriana', // Nombre en español
    descripcion: 'Enfermedad bacteriana que causa manchas en hojas.', // Descripción técnica
  ),
  
  /// 2. Tizón temprano del tomate (enfermedad fúngica temprana)
  'Tomato_Early_blight': ClaseEnfermedad(
    codigo: 'Tomato_Early_blight', // Código original del modelo
    nombre: 'Tizón temprano', // Nombre en español
    descripcion: 'Enfermedad fúngica que aparece temprano en la temporada.', // Aparece al inicio del ciclo
  ),
  
  /// 3. Tomate saludable (clase positiva sin enfermedad) ✓
  'Tomato_healthy': ClaseEnfermedad(
    codigo: 'Tomato_healthy', // Código original del modelo
    nombre: 'Tomate sano', // Nombre en español
    descripcion: 'Tomate en estado saludable sin enfermedades.', // Condición óptima
    esSano: true, // ✓ Marcado como sano (no requiere tratamiento)
  ),
  
  /// 4. Tizón tardío del tomate (enfermedad fúngica tardía)
  'Tomato_Late_blight': ClaseEnfermedad(
    codigo: 'Tomato_Late_blight', // Código original del modelo
    nombre: 'Tizón tardío', // Nombre en español
    descripcion: 'Enfermedad fúngica que aparece tarde en la temporada.', // Aparece al final del ciclo
  ),
  
  /// 5. Moho foliar del tomate (enfermedad fúngica de hojas)
  'Tomato_Leaf_Mold': ClaseEnfermedad(
    codigo: 'Tomato_Leaf_Mold', // Código original del modelo
    nombre: 'Moho foliar', // Nombre en español
    descripcion: 'Enfermedad fúngica que afecta las hojas.', // Ataca principalmente el follaje
  ),
  
  /// 6. Mancha séptica del tomate (enfermedad fúngica Septoria)
  'Tomato_Septoria_leaf_spot': ClaseEnfermedad(
    codigo: 'Tomato_Septoria_leaf_spot', // Código original del modelo
    nombre: 'Mancha séptica', // Nombre en español
    descripcion: 'Enfermedad fúngica que causa manchas sépticas.', // Manchas con patrón específico
  ),
  
  /// 7. Ácaro de dos manchas (plaga arácnida, no es enfermedad)
  'Tomato_Spider_mites_Two_spotted_spider_mite': ClaseEnfermedad(
    codigo: 'Tomato_Spider_mites_Two_spotted_spider_mite', // Código original (nombre largo)
    nombre: 'Ácaro de dos manchas', // Nombre en español
    descripcion: 'Plaga de ácaros tejedores.', // Plaga arácnida, no enfermedad bacteriana/fúngica
  ),
  
  /// 8. Mancha diana del tomate (enfermedad fúngica con patrón circular)
  'Tomato__Target_Spot': ClaseEnfermedad(
    codigo: 'Tomato__Target_Spot', // Código original (con doble guion bajo)
    nombre: 'Mancha diana', // Nombre en español
    descripcion: 'Enfermedad fúngica con patrón de mancha circular.', // Patrón concéntrico como diana
  ),
  
  /// 9. Virus del mosaico del tomate (enfermedad viral)
  'Tomato__Tomato_mosaic_virus': ClaseEnfermedad(
    codigo: 'Tomato__Tomato_mosaic_virus', // Código original (con doble guion bajo)
    nombre: 'Virus del mosaico', // Nombre en español
    descripcion: 'Virus que causa patrón de mosaico en hojas.', // Patrón de manchas irregulares
  ),
  
  /// 10. Virus del rizado amarillo del tomate (enfermedad viral severa)
  'Tomato__Tomato_YellowLeaf__Curl_Virus': ClaseEnfermedad(
    codigo: 'Tomato__Tomato_YellowLeaf__Curl_Virus', // Código original (con múltiples guiones bajos)
    nombre: 'Virus del rizado amarillo', // Nombre en español
    descripcion: 'Virus que causa ondulación y amarillamiento.', // Provoca enrollamiento de hojas
  ),
  
  // ════════════════════════════════════════════════════════════════════════════
  // CONDICIONES DEL INVERNADERO (4 clases adicionales del proyecto)
  // ════════════════════════════════════════════════════════════════════════════
  
  /// 11. Hojas secas en invernadero (condición ambiental)
  'greenhouse_dried_leaves': ClaseEnfermedad(
    codigo: 'greenhouse_dried_leaves', // Código para hojas deshidratadas
    nombre: 'Hojas secas', // Nombre en español
    descripcion: 'Hojas secadas en invernadero.', // Condición por falta de agua o estrés térmico
  ),
  
  /// 12. Hojas sanas en invernadero (condición óptima) ✓
  'greenhouse_healthy_leaves': ClaseEnfermedad(
    codigo: 'greenhouse_healthy_leaves', // Código para hojas saludables de invernadero
    nombre: 'Hojas sanas', // Nombre en español
    descripcion: 'Hojas saludables en invernadero.', // Condición óptima sin enfermedad
    esSano: true, // ✓ Marcado como sano
  ),
  
  /// 13. Hojas con manchas en invernadero (condición de estrés o enfermedad leve)
  'greenhouse_leaves_with_stains': ClaseEnfermedad(
    codigo: 'greenhouse_leaves_with_stains', // Código para hojas con manchas generales
    nombre: 'Hojas con manchas', // Nombre en español
    descripcion: 'Hojas con manchas diversas en invernadero.', // Manchas de origen variado (fúngicas, bacterianas o estrés)
  ),
  
  /// 14. Hojas con manchas amarillas en invernadero (clorosis o deficiencia nutricional)
  'greenhouse_leaves_yellow_stains': ClaseEnfermedad(
    codigo: 'greenhouse_leaves_yellow_stains', // Código para hojas con clorosis
    nombre: 'Hojas con manchas amarillas', // Nombre en español
    descripcion: 'Hojas con manchas amarillas específicas.', // Indica deficiencia de nutrientes (N, Fe, Mg)
  ),
  
  // ════════════════════════════════════════════════════════════════════════════
  // ALIAS SIMPLIFICADOS (versiones cortas usadas en API abreviada)
  // ════════════════════════════════════════════════════════════════════════════
  
  /// Alias: Tomate sano (versión corta) ✓
  'healthy': ClaseEnfermedad(
    codigo: 'healthy', // Alias simplificado
    nombre: 'Tomate sano', // Nombre en español
    descripcion: 'Alias simple para tomate saludable.', // Mapea a Tomato_healthy
    esSano: true, // ✓ Marcado como sano
  ),
  
  /// Alias: Tizón temprano (versión corta)
  'early_blight': ClaseEnfermedad(
    codigo: 'early_blight', // Alias simplificado
    nombre: 'Tizón temprano', // Nombre en español
    descripcion: 'Alias simple para tizón temprano.', // Mapea a Tomato_Early_blight
  ),
  
  /// Alias: Tizón tardío (versión corta)
  'late_blight': ClaseEnfermedad(
    codigo: 'late_blight', // Alias simplificado
    nombre: 'Tizón tardío', // Nombre en español
    descripcion: 'Alias simple para tizón tardío.', // Mapea a Tomato_Late_blight
  ),
  
  /// Alias: Moho foliar (versión corta)
  'leaf_mold': ClaseEnfermedad(
    codigo: 'leaf_mold', // Alias simplificado
    nombre: 'Moho foliar', // Nombre en español
    descripcion: 'Alias simple para moho foliar.', // Mapea a Tomato_Leaf_Mold
  ),
  
  /// Alias: Mancha séptica (versión corta)
  'septoria': ClaseEnfermedad(
    codigo: 'septoria', // Alias simplificado
    nombre: 'Mancha séptica', // Nombre en español
    descripcion: 'Alias simple para mancha séptica.', // Mapea a Tomato_Septoria_leaf_spot
  ),
  
  /// Alias: Mancha bacteriana (versión corta)
  'bacterial_spot': ClaseEnfermedad(
    codigo: 'bacterial_spot', // Alias simplificado
    nombre: 'Mancha bacteriana', // Nombre en español
    descripcion: 'Alias simple para mancha bacteriana.', // Mapea a Tomato_Bacterial_spot
  ),
  
  /// Alias: Ácaro de dos manchas (versión corta)
  'spider_mites': ClaseEnfermedad(
    codigo: 'spider_mites', // Alias simplificado
    nombre: 'Ácaro de dos manchas', // Nombre en español
    descripcion: 'Alias simple para ácaro de dos manchas.', // Mapea a Tomato_Spider_mites_Two_spotted_spider_mite
  ),
  
  /// Alias: Mancha diana (versión corta)
  'target_spot': ClaseEnfermedad(
    codigo: 'target_spot', // Alias simplificado
    nombre: 'Mancha diana', // Nombre en español
    descripcion: 'Alias simple para mancha diana.', // Mapea a Tomato__Target_Spot
  ),
  
  /// Alias: Virus del mosaico (versión corta)
  'mosaic_virus': ClaseEnfermedad(
    codigo: 'mosaic_virus', // Alias simplificado
    nombre: 'Virus del mosaico', // Nombre en español
    descripcion: 'Alias simple para virus del mosaico.', // Mapea a Tomato__Tomato_mosaic_virus
  ),
  
  /// Alias: Virus del rizado amarillo (versión corta)
  'yellow_leaf_curl': ClaseEnfermedad(
    codigo: 'yellow_leaf_curl', // Alias simplificado
    nombre: 'Virus del rizado amarillo', // Nombre en español
    descripcion: 'Alias simple para virus del rizado amarillo.', // Mapea a Tomato__Tomato_YellowLeaf__Curl_Virus
  ),
  
  // ════════════════════════════════════════════════════════════════════════════
  // VARIANTES CON ESPACIOS (para compatibilidad con diferentes formatos de API)
  // ════════════════════════════════════════════════════════════════════════════
  
  /// Variante: Tomate sano con espacio (formato alternativo) ✓
  'Tomato Healthy': ClaseEnfermedad(
    codigo: 'Tomato Healthy', // Variante con espacio en lugar de guion bajo
    nombre: 'Tomate sano', // Nombre en español
    descripcion: 'Variante con espacios para tomate saludable.', // Mapea a Tomato_healthy
    esSano: true, // ✓ Marcado como sano
  ),
};

// ══════════════════════════════════════════════════════════════════════════════
// MAPEO SIMPLIFICADO (solo código → nombre en español)
// ══════════════════════════════════════════════════════════════════════════════

/// Diccionario simplificado de código → nombre en español
/// Usado para traducción rápida sin necesidad de objetos ClaseEnfermedad completos
/// Equivalente a CLASES_ENFERMEDAD_ES del proyecto Angular original
const Map<String, String> clasesEnfermedadEs = {
  // ════════════════════════════════════════════════════════════════════════════
  // ENFERMEDADES DEL TOMATE (formato original del modelo)
  // ════════════════════════════════════════════════════════════════════════════
  'Tomato_Bacterial_spot': 'Mancha bacteriana', // Clase 1: enfermedad bacteriana
  'Tomato_Early_blight': 'Tizón temprano', // Clase 2: tizón temprano
  'Tomato_healthy': 'Tomate sano', // Clase 3: tomate saludable ✓
  'Tomato_Late_blight': 'Tizón tardío', // Clase 4: tizón tardío
  'Tomato_Leaf_Mold': 'Moho foliar', // Clase 5: moho de hojas
  'Tomato_Septoria_leaf_spot': 'Mancha séptica', // Clase 6: septoria
  'Tomato_Spider_mites_Two_spotted_spider_mite': 'Ácaro de dos manchas', // Clase 7: plaga de ácaros
  'Tomato__Target_Spot': 'Mancha diana', // Clase 8: mancha circular
  'Tomato__Tomato_mosaic_virus': 'Virus del mosaico', // Clase 9: virus mosaico
  'Tomato__Tomato_YellowLeaf__Curl_Virus': 'Virus del rizado amarillo', // Clase 10: virus TYLCV
  
  // ════════════════════════════════════════════════════════════════════════════
  // CONDICIONES DEL INVERNADERO
  // ════════════════════════════════════════════════════════════════════════════
  'greenhouse_dried_leaves': 'Hojas secas', // Clase 11: hojas deshidratadas
  'greenhouse_healthy_leaves': 'Hojas sanas', // Clase 12: hojas saludables ✓
  'greenhouse_leaves_with_stains': 'Hojas con manchas', // Clase 13: manchas generales
  'greenhouse_leaves_yellow_stains': 'Hojas con manchas amarillas', // Clase 14: clorosis
  
  // ════════════════════════════════════════════════════════════════════════════
  // ALIAS SIMPLIFICADOS (versiones abreviadas para API)
  // ════════════════════════════════════════════════════════════════════════════
  'healthy': 'Tomate sano', // Alias de Tomato_healthy ✓
  'early_blight': 'Tizón temprano', // Alias de Tomato_Early_blight
  'late_blight': 'Tizón tardío', // Alias de Tomato_Late_blight
  'leaf_mold': 'Moho foliar', // Alias de Tomato_Leaf_Mold
  'septoria': 'Mancha séptica', // Alias de Tomato_Septoria_leaf_spot
  'bacterial_spot': 'Mancha bacteriana', // Alias de Tomato_Bacterial_spot
  'spider_mites': 'Ácaro de dos manchas', // Alias de Tomato_Spider_mites_Two_spotted_spider_mite
  'target_spot': 'Mancha diana', // Alias de Tomato__Target_Spot
  'mosaic_virus': 'Virus del mosaico', // Alias de Tomato__Tomato_mosaic_virus
  'yellow_leaf_curl': 'Virus del rizado amarillo', // Alias de Tomato__Tomato_YellowLeaf__Curl_Virus
  
  // ════════════════════════════════════════════════════════════════════════════
  // VARIANTES CON ESPACIOS
  // ════════════════════════════════════════════════════════════════════════════
  'Tomato Healthy': 'Tomate sano', // Variante con espacio ✓
};

// ══════════════════════════════════════════════════════════════════════════════
// FUNCIONES AUXILIARES PARA TRADUCCIÓN Y CONSULTA
// ══════════════════════════════════════════════════════════════════════════════

/// Obtiene el objeto ClaseEnfermedad completo para un código dado
/// @param codigo - Código de la enfermedad (puede tener espacios al inicio/final)
/// @return ClaseEnfermedad? - Objeto completo de la clase o null si no se encuentra
ClaseEnfermedad? obtenerClaseEnfermedad(String codigo) {
  return clasesEnfermedad[codigo.trim()]; // Busca en el diccionario después de limpiar espacios
}

/// Función principal que traduce un diagnóstico del idioma inglés/código al español
/// Recibe una cadena con el nombre de la enfermedad y retorna su traducción al español
/// Maneja múltiples formatos: originales del modelo, alias y variantes con espacios
/// 
/// @param diagnostico - Código de enfermedad en inglés (ej: "Tomato_healthy", "early_blight", "Tomato Healthy")
/// @return String - Nombre de la enfermedad en español o el original si no se encuentra traducción
String traducirDiagnostico(String diagnostico) {
  // PASO 1: Validar entrada vacía
  // Si no hay diagnóstico (vacío o null), retorna mensaje por defecto
  if (diagnostico.isEmpty) {
    return 'Sin diagnóstico'; // Mensaje predeterminado para datos vacíos
  }

  // PASO 2: Normalizar entrada (eliminar espacios)
  // Elimina espacios al inicio y final de la cadena para búsqueda consistente
  final normalizado = diagnostico.trim();

  // PASO 3: Búsqueda exacta en el diccionario
  // Busca el diagnóstico normalizado directamente en el mapeo clasesEnfermedadEs
  // Si está exactamente igual (case-sensitive), retorna la traducción correspondiente
  if (clasesEnfermedadEs[normalizado] != null) {
    return clasesEnfermedadEs[normalizado]!; // Traducción encontrada directamente
  }

  // PASO 4: Búsqueda con normalización avanzada (fallback)
  // Si no encontró la traducción exacta, intenta con una clave normalizada
  // Aplica transformaciones para manejar variantes del formato:
  // 1. Reemplaza "Tomato " al inicio (case-insensitive) para eliminar prefijo
  // 2. Reemplaza espacios con guiones bajos para formato snake_case
  // 3. Convierte todo a minúsculas para búsqueda case-insensitive
  final claveSnake = normalizado
      .replaceFirst(RegExp(r'^Tomato\s+', caseSensitive: false), '') // Elimina prefijo "Tomato "
      .replaceAll(' ', '_') // Convierte espacios a guiones bajos
      .toLowerCase(); // Convierte a minúsculas

  // PASO 5: Búsqueda con clave normalizada
  // Busca la clave normalizada en el mapeo
  if (clasesEnfermedadEs[claveSnake] != null) {
    return clasesEnfermedadEs[claveSnake]!; // Traducción encontrada con normalización
  }

  // PASO 6: Retorno de valor original formateado (último recurso)
  // Si no encuentra ninguna traducción, retorna el diagnóstico original
  // con formato legible: reemplaza guiones bajos por espacios y elimina "Tomato "
  return normalizado.replaceAll('_', ' ').replaceAll('Tomato ', '');
}

/// Alias de traducirDiagnostico para compatibilidad con código legacy
/// Mantiene compatibilidad con código anterior que usaba este nombre de función
/// 
/// @param codigo - Código de enfermedad en inglés
/// @return String - Nombre de la enfermedad en español
String traducirClaseEnfermedad(String codigo) {
  return traducirDiagnostico(codigo); // Delega a la función principal
}

/// Verifica si un código de enfermedad corresponde a una clase sana (sin enfermedad)
/// Usa tanto el flag esSano del objeto ClaseEnfermedad como búsqueda textual de "healthy"/"sano"
/// 
/// @param codigo - Código de enfermedad a verificar
/// @return bool - true si es clase sana, false si es enfermedad
bool esClaseSana(String codigo) {
  // Intenta obtener el objeto ClaseEnfermedad del catálogo
  // Si existe y tiene esSano=true, retorna true
  return obtenerClaseEnfermedad(codigo)?.esSano ??
      // Si no encuentra el objeto o esSano es null, hace búsqueda textual (fallback)
      // Busca "healthy" o "sano" en el código (case-insensitive)
      codigo.toLowerCase().contains('healthy') ||
          codigo.toLowerCase().contains('sano');
}
