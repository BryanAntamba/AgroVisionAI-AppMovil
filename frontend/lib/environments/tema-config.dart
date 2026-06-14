// ═══════════════════════════════════════════════════════════════════════════
// TEMA CONFIG - CONFIGURACIÓN DE TEMAS VISUALES DE LA PLATAFORMA
// ═══════════════════════════════════════════════════════════════════════════
// Define las clases de configuración para personalizar la apariencia visual
// de la plataforma incluyendo navbar, colores, botones y modales.
// ═══════════════════════════════════════════════════════════════════════════

/// Clase que configura la apariencia del navbar (barra de navegación)
/// Controla fondo, resplandor, bordes y efectos visuales
class NavbarConfig {
  String tipoFondo;           // Tipo de fondo: 'gradiente' o 'solido'
  String colorBase;           // Color principal del navbar (formato hex)
  bool resplandorActivo;      // Indica si el efecto de resplandor está habilitado
  String colorResplandor;     // Color del efecto de resplandor (formato hex)
  String posicionResplandor;  // Posición del resplandor: 'top right', 'bottom left', etc.
  int opacidadResplandor;     // Opacidad del resplandor (0-100)
  int tamanoResplandor;       // Tamaño del resplandor en porcentaje
  String colorBorde;          // Color del borde del navbar (formato hex)

  /// Constructor con valores por defecto para el tema verde de AgroVision
  NavbarConfig({
    this.tipoFondo = 'gradiente',          // Gradiente por defecto
    this.colorBase = '#ffffff',            // Blanco como base
    this.resplandorActivo = true,          // Resplandor activado
    this.colorResplandor = '#55a820',      // Verde principal
    this.posicionResplandor = 'top right', // Esquina superior derecha
    this.opacidadResplandor = 20,          // 20% de opacidad
    this.tamanoResplandor = 34,            // 34% de tamaño
    this.colorBorde = '#d7e4dc',           // Verde claro para borde
  });

  /// Factory constructor para deserializar desde JSON
  /// Permite cargar configuración guardada
  factory NavbarConfig.fromJson(Map<String, dynamic> json) {
    return NavbarConfig(
      tipoFondo: json['tipoFondo'] as String? ?? 'gradiente',          // Lee tipoFondo o usa default
      colorBase: json['colorBase'] as String? ?? '#ffffff',            // Lee colorBase o usa default
      resplandorActivo: json['resplandorActivo'] as bool? ?? true,     // Lee resplandor o usa default
      colorResplandor: json['colorResplandor'] as String? ?? '#55a820', // Lee color o usa default
      posicionResplandor: json['posicionResplandor'] as String? ?? 'top right', // Lee posición o usa default
      opacidadResplandor: json['opacidadResplandor'] as int? ?? 20,    // Lee opacidad o usa default
      tamanoResplandor: json['tamanoResplandor'] as int? ?? 34,        // Lee tamaño o usa default
      colorBorde: json['colorBorde'] as String? ?? '#d7e4dc',          // Lee borde o usa default
    );
  }

  /// Serializa la configuración a formato JSON
  /// Permite guardar la configuración personalizada
  Map<String, dynamic> toJson() => {
    'tipoFondo': tipoFondo,                // Guarda tipo de fondo
    'colorBase': colorBase,                // Guarda color base
    'resplandorActivo': resplandorActivo,  // Guarda estado del resplandor
    'colorResplandor': colorResplandor,    // Guarda color del resplandor
    'posicionResplandor': posicionResplandor, // Guarda posición
    'opacidadResplandor': opacidadResplandor, // Guarda opacidad
    'tamanoResplandor': tamanoResplandor,  // Guarda tamaño
    'colorBorde': colorBorde,              // Guarda color del borde
  };
}

/// Clase que configura los colores de texto e iconos de la plataforma
/// Define la paleta de colores para diferentes elementos textuales
class ColoresConfig {
  String titulos;              // Color para títulos principales (formato hex)
  String linksNormales;        // Color para enlaces en estado normal (formato hex)
  String linksActivos;         // Color para enlaces activos/hover (formato hex)
  String textosDescriptivos;   // Color para textos descriptivos secundarios (formato hex)
  String iconos;               // Color para iconos de la interfaz (formato hex)

  /// Constructor con valores por defecto del tema verde oscuro
  ColoresConfig({
    this.titulos = '#073d2b',           // Verde muy oscuro para títulos
    this.linksNormales = '#456657',     // Verde grisáceo para enlaces normales
    this.linksActivos = '#55a820',      // Verde brillante para enlaces activos
    this.textosDescriptivos = '#597268', // Verde medio para textos descriptivos
    this.iconos = '#55a820',            // Verde brillante para iconos
  });

  /// Factory constructor para deserializar desde JSON
  factory ColoresConfig.fromJson(Map<String, dynamic> json) {
    return ColoresConfig(
      titulos: json['titulos'] as String? ?? '#073d2b',               // Lee títulos o usa default
      linksNormales: json['linksNormales'] as String? ?? '#456657',   // Lee links normales o usa default
      linksActivos: json['linksActivos'] as String? ?? '#55a820',     // Lee links activos o usa default
      textosDescriptivos: json['textosDescriptivos'] as String? ?? '#597268', // Lee textos o usa default
      iconos: json['iconos'] as String? ?? '#55a820',                 // Lee iconos o usa default
    );
  }

  /// Serializa la configuración a formato JSON
  Map<String, dynamic> toJson() => {
    'titulos': titulos,                    // Guarda color de títulos
    'linksNormales': linksNormales,        // Guarda color de links normales
    'linksActivos': linksActivos,          // Guarda color de links activos
    'textosDescriptivos': textosDescriptivos, // Guarda color de textos
    'iconos': iconos,                      // Guarda color de iconos
  };
}

/// Clase que configura la apariencia de los botones
/// Define estilos para botones principales y destructivos
class BotonesConfig {
  String tipo;                // Tipo de botón: 'gradiente' o 'solido'
  String colorInicial;        // Color inicial del gradiente (formato hex)
  String colorFinal;          // Color final del gradiente (formato hex)
  String colorTexto;          // Color del texto del botón (formato hex)
  String destructivoColor;    // Color de botones destructivos (formato hex)
  String destructivoHover;    // Color de botones destructivos en hover (formato hex)

  /// Constructor con valores por defecto
  BotonesConfig({
    this.tipo = 'gradiente',              // Gradiente por defecto
    this.colorInicial = '#073d2b',        // Verde oscuro inicial
    this.colorFinal = '#55a820',          // Verde brillante final
    this.colorTexto = '#ffffff',          // Texto blanco
    this.destructivoColor = '#a32626',    // Rojo para acciones destructivas
    this.destructivoHover = '#8b1f1f',    // Rojo más oscuro en hover
  });

  /// Factory constructor para deserializar desde JSON
  factory BotonesConfig.fromJson(Map<String, dynamic> json) {
    return BotonesConfig(
      tipo: json['tipo'] as String? ?? 'gradiente',                     // Lee tipo o usa default
      colorInicial: json['colorInicial'] as String? ?? '#073d2b',       // Lee color inicial o usa default
      colorFinal: json['colorFinal'] as String? ?? '#55a820',           // Lee color final o usa default
      colorTexto: json['colorTexto'] as String? ?? '#ffffff',           // Lee color texto o usa default
      destructivoColor: json['destructivoColor'] as String? ?? '#a32626', // Lee destructivo o usa default
      destructivoHover: json['destructivoHover'] as String? ?? '#8b1f1f', // Lee hover o usa default
    );
  }

  /// Serializa la configuración a formato JSON
  Map<String, dynamic> toJson() => {
    'tipo': tipo,                          // Guarda tipo de botón
    'colorInicial': colorInicial,          // Guarda color inicial
    'colorFinal': colorFinal,              // Guarda color final
    'colorTexto': colorTexto,              // Guarda color del texto
    'destructivoColor': destructivoColor,  // Guarda color destructivo
    'destructivoHover': destructivoHover,  // Guarda color hover destructivo
  };
}

/// Clase que configura la apariencia de los modales (ventanas emergentes)
/// Define estilos para backdrop, botones y elementos de modales
class ModalesConfig {
  String colorBackdrop;           // Color del fondo semitransparente detrás del modal (formato hex)
  int opacidadBackdrop;           // Opacidad del backdrop (0-100)
  String botonesFondoDestructivo; // Color de fondo de botones destructivos en modales (formato hex)
  String botonesHoverDestructivo; // Color hover de botones destructivos (formato hex)
  String iconoExitoColor;         // Color del icono de éxito (formato hex)
  String iconoExitoFondo;         // Color de fondo del icono de éxito (formato hex)

  /// Constructor con valores por defecto
  ModalesConfig({
    this.colorBackdrop = '#073d2b',               // Verde oscuro para backdrop
    this.opacidadBackdrop = 45,                   // 45% de opacidad
    this.botonesFondoDestructivo = '#a32626',     // Rojo para botones destructivos
    this.botonesHoverDestructivo = '#8b1f1f',     // Rojo oscuro en hover
    this.iconoExitoColor = '#55a820',             // Verde para icono de éxito
    this.iconoExitoFondo = '#eaf7e5',             // Verde muy claro para fondo de icono
  });

  /// Factory constructor para deserializar desde JSON
  factory ModalesConfig.fromJson(Map<String, dynamic> json) {
    return ModalesConfig(
      colorBackdrop: json['colorBackdrop'] as String? ?? '#073d2b',     // Lee backdrop o usa default
      opacidadBackdrop: json['opacidadBackdrop'] as int? ?? 45,         // Lee opacidad o usa default
      botonesFondoDestructivo:
          json['botonesFondoDestructivo'] as String? ?? '#a32626',      // Lee botón destructivo o usa default
      botonesHoverDestructivo:
          json['botonesHoverDestructivo'] as String? ?? '#8b1f1f',      // Lee hover destructivo o usa default
      iconoExitoColor: json['iconoExitoColor'] as String? ?? '#55a820', // Lee icono éxito o usa default
      iconoExitoFondo: json['iconoExitoFondo'] as String? ?? '#eaf7e5', // Lee fondo icono o usa default
    );
  }

  /// Serializa la configuración a formato JSON
  Map<String, dynamic> toJson() => {
    'colorBackdrop': colorBackdrop,                      // Guarda color del backdrop
    'opacidadBackdrop': opacidadBackdrop,                // Guarda opacidad del backdrop
    'botonesFondoDestructivo': botonesFondoDestructivo,  // Guarda color botón destructivo
    'botonesHoverDestructivo': botonesHoverDestructivo,  // Guarda color hover destructivo
    'iconoExitoColor': iconoExitoColor,                  // Guarda color icono éxito
    'iconoExitoFondo': iconoExitoFondo,                  // Guarda fondo icono éxito
  };
}

/// Clase principal que agrupa toda la configuración del tema
/// Incluye nombre de la plataforma, logos y todas las sub-configuraciones
class TemaConfig {
  String nombrePlataforma;  // Nombre de la plataforma que se muestra en la UI
  NavbarConfig navbar;      // Configuración del navbar
  ColoresConfig colores;    // Configuración de colores de texto e iconos
  BotonesConfig botones;    // Configuración de botones
  ModalesConfig modales;    // Configuración de modales
  String? logoUrl;          // URL opcional del logo personalizado
  String? faviconUrl;       // URL opcional del favicon personalizado

  /// Constructor con valores por defecto para AgroVision AI
  /// Inicializa sub-configuraciones si no se proporcionan
  TemaConfig({
    this.nombrePlataforma = 'AgroVision AI',  // Nombre por defecto
    NavbarConfig? navbar,                     // Navbar opcional
    ColoresConfig? colores,                   // Colores opcionales
    BotonesConfig? botones,                   // Botones opcionales
    ModalesConfig? modales,                   // Modales opcionales
    this.logoUrl,                             // Logo opcional (puede ser null)
    this.faviconUrl,                          // Favicon opcional (puede ser null)
  }) : navbar = navbar ?? NavbarConfig(),     // Usa navbar proporcionado o crea uno nuevo
       colores = colores ?? ColoresConfig(),   // Usa colores proporcionados o crea nuevos
       botones = botones ?? BotonesConfig(),   // Usa botones proporcionados o crea nuevos
       modales = modales ?? ModalesConfig();   // Usa modales proporcionados o crea nuevos

  /// Factory constructor para deserializar desde JSON
  /// Reconstruye toda la configuración del tema desde un mapa JSON
  factory TemaConfig.fromJson(Map<String, dynamic> json) {
    return TemaConfig(
      nombrePlataforma: json['nombrePlataforma'] as String? ?? 'AgroVision AI', // Lee nombre o usa default
      navbar: NavbarConfig.fromJson(
        (json['navbar'] as Map?)?.cast<String, dynamic>() ?? {},     // Deserializa navbar o usa mapa vacío
      ),
      colores: ColoresConfig.fromJson(
        (json['colores'] as Map?)?.cast<String, dynamic>() ?? {},    // Deserializa colores o usa mapa vacío
      ),
      botones: BotonesConfig.fromJson(
        (json['botones'] as Map?)?.cast<String, dynamic>() ?? {},    // Deserializa botones o usa mapa vacío
      ),
      modales: ModalesConfig.fromJson(
        (json['modales'] as Map?)?.cast<String, dynamic>() ?? {},    // Deserializa modales o usa mapa vacío
      ),
      logoUrl: json['logoUrl'] as String?,        // Lee logo URL (puede ser null)
      faviconUrl: json['faviconUrl'] as String?,  // Lee favicon URL (puede ser null)
    );
  }

  /// Serializa toda la configuración del tema a formato JSON
  /// Permite guardar el tema completo personalizado
  Map<String, dynamic> toJson() => {
    'nombrePlataforma': nombrePlataforma,  // Guarda nombre de la plataforma
    'navbar': navbar.toJson(),             // Serializa configuración del navbar
    'colores': colores.toJson(),           // Serializa configuración de colores
    'botones': botones.toJson(),           // Serializa configuración de botones
    'modales': modales.toJson(),           // Serializa configuración de modales
    'logoUrl': logoUrl,                    // Guarda URL del logo (puede ser null)
    'faviconUrl': faviconUrl,              // Guarda URL del favicon (puede ser null)
  };
}
