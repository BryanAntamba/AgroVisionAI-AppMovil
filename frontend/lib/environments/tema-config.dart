// Modelos de configuración visual de la plataforma AgroVision AI.
// Equivalente al servicio Angular `TemaService` / `TemaConfig`.

class NavbarConfig {
  String tipoFondo;
  String colorBase;

  NavbarConfig({
    this.tipoFondo = 'gradiente',
    this.colorBase = '#073D2B',
  });

  NavbarConfig copyWith({String? tipoFondo, String? colorBase}) => NavbarConfig(
        tipoFondo: tipoFondo ?? this.tipoFondo,
        colorBase: colorBase ?? this.colorBase,
      );

  Map<String, dynamic> toJson() => {
        'tipoFondo': tipoFondo,
        'colorBase': colorBase,
      };

  factory NavbarConfig.fromJson(Map<String, dynamic> j) => NavbarConfig(
        tipoFondo: j['tipoFondo'] as String? ?? 'gradiente',
        colorBase: j['colorBase'] as String? ?? '#073D2B',
      );
}

class ColoresConfig {
  String titulos;
  String linksNormales;
  String linksActivos;
  String textosDescriptivos;

  ColoresConfig({
    this.titulos = '#073D2B',
    this.linksNormales = '#073D2B',
    this.linksActivos = '#55A820',
    this.textosDescriptivos = '#4B7A5A',
  });

  ColoresConfig copyWith({
    String? titulos,
    String? linksNormales,
    String? linksActivos,
    String? textosDescriptivos,
  }) =>
      ColoresConfig(
        titulos: titulos ?? this.titulos,
        linksNormales: linksNormales ?? this.linksNormales,
        linksActivos: linksActivos ?? this.linksActivos,
        textosDescriptivos: textosDescriptivos ?? this.textosDescriptivos,
      );

  Map<String, dynamic> toJson() => {
        'titulos': titulos,
        'linksNormales': linksNormales,
        'linksActivos': linksActivos,
        'textosDescriptivos': textosDescriptivos,
      };

  factory ColoresConfig.fromJson(Map<String, dynamic> j) => ColoresConfig(
        titulos: j['titulos'] as String? ?? '#073D2B',
        linksNormales: j['linksNormales'] as String? ?? '#073D2B',
        linksActivos: j['linksActivos'] as String? ?? '#55A820',
        textosDescriptivos: j['textosDescriptivos'] as String? ?? '#4B7A5A',
      );
}

class BotonesConfig {
  String colorFondo;
  String colorTexto;
  String colorHover;

  BotonesConfig({
    this.colorFondo = '#55A820',
    this.colorTexto = '#FFFFFF',
    this.colorHover = '#073D2B',
  });

  BotonesConfig copyWith({
    String? colorFondo,
    String? colorTexto,
    String? colorHover,
  }) =>
      BotonesConfig(
        colorFondo: colorFondo ?? this.colorFondo,
        colorTexto: colorTexto ?? this.colorTexto,
        colorHover: colorHover ?? this.colorHover,
      );

  Map<String, dynamic> toJson() => {
        'colorFondo': colorFondo,
        'colorTexto': colorTexto,
        'colorHover': colorHover,
      };

  factory BotonesConfig.fromJson(Map<String, dynamic> j) => BotonesConfig(
        colorFondo: j['colorFondo'] as String? ?? '#55A820',
        colorTexto: j['colorTexto'] as String? ?? '#FFFFFF',
        colorHover: j['colorHover'] as String? ?? '#073D2B',
      );
}

class ModalesConfig {
  String colorEncabezado;
  String colorFondo;

  ModalesConfig({
    this.colorEncabezado = '#073D2B',
    this.colorFondo = '#FFFFFF',
  });

  ModalesConfig copyWith({String? colorEncabezado, String? colorFondo}) =>
      ModalesConfig(
        colorEncabezado: colorEncabezado ?? this.colorEncabezado,
        colorFondo: colorFondo ?? this.colorFondo,
      );

  Map<String, dynamic> toJson() => {
        'colorEncabezado': colorEncabezado,
        'colorFondo': colorFondo,
      };

  factory ModalesConfig.fromJson(Map<String, dynamic> j) => ModalesConfig(
        colorEncabezado: j['colorEncabezado'] as String? ?? '#073D2B',
        colorFondo: j['colorFondo'] as String? ?? '#FFFFFF',
      );
}

/// Configuración visual completa de la plataforma.
class TemaConfig {
  String nombrePlataforma;
  NavbarConfig navbar;
  ColoresConfig colores;
  BotonesConfig botones;
  ModalesConfig modales;

  TemaConfig({
    this.nombrePlataforma = 'AgroVision AI',
    NavbarConfig? navbar,
    ColoresConfig? colores,
    BotonesConfig? botones,
    ModalesConfig? modales,
  })  : navbar = navbar ?? NavbarConfig(),
        colores = colores ?? ColoresConfig(),
        botones = botones ?? BotonesConfig(),
        modales = modales ?? ModalesConfig();

  TemaConfig copyWith({
    String? nombrePlataforma,
    NavbarConfig? navbar,
    ColoresConfig? colores,
    BotonesConfig? botones,
    ModalesConfig? modales,
  }) =>
      TemaConfig(
        nombrePlataforma: nombrePlataforma ?? this.nombrePlataforma,
        navbar: navbar ?? this.navbar,
        colores: colores ?? this.colores,
        botones: botones ?? this.botones,
        modales: modales ?? this.modales,
      );

  Map<String, dynamic> toJson() => {
        'nombrePlataforma': nombrePlataforma,
        'navbar': navbar.toJson(),
        'colores': colores.toJson(),
        'botones': botones.toJson(),
        'modales': modales.toJson(),
      };

  factory TemaConfig.fromJson(Map<String, dynamic> j) => TemaConfig(
        nombrePlataforma:
            j['nombrePlataforma'] as String? ?? 'AgroVision AI',
        navbar: j['navbar'] != null
            ? NavbarConfig.fromJson(j['navbar'] as Map<String, dynamic>)
            : null,
        colores: j['colores'] != null
            ? ColoresConfig.fromJson(j['colores'] as Map<String, dynamic>)
            : null,
        botones: j['botones'] != null
            ? BotonesConfig.fromJson(j['botones'] as Map<String, dynamic>)
            : null,
        modales: j['modales'] != null
            ? ModalesConfig.fromJson(j['modales'] as Map<String, dynamic>)
            : null,
      );
}
