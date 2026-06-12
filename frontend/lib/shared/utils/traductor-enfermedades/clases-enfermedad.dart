// Mapeo de las 14 clases del modelo CNN a nombres en español para el agricultor
// Clase que representa una enfermedad o condición del cultivo
class ClaseEnfermedad {
  final String codigo;
  final String nombre;
  final String descripcion;
  final bool esSano;

  const ClaseEnfermedad({
    required this.codigo,
    required this.nombre,
    required this.descripcion,
    this.esSano = false,
  });
}

// Mapeo completo de las 14 clases del modelo CNN
const Map<String, ClaseEnfermedad> clasesEnfermedad = {
  // Enfermedades del tomate (formato original del modelo)
  'Tomato_Bacterial_spot': ClaseEnfermedad(
    codigo: 'Tomato_Bacterial_spot',
    nombre: 'Mancha bacteriana',
    descripcion: 'Enfermedad bacteriana que causa manchas en hojas.',
  ),
  'Tomato_Early_blight': ClaseEnfermedad(
    codigo: 'Tomato_Early_blight',
    nombre: 'Tizón temprano',
    descripcion: 'Enfermedad fúngica que aparece temprano en la temporada.',
  ),
  'Tomato_healthy': ClaseEnfermedad(
    codigo: 'Tomato_healthy',
    nombre: 'Tomate sano',
    descripcion: 'Tomate en estado saludable sin enfermedades.',
    esSano: true,
  ),
  'Tomato_Late_blight': ClaseEnfermedad(
    codigo: 'Tomato_Late_blight',
    nombre: 'Tizón tardío',
    descripcion: 'Enfermedad fúngica que aparece tarde en la temporada.',
  ),
  'Tomato_Leaf_Mold': ClaseEnfermedad(
    codigo: 'Tomato_Leaf_Mold',
    nombre: 'Moho foliar',
    descripcion: 'Enfermedad fúngica que afecta las hojas.',
  ),
  'Tomato_Septoria_leaf_spot': ClaseEnfermedad(
    codigo: 'Tomato_Septoria_leaf_spot',
    nombre: 'Mancha séptica',
    descripcion: 'Enfermedad fúngica que causa manchas sépticas.',
  ),
  'Tomato_Spider_mites_Two_spotted_spider_mite': ClaseEnfermedad(
    codigo: 'Tomato_Spider_mites_Two_spotted_spider_mite',
    nombre: 'Ácaro de dos manchas',
    descripcion: 'Plaga de ácaros tejedores.',
  ),
  'Tomato__Target_Spot': ClaseEnfermedad(
    codigo: 'Tomato__Target_Spot',
    nombre: 'Mancha diana',
    descripcion: 'Enfermedad fúngica con patrón de mancha circular.',
  ),
  'Tomato__Tomato_mosaic_virus': ClaseEnfermedad(
    codigo: 'Tomato__Tomato_mosaic_virus',
    nombre: 'Virus del mosaico',
    descripcion: 'Virus que causa patrón de mosaico en hojas.',
  ),
  'Tomato__Tomato_YellowLeaf__Curl_Virus': ClaseEnfermedad(
    codigo: 'Tomato__Tomato_YellowLeaf__Curl_Virus',
    nombre: 'Virus del rizado amarillo',
    descripcion: 'Virus que causa ondulación y amarillamiento.',
  ),
  // Condiciones del invernadero
  'greenhouse_dried_leaves': ClaseEnfermedad(
    codigo: 'greenhouse_dried_leaves',
    nombre: 'Hojas secas',
    descripcion: 'Hojas secadas en invernadero.',
  ),
  'greenhouse_healthy_leaves': ClaseEnfermedad(
    codigo: 'greenhouse_healthy_leaves',
    nombre: 'Hojas sanas',
    descripcion: 'Hojas saludables en invernadero.',
    esSano: true,
  ),
  'greenhouse_leaves_with_stains': ClaseEnfermedad(
    codigo: 'greenhouse_leaves_with_stains',
    nombre: 'Hojas con manchas',
    descripcion: 'Hojas con manchas diversas en invernadero.',
  ),
  'greenhouse_leaves_yellow_stains': ClaseEnfermedad(
    codigo: 'greenhouse_leaves_yellow_stains',
    nombre: 'Hojas con manchas amarillas',
    descripcion: 'Hojas con manchas amarillas específicas.',
  ),
  // Alias simplificados (versiones cortas usadas en API)
  'healthy': ClaseEnfermedad(
    codigo: 'healthy',
    nombre: 'Tomate sano',
    descripcion: 'Alias simple para tomate saludable.',
    esSano: true,
  ),
  'early_blight': ClaseEnfermedad(
    codigo: 'early_blight',
    nombre: 'Tizón temprano',
    descripcion: 'Alias simple para tizón temprano.',
  ),
  'late_blight': ClaseEnfermedad(
    codigo: 'late_blight',
    nombre: 'Tizón tardío',
    descripcion: 'Alias simple para tizón tardío.',
  ),
  'leaf_mold': ClaseEnfermedad(
    codigo: 'leaf_mold',
    nombre: 'Moho foliar',
    descripcion: 'Alias simple para moho foliar.',
  ),
  'septoria': ClaseEnfermedad(
    codigo: 'septoria',
    nombre: 'Mancha séptica',
    descripcion: 'Alias simple para mancha séptica.',
  ),
  'bacterial_spot': ClaseEnfermedad(
    codigo: 'bacterial_spot',
    nombre: 'Mancha bacteriana',
    descripcion: 'Alias simple para mancha bacteriana.',
  ),
  'spider_mites': ClaseEnfermedad(
    codigo: 'spider_mites',
    nombre: 'Ácaro de dos manchas',
    descripcion: 'Alias simple para ácaro de dos manchas.',
  ),
  'target_spot': ClaseEnfermedad(
    codigo: 'target_spot',
    nombre: 'Mancha diana',
    descripcion: 'Alias simple para mancha diana.',
  ),
  'mosaic_virus': ClaseEnfermedad(
    codigo: 'mosaic_virus',
    nombre: 'Virus del mosaico',
    descripcion: 'Alias simple para virus del mosaico.',
  ),
  'yellow_leaf_curl': ClaseEnfermedad(
    codigo: 'yellow_leaf_curl',
    nombre: 'Virus del rizado amarillo',
    descripcion: 'Alias simple para virus del rizado amarillo.',
  ),
  // Variantes con espacios
  'Tomato Healthy': ClaseEnfermedad(
    codigo: 'Tomato Healthy',
    nombre: 'Tomate sano',
    descripcion: 'Variante con espacios para tomate saludable.',
    esSano: true,
  ),
};

// Mapeo simplificado de códigos a nombres en español (CLASES_ENFERMEDAD_ES de Angular)
const Map<String, String> clasesEnfermedadEs = {
  // Enfermedades y condiciones del tomate en inglés mapeadas a español
  'Tomato_Bacterial_spot': 'Mancha bacteriana',
  'Tomato_Early_blight': 'Tizón temprano',
  'Tomato_healthy': 'Tomate sano',
  'Tomato_Late_blight': 'Tizón tardío',
  'Tomato_Leaf_Mold': 'Moho foliar',
  'Tomato_Septoria_leaf_spot': 'Mancha séptica',
  'Tomato_Spider_mites_Two_spotted_spider_mite': 'Ácaro de dos manchas',
  'Tomato__Target_Spot': 'Mancha diana',
  'Tomato__Tomato_mosaic_virus': 'Virus del mosaico',
  'Tomato__Tomato_YellowLeaf__Curl_Virus': 'Virus del rizado amarillo',
  'greenhouse_dried_leaves': 'Hojas secas',
  'greenhouse_healthy_leaves': 'Hojas sanas',
  'greenhouse_leaves_with_stains': 'Hojas con manchas',
  'greenhouse_leaves_yellow_stains': 'Hojas con manchas amarillas',
  // Alias usados en datos simulados / API abreviada
  'healthy': 'Tomate sano',
  'early_blight': 'Tizón temprano',
  'late_blight': 'Tizón tardío',
  'leaf_mold': 'Moho foliar',
  'septoria': 'Mancha séptica',
  'bacterial_spot': 'Mancha bacteriana',
  'spider_mites': 'Ácaro de dos manchas',
  'target_spot': 'Mancha diana',
  'mosaic_virus': 'Virus del mosaico',
  'yellow_leaf_curl': 'Virus del rizado amarillo',
  'Tomato Healthy': 'Tomate sano',
};

/// Obtiene el objeto ClaseEnfermedad completo para un código dado
ClaseEnfermedad? obtenerClaseEnfermedad(String codigo) {
  return clasesEnfermedad[codigo.trim()];
}

/// Función que traduce un diagnóstico del idioma English/código al español
/// Recibe una cadena con el nombre de la enfermedad y retorna su traducción al español
String traducirDiagnostico(String diagnostico) {
  // Si no hay diagnóstico (vacío o null), retorna mensaje por defecto
  if (diagnostico.isEmpty) {
    return 'Sin diagnóstico';
  }

  // Elimina espacios al inicio y final de la cadena
  final normalizado = diagnostico.trim();

  // Busca el diagnóstico normalizado directamente en el mapeo
  // Si está exactamente igual, retorna la traducción correspondiente
  if (clasesEnfermedadEs[normalizado] != null) {
    return clasesEnfermedadEs[normalizado]!;
  }

  // Si no encontró la traducción exacta, intenta con una clave normalizada
  // Reemplaza "Tomato " al inicio (case-insensitive) para buscar una versión simplificada
  // Reemplaza espacios con guiones bajos para que coincida con el patrón de la API
  // Convierte todo a minúsculas para búsqueda flexible
  final claveSnake = normalizado
      .replaceFirst(RegExp(r'^Tomato\s+', caseSensitive: false), '')
      .replaceAll(' ', '_')
      .toLowerCase();

  // Busca la clave normalizada en el mapeo
  if (clasesEnfermedadEs[claveSnake] != null) {
    return clasesEnfermedadEs[claveSnake]!;
  }

  // Si no encuentra ninguna traducción, retorna el diagnóstico original sin traducir
  return normalizado.replaceAll('_', ' ').replaceAll('Tomato ', '');
}

/// Alias de traducirDiagnostico para compatibilidad
String traducirClaseEnfermedad(String codigo) {
  return traducirDiagnostico(codigo);
}

/// Verifica si un código de enfermedad corresponde a una clase sana
bool esClaseSana(String codigo) {
  return obtenerClaseEnfermedad(codigo)?.esSano ??
      codigo.toLowerCase().contains('healthy') ||
          codigo.toLowerCase().contains('sano');
}
