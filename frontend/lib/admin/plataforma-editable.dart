import 'package:flutter/material.dart';
import '../navbars/barra-admin.dart';
import '../styles/admin-styles/plataforma-editable.dart';
import '../environments/tema-config.dart';
import '../shared/services/tema.service.dart';

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

  // Logo y Favicon
  // String? _logoPreview;
  // String? _faviconPreview;

  // Carrusel
  // List<ImagenCarrusel> _imagenesCarrusel = [ ... ];
  // int _siguienteIdCarrusel = 4;

  @override
  void initState() {
    super.initState();
    _config = TemaService.instance.config;
    _nombreCtrl = TextEditingController(text: _config.nombrePlataforma);
  }

  @override
  void dispose() {
    _nombreCtrl.dispose();
    super.dispose();
  }

  void _guardarCambios() {
    setState(() {
      _erroresValidacion.clear();
      if (_nombreCtrl.text.trim().length < 3) {
        _erroresValidacion.add('El nombre de la plataforma debe tener al menos 3 caracteres.');
      }
      if (_erroresValidacion.isNotEmpty) {
        _mostrarModalErrores = true;
      } else {
        _config.nombrePlataforma = _nombreCtrl.text.trim();
        TemaService.instance.guardar(_config);
        _mostrarModalGuardadoExito = true;
      }
    });
  }

  void _confirmarResetear() {
    TemaService.instance.resetear();
    setState(() {
      _config = TemaService.instance.config;
      _nombreCtrl.text = _config.nombrePlataforma;
      _mostrarModalResetConfirmar = false;
      _mostrarModalResetExito = true;
    });
  }

  // UI Builders
  Widget _buildSectionHeader(IconData icon, String title, String description) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          children: [
            Icon(icon, size: 24, color: PlataformaEditableStyles.primaryGreen),
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
      child: Text(text, style: PlataformaEditableStyles.helpText),
    );
  }

  Widget _buildIdentidadVisual() {
    return Container(
      padding: const EdgeInsets.all(28),
      decoration: PlataformaEditableStyles.sectionDecoration,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          _buildSectionHeader(Icons.image, 'Identidad Visual', 'Personaliza el logo, icono y nombre que representan tu plataforma'),
          
          // Nombre de la Plataforma
          const Row(
            children: [
              Icon(Icons.edit, size: 16, color: PlataformaEditableStyles.primaryGreen),
              SizedBox(width: 8),
              Text('Nombre de la Plataforma', style: PlataformaEditableStyles.configLabel),
            ],
          ),
          const SizedBox(height: 8),
          _buildHelpText('Este nombre aparecerá en el componente de inicio.'),
          Container(
            height: 44,
            decoration: PlataformaEditableStyles.inputDecoration(),
            child: Row(
              children: [
                const SizedBox(width: 12),
                const Icon(Icons.drive_file_rename_outline, color: PlataformaEditableStyles.primaryGreen, size: 20),
                const SizedBox(width: 12),
                Expanded(
                  child: TextField(
                    controller: _nombreCtrl,
                    decoration: const InputDecoration(
                      border: InputBorder.none,
                      hintText: 'Ej: AgroVision AI',
                    ),
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
          
          // (Mock para Logo y Favicon ya que en móvil o web usaríamos image_picker)
          const SizedBox(height: 24),
          const Text('Logo Principal y Favicon se configuran aquí en la versión web.', style: PlataformaEditableStyles.helpText),
        ],
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
          _buildSectionHeader(Icons.menu, 'Barra de Navegación', 'Configura el fondo, efectos y apariencia del navbar'),
          
          const Text('Tipo de Fondo', style: PlataformaEditableStyles.configLabel),
          const SizedBox(height: 8),
          RadioGroup<String>(
            groupValue: _config.navbar.tipoFondo,
            onChanged: (v) => setState(() => _config.navbar.tipoFondo = v!),
            child: Row(
              children: [
                Radio<String>(
                  value: 'solido',
                  activeColor: PlataformaEditableStyles.primaryGreen,
                ),
                const Text('Sólido'),
                const SizedBox(width: 20),
                Radio<String>(
                  value: 'gradiente',
                  activeColor: PlataformaEditableStyles.primaryGreen,
                ),
                const Text('Gradiente con resplandor'),
              ],
            ),
          ),
          
          const SizedBox(height: 16),
          const Text('Color Base del Fondo', style: PlataformaEditableStyles.configLabel),
          const SizedBox(height: 8),
          Row(
            children: [
              Container(
                width: 60, height: 44,
                decoration: BoxDecoration(
                  color: _colorFromHex(_config.navbar.colorBase),
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
                    controller: TextEditingController(text: _config.navbar.colorBase),
                    onChanged: (v) => _config.navbar.colorBase = v,
                    decoration: const InputDecoration(border: InputBorder.none, contentPadding: EdgeInsets.symmetric(horizontal: 12)),
                    style: const TextStyle(fontSize: 14, fontFamily: 'Courier New', fontWeight: FontWeight.bold),
                  ),
                ),
              ),
            ],
          ),
        ],
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
          _buildSectionHeader(Icons.palette, 'Colores de Texto', 'Define los colores para títulos, enlaces y textos descriptivos'),
          _buildColorRow('Color de Títulos', 'Aplica a títulos de navbar, dashboard...', _config.colores.titulos, (v) => _config.colores.titulos = v),
          const SizedBox(height: 16),
          _buildColorRow('Enlaces Normales', 'Color de los enlaces en estado normal', _config.colores.linksNormales, (v) => _config.colores.linksNormales = v),
          const SizedBox(height: 16),
          _buildColorRow('Enlaces Hover/Activo', 'Color cuando el mouse pasa sobre el enlace', _config.colores.linksActivos, (v) => _config.colores.linksActivos = v),
          const SizedBox(height: 16),
          _buildColorRow('Textos Descriptivos', 'Textos secundarios, descripciones', _config.colores.textosDescriptivos, (v) => _config.colores.textosDescriptivos = v),
        ],
      ),
    );
  }

  Widget _buildColorRow(String title, String desc, String value, Function(String) onChanged) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(title, style: PlataformaEditableStyles.configLabel),
        Text(desc, style: PlataformaEditableStyles.helpTextSmall),
        const SizedBox(height: 8),
        Row(
          children: [
            Container(
              width: 60, height: 44,
              decoration: BoxDecoration(
                color: _colorFromHex(value),
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
                  controller: TextEditingController(text: value),
                  onChanged: onChanged,
                  decoration: const InputDecoration(border: InputBorder.none, contentPadding: EdgeInsets.symmetric(horizontal: 12)),
                  style: const TextStyle(fontSize: 14, fontFamily: 'Courier New', fontWeight: FontWeight.bold),
                ),
              ),
            ),
          ],
        ),
      ],
    );
  }

  Color _colorFromHex(String hexColor) {
    hexColor = hexColor.replaceAll('#', '');
    if (hexColor.length == 6) {
      hexColor = 'FF$hexColor';
    }
    return Color(int.tryParse('0x$hexColor') ?? 0xFF073D2B);
  }

  Widget _buildActionButtons() {
    return Container(
      padding: const EdgeInsets.symmetric(vertical: 20),
      decoration: const BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.all(Radius.circular(8)),
        border: Border(top: BorderSide(color: PlataformaEditableStyles.borderGrey, width: 2)),
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
                  Icon(Icons.refresh, color: PlataformaEditableStyles.danger, size: 16),
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
                  Icon(Icons.save, color: Colors.white, size: 16),
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
            const Text('Se restablecerán todos los colores. Esta acción no se puede deshacer.', style: PlataformaEditableStyles.sectionDesc),
            const SizedBox(height: 20),
            Row(
              mainAxisAlignment: MainAxisAlignment.end,
              children: [
                TextButton(onPressed: () => setState(() => _mostrarModalResetConfirmar = false), child: const Text('Cancelar', style: TextStyle(color: PlataformaEditableStyles.darkGreen))),
                ElevatedButton(
                  onPressed: _confirmarResetear,
                  style: ElevatedButton.styleFrom(backgroundColor: PlataformaEditableStyles.darkGreen),
                  child: const Text('Sí, resetear', style: TextStyle(color: Colors.white)),
                ),
              ],
            )
          ],
        ),
      );
    } else if (_mostrarModalGuardadoExito) {
      content = _buildSuccessModal('Cambios guardados correctamente', 'La nueva configuración ha sido aplicada.', () => setState(() => _mostrarModalGuardadoExito = false));
    } else if (_mostrarModalResetExito) {
      content = _buildSuccessModal('Configuración restaurada', 'Todos los cambios han sido reseteados al valor predeterminado.', () => setState(() => _mostrarModalResetExito = false));
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
            const Text('Por favor corrija los siguientes errores:', style: PlataformaEditableStyles.sectionDesc),
            const SizedBox(height: 10),
            ..._erroresValidacion.map((e) => Text('• $e', style: const TextStyle(color: PlataformaEditableStyles.danger, fontSize: 13))),
            const SizedBox(height: 20),
            SizedBox(
              width: double.infinity,
              child: OutlinedButton(
                onPressed: () => setState(() => _mostrarModalErrores = false),
                style: OutlinedButton.styleFrom(side: const BorderSide(color: PlataformaEditableStyles.borderGrey)),
                child: const Text('Cerrar', style: TextStyle(color: PlataformaEditableStyles.danger)),
              ),
            ),
          ],
        ),
      );
    }

    return Positioned.fill(
      child: GestureDetector(
        onTap: () {}, // consume tap
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
            child: const Icon(Icons.check_circle, color: PlataformaEditableStyles.primaryGreen, size: 36),
          ),
          const SizedBox(height: 16),
          Text(title, style: const TextStyle(fontSize: 20, fontWeight: FontWeight.bold, color: PlataformaEditableStyles.darkGreen), textAlign: TextAlign.center),
          const SizedBox(height: 10),
          Text(desc, style: PlataformaEditableStyles.sectionDesc, textAlign: TextAlign.center),
          const SizedBox(height: 24),
          SizedBox(
            width: double.infinity,
            child: ElevatedButton(
              onPressed: onOk,
              style: ElevatedButton.styleFrom(backgroundColor: PlataformaEditableStyles.primaryGreen, padding: const EdgeInsets.symmetric(vertical: 14)),
              child: const Text('Aceptar', style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold, fontSize: 15)),
            ),
          ),
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: PlataformaEditableStyles.bgPage,
      body: Stack(
        children: [
          Column(
            children: [
              const BarraAdmin(),
              Expanded(
                child: SingleChildScrollView(
                  padding: const EdgeInsets.all(32),
                  child: Center(
                    child: ConstrainedBox(
                      constraints: const BoxConstraints(maxWidth: 1220),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          const Text('Configuración', style: PlataformaEditableStyles.eyebrow),
                          const SizedBox(height: 8),
                          const Text('Editar Plataforma', style: PlataformaEditableStyles.h1),
                          const SizedBox(height: 10),
                          const Text('Personaliza la identidad visual y los colores de toda la plataforma', style: PlataformaEditableStyles.pageDesc),
                          const SizedBox(height: 24),
                          _buildIdentidadVisual(),
                          const SizedBox(height: 24),
                          _buildNavbar(),
                          const SizedBox(height: 24),
                          _buildColores(),
                          const SizedBox(height: 24),
                          _buildActionButtons(),
                        ],
                      ),
                    ),
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
