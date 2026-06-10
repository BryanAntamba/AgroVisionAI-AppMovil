const Map<String, dynamic> datosIOTSimulados = {
  "meta": {
    "titulo": "Cultivo de Tomate - Sector A",
    "fecha_captura": "20 oct 2023 · 14:30 pm"
  },
  "captura": {
    "numero_planta": 4,
    "intervalo_nueva_captura_ms": 10000
  },
  "imagenes": {
    "tiene_captura": true,
    "original": "assets/imagesLogin/tomateHumedo.jpg"
  },
  "indice_salud": {
    "valor": 78,
    "estado": "Saludable",
    "descripcion": "La planta presenta buen desarrollo general con algunas áreas de atención.",
    "componentes": [
      {"etiqueta": "Follaje", "valor": 85},
      {"etiqueta": "Tallo", "valor": 90},
      {"etiqueta": "Raíz", "valor": 60}
    ]
  },
  "sensores_tiempo_real": {
    "temperatura_aire_c": 24.5,
    "temperatura_optima_min": 18,
    "temperatura_optima_max": 28,
    "temperatura_sensor_min": -10,
    "temperatura_sensor_max": 50,
    "humedad_aire_pct": 65,
    "humedad_aire_optima_min": 50,
    "humedad_aire_optima_max": 70,
    "humedad_suelo_pct": 45,
    "riego_minimo": 40,
    "intensidad_luz_lux": 85000,
    "luz_optima_min": 60000,
    "luz_optima_max": 100000
  },
  "sensores_complementarios": {
    "humedad_hoja_pct": 30,
    "humedad_hoja_optima_min": 25,
    "humedad_hoja_optima_max": 60,
    "flujo_aire_ms": 1.2,
    "flujo_aire_ref_min": 0.5,
    "flujo_aire_ref_max": 2.0
  },
  "diagnostico_final": {
    "diagnostico_final": "Tizón temprano",
    "descripcion": "Se detectan manchas concéntricas en las hojas inferiores, síntoma clásico de Alternaria solani.",
    "confianza_final": 88,
    "predicciones": {
      "early_blight": 88,
      "healthy": 10,
      "late_blight": 2
    },
    "otras_condiciones": "Resto de enfermedades < 1%"
  },
  "metricas_lesion": {
    "area_afectada_pct": 12,
    "area_amarilla_pct": 8,
    "area_marron_pct": 4,
    "manchas_detectadas": 5
  },
  "reconexion": {
    "intentos_para_exito": 2
  }
};

const List<Map<String, dynamic>> recomendacionesSimuladas = [
  {
    "tipo": "warn",
    "titulo": "Riego necesario pronto",
    "mensaje": "La humedad del suelo está cerca del límite inferior.",
    "accion": "Aumentar frecuencia de riego un 10%.",
    "icono": "fa-droplet"
  },
  {
    "tipo": "crit",
    "titulo": "Aplicar fungicida",
    "mensaje": "Alta probabilidad de Tizón Temprano detectada.",
    "accion": "Aplicar fungicida a base de cobre inmediatamente.",
    "icono": "fa-spray-can-sparkles"
  }
];
