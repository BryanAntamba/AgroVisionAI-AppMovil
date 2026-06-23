// ═══════════════════════════════════════════════════════════════════════════
// IMPORTACIONES
// ═══════════════════════════════════════════════════════════════════════════
import 'package:flutter/material.dart'; // Framework de Flutter para widgets
import 'package:font_awesome_flutter/font_awesome_flutter.dart'; // Iconos de FontAwesome
import '../navbars/barra-admin.dart'; // Widget de barra de navegación admin
import '../styles/admin-styles/plataforma-editable.dart'; // Estilos específicos de esta pantalla
import '../environments/tema-config.dart'; // Configuración del tema (colores, navbar, botones, etc.)
import '../shared/services/tema.service.dart'; // Servicio para guardar/cargar configuración del tema

// ═══════════════════════════════════════════════════════════════════════════
// CLASE: ImagenCarrusel - Representa una imagen del carrusel de tablets
// ═══════════════════════════════════════════════════════════════════════════
class ImagenCarrusel {
  final int id; // ID único de la imagen
  final String nombre; // Nombre del archivo de la imagen
  final String url; // URL de la imagen
  final bool esNueva; // Indica si es una imagen recién agregada (default: false)
  
  // Constructor
  ImagenCarrusel({required this.id, required this.nombre, required this.url, this.esNueva = false});
}

// ═══════════════════════════════════════════════════════════════════════════
// WIDGET PRINCIPAL: PlataformaEditable - Pantalla de configuración del tema
// Permite personalizar colores, logo, navbar, botones, modales, etc.
// ═══════════════════════════════════════════════════════════════════════════
class PlataformaEditable extends StatefulWidget {
  const PlataformaEditable({super.key}); // Constructor

  @override
  State<PlataformaEditable> createState() => _PlataformaEditableState(); // Crea el estado
}

// ═══════════════════════════════════════════════════════════════════════════
// ESTADO: _PlataformaEditableState - Gestiona la configuración del tema
// ═══════════════════════════════════════════════════════════════════════════
class _PlataformaEditableState extends State<PlataformaEditable> {
  // ─── ESTADO DE MODALES ───
  bool _mostrarModalResetConfirmar = false; // true = muestra modal de confirmación de reseteo
  bool _mostrarModalResetExito = false; // true = muestra modal de éxito tras resetear
  bool _mostrarModalGuardadoExito = false; // true = muestra modal de éxito tras guardar
  bool _mostrarModalErrores = false; // true = muestra modal con errores de validación
  final List<String> _erroresValidacion = []; // Lista de mensajes de error de validación

  // ─── CONFIGURACIÓN DEL TEMA ───
  late TemaConfig _config; // Objeto de configuración del tema (deep copy para edición sin afectar original)

  // ─── CONTROLADORES DE TEXTO ───
  late TextEditingController _nombreCtrl; // Controlador para nombre de la plataforma
  late TextEditingController _navColorBaseCtrl; // Controlador para color base del navbar
  late TextEditingController _navColorResplandorCtrl; // Controlador para color resplandor del navbar (gradiente)
  late TextEditingController _navColorBordeCtrl; // Controlador para color borde del navbar
  late TextEditingController _coloresTitulosCtrl; // Controlador para color de títulos
  late TextEditingController _coloresLinksNormalesCtrl; // Controlador para color de enlaces normales
  late TextEditingController _coloresLinksActivosCtrl; // Controlador para color de enlaces activos/hover
  late TextEditingController _coloresTextosCtrl; // Controlador para color de textos descriptivos
  late TextEditingController _botonesColorInicialCtrl; // Controlador para color inicial de botones
  late TextEditingController _botonesColorFinalCtrl; // Controlador para color final de botones (gradiente)
  late TextEditingController _botonesColorTextoCtrl; // Controlador para color de texto de botones
  late TextEditingController _botonesDestructivoColorCtrl; // Controlador para color de botones destructivos
  late TextEditingController _botonesDestructivoHoverCtrl; // Controlador para color hover de botones destructivos
  late TextEditingController _iconosCtrl; // Controlador para color de iconos
  late TextEditingController _modalesColorBackdropCtrl; // Controlador para color de fondo (backdrop) de modales
  late TextEditingController _modalesBotonesFondoDestructivoCtrl; // Controlador para color de botones destructivos en modales
  late TextEditingController _modalesBotonesHoverDestructivoCtrl; // Controlador para color hover de botones destructivos en modales
  late TextEditingController _modalesIconoExitoColorCtrl; // Controlador para color de icono de éxito en modales
  late TextEditingController _modalesIconoExitoFondoCtrl; // Controlador para color de fondo de icono de éxito

  // ─── ESTADO DE LOGO ───
  String? _logoPreview; // URL de preview del logo (null = no hay preview, se usa logo actual)

  // ─── DATOS DE CARRUSEL ───
  final List<ImagenCarrusel> _imagenesCarrusel = [ // Lista de imágenes del carrusel de tablets
    ImagenCarrusel(id: 1, nombre: 'campo-1.jpg', url: ''), // Imagen 1
    ImagenCarrusel(id: 2, nombre: 'cultivo.png', url: ''), // Imagen 2
  ];

  // ═══════════════════════════════════════════════════════════════════════════
  // INICIALIZACIÓN
  // ═══════════════════════════════════════════════════════════════════════════
  @override
  void initState() {
    super.initState(); // Llama al initState del padre
    _initValues(TemaService.instance.config); // Inicializa valores con configuración actual del servicio
  }

  // ─── Inicializa valores y controladores con una configuración ─────────────
  void _initValues(TemaConfig configToLoad) {
    _config = TemaConfig.fromJson(configToLoad.toJson()); // Deep copy para evitar editar en vivo sin guardar (clona objeto)
    
    // Inicializa todos los controladores con valores de la configuración
    _nombreCtrl = TextEditingController(text: _config.nombrePlataforma); // Nombre de la plataforma
    _navColorBaseCtrl = TextEditingController(text: _config.navbar.colorBase); // Color base del navbar
    _navColorResplandorCtrl = TextEditingController(text: _config.navbar.colorResplandor); // Color resplandor (gradiente)
    _navColorBordeCtrl = TextEditingController(text: _config.navbar.colorBorde); // Color borde del navbar
    _coloresTitulosCtrl = TextEditingController(text: _config.colores.titulos); // Color de títulos
    _coloresLinksNormalesCtrl = TextEditingController(text: _config.colores.linksNormales); // Color de enlaces normales
    _coloresLinksActivosCtrl = TextEditingController(text: _config.colores.linksActivos); // Color de enlaces activos
    _coloresTextosCtrl = TextEditingController(text: _config.colores.textosDescriptivos); // Color de textos descriptivos
    _botonesColorInicialCtrl = TextEditingController(text: _config.botones.colorInicial); // Color inicial de botones
    _botonesColorFinalCtrl = TextEditingController(text: _config.botones.colorFinal); // Color final de botones
    _botonesColorTextoCtrl = TextEditingController(text: _config.botones.colorTexto); // Color de texto de botones
    _botonesDestructivoColorCtrl = TextEditingController(text: _config.botones.destructivoColor); // Color de botones destructivos
    _botonesDestructivoHoverCtrl = TextEditingController(text: _config.botones.destructivoHover); // Color hover destructivos
    _iconosCtrl = TextEditingController(text: _config.colores.iconos); // Color de iconos
    _modalesColorBackdropCtrl = TextEditingController(text: _config.modales.colorBackdrop); // Color backdrop de modales
    _modalesBotonesFondoDestructivoCtrl = TextEditingController(text: _config.modales.botonesFondoDestructivo); // Color botón destructivo en modal
    _modalesBotonesHoverDestructivoCtrl = TextEditingController(text: _config.modales.botonesHoverDestructivo); // Color hover destructivo en modal
    _modalesIconoExitoColorCtrl = TextEditingController(text: _config.modales.iconoExitoColor); // Color icono de éxito
    _modalesIconoExitoFondoCtrl = TextEditingController(text: _config.modales.iconoExitoFondo); // Color fondo icono de éxito
  }

  // ═══════════════════════════════════════════════════════════════════════════
  // LIMPIEZA
  // ═══════════════════════════════════════════════════════════════════════════
  @override
  void dispose() {
    // Libera recursos de todos los controladores
    _nombreCtrl.dispose(); // Libera controlador de nombre
    _navColorBaseCtrl.dispose(); // Libera controlador de color base navbar
    _navColorResplandorCtrl.dispose(); // Libera controlador de color resplandor navbar
    _navColorBordeCtrl.dispose(); // Libera controlador de color borde navbar
    _coloresTitulosCtrl.dispose(); // Libera controlador de color títulos
    _coloresLinksNormalesCtrl.dispose(); // Libera controlador de color enlaces normales
    _coloresLinksActivosCtrl.dispose(); // Libera controlador de color enlaces activos
    _coloresTextosCtrl.dispose(); // Libera controlador de color textos descriptivos
    _botonesColorInicialCtrl.dispose(); // Libera controlador de color inicial botones
    _botonesColorFinalCtrl.dispose(); // Libera controlador de color final botones
    _botonesColorTextoCtrl.dispose(); // Libera controlador de color texto botones
    _botonesDestructivoColorCtrl.dispose(); // Libera controlador de color destructivo
    _botonesDestructivoHoverCtrl.dispose(); // Libera controlador de color hover destructivo
    _iconosCtrl.dispose(); // Libera controlador de color iconos
    _modalesColorBackdropCtrl.dispose(); // Libera controlador de color backdrop
    _modalesBotonesFondoDestructivoCtrl.dispose(); // Libera controlador de botón destructivo modal
    _modalesBotonesHoverDestructivoCtrl.dispose(); // Libera controlador de hover destructivo modal
    _modalesIconoExitoColorCtrl.dispose(); // Libera controlador de color icono éxito
    _modalesIconoExitoFondoCtrl.dispose(); // Libera controlador de fondo icono éxito
    super.dispose(); // Llama al dispose del padre
  }

  // ═══════════════════════════════════════════════════════════════════════════
  // CONVERSIÓN DE COLOR HEXADECIMAL A COLOR DE FLUTTER
  // ═══════════════════════════════════════════════════════════════════════════
  /// Convierte un string hexadecimal a un objeto Color de Flutter
  /// @param hexColor: String en formato hexadecimal (#RRGGBB o RRGGBB)
  /// @return Color: Objeto Color de Flutter
  /// Ejemplo: "#073D2B" -> Color(0xFF073D2B)
  Color _colorFromHex(String hexColor) {
    hexColor = hexColor.replaceAll('#', ''); // Remueve el símbolo # si existe
    if (hexColor.length == 6) {
      hexColor = 'FF$hexColor'; // Agrega opacidad completa (FF) si no está especificada
    }
    // Intenta parsear el string hexadecimal, si falla usa color verde por defecto
    return Color(int.tryParse('0x$hexColor') ?? 0xFF073D2B);
  }

  // ═══════════════════════════════════════════════════════════════════════════
  // GUARDAR CAMBIOS - Valida y persiste la configuración del tema
  // ═══════════════════════════════════════════════════════════════════════════
  /// Guarda todos los cambios realizados en la configuración del tema
  /// Proceso:
  /// 1. Limpia errores previos
  /// 2. Valida el nombre de la plataforma (1-50 caracteres)
  /// 3. Si hay errores, muestra modal de errores
  /// 4. Si no hay errores:
  ///    - Actualiza todos los valores de _config desde los controladores
  ///    - Guarda la configuración usando TemaService
  ///    - Muestra modal de éxito
  void _guardarCambios() {
    setState(() {
      // 1. Limpia la lista de errores de validación
      _erroresValidacion.clear();
      
      // 2. Valida el nombre de la plataforma
      if (_nombreCtrl.text.trim().isEmpty || _nombreCtrl.text.trim().length > 50) {
        _erroresValidacion.add('El nombre de la plataforma debe tener entre 1 y 50 caracteres.');
      }
      
      // 3. Si hay errores, muestra el modal de errores
      if (_erroresValidacion.isNotEmpty) {
        _mostrarModalErrores = true;
      } else {
        // 4. Actualiza la configuración con los valores de los controladores
        _config.nombrePlataforma = _nombreCtrl.text.trim(); // Nombre de la plataforma
        
        // Colores del navbar
        _config.navbar.colorBase = _navColorBaseCtrl.text;
        _config.navbar.colorResplandor = _navColorResplandorCtrl.text;
        _config.navbar.colorBorde = _navColorBordeCtrl.text;
        
        // Colores de textos
        _config.colores.titulos = _coloresTitulosCtrl.text;
        _config.colores.linksNormales = _coloresLinksNormalesCtrl.text;
        _config.colores.linksActivos = _coloresLinksActivosCtrl.text;
        _config.colores.textosDescriptivos = _coloresTextosCtrl.text;
        
        // Colores de botones
        _config.botones.colorInicial = _botonesColorInicialCtrl.text;
        _config.botones.colorFinal = _botonesColorFinalCtrl.text;
        _config.botones.colorTexto = _botonesColorTextoCtrl.text;
        _config.botones.destructivoColor = _botonesDestructivoColorCtrl.text;
        _config.botones.destructivoHover = _botonesDestructivoHoverCtrl.text;
        
        // Color de iconos
        _config.colores.iconos = _iconosCtrl.text;
        
        // Colores de modales
        _config.modales.colorBackdrop = _modalesColorBackdropCtrl.text;
        _config.modales.botonesFondoDestructivo = _modalesBotonesFondoDestructivoCtrl.text;
        _config.modales.botonesHoverDestructivo = _modalesBotonesHoverDestructivoCtrl.text;
        _config.modales.iconoExitoColor = _modalesIconoExitoColorCtrl.text;
        _config.modales.iconoExitoFondo = _modalesIconoExitoFondoCtrl.text;

        // Guarda la configuración usando el servicio de tema
        TemaService.instance.guardar(_config);
        
        // Muestra el modal de éxito
        _mostrarModalGuardadoExito = true;
      }
    });
  }

  // ═══════════════════════════════════════════════════════════════════════════
  // CONFIRMAR RESETEO - Restaura la configuración a valores por defecto
  // ═══════════════════════════════════════════════════════════════════════════
  /// Resetea toda la configuración del tema a los valores por defecto
  /// Proceso:
  /// 1. Llama al servicio de tema para resetear la configuración
  /// 2. Reinicializa todos los valores y controladores con la config reseteada
  /// 3. Cierra el modal de confirmación
  /// 4. Muestra el modal de éxito
  void _confirmarResetear() {
    TemaService.instance.resetear(); // Resetea la configuración en el servicio
    setState(() {
      _initValues(TemaService.instance.config); // Reinicializa valores con config por defecto
      _mostrarModalResetConfirmar = false; // Cierra modal de confirmación
      _mostrarModalResetExito = true; // Muestra modal de éxito
    });
  }

  // ═══════════════════════════════════════════════════════════════════════════
  // CONSTRUCTOR DE ENCABEZADO DE SECCIÓN
  // ═══════════════════════════════════════════════════════════════════════════
  /// Construye un encabezado visual para cada sección de configuración
  /// @param icon: Icono de FontAwesome para la sección
  /// @param title: Título de la sección
  /// @param description: Descripción breve de lo que hace la sección
  /// @return Widget: Encabezado visual con icono, título y descripción
  Widget _buildSectionHeader(dynamic icon, String title, String description) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        // Fila con icono y título
        Row(
          children: [
            FaIcon(icon, size: 24, color: PlataformaEditableStyles.primaryGreen),
            const SizedBox(width: 12),
            Text(title, style: PlataformaEditableStyles.sectionTitle),
          ],
        ),
        const SizedBox(height: 8),
        // Descripción con padding a la izquierda para alinear con el título
        Padding(
          padding: const EdgeInsets.only(left: 36.0),
          child: Text(description, style: PlataformaEditableStyles.sectionDesc),
        ),
        const SizedBox(height: 24),
      ],
    );
  }

  // ═══════════════════════════════════════════════════════════════════════════
  // CONSTRUCTOR DE TEXTO DE AYUDA
  // ═══════════════════════════════════════════════════════════════════════════
  /// Construye una caja de ayuda con fondo de color para mostrar instrucciones
  /// @param text: Texto de ayuda o instrucción para el usuario
  /// @return Widget: Container con estilo de caja de ayuda
  Widget _buildHelpText(String text) {
    return Container(
      margin: const EdgeInsets.only(bottom: 12), // Margen inferior para separación
      padding: const EdgeInsets.all(12), // Padding interno
      decoration: PlataformaEditableStyles.helpBox, // Decoración predefinida (fondo, bordes)
      width: double.infinity, // Ocupa todo el ancho disponible
      child: Text(text, style: PlataformaEditableStyles.helpText),
    );
  }

  // ═══════════════════════════════════════════════════════════════════════════
  // CONSTRUCTOR DE FILA DE COLOR - Selector de color con preview
  // ═══════════════════════════════════════════════════════════════════════════
  /// Construye una fila con un selector de color que incluye:
  /// - Título y descripción del color
  /// - Preview del color actual (cuadrado de color)
  /// - Campo de texto para ingresar el código hexadecimal
  /// @param title: Título del campo (ej: "Color del Fondo")
  /// @param desc: Descripción del campo (ej: "Aplica a todos los títulos")
  /// @param ctrl: Controlador de texto que maneja el valor del color
  /// @param onChanged: Función callback que se ejecuta al cambiar el color
  /// @param fullWidth: Si es true, ocupa todo el ancho; si es false, se puede expandir
  /// @return Widget: Selector de color completo con preview
  Widget _buildColorRow(String title, String desc, TextEditingController ctrl, Function(String) onChanged, [bool fullWidth = false]) {
    final field = Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        // Título del campo
        Text(title, style: PlataformaEditableStyles.configLabel),
        // Descripción (opcional, solo si no está vacía)
        if (desc.isNotEmpty) ...[
          const SizedBox(height: 2),
          Text(desc, style: PlataformaEditableStyles.helpTextSmall),
        ],
        const SizedBox(height: 8),
        // Fila con preview de color y campo de texto
        Row(
          children: [
            // Cuadrado de preview del color actual
            Container(
              width: 60, height: 44,
              decoration: BoxDecoration(
                color: _colorFromHex(ctrl.text), // Convierte el hex a Color
                border: Border.all(color: PlataformaEditableStyles.borderGrey),
                borderRadius: BorderRadius.circular(8),
              ),
            ),
            const SizedBox(width: 10),
            // Campo de texto para ingresar el código hexadecimal
            Expanded(
              child: Container(
                height: 44,
                decoration: PlataformaEditableStyles.inputDecoration(),
                child: TextField(
                  controller: ctrl, // Controlador del campo
                  onChanged: (v) {
                    onChanged(v); // Ejecuta callback personalizado
                    setState(() {}); // Actualiza el preview del color
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
    // Si fullWidth es true, devuelve el field directo; si no, lo envuelve en Expanded
    if (fullWidth) return field;
    return Expanded(child: field);
  }

  // ═══════════════════════════════════════════════════════════════════════════
  // SECCIÓN: IDENTIDAD VISUAL - Logo, icono, carrusel y nombre
  // ═══════════════════════════════════════════════════════════════════════════
  /// Construye la sección completa de Identidad Visual que incluye:
  /// 1. Logo principal de la plataforma (con upload y preview)
  /// 2. Icono de la aplicación móvil
  /// 3. Carrusel de imágenes para tablets (agregar, reordenar, eliminar)
  /// 4. Nombre de la aplicación (con contador de caracteres)
  /// @return Widget: Container con toda la sección de identidad visual
  Widget _buildIdentidadVisual() {
    return Container(
      padding: const EdgeInsets.all(28),
      decoration: PlataformaEditableStyles.sectionDecoration,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // Encabezado de la sección
          _buildSectionHeader(FontAwesomeIcons.image, 'Identidad Visual', 'Personaliza el logo, icono y nombre que representan tu plataforma'),
          
          // ─────────────────────────────────────────────────────────────────
          // SUB-SECCIÓN: Logo Principal
          // ─────────────────────────────────────────────────────────────────
          const Text('Logo Principal de la Plataforma', style: PlataformaEditableStyles.configLabel),
          const SizedBox(height: 8),
          _buildHelpText('Este logo aparecerá en todas las barras de navegación (Admin y Agricultor), páginas de autenticación y paneles. El cambio no afectará el tamaño, solo la imagen.'),
          Container(
            width: double.infinity,
            padding: const EdgeInsets.all(20),
            decoration: PlataformaEditableStyles.fileUploadArea,
            child: Column(
              children: [
                // Si hay preview de logo nuevo, mostrarlo
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
                        // Imagen de preview
                        Image.network(_logoPreview!, width: 200, height: 120, fit: BoxFit.contain),
                        // Botón X para eliminar el preview
                        Positioned(
                          top: -20,
                          right: -20,
                          child: GestureDetector(
                            onTap: () => setState(() => _logoPreview = null), // Elimina el preview
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
                  // Si no hay preview, mostrar estado actual
                  Column(
                    children: [
                      const FaIcon(FontAwesomeIcons.cloudArrowUp, size: 48, color: PlataformaEditableStyles.borderInput),
                      const SizedBox(height: 8),
                      const Text('Logo actual: escudo.png', style: TextStyle(color: Color(0xFF6B8177), fontSize: 14)),
                      const SizedBox(height: 16),
                    ],
                  ),
                // Botón para subir nuevo logo
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    ElevatedButton.icon(
                      onPressed: () {}, // TODO: Implementar funcionalidad de upload
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
          
          // ─────────────────────────────────────────────────────────────────
          // SUB-SECCIÓN: Icono de App
          // ─────────────────────────────────────────────────────────────────
          const Text('Icono de la Aplicación', style: PlataformaEditableStyles.configLabel),
          const SizedBox(height: 8),
          _buildHelpText('Icono principal de la aplicación móvil. Se recomienda usar imágenes cuadradas de 512x512px o 1024x1024px en formato PNG.'),
          Container(
            width: double.infinity,
            padding: const EdgeInsets.all(20),
            decoration: PlataformaEditableStyles.fileUploadArea,
            child: Column(
              children: [
                // Icono placeholder
                const FaIcon(FontAwesomeIcons.leaf, size: 48, color: PlataformaEditableStyles.borderInput),
                const SizedBox(height: 8),
                const Text('Icono actual: iconoHoja.png', style: TextStyle(color: Color(0xFF6B8177), fontSize: 14)),
                const SizedBox(height: 16),
                // Botón para subir nuevo icono
                ElevatedButton.icon(
                  onPressed: () {}, // TODO: Implementar funcionalidad de upload
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
          
          // ─────────────────────────────────────────────────────────────────
          // SUB-SECCIÓN: Carrusel de Imágenes
          // ─────────────────────────────────────────────────────────────────
          const Text('Carrusel de Imágenes para Tablets', style: PlataformaEditableStyles.configLabel),
          const SizedBox(height: 8),
          _buildHelpText('Gestiona las imágenes que se mostrarán en dispositivos tablet. Puedes agregar nuevas imágenes, eliminar existentes, cambiarlas o reordenarlas. Se recomienda usar imágenes de alta calidad con una relación de aspecto de 16:9 o similar.'),
          // Lista de imágenes del carrusel
          Column(
            children: _imagenesCarrusel.asMap().entries.map((entry) {
              final idx = entry.key; // Índice de la imagen
              final img = entry.value; // Objeto ImagenCarrusel
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
                    // Preview de la imagen con número de orden
                    Container(
                      width: 200, height: 120,
                      decoration: BoxDecoration(border: Border.all(color: const Color(0xFFE0EBE5)), borderRadius: BorderRadius.circular(6)),
                      child: Stack(
                        children: [
                          // Fondo gris con icono placeholder de imagen
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
                          // Badge circular con el número de orden de la imagen
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
                    // Información y botones de acción de la imagen
                    Expanded(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          // Nombre del archivo de la imagen
                          Text(img.nombre, style: const TextStyle(fontWeight: FontWeight.bold, color: PlataformaEditableStyles.darkGreen, fontSize: 14)),
                          const SizedBox(height: 12),
                          // Botones de acción (subir, bajar, reemplazar, eliminar)
                          Wrap(
                            spacing: 8,
                            runSpacing: 8,
                            children: [
                              _buildCarruselBtn(FontAwesomeIcons.arrowUp, () {}), // Mover arriba
                              _buildCarruselBtn(FontAwesomeIcons.arrowDown, () {}), // Mover abajo
                              _buildCarruselBtn(FontAwesomeIcons.repeat, () {}), // Reemplazar
                              _buildCarruselBtn(FontAwesomeIcons.trash, () {}), // Eliminar
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
          // Área para agregar nuevas imágenes al carrusel
          Container(
            width: double.infinity,
            padding: const EdgeInsets.all(20),
            decoration: BoxDecoration(border: Border.all(color: PlataformaEditableStyles.borderInput, width: 2), borderRadius: BorderRadius.circular(8), color: PlataformaEditableStyles.bgHelp),
            child: Column(
              children: [
                // Botón para agregar imágenes
                ElevatedButton.icon(
                  onPressed: () {}, // TODO: Implementar selección múltiple de imágenes
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
          
          // ─────────────────────────────────────────────────────────────────
          // SUB-SECCIÓN: Nombre de la Aplicación
          // ─────────────────────────────────────────────────────────────────
          const Row(
            children: [
              FaIcon(FontAwesomeIcons.penToSquare, size: 16, color: PlataformaEditableStyles.primaryGreen),
              SizedBox(width: 8),
              Text('Nombre de la Aplicación', style: PlataformaEditableStyles.configLabel),
            ],
          ),
          const SizedBox(height: 8),
          _buildHelpText('Este nombre aparecerá en el botón de inicio de arranque del dispositivo y como título de la aplicación.'),
          // Campo de texto para el nombre con icono
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
                    controller: _nombreCtrl, // Controlador del nombre
                    decoration: const InputDecoration(border: InputBorder.none, hintText: 'Ej: AgroVision AI'),
                    maxLength: 50, // Máximo 50 caracteres
                    buildCounter: (context, {required currentLength, required isFocused, maxLength}) => null, // Oculta contador por defecto
                    style: const TextStyle(fontSize: 14, color: PlataformaEditableStyles.darkGreen),
                  ),
                ),
              ],
            ),
          ),
          const SizedBox(height: 6),
          // Contador de caracteres personalizado
          Align(
            alignment: Alignment.centerRight,
            child: Text('${_nombreCtrl.text.length} / 50 caracteres', style: PlataformaEditableStyles.helpTextSmall),
          ),
        ],
      ),
    );
  }

  // ═══════════════════════════════════════════════════════════════════════════
  // CONSTRUCTOR DE BOTÓN DE CARRUSEL - Botones pequeños de acción
  // ═══════════════════════════════════════════════════════════════════════════
  /// Construye un botón pequeño cuadrado para acciones del carrusel
  /// (subir, bajar, reemplazar, eliminar imágenes)
  /// @param icon: Icono de FontAwesome para el botón
  /// @param onTap: Función callback al hacer clic en el botón
  /// @return Widget: Botón cuadrado con icono
  Widget _buildCarruselBtn(dynamic icon, VoidCallback onTap) {
    return InkWell(
      onTap: onTap, // Ejecuta la función al hacer clic
      child: Container(
        width: 36, height: 36, // Botón cuadrado de 36x36
        decoration: BoxDecoration(
          border: Border.all(color: PlataformaEditableStyles.borderGrey),
          borderRadius: BorderRadius.circular(6),
          color: Colors.white
        ),
        child: Center(child: FaIcon(icon, size: 14, color: const Color(0xFF456657))),
      ),
    );
  }

  // ═══════════════════════════════════════════════════════════════════════════
  // SECCIÓN: NAVBAR - Configuración de la barra de navegación
  // ═══════════════════════════════════════════════════════════════════════════
  /// Construye la sección de configuración del Navbar que incluye:
  /// - Tipo de fondo (sólido o gradiente)
  /// - Colores del navbar según el tipo seleccionado
  /// @return Widget: Container con configuración del navbar
  Widget _buildNavbar() {
    return Container(
      padding: const EdgeInsets.all(28),
      decoration: PlataformaEditableStyles.sectionDecoration,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // Encabezado de la sección
          _buildSectionHeader(FontAwesomeIcons.bars, 'Barra de Navegación', 'Configura el fondo, efectos y apariencia del navbar'),
          
          // Selector de tipo de fondo (sólido o gradiente)
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const Text('Tipo de Fondo', style: PlataformaEditableStyles.configLabel),
              const SizedBox(height: 12),
              Row(
                children: [
                  // Radio button para fondo sólido
                  _buildRadio('solido', 'Sólido', _config.navbar.tipoFondo, (v) => setState(() => _config.navbar.tipoFondo = v)),
                  const SizedBox(width: 12),
                  // Radio button para fondo gradiente
                  _buildRadio('gradiente', 'Gradiente', _config.navbar.tipoFondo, (v) => setState(() => _config.navbar.tipoFondo = v)),
                ],
              ),
            ],
          ),
          const SizedBox(height: 20),
          
          // Campos de color según el tipo de fondo seleccionado
          if (_config.navbar.tipoFondo == 'solido') ...[
            // Si es sólido, solo muestra un selector de color
            Row(
              children: [
                _buildColorRow('Color del Fondo', '', _navColorBaseCtrl, (v) => _config.navbar.colorBase = v),
                const Expanded(child: SizedBox()), // Espacio vacío para mantener layout
              ],
            ),
          ] else ...[
            // Si es gradiente, muestra dos selectores de color (inicial y final)
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

  // ═══════════════════════════════════════════════════════════════════════════
  // CONSTRUCTOR DE RADIO BUTTON PERSONALIZADO
  // ═══════════════════════════════════════════════════════════════════════════
  /// Construye un radio button personalizado con estilos de la plataforma
  /// @param value: Valor que representa esta opción
  /// @param text: Texto a mostrar junto al radio
  /// @param groupValue: Valor actualmente seleccionado del grupo
  /// @param onChanged: Función callback al seleccionar esta opción
  /// @return Widget: Radio button personalizado con estilos
  Widget _buildRadio(String value, String text, String groupValue, Function(String) onChanged) {
    bool selected = value == groupValue; // true si esta opción está seleccionada
    return GestureDetector(
      onTap: () => onChanged(value), // Selecciona esta opción al hacer clic
      child: Container(
        padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 10),
        decoration: BoxDecoration(
          // Color de fondo cambia según si está seleccionado
          color: selected ? PlataformaEditableStyles.bgHelp : PlataformaEditableStyles.bgInput,
          // Borde verde si está seleccionado, gris si no
          border: Border.all(color: selected ? PlataformaEditableStyles.primaryGreen : PlataformaEditableStyles.borderInput, width: 2),
          borderRadius: BorderRadius.circular(8),
        ),
        child: Row(
          children: [
            // Círculo del radio button
            Container(
              width: 18, height: 18,
              decoration: BoxDecoration(
                shape: BoxShape.circle, 
                border: Border.all(color: selected ? PlataformaEditableStyles.primaryGreen : Colors.grey, width: 2)
              ),
              // Si está seleccionado, muestra punto interno
              child: selected ? Center(
                child: Container(
                  width: 10, height: 10,
                  decoration: const BoxDecoration(shape: BoxShape.circle, color: PlataformaEditableStyles.primaryGreen)
                )
              ) : null,
            ),
            const SizedBox(width: 8),
            // Texto de la opción (verde y bold si está seleccionado)
            Text(text, style: TextStyle(
              color: selected ? PlataformaEditableStyles.primaryGreen : PlataformaEditableStyles.darkGreen, 
              fontWeight: selected ? FontWeight.bold : FontWeight.normal
            )),
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
          // ═══ CAPA 1: Contenido principal (debajo de la navbar) ═══
          Column(
            children: [
              // ─── Espacio vacío para evitar que navbar tape contenido ───
              const SizedBox(height: 119), // Altura total del navbar (72 + 35 + 6*2 = 119)
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
          
          // ═══ CAPA 2: Barra de navegación fija en la parte superior ═══
          Positioned(
            top: 0,
            left: 0,
            right: 0,
            child: const BarraAdmin(),
          ),
          
          // ═══ CAPA 3: Modales con overlay de pantalla completa ═══
          _buildOverlay(),
        ],
      ),
    );
  }
}
