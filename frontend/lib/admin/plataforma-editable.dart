import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import '../navbars/barra-admin.dart';
import '../styles/admin-styles/plataforma-editable.dart';
import '../environments/tema-config.dart';
import '../shared/services/tema.service.dart';

class ImagenCarrusel {
  final int id;
  final String nombre;
  final String url;
  final bool esNueva;
  ImagenCarrusel({required this.id, required this.nombre, required this.url, this.esNueva = false});
}

class PlataformaEditable extends StatefulWidget {
  const PlataformaEditable({super.key});

  @override
  State<PlataformaEditable> createState() => _PlataformaEditableState();
}

class _PlataformaEditableState extends State<PlataformaEditable> {
  // Modales
  bool _mostrarModalResetConfirmar = false;
  bool _mostrarModalResetExito = false;
  bool _mostrarModalGuardadoExito = false;
  bool _mostrarModalErrores = false;
  final List<String> _erroresValidacion = [];

  // Config
  late TemaConfig _config;

  // Controllers
  late TextEditingController _nombreCtrl;
  late TextEditingController _navColorBaseCtrl;
  late TextEditingController _navColorResplandorCtrl;
  late TextEditingController _navColorBordeCtrl;
  late TextEditingController _coloresTitulosCtrl;
  late TextEditingController _coloresLinksNormalesCtrl;
  late TextEditingController _coloresLinksActivosCtrl;
  late TextEditingController _coloresTextosCtrl;
  late TextEditingController _botonesColorInicialCtrl;
  late TextEditingController _botonesColorFinalCtrl;
  late TextEditingController _botonesColorTextoCtrl;
  late TextEditingController _botonesDestructivoColorCtrl;
  late TextEditingController _botonesDestructivoHoverCtrl;
  late TextEditingController _iconosCtrl;
  late TextEditingController _modalesColorBackdropCtrl;
  late TextEditingController _modalesBotonesFondoDestructivoCtrl;
  late TextEditingController _modalesBotonesHoverDestructivoCtrl;
  late TextEditingController _modalesIconoExitoColorCtrl;
  late TextEditingController _modalesIconoExitoFondoCtrl;

  // Logo y Favicon
  String? _logoPreview;

  // Carrusel
  final List<ImagenCarrusel> _imagenesCarrusel = [
    ImagenCarrusel(id: 1, nombre: 'campo-1.jpg', url: ''),
    ImagenCarrusel(id: 2, nombre: 'cultivo.png', url: ''),
  ];

  @override
  void initState() {
    super.initState();
    _initValues(TemaService.instance.config);
  }

  void _initValues(TemaConfig configToLoad) {
    _config = TemaConfig.fromJson(configToLoad.toJson()); // Deep copy para evitar editar en vivo sin guardar
    
    _nombreCtrl = TextEditingController(text: _config.nombrePlataforma);
    _navColorBaseCtrl = TextEditingController(text: _config.navbar.colorBase);
    _navColorResplandorCtrl = TextEditingController(text: _config.navbar.colorResplandor);
    _navColorBordeCtrl = TextEditingController(text: _config.navbar.colorBorde);
    _coloresTitulosCtrl = TextEditingController(text: _config.colores.titulos);
    _coloresLinksNormalesCtrl = TextEditingController(text: _config.colores.linksNormales);
    _coloresLinksActivosCtrl = TextEditingController(text: _config.colores.linksActivos);
    _coloresTextosCtrl = TextEditingController(text: _config.colores.textosDescriptivos);
    _botonesColorInicialCtrl = TextEditingController(text: _config.botones.colorInicial);
    _botonesColorFinalCtrl = TextEditingController(text: _config.botones.colorFinal);
    _botonesColorTextoCtrl = TextEditingController(text: _config.botones.colorTexto);
    _botonesDestructivoColorCtrl = TextEditingController(text: _config.botones.destructivoColor);
    _botonesDestructivoHoverCtrl = TextEditingController(text: _config.botones.destructivoHover);
    _iconosCtrl = TextEditingController(text: _config.colores.iconos);
    _modalesColorBackdropCtrl = TextEditingController(text: _config.modales.colorBackdrop);
    _modalesBotonesFondoDestructivoCtrl = TextEditingController(text: _config.modales.botonesFondoDestructivo);
    _modalesBotonesHoverDestructivoCtrl = TextEditingController(text: _config.modales.botonesHoverDestructivo);
    _modalesIconoExitoColorCtrl = TextEditingController(text: _config.modales.iconoExitoColor);
    _modalesIconoExitoFondoCtrl = TextEditingController(text: _config.modales.iconoExitoFondo);
  }

  @override
  void dispose() {
    _nombreCtrl.dispose();
    _navColorBaseCtrl.dispose();
    _navColorResplandorCtrl.dispose();
    _navColorBordeCtrl.dispose();
    _coloresTitulosCtrl.dispose();
    _coloresLinksNormalesCtrl.dispose();
    _coloresLinksActivosCtrl.dispose();
    _coloresTextosCtrl.dispose();
    _botonesColorInicialCtrl.dispose();
    _botonesColorFinalCtrl.dispose();
    _botonesColorTextoCtrl.dispose();
    _botonesDestructivoColorCtrl.dispose();
    _botonesDestructivoHoverCtrl.dispose();
    _iconosCtrl.dispose();
    _modalesColorBackdropCtrl.dispose();
    _modalesBotonesFondoDestructivoCtrl.dispose();
    _modalesBotonesHoverDestructivoCtrl.dispose();
    _modalesIconoExitoColorCtrl.dispose();
    _modalesIconoExitoFondoCtrl.dispose();
    super.dispose();
  }

  Color _colorFromHex(String hexColor) {
    hexColor = hexColor.replaceAll('#', '');
    if (hexColor.length == 6) {
      hexColor = 'FF$hexColor';
    }
    return Color(int.tryParse('0x$hexColor') ?? 0xFF073D2B);
  }

  void _guardarCambios() {
    setState(() {
      _erroresValidacion.clear();
      if (_nombreCtrl.text.trim().isEmpty || _nombreCtrl.text.trim().length > 50) {
        _erroresValidacion.add('El nombre de la plataforma debe tener entre 1 y 50 caracteres.');
      }
      
      if (_erroresValidacion.isNotEmpty) {
        _mostrarModalErrores = true;
      } else {
        _config.nombrePlataforma = _nombreCtrl.text.trim();
        _config.navbar.colorBase = _navColorBaseCtrl.text;
        _config.navbar.colorResplandor = _navColorResplandorCtrl.text;
        _config.navbar.colorBorde = _navColorBordeCtrl.text;
        
        _config.colores.titulos = _coloresTitulosCtrl.text;
        _config.colores.linksNormales = _coloresLinksNormalesCtrl.text;
        _config.colores.linksActivos = _coloresLinksActivosCtrl.text;
        _config.colores.textosDescriptivos = _coloresTextosCtrl.text;
        
        _config.botones.colorInicial = _botonesColorInicialCtrl.text;
        _config.botones.colorFinal = _botonesColorFinalCtrl.text;
        _config.botones.colorTexto = _botonesColorTextoCtrl.text;
        _config.botones.destructivoColor = _botonesDestructivoColorCtrl.text;
        _config.botones.destructivoHover = _botonesDestructivoHoverCtrl.text;
        
        _config.colores.iconos = _iconosCtrl.text;
        
        _config.modales.colorBackdrop = _modalesColorBackdropCtrl.text;
        _config.modales.botonesFondoDestructivo = _modalesBotonesFondoDestructivoCtrl.text;
        _config.modales.botonesHoverDestructivo = _modalesBotonesHoverDestructivoCtrl.text;
        _config.modales.iconoExitoColor = _modalesIconoExitoColorCtrl.text;
        _config.modales.iconoExitoFondo = _modalesIconoExitoFondoCtrl.text;

        TemaService.instance.guardar(_config);
        _mostrarModalGuardadoExito = true;
      }
    });
  }

  void _confirmarResetear() {
    TemaService.instance.resetear();
    setState(() {
      _initValues(TemaService.instance.config);
      _mostrarModalResetConfirmar = false;
      _mostrarModalResetExito = true;
    });
  }

  Widget _buildSectionHeader(dynamic icon, String title, String description) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          children: [
            FaIcon(icon, size: 24, color: PlataformaEditableStyles.primaryGreen),
            const SizedBox(width: 12),
            Text(title, style: PlataformaEditableStyles.sectionTitle),
          ],
        ),
        const SizedBox(height: 8),
        Padding(
          padding: const EdgeInsets.only(left: 36.0),
          child: Text(description, style: PlataformaEditableStyles.sectionDesc),
        ),
        const SizedBox(height: 24),
      ],
    );
  }

  Widget _buildHelpText(String text) {
    return Container(
      margin: const EdgeInsets.only(bottom: 12),
      padding: const EdgeInsets.all(12),
      decoration: PlataformaEditableStyles.helpBox,
      width: double.infinity,
      child: Text(text, style: PlataformaEditableStyles.helpText),
    );
  }

  Widget _buildColorRow(String title, String desc, TextEditingController ctrl, Function(String) onChanged, [bool fullWidth = false]) {
    final field = Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(title, style: PlataformaEditableStyles.configLabel),
        if (desc.isNotEmpty) ...[
          const SizedBox(height: 2),
          Text(desc, style: PlataformaEditableStyles.helpTextSmall),
        ],
        const SizedBox(height: 8),
        Row(
          children: [
            Container(
              width: 60, height: 44,
              decoration: BoxDecoration(
                color: _colorFromHex(ctrl.text),
                border: Border.all(color: PlataformaEditableStyles.borderGrey),
                borderRadius: BorderRadius.circular(8),
              ),
            ),
            const SizedBox(width: 10),
            Expanded(
              child: Container(
                height: 44,
                decoration: PlataformaEditableStyles.inputDecoration(),
                child: TextField(
                  controller: ctrl,
                  onChanged: (v) {
                    onChanged(v);
                    setState(() {});
                  },
                  decoration: const InputDecoration(border: InputBorder.none, contentPadding: EdgeInsets.symmetric(horizontal: 12)),
                  style: const TextStyle(fontSize: 14, fontFamily: 'Courier New', fontWeight: FontWeight.bold),
                ),
              ),
            ),
          ],
        ),
      ],
    );
    if (fullWidth) return field;
    return Expanded(child: field);
  }

  Widget _buildIdentidadVisual() {
    return Container(
      padding: const EdgeInsets.all(28),
      decoration: PlataformaEditableStyles.sectionDecoration,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          _buildSectionHeader(FontAwesomeIcons.image, 'Identidad Visual', 'Personaliza el logo, icono y nombre que representan tu plataforma'),
          
          // Logo
          const Text('Logo Principal de la Plataforma', style: PlataformaEditableStyles.configLabel),
          const SizedBox(height: 8),
          _buildHelpText('Este logo aparecerá en todas las barras de navegación (Admin y Agricultor), páginas de autenticación y paneles. El cambio no afectará el tamaño, solo la imagen.'),
          Container(
            width: double.infinity,
            padding: const EdgeInsets.all(20),
            decoration: PlataformaEditableStyles.fileUploadArea,
            child: Column(
              children: [
                if (_logoPreview != null)
                  Container(
                    margin: const EdgeInsets.only(bottom: 16),
                    padding: const EdgeInsets.all(12),
                    decoration: BoxDecoration(
                      border: Border.all(color: PlataformaEditableStyles.borderGrey),
                      borderRadius: BorderRadius.circular(8),
                      color: Colors.white,
                    ),
                    child: Stack(
                      clipBehavior: Clip.none,
                      children: [
                        Image.network(_logoPreview!, width: 200, height: 120, fit: BoxFit.contain),
                        Positioned(
                          top: -20,
                          right: -20,
                          child: GestureDetector(
                            onTap: () => setState(() => _logoPreview = null),
                            child: Container(
                              width: 28, height: 28,
                              decoration: const BoxDecoration(color: PlataformaEditableStyles.danger, shape: BoxShape.circle),
                              child: const Icon(Icons.close, color: Colors.white, size: 14),
                            ),
                          ),
                        ),
                      ],
                    ),
                  )
                else
                  Column(
                    children: [
                      const FaIcon(FontAwesomeIcons.cloudArrowUp, size: 48, color: PlataformaEditableStyles.borderInput),
                      const SizedBox(height: 8),
                      const Text('Logo actual: escudo.png', style: TextStyle(color: Color(0xFF6B8177), fontSize: 14)),
                      const SizedBox(height: 16),
                    ],
                  ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    ElevatedButton.icon(
                      onPressed: () {},
                      icon: const FaIcon(FontAwesomeIcons.upload, size: 14),
                      label: const Text('Subir Nuevo Logo'),
                      style: ElevatedButton.styleFrom(
                        backgroundColor: PlataformaEditableStyles.darkGreen,
                        foregroundColor: Colors.white,
                        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8)),
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),
          
          const SizedBox(height: 24),
          // Icono de App
          const Text('Icono de la Aplicación', style: PlataformaEditableStyles.configLabel),
          const SizedBox(height: 8),
          _buildHelpText('Icono principal de la aplicación móvil. Se recomienda usar imágenes cuadradas de 512x512px o 1024x1024px en formato PNG.'),
          Container(
            width: double.infinity,
            padding: const EdgeInsets.all(20),
            decoration: PlataformaEditableStyles.fileUploadArea,
            child: Column(
              children: [
                const FaIcon(FontAwesomeIcons.leaf, size: 48, color: PlataformaEditableStyles.borderInput),
                const SizedBox(height: 8),
                const Text('Icono actual: iconoHoja.png', style: TextStyle(color: Color(0xFF6B8177), fontSize: 14)),
                const SizedBox(height: 16),
                ElevatedButton.icon(
                  onPressed: () {},
                  icon: const FaIcon(FontAwesomeIcons.upload, size: 14),
                  label: const Text('Subir Nuevo Icono de App'),
                  style: ElevatedButton.styleFrom(
                    backgroundColor: PlataformaEditableStyles.darkGreen,
                    foregroundColor: Colors.white,
                    shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8)),
                  ),
                ),
              ],
            ),
          ),

          const SizedBox(height: 24),
          // Carrusel
          const Text('Carrusel de Imágenes para Tablets', style: PlataformaEditableStyles.configLabel),
          const SizedBox(height: 8),
          _buildHelpText('Gestiona las imágenes que se mostrarán en dispositivos tablet. Puedes agregar nuevas imágenes, eliminar existentes, cambiarlas o reordenarlas. Se recomienda usar imágenes de alta calidad con una relación de aspecto de 16:9 o similar.'),
          Column(
            children: _imagenesCarrusel.asMap().entries.map((entry) {
              final idx = entry.key;
              final img = entry.value;
              return Container(
                margin: const EdgeInsets.only(bottom: 16),
                padding: const EdgeInsets.all(16),
                decoration: BoxDecoration(
                  border: Border.all(color: PlataformaEditableStyles.borderGrey),
                  borderRadius: BorderRadius.circular(8),
                  color: PlataformaEditableStyles.bgInput,
                ),
                child: Row(
                  children: [
                    Container(
                      width: 200, height: 120,
                      decoration: BoxDecoration(border: Border.all(color: const Color(0xFFE0EBE5)), borderRadius: BorderRadius.circular(6)),
                      child: Stack(
                        children: [
                          Positioned.fill(
                            child: ClipRRect(
                              borderRadius: BorderRadius.circular(5),
                              child: Container(
                                color: const Color(0xFFD7E4DC),
                                child: Center(
                                  child: FaIcon(FontAwesomeIcons.image, size: 32, color: PlataformaEditableStyles.borderInput),
                                ),
                              ),
                            ),
                          ),
                          Positioned(
                            top: 8, left: 8,
                            child: Container(
                              width: 28, height: 28,
                              decoration: const BoxDecoration(color: Color.fromRGBO(7, 61, 43, 0.85), shape: BoxShape.circle),
                              child: Center(child: Text('${idx + 1}', style: const TextStyle(color: Colors.white, fontWeight: FontWeight.bold))),
                            ),
                          ),
                        ],
                      ),
                    ),
                    const SizedBox(width: 16),
                    Expanded(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(img.nombre, style: const TextStyle(fontWeight: FontWeight.bold, color: PlataformaEditableStyles.darkGreen, fontSize: 14)),
                          const SizedBox(height: 12),
                          Wrap(
                            spacing: 8,
                            runSpacing: 8,
                            children: [
                              _buildCarruselBtn(FontAwesomeIcons.arrowUp, () {}),
                              _buildCarruselBtn(FontAwesomeIcons.arrowDown, () {}),
                              _buildCarruselBtn(FontAwesomeIcons.repeat, () {}),
                              _buildCarruselBtn(FontAwesomeIcons.trash, () {}),
                            ],
                          )
                        ],
                      ),
                    )
                  ],
                ),
              );
            }).toList(),
          ),
          Container(
            width: double.infinity,
            padding: const EdgeInsets.all(20),
            decoration: BoxDecoration(border: Border.all(color: PlataformaEditableStyles.borderInput, width: 2), borderRadius: BorderRadius.circular(8), color: PlataformaEditableStyles.bgHelp),
            child: Column(
              children: [
                ElevatedButton.icon(
                  onPressed: () {},
                  icon: const FaIcon(FontAwesomeIcons.plus, size: 14),
                  label: const Text('Agregar Nuevas Imágenes'),
                  style: ElevatedButton.styleFrom(backgroundColor: PlataformaEditableStyles.primaryGreen, foregroundColor: Colors.white, shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8))),
                ),
                const SizedBox(height: 8),
                const Text('Puedes seleccionar múltiples imágenes a la vez', style: TextStyle(color: Color(0xFF6B8177), fontSize: 12, fontWeight: FontWeight.w600)),
              ],
            ),
          ),

          const SizedBox(height: 24),
          // Nombre Plataforma
          const Row(
            children: [
              FaIcon(FontAwesomeIcons.penToSquare, size: 16, color: PlataformaEditableStyles.primaryGreen),
              SizedBox(width: 8),
              Text('Nombre de la Aplicación', style: PlataformaEditableStyles.configLabel),
            ],
          ),
          const SizedBox(height: 8),
          _buildHelpText('Este nombre aparecerá en el botón de inicio de arranque del dispositivo y como título de la aplicación.'),
          Container(
            height: 44,
            decoration: PlataformaEditableStyles.inputDecoration(),
            child: Row(
              children: [
                const SizedBox(width: 12),
                const FaIcon(FontAwesomeIcons.signature, color: PlataformaEditableStyles.primaryGreen, size: 16),
                const SizedBox(width: 12),
                Expanded(
                  child: TextField(
                    controller: _nombreCtrl,
                    decoration: const InputDecoration(border: InputBorder.none, hintText: 'Ej: AgroVision AI'),
                    maxLength: 50,
                    buildCounter: (context, {required currentLength, required isFocused, maxLength}) => null,
                    style: const TextStyle(fontSize: 14, color: PlataformaEditableStyles.darkGreen),
                  ),
                ),
              ],
            ),
          ),
          const SizedBox(height: 6),
          Align(
            alignment: Alignment.centerRight,
            child: Text('${_nombreCtrl.text.length} / 50 caracteres', style: PlataformaEditableStyles.helpTextSmall),
          ),
        ],
      ),
    );
  }

  Widget _buildCarruselBtn(dynamic icon, VoidCallback onTap) {
    return InkWell(
      onTap: onTap,
      child: Container(
        width: 36, height: 36,
        decoration: BoxDecoration(border: Border.all(color: PlataformaEditableStyles.borderGrey), borderRadius: BorderRadius.circular(6), color: Colors.white),
        child: Center(child: FaIcon(icon, size: 14, color: const Color(0xFF456657))),
      ),
    );
  }

  Widget _buildNavbar() {
    return Container(
      padding: const EdgeInsets.all(28),
      decoration: PlataformaEditableStyles.sectionDecoration,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          _buildSectionHeader(FontAwesomeIcons.bars, 'Barra de Navegación', 'Configura el fondo, efectos y apariencia del navbar'),
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const Text('Tipo de Fondo', style: PlataformaEditableStyles.configLabel),
              const SizedBox(height: 12),
              Row(
                children: [
                  _buildRadio('solido', 'Sólido', _config.navbar.tipoFondo, (v) => setState(() => _config.navbar.tipoFondo = v)),
                  const SizedBox(width: 12),
                  _buildRadio('gradiente', 'Gradiente', _config.navbar.tipoFondo, (v) => setState(() => _config.navbar.tipoFondo = v)),
                ],
              ),
            ],
          ),
          const SizedBox(height: 20),
          if (_config.navbar.tipoFondo == 'solido') ...[
            Row(
              children: [
                _buildColorRow('Color del Fondo', '', _navColorBaseCtrl, (v) => _config.navbar.colorBase = v),
                const Expanded(child: SizedBox()),
              ],
            ),
          ] else ...[
            Row(
              children: [
                _buildColorRow('Color Inicial del Gradiente', '', _navColorBaseCtrl, (v) => _config.navbar.colorBase = v),
                const SizedBox(width: 20),
                _buildColorRow('Color Final del Gradiente', '', _navColorResplandorCtrl, (v) => _config.navbar.colorResplandor = v),
              ],
            ),
          ],

        ],
      ),
    );
  }

  Widget _buildRadio(String value, String text, String groupValue, Function(String) onChanged) {
    bool selected = value == groupValue;
    return GestureDetector(
      onTap: () => onChanged(value),
      child: Container(
        padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 10),
        decoration: BoxDecoration(
          color: selected ? PlataformaEditableStyles.bgHelp : PlataformaEditableStyles.bgInput,
          border: Border.all(color: selected ? PlataformaEditableStyles.primaryGreen : PlataformaEditableStyles.borderInput, width: 2),
          borderRadius: BorderRadius.circular(8),
        ),
        child: Row(
          children: [
            Container(
              width: 18, height: 18,
              decoration: BoxDecoration(shape: BoxShape.circle, border: Border.all(color: selected ? PlataformaEditableStyles.primaryGreen : Colors.grey, width: 2)),
              child: selected ? Center(child: Container(width: 10, height: 10, decoration: const BoxDecoration(shape: BoxShape.circle, color: PlataformaEditableStyles.primaryGreen))) : null,
            ),
            const SizedBox(width: 8),
            Text(text, style: TextStyle(color: selected ? PlataformaEditableStyles.primaryGreen : PlataformaEditableStyles.darkGreen, fontWeight: selected ? FontWeight.bold : FontWeight.normal)),
          ],
        ),
      ),
    );
  }

  Widget _buildColores() {
    return Container(
      padding: const EdgeInsets.all(28),
      decoration: PlataformaEditableStyles.sectionDecoration,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          _buildSectionHeader(FontAwesomeIcons.palette, 'Colores de Texto', 'Define los colores para títulos, enlaces y textos descriptivos'),
          Row(
            children: [
              _buildColorRow('Color de Títulos', 'Aplica a títulos de navbar, dashboard...', _coloresTitulosCtrl, (v) => _config.colores.titulos = v),
              const SizedBox(width: 20),
              _buildColorRow('Enlaces Normales', 'Color de los enlaces en estado normal', _coloresLinksNormalesCtrl, (v) => _config.colores.linksNormales = v),
            ],
          ),
          const SizedBox(height: 20),
          Row(
            children: [
              _buildColorRow('Enlaces Hover/Activo', 'Color cuando el mouse pasa sobre el enlace', _coloresLinksActivosCtrl, (v) => _config.colores.linksActivos = v),
              const SizedBox(width: 20),
              _buildColorRow('Textos Descriptivos', 'Textos secundarios, descripciones', _coloresTextosCtrl, (v) => _config.colores.textosDescriptivos = v),
            ],
          ),
        ],
      ),
    );
  }

  Widget _buildBotones() {
    return Container(
      padding: const EdgeInsets.all(28),
      decoration: PlataformaEditableStyles.sectionDecoration,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          _buildSectionHeader(FontAwesomeIcons.square, 'Colores de Botones', 'Configura el estilo de todos los botones principales de la plataforma'),
          Row(
            children: [
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const Text('Tipo de Fondo', style: PlataformaEditableStyles.configLabel),
                    const SizedBox(height: 8),
                    Row(
                      children: [
                        _buildRadio('solido', 'Sólido', _config.botones.tipo, (v) => setState(() => _config.botones.tipo = v)),
                        const SizedBox(width: 12),
                        _buildRadio('gradiente', 'Gradiente', _config.botones.tipo, (v) => setState(() => _config.botones.tipo = v)),
                      ],
                    ),
                  ],
                ),
              ),
            ],
          ),
          const SizedBox(height: 20),
          if (_config.botones.tipo == 'solido') ...[
            Row(
              children: [
                _buildColorRow('Color del Botón', '', _botonesColorInicialCtrl, (v) => _config.botones.colorInicial = v),
                const SizedBox(width: 20),
                _buildColorRow('Color del Texto', '', _botonesColorTextoCtrl, (v) => _config.botones.colorTexto = v),
              ],
            ),
          ] else ...[
            Row(
              children: [
                _buildColorRow('Color Inicial del Gradiente', '', _botonesColorInicialCtrl, (v) => _config.botones.colorInicial = v),
                const SizedBox(width: 20),
                _buildColorRow('Color Final del Gradiente', '', _botonesColorFinalCtrl, (v) => _config.botones.colorFinal = v),
              ],
            ),
            const SizedBox(height: 20),
            Row(
              children: [
                _buildColorRow('Color del Texto', '', _botonesColorTextoCtrl, (v) => _config.botones.colorTexto = v),
                const Expanded(child: SizedBox()),
              ],
            ),
          ],
          const SizedBox(height: 20),
          Row(
            children: [
              _buildColorRow('Color Botones Destructivos', 'Color de botones como "Eliminar"', _botonesDestructivoColorCtrl, (v) => _config.botones.destructivoColor = v),
              const SizedBox(width: 20),
              _buildColorRow('Hover Botones Destructivos', 'Color al pasar el cursor sobre botones destructivos', _botonesDestructivoHoverCtrl, (v) => _config.botones.destructivoHover = v),
            ],
          ),
          const SizedBox(height: 24),
          const Text('Vista Previa', style: PlataformaEditableStyles.configLabel),
          const SizedBox(height: 12),
          Wrap(
            spacing: 16,
            runSpacing: 16,
            children: [
              Container(
                padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 12),
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(8),
                  color: _config.botones.tipo == 'solido' ? _colorFromHex(_config.botones.colorInicial) : null,
                  gradient: _config.botones.tipo == 'gradiente' ? LinearGradient(colors: [_colorFromHex(_config.botones.colorInicial), _colorFromHex(_config.botones.colorFinal)]) : null,
                ),
                child: Row(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    FaIcon(FontAwesomeIcons.floppyDisk, color: _colorFromHex(_config.botones.colorTexto), size: 16),
                    const SizedBox(width: 8),
                    Text('Botón Principal', style: TextStyle(color: _colorFromHex(_config.botones.colorTexto), fontWeight: FontWeight.bold)),
                  ],
                ),
              ),
              Container(
                padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 12),
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(8),
                  color: _colorFromHex(_config.botones.destructivoColor),
                  boxShadow: [BoxShadow(color: _colorFromHex(_config.botones.destructivoColor).withOpacity(0.24), blurRadius: 16, offset: const Offset(0, 8))],
                ),
                child: const Row(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    FaIcon(FontAwesomeIcons.trash, color: Colors.white, size: 16),
                    SizedBox(width: 8),
                    Text('Botón Destructivo', style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold)),
                  ],
                ),
              ),
            ],
          )
        ],
      ),
    );
  }

  Widget _buildIconos() {
    return Container(
      padding: const EdgeInsets.all(28),
      decoration: PlataformaEditableStyles.sectionDecoration,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          _buildSectionHeader(FontAwesomeIcons.icons, 'Color de Iconos', 'Define el color para todos los iconos de Font Awesome en la plataforma'),
          Row(
            children: [
              _buildColorRow('Color de Iconos', 'Se aplicará a todos los iconos de Font Awesome', _iconosCtrl, (v) => _config.colores.iconos = v),
              const SizedBox(width: 20),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const Text('Vista Previa', style: PlataformaEditableStyles.configLabel),
                    const SizedBox(height: 8),
                    Container(
                      padding: const EdgeInsets.all(16),
                      decoration: BoxDecoration(border: Border.all(color: PlataformaEditableStyles.borderGrey), borderRadius: BorderRadius.circular(8), color: PlataformaEditableStyles.bgInput),
                      child: Wrap(
                        spacing: 16,
                        runSpacing: 16,
                        alignment: WrapAlignment.spaceEvenly,
                        children: [
                          FaIcon(FontAwesomeIcons.house, color: _colorFromHex(_config.colores.iconos), size: 28),
                          FaIcon(FontAwesomeIcons.user, color: _colorFromHex(_config.colores.iconos), size: 28),
                          FaIcon(FontAwesomeIcons.gear, color: _colorFromHex(_config.colores.iconos), size: 28),
                          FaIcon(FontAwesomeIcons.bell, color: _colorFromHex(_config.colores.iconos), size: 28),
                          FaIcon(FontAwesomeIcons.heart, color: _colorFromHex(_config.colores.iconos), size: 28),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }

  Widget _buildFondoModales() {
    return Container(
      padding: const EdgeInsets.all(28),
      decoration: PlataformaEditableStyles.sectionDecoration,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          _buildSectionHeader(FontAwesomeIcons.windowRestore, 'Fondo de Modales', 'Personaliza el color y opacidad del fondo oscuro que aparece detrás de los modales'),
          Row(
            children: [
              _buildColorRow('Color del Fondo Oscuro', 'Color base del fondo', _modalesColorBackdropCtrl, (v) => _config.modales.colorBackdrop = v),
              const SizedBox(width: 20),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text('Opacidad del Fondo: ${_config.modales.opacidadBackdrop}%', style: PlataformaEditableStyles.configLabel),
                    const SizedBox(height: 2),
                    const Text('Controla qué tan oscuro aparece el fondo detrás de los modales', style: PlataformaEditableStyles.helpTextSmall),
                    Slider(
                      value: _config.modales.opacidadBackdrop.toDouble(),
                      min: 0, max: 100,
                      activeColor: PlataformaEditableStyles.primaryGreen,
                      onChanged: (v) => setState(() => _config.modales.opacidadBackdrop = v.toInt()),
                    ),
                  ],
                ),
              ),
            ],
          ),
          const SizedBox(height: 24),
          const Text('Vista Previa del Fondo', style: PlataformaEditableStyles.configLabel),
          const SizedBox(height: 12),
          Container(
            padding: const EdgeInsets.all(16),
            decoration: BoxDecoration(border: Border.all(color: PlataformaEditableStyles.borderGrey), borderRadius: BorderRadius.circular(8), color: PlataformaEditableStyles.bgInput),
            child: Container(
              height: 200,
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(8),
                color: _colorFromHex(_config.modales.colorBackdrop).withOpacity(_config.modales.opacidadBackdrop / 100),
              ),
              child: Center(
                child: Container(
                  padding: const EdgeInsets.symmetric(horizontal: 40, vertical: 32),
                  decoration: BoxDecoration(color: Colors.white, borderRadius: BorderRadius.circular(12), border: Border.all(color: PlataformaEditableStyles.borderGrey), boxShadow: const [BoxShadow(color: Colors.black38, blurRadius: 60, offset: Offset(0, 20))]),
                  child: const Column(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      FaIcon(FontAwesomeIcons.circleInfo, color: PlataformaEditableStyles.primaryGreen, size: 36),
                      SizedBox(height: 12),
                      Text('Ejemplo de modal', style: TextStyle(color: PlataformaEditableStyles.darkGreen, fontWeight: FontWeight.bold, fontSize: 16)),
                    ],
                  ),
                ),
              ),
            ),
          )
        ],
      ),
    );
  }

  Widget _buildModalesAccion() {
    return Container(
      padding: const EdgeInsets.all(28),
      decoration: PlataformaEditableStyles.sectionDecoration,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          _buildSectionHeader(FontAwesomeIcons.squareCheck, 'Modales de Éxito', 'Personaliza los colores de los íconos de confirmación en los modales de éxito'),
          Row(
            children: [
              _buildColorRow('Color Ícono Éxito', 'Color del ícono de check', _modalesIconoExitoColorCtrl, (v) => _config.modales.iconoExitoColor = v),
              const SizedBox(width: 20),
              _buildColorRow('Color Fondo Ícono Éxito', 'Color del fondo circular', _modalesIconoExitoFondoCtrl, (v) => _config.modales.iconoExitoFondo = v),
            ],
          ),
        ],
      ),
    );
  }



  Widget _buildActionButtons() {
    return Container(
      padding: const EdgeInsets.symmetric(vertical: 20, horizontal: 20),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(8),
        border: const Border(top: BorderSide(color: Color(0xFFE0EBE5), width: 2)),
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          GestureDetector(
            onTap: () => setState(() => _mostrarModalResetConfirmar = true),
            child: Container(
              padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
              decoration: PlataformaEditableStyles.cancelBtn,
              child: const Row(
                children: [
                  FaIcon(FontAwesomeIcons.rotateLeft, color: PlataformaEditableStyles.danger, size: 14),
                  SizedBox(width: 8),
                  Text('Resetear Todo', style: TextStyle(color: PlataformaEditableStyles.danger, fontWeight: FontWeight.bold)),
                ],
              ),
            ),
          ),
          GestureDetector(
            onTap: _guardarCambios,
            child: Container(
              padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 12),
              decoration: PlataformaEditableStyles.primaryBtn,
              child: const Row(
                children: [
                  FaIcon(FontAwesomeIcons.floppyDisk, color: Colors.white, size: 14),
                  SizedBox(width: 8),
                  Text('Guardar Cambios', style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold)),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildOverlay() {
    if (!_mostrarModalResetConfirmar && !_mostrarModalResetExito && !_mostrarModalGuardadoExito && !_mostrarModalErrores) {
      return const SizedBox.shrink();
    }
    
    Widget content = const SizedBox.shrink();

    if (_mostrarModalResetConfirmar) {
      content = Container(
        padding: const EdgeInsets.all(28),
        width: 400,
        decoration: BoxDecoration(color: Colors.white, borderRadius: BorderRadius.circular(12)),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Text('¿Resetear configuración?', style: PlataformaEditableStyles.sectionTitle),
            const SizedBox(height: 10),
            const Text('Se restablecerán todos los colores, estilos de botones y fondos de la plataforma a sus valores por defecto. Esta acción no se puede deshacer.', style: PlataformaEditableStyles.sectionDesc),
            const SizedBox(height: 20),
            Row(
              mainAxisAlignment: MainAxisAlignment.end,
              children: [
                GestureDetector(
                  onTap: () => setState(() => _mostrarModalResetConfirmar = false),
                  child: Container(
                    padding: const EdgeInsets.symmetric(horizontal: 18, vertical: 10),
                    decoration: BoxDecoration(borderRadius: BorderRadius.circular(8), border: Border.all(color: PlataformaEditableStyles.borderGrey), color: PlataformaEditableStyles.bgInput),
                    child: const Text('Cancelar', style: TextStyle(color: PlataformaEditableStyles.darkGreen, fontWeight: FontWeight.w800)),
                  ),
                ),
                const SizedBox(width: 10),
                GestureDetector(
                  onTap: _confirmarResetear,
                  child: Container(
                    padding: const EdgeInsets.symmetric(horizontal: 18, vertical: 10),
                    decoration: BoxDecoration(borderRadius: BorderRadius.circular(8), color: PlataformaEditableStyles.darkGreen),
                    child: const Text('Sí, resetear', style: TextStyle(color: Colors.white, fontWeight: FontWeight.w800)),
                  ),
                ),
              ],
            )
          ],
        ),
      );
    } else if (_mostrarModalGuardadoExito) {
      content = _buildSuccessModal('Cambios guardados correctamente', 'La nueva configuración visual ha sido aplicada con éxito a toda la plataforma.', () => setState(() => _mostrarModalGuardadoExito = false));
    } else if (_mostrarModalResetExito) {
      content = _buildSuccessModal('Configuración restaurada', 'Todos los cambios han sido reseteados al valor predeterminado correctamente.', () => setState(() => _mostrarModalResetExito = false));
    } else if (_mostrarModalErrores) {
      content = Container(
        padding: const EdgeInsets.all(28),
        width: 400,
        decoration: BoxDecoration(color: Colors.white, borderRadius: BorderRadius.circular(12)),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Text('Error de validación', style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold, color: PlataformaEditableStyles.danger)),
            const SizedBox(height: 10),
            const Text('No se pueden guardar los cambios. Por favor corrija los siguientes errores:', style: PlataformaEditableStyles.sectionDesc),
            const SizedBox(height: 10),
            ..._erroresValidacion.map((e) => Row(crossAxisAlignment: CrossAxisAlignment.start, children: [const Text('• ', style: TextStyle(color: PlataformaEditableStyles.danger, fontSize: 13)), Expanded(child: Text(e, style: const TextStyle(color: PlataformaEditableStyles.danger, fontSize: 13)))])),
            const SizedBox(height: 20),
            SizedBox(
              width: double.infinity,
              child: GestureDetector(
                onTap: () => setState(() => _mostrarModalErrores = false),
                child: Container(
                  padding: const EdgeInsets.symmetric(vertical: 12),
                  decoration: BoxDecoration(borderRadius: BorderRadius.circular(8), border: Border.all(color: PlataformaEditableStyles.borderGrey), color: PlataformaEditableStyles.bgInput),
                  alignment: Alignment.center,
                  child: const Text('Cerrar', style: TextStyle(color: PlataformaEditableStyles.danger, fontWeight: FontWeight.w800)),
                ),
              ),
            ),
          ],
        ),
      );
    }

    return Positioned.fill(
      child: GestureDetector(
        onTap: () {},
        child: Container(
          color: const Color.fromRGBO(7, 61, 43, 0.45),
          child: Center(
            child: content,
          ),
        ),
      ),
    );
  }

  Widget _buildSuccessModal(String title, String desc, VoidCallback onOk) {
    return Container(
      padding: const EdgeInsets.all(32),
      width: 400,
      decoration: BoxDecoration(color: Colors.white, borderRadius: BorderRadius.circular(12)),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          Container(
            width: 64, height: 64,
            decoration: const BoxDecoration(color: Color(0xFFEAF7E5), shape: BoxShape.circle),
            child: const Center(child: FaIcon(FontAwesomeIcons.circleCheck, color: PlataformaEditableStyles.primaryGreen, size: 36)),
          ),
          const SizedBox(height: 16),
          Text(title, style: const TextStyle(fontSize: 20, fontWeight: FontWeight.bold, color: PlataformaEditableStyles.darkGreen), textAlign: TextAlign.center),
          const SizedBox(height: 10),
          Text(desc, style: PlataformaEditableStyles.sectionDesc, textAlign: TextAlign.center),
          const SizedBox(height: 24),
          SizedBox(
            width: double.infinity,
            child: GestureDetector(
              onTap: onOk,
              child: Container(
                padding: const EdgeInsets.symmetric(vertical: 14),
                decoration: PlataformaEditableStyles.primaryBtn,
                alignment: Alignment.center,
                child: const Text('Aceptar', style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold, fontSize: 15)),
              ),
            ),
          ),
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    final screenWidth = MediaQuery.of(context).size.width;
    final isDesktop = screenWidth > 991;

    return Scaffold(
      backgroundColor: PlataformaEditableStyles.bgPage,
      body: Stack(
        children: [
          Column(
            children: [
              const BarraAdmin(),
              Expanded(
                child: SingleChildScrollView(
                  padding: EdgeInsets.symmetric(
                    horizontal: isDesktop ? 60 : 20,
                    vertical: 32,
                  ),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      // Header
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Row(
                            children: [
                              Container(
                                padding: const EdgeInsets.all(12),
                                decoration: BoxDecoration(
                                  color: PlataformaEditableStyles.bgHelp,
                                  borderRadius: BorderRadius.circular(10),
                                  border: Border.all(
                                    color: PlataformaEditableStyles.primaryGreen.withOpacity(0.2),
                                  ),
                                ),
                                child: const FaIcon(
                                  FontAwesomeIcons.paintbrush,
                                  size: 24,
                                  color: PlataformaEditableStyles.primaryGreen,
                                ),
                              ),
                              const SizedBox(width: 16),
                              Expanded(
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Text(
                                      'Editar Configuración Visual',
                                      style: PlataformaEditableStyles.h1.copyWith(fontSize: 28),
                                    ),
                                    const SizedBox(height: 4),
                                    const Text(
                                      'Personaliza colores, fondos, estilos de botones y otros elementos visuales de la plataforma',
                                      style: PlataformaEditableStyles.pageDesc,
                                    ),
                                  ],
                                ),
                              ),
                            ],
                          ),
                          const SizedBox(height: 24),
                          Container(
                            padding: const EdgeInsets.all(16),
                            decoration: BoxDecoration(
                              color: const Color(0xFFE8F5E9),
                              borderRadius: BorderRadius.circular(8),
                              border: Border.all(
                                color: PlataformaEditableStyles.primaryGreen.withOpacity(0.3),
                              ),
                            ),
                            child: const Row(
                              children: [
                                FaIcon(
                                  FontAwesomeIcons.lightbulb,
                                  size: 18,
                                  color: PlataformaEditableStyles.primaryGreen,
                                ),
                                SizedBox(width: 12),
                                Expanded(
                                  child: Text(
                                    'Los cambios realizados aquí afectarán la apariencia de toda la plataforma. Puedes ver una vista previa de algunos elementos antes de guardar.',
                                    style: TextStyle(
                                      fontSize: 13,
                                      color: PlataformaEditableStyles.darkGreen,
                                      fontWeight: FontWeight.w600,
                                      height: 1.4,
                                    ),
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ],
                      ),
                      const SizedBox(height: 32),
                      
                      // Secciones
                      _buildIdentidadVisual(),
                      const SizedBox(height: 24),
                      _buildNavbar(),
                      const SizedBox(height: 24),
                      _buildColores(),
                      const SizedBox(height: 24),
                      _buildBotones(),
                      const SizedBox(height: 24),
                      _buildIconos(),
                      const SizedBox(height: 24),
                      _buildFondoModales(),
                      const SizedBox(height: 24),
                      _buildModalesAccion(),
                      const SizedBox(height: 32),
                      
                      // Action buttons
                      _buildActionButtons(),
                    ],
                  ),
                ),
              ),
            ],
          ),
          _buildOverlay(),
        ],
      ),
    );
  }
}
