class NavbarConfig {
  String tipoFondo;
  String colorBase;
  bool resplandorActivo;
  String colorResplandor;
  String posicionResplandor;
  int opacidadResplandor;
  int tamanoResplandor;
  String colorBorde;

  NavbarConfig({
    this.tipoFondo = 'gradiente',
    this.colorBase = '#ffffff',
    this.resplandorActivo = true,
    this.colorResplandor = '#55a820',
    this.posicionResplandor = 'top right',
    this.opacidadResplandor = 20,
    this.tamanoResplandor = 34,
    this.colorBorde = '#d7e4dc',
  });

  factory NavbarConfig.fromJson(Map<String, dynamic> json) {
    return NavbarConfig(
      tipoFondo: json['tipoFondo'] as String? ?? 'gradiente',
      colorBase: json['colorBase'] as String? ?? '#ffffff',
      resplandorActivo: json['resplandorActivo'] as bool? ?? true,
      colorResplandor: json['colorResplandor'] as String? ?? '#55a820',
      posicionResplandor: json['posicionResplandor'] as String? ?? 'top right',
      opacidadResplandor: json['opacidadResplandor'] as int? ?? 20,
      tamanoResplandor: json['tamanoResplandor'] as int? ?? 34,
      colorBorde: json['colorBorde'] as String? ?? '#d7e4dc',
    );
  }

  Map<String, dynamic> toJson() => {
    'tipoFondo': tipoFondo,
    'colorBase': colorBase,
    'resplandorActivo': resplandorActivo,
    'colorResplandor': colorResplandor,
    'posicionResplandor': posicionResplandor,
    'opacidadResplandor': opacidadResplandor,
    'tamanoResplandor': tamanoResplandor,
    'colorBorde': colorBorde,
  };
}

class ColoresConfig {
  String titulos;
  String linksNormales;
  String linksActivos;
  String textosDescriptivos;
  String iconos;

  ColoresConfig({
    this.titulos = '#073d2b',
    this.linksNormales = '#456657',
    this.linksActivos = '#55a820',
    this.textosDescriptivos = '#597268',
    this.iconos = '#55a820',
  });

  factory ColoresConfig.fromJson(Map<String, dynamic> json) {
    return ColoresConfig(
      titulos: json['titulos'] as String? ?? '#073d2b',
      linksNormales: json['linksNormales'] as String? ?? '#456657',
      linksActivos: json['linksActivos'] as String? ?? '#55a820',
      textosDescriptivos: json['textosDescriptivos'] as String? ?? '#597268',
      iconos: json['iconos'] as String? ?? '#55a820',
    );
  }

  Map<String, dynamic> toJson() => {
    'titulos': titulos,
    'linksNormales': linksNormales,
    'linksActivos': linksActivos,
    'textosDescriptivos': textosDescriptivos,
    'iconos': iconos,
  };
}

class BotonesConfig {
  String tipo;
  String colorInicial;
  String colorFinal;
  String colorTexto;
  String destructivoColor;
  String destructivoHover;

  BotonesConfig({
    this.tipo = 'gradiente',
    this.colorInicial = '#073d2b',
    this.colorFinal = '#55a820',
    this.colorTexto = '#ffffff',
    this.destructivoColor = '#a32626',
    this.destructivoHover = '#8b1f1f',
  });

  factory BotonesConfig.fromJson(Map<String, dynamic> json) {
    return BotonesConfig(
      tipo: json['tipo'] as String? ?? 'gradiente',
      colorInicial: json['colorInicial'] as String? ?? '#073d2b',
      colorFinal: json['colorFinal'] as String? ?? '#55a820',
      colorTexto: json['colorTexto'] as String? ?? '#ffffff',
      destructivoColor: json['destructivoColor'] as String? ?? '#a32626',
      destructivoHover: json['destructivoHover'] as String? ?? '#8b1f1f',
    );
  }

  Map<String, dynamic> toJson() => {
    'tipo': tipo,
    'colorInicial': colorInicial,
    'colorFinal': colorFinal,
    'colorTexto': colorTexto,
    'destructivoColor': destructivoColor,
    'destructivoHover': destructivoHover,
  };
}

class ModalesConfig {
  String colorBackdrop;
  int opacidadBackdrop;
  String botonesFondoDestructivo;
  String botonesHoverDestructivo;
  String iconoExitoColor;
  String iconoExitoFondo;

  ModalesConfig({
    this.colorBackdrop = '#073d2b',
    this.opacidadBackdrop = 45,
    this.botonesFondoDestructivo = '#a32626',
    this.botonesHoverDestructivo = '#8b1f1f',
    this.iconoExitoColor = '#55a820',
    this.iconoExitoFondo = '#eaf7e5',
  });

  factory ModalesConfig.fromJson(Map<String, dynamic> json) {
    return ModalesConfig(
      colorBackdrop: json['colorBackdrop'] as String? ?? '#073d2b',
      opacidadBackdrop: json['opacidadBackdrop'] as int? ?? 45,
      botonesFondoDestructivo:
          json['botonesFondoDestructivo'] as String? ?? '#a32626',
      botonesHoverDestructivo:
          json['botonesHoverDestructivo'] as String? ?? '#8b1f1f',
      iconoExitoColor: json['iconoExitoColor'] as String? ?? '#55a820',
      iconoExitoFondo: json['iconoExitoFondo'] as String? ?? '#eaf7e5',
    );
  }

  Map<String, dynamic> toJson() => {
    'colorBackdrop': colorBackdrop,
    'opacidadBackdrop': opacidadBackdrop,
    'botonesFondoDestructivo': botonesFondoDestructivo,
    'botonesHoverDestructivo': botonesHoverDestructivo,
    'iconoExitoColor': iconoExitoColor,
    'iconoExitoFondo': iconoExitoFondo,
  };
}

class TemaConfig {
  String nombrePlataforma;
  NavbarConfig navbar;
  ColoresConfig colores;
  BotonesConfig botones;
  ModalesConfig modales;
  String? logoUrl;
  String? faviconUrl;

  TemaConfig({
    this.nombrePlataforma = 'AgroVision AI',
    NavbarConfig? navbar,
    ColoresConfig? colores,
    BotonesConfig? botones,
    ModalesConfig? modales,
    this.logoUrl,
    this.faviconUrl,
  }) : navbar = navbar ?? NavbarConfig(),
       colores = colores ?? ColoresConfig(),
       botones = botones ?? BotonesConfig(),
       modales = modales ?? ModalesConfig();

  factory TemaConfig.fromJson(Map<String, dynamic> json) {
    return TemaConfig(
      nombrePlataforma: json['nombrePlataforma'] as String? ?? 'AgroVision AI',
      navbar: NavbarConfig.fromJson(
        (json['navbar'] as Map?)?.cast<String, dynamic>() ?? {},
      ),
      colores: ColoresConfig.fromJson(
        (json['colores'] as Map?)?.cast<String, dynamic>() ?? {},
      ),
      botones: BotonesConfig.fromJson(
        (json['botones'] as Map?)?.cast<String, dynamic>() ?? {},
      ),
      modales: ModalesConfig.fromJson(
        (json['modales'] as Map?)?.cast<String, dynamic>() ?? {},
      ),
      logoUrl: json['logoUrl'] as String?,
      faviconUrl: json['faviconUrl'] as String?,
    );
  }

  Map<String, dynamic> toJson() => {
    'nombrePlataforma': nombrePlataforma,
    'navbar': navbar.toJson(),
    'colores': colores.toJson(),
    'botones': botones.toJson(),
    'modales': modales.toJson(),
    'logoUrl': logoUrl,
    'faviconUrl': faviconUrl,
  };
}
