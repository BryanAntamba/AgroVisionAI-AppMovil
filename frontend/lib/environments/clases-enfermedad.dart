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

const Map<String, ClaseEnfermedad> clasesEnfermedad = {
  'Tomato_healthy': ClaseEnfermedad(
    codigo: 'Tomato_healthy',
    nombre: 'Tomate sano',
    descripcion: 'No se detectaron enfermedades activas en la planta.',
    esSano: true,
  ),
  'Tomato_Early_blight': ClaseEnfermedad(
    codigo: 'Tomato_Early_blight',
    nombre: 'Tizón temprano',
    descripcion:
        'Enfermedad foliar asociada a manchas oscuras y amarillamiento.',
  ),
  'Tomato_Late_blight': ClaseEnfermedad(
    codigo: 'Tomato_Late_blight',
    nombre: 'Tizón tardío',
    descripcion: 'Infección agresiva que puede avanzar con alta humedad.',
  ),
  'Tomato_Leaf_Mold': ClaseEnfermedad(
    codigo: 'Tomato_Leaf_Mold',
    nombre: 'Moho foliar',
    descripcion: 'Moho en hojas favorecido por humedad y poca ventilación.',
  ),
  'Tomato_Septoria_leaf_spot': ClaseEnfermedad(
    codigo: 'Tomato_Septoria_leaf_spot',
    nombre: 'Mancha séptica',
    descripcion: 'Pequeñas manchas circulares que deterioran el tejido foliar.',
  ),
  'Tomato_Bacterial_spot': ClaseEnfermedad(
    codigo: 'Tomato_Bacterial_spot',
    nombre: 'Mancha bacteriana',
    descripcion: 'Lesiones por infección bacteriana en hojas o fruto.',
  ),
  'Tomato_Spider_mites_Two_spotted_spider_mite': ClaseEnfermedad(
    codigo: 'Tomato_Spider_mites_Two_spotted_spider_mite',
    nombre: 'Ácaros de dos manchas',
    descripcion:
        'Daño por ácaros que produce punteado y debilitamiento foliar.',
  ),
  'Tomato_Target_Spot': ClaseEnfermedad(
    codigo: 'Tomato_Target_Spot',
    nombre: 'Mancha objetivo',
    descripcion:
        'Manchas concéntricas en hojas causadas por infección fúngica.',
  ),
  'Tomato_Yellow_Leaf_Curl_Virus': ClaseEnfermedad(
    codigo: 'Tomato_Yellow_Leaf_Curl_Virus',
    nombre: 'Virus del rizado amarillo',
    descripcion:
        'Virus que provoca rizado, amarillamiento y menor crecimiento.',
  ),
  'Tomato_mosaic_virus': ClaseEnfermedad(
    codigo: 'Tomato_mosaic_virus',
    nombre: 'Virus del mosaico',
    descripcion: 'Virus que genera moteado, deformación y pérdida de vigor.',
  ),
};

const Map<String, String> clasesEnfermedadEs = {
  'Tomato_healthy': 'Tomate sano',
  'Tomato_Early_blight': 'Tizón temprano',
  'Tomato_Late_blight': 'Tizón tardío',
  'Tomato_Leaf_Mold': 'Moho foliar',
  'Tomato_Septoria_leaf_spot': 'Mancha séptica',
  'Tomato_Bacterial_spot': 'Mancha bacteriana',
  'Tomato_Spider_mites_Two_spotted_spider_mite': 'Ácaros de dos manchas',
  'Tomato_Target_Spot': 'Mancha objetivo',
  'Tomato_Yellow_Leaf_Curl_Virus': 'Virus del rizado amarillo',
  'Tomato_mosaic_virus': 'Virus del mosaico',
};

ClaseEnfermedad? obtenerClaseEnfermedad(String codigo) {
  return clasesEnfermedad[codigo.trim()];
}

String traducirClaseEnfermedad(String codigo) {
  final normalizado = codigo.trim();
  return clasesEnfermedadEs[normalizado] ??
      normalizado.replaceAll('_', ' ').replaceAll('Tomato ', '');
}

bool esClaseSana(String codigo) {
  return obtenerClaseEnfermedad(codigo)?.esSano ??
      codigo.toLowerCase().contains('healthy') ||
          codigo.toLowerCase().contains('sano');
}
