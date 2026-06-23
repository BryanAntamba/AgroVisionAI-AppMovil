// ═══════════════════════════════════════════════════════════════════════════
// IMPORTACIONES
// ═══════════════════════════════════════════════════════════════════════════
import 'package:flutter/material.dart'; // Framework de Flutter para widgets
import 'package:font_awesome_flutter/font_awesome_flutter.dart'; // Iconos de FontAwesome
import '../styles/admin-styles/recomendaciones.dart'; // Estilos específicos de esta pantalla
import '../navbars/barra-admin.dart'; // Widget de barra de navegación admin
import '../styles/navbars-styles/barra-admin.dart'; // Estilos de la barra admin
import '../environments/modales-recomendacion.dart'; // Tipos de datos y store de recomendaciones
import 'modalesRecomendacion/eliminar-recomendacion.dart'; // Modal de eliminación
import 'modalesRecomendacion/visualizar-recomendacion.dart'; // Modal de visualización
import 'modalesRecomendacion/editar-recomendacion.dart'; // Modal de edición
import 'modalesRecomendacion/registrar-recomendacion.dart'; // Modal de registro

// ═══════════════════════════════════════════════════════════════════════════
// ENUM: FiltroPrioridad - Filtro para la lista de recomendaciones
// ═══════════════════════════════════════════════════════════════════════════
enum FiltroPrioridad { todas, baja, media, alta, critica }

// Extensión para obtener label legible de cada prioridad
extension FiltroPrioridadLabel on FiltroPrioridad {
  String get label {
    switch (this) {
      case FiltroPrioridad.todas:   return 'Todas'; // Muestra todas las recomendaciones
      case FiltroPrioridad.baja:    return 'Baja'; // Solo prioridad baja
      case FiltroPrioridad.media:   return 'Media'; // Solo prioridad media
      case FiltroPrioridad.alta:    return 'Alta'; // Solo prioridad alta
      case FiltroPrioridad.critica: return 'Critica'; // Solo prioridad crítica
    }
  }
}

// ═══════════════════════════════════════════════════════════════════════════
// WIDGET PRINCIPAL: Recomendaciones - Pantalla de gestión de recomendaciones
// Permite listar, filtrar, crear, editar, visualizar y eliminar recomendaciones
// ═══════════════════════════════════════════════════════════════════════════
class Recomendaciones extends StatefulWidget {
  const Recomendaciones({super.key});

  @override
  State<Recomendaciones> createState() => _RecomendacionesState();
}

// ═══════════════════════════════════════════════════════════════════════════
// ESTADO: _RecomendacionesState - Gestiona la pantalla de recomendaciones
// ═══════════════════════════════════════════════════════════════════════════
class _RecomendacionesState extends State<Recomendaciones> {
  // ─── ESTADO DE FILTROS ───
  String _busqueda = ''; // Término de búsqueda (título o descripción)
  FiltroPrioridad _filtroPrioridad = FiltroPrioridad.todas; // Filtro de prioridad seleccionado
  bool _prioridadExpanded = false; // Controla si dropdown de prioridad está expandido

  // ─── DATOS ───
  List<RecomendacionRegistrada> _lista = []; // Lista completa de recomendaciones del store
  List<RecomendacionRegistrada> _vistaPrevia = []; // Lista filtrada que se muestra en UI

  // ─── ESTADO DE MODALES ───
  bool _mostrarRegistrar   = false; // true = muestra modal de registro
  bool _mostrarEditar      = false; // true = muestra modal de edición
  bool _mostrarVisualizar  = false; // true = muestra modal de visualización
  bool _mostrarEliminar    = false; // true = muestra modal de eliminación
  RecomendacionRegistrada? _seleccionada; // Recomendación seleccionada para editar/visualizar/eliminar

  // ═══════════════════════════════════════════════════════════════════════════
  // INICIALIZACIÓN
  // ═══════════════════════════════════════════════════════════════════════════
  @override
  void initState() {
    super.initState(); // Llama al initState del padre
    _refrescar(); // Carga datos iniciales del store
  }

  // ═══════════════════════════════════════════════════════════════════════════
  // LÓGICA DE DATOS Y FILTROS
  // ═══════════════════════════════════════════════════════════════════════════

  // Recarga datos completos del store y aplica filtros
  void _refrescar() {
    _lista = RecomendacionesStore.obtenerTodas(); // Obtiene todas las recomendaciones
    _aplicarFiltros(); // Aplica filtros activos
  }

  // Aplica filtros de búsqueda y prioridad a la lista completa
  void _aplicarFiltros() {
    final termino = _normalizar(_busqueda); // Normaliza término de búsqueda (sin acentos, minúsculas)
    setState(() { // Actualiza estado
      _vistaPrevia = _lista.where((r) { // Filtra lista completa
        // ─── Filtro de búsqueda (título o descripción) ───
        final coincideBusqueda = termino.isEmpty ||
            _normalizar(r.titulo).contains(termino) ||
            _normalizar(r.descripcion).contains(termino);
        // ─── Filtro de prioridad ───
        final coincidePrioridad = _filtroPrioridad == FiltroPrioridad.todas ||
            r.prioridad.label.toLowerCase() == _filtroPrioridad.label.toLowerCase();
        return coincideBusqueda && coincidePrioridad; // Debe cumplir ambos filtros
      }).toList();
    });
  }

  // Normaliza string: elimina acentos, convierte a minúsculas, elimina espacios extra
  String _normalizar(String v) => v
      .toLowerCase() // Convierte a minúsculas
      .replaceAll(RegExp(r'[áàäâ]'), 'a') // Reemplaza variantes de 'a'
      .replaceAll(RegExp(r'[éèëê]'), 'e') // Reemplaza variantes de 'e'
      .replaceAll(RegExp(r'[íìïî]'), 'i') // Reemplaza variantes de 'i'
      .replaceAll(RegExp(r'[óòöô]'), 'o') // Reemplaza variantes de 'o'
      .replaceAll(RegExp(r'[úùüû]'), 'u') // Reemplaza variantes de 'u'
      .trim(); // Elimina espacios al inicio y final

  // ═══════════════════════════════════════════════════════════════════════════
  // ACCIONES DE MODALES
  // ═══════════════════════════════════════════════════════════════════════════

  // Cierra todos los modales y limpia selección
  void _cerrarTodosModales() => setState(() {
    _mostrarRegistrar  = false; // Oculta modal de registro
    _mostrarEditar     = false; // Oculta modal de edición
    _mostrarVisualizar = false; // Oculta modal de visualización
    _mostrarEliminar   = false; // Oculta modal de eliminación
    _seleccionada      = null; // Limpia recomendación seleccionada
  });

  // Guarda nueva recomendación en el store
  void _guardarRegistro(DatosRecomendacionForm datos) {
    RecomendacionesStore.agregar(datos); // Agrega al store
    setState(() => _mostrarRegistrar = false); // Cierra modal
    _refrescar(); // Recarga lista
  }

  // Guarda cambios de edición en el store
  void _guardarEdicion(DatosRecomendacionForm datos) {
    if (_seleccionada == null) return; // Valida que haya recomendación seleccionada
    RecomendacionesStore.actualizar(_seleccionada!.id, datos); // Actualiza en store
    setState(() { _mostrarEditar = false; _seleccionada = null; }); // Cierra modal y limpia selección
    _refrescar(); // Recarga lista
  }

  // Confirma y ejecuta eliminación de recomendación
  void _confirmarEliminacion() {
    if (_seleccionada == null) return; // Valida que haya recomendación seleccionada
    RecomendacionesStore.eliminar(_seleccionada!.id); // Elimina del store
    setState(() { _mostrarEliminar = false; _seleccionada = null; }); // Cierra modal y limpia selección
    _refrescar(); // Recarga lista
  }

  // ═══════════════════════════════════════════════════════════════════════════
  // BUILD METHOD - Construye la interfaz de la pantalla de recomendaciones
  // ═══════════════════════════════════════════════════════════════════════════
  @override
  Widget build(BuildContext context) {
    final isMobile = MediaQuery.of(context).size.width < 768; // Determina si es vista móvil (ancho < 768px)
    final screenWidth = MediaQuery.of(context).size.width; // Obtiene ancho de pantalla

    return Scaffold( // Widget principal de la pantalla
      backgroundColor: RecomendacionesStyles.backgroundPage, // Color de fondo de la página
      body: Stack( // Stack permite superponer widgets (contenido + barra + modales)
        children: [
          // ─────────────────────────────────────────────────────────────────
          // CONTENIDO PRINCIPAL CON PADDING SUPERIOR
          // ─────────────────────────────────────────────────────────────────
          Positioned.fill( // Ocupa todo el espacio disponible
            child: Column( // Columna: espacio para barra + contenido scrolleable
              children: [
                // ─── ESPACIO RESERVADO PARA LA BARRA FIJA ───
                SizedBox(
                  height: screenWidth > 991 // Calcula altura según ancho de pantalla
                      ? BarraAdminStyles.navbarHeight + // Altura de la barra
                          BarraAdminStyles.contentPaddingTop + // Padding superior
                          (BarraAdminStyles.navbarPaddingVertical * 2) // Padding vertical x2
                      : BarraAdminStyles.navbarHeight +
                          BarraAdminStyles.contentPaddingTop +
                          (BarraAdminStyles.navbarPaddingVertical * 2),
                ),
                // ─── CONTENIDO SCROLLEABLE ───
                Expanded( // Ocupa espacio restante
                  child: SingleChildScrollView( // Hace el contenido scrolleable
                    padding: EdgeInsets.all(isMobile ? 16 : 32), // Padding según viewport
                    child: Center( // Centra contenido horizontalmente
                      child: ConstrainedBox( // Limita ancho máximo
                        constraints: const BoxConstraints(maxWidth: 1220), // Ancho máximo 1220px
                        child: Column( // Columna: header + filtros + lista
                          crossAxisAlignment: CrossAxisAlignment.stretch, // Ocupa ancho completo
                          children: [
                            _buildHeader(isMobile), // Header con título y botón
                            const SizedBox(height: 18), // Espacio vertical
                            _buildFiltersBar(isMobile), // Barra de filtros
                            const SizedBox(height: 18),
                            _buildListaRecomendaciones(isMobile), // Lista de recomendaciones
                            const SizedBox(height: 32), // Espacio inferior
                          ],
                        ),
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ),
          // ─────────────────────────────────────────────────────────────────
          // BARRA FIJA EN LA PARTE SUPERIOR (superpuesta al contenido)
          // ─────────────────────────────────────────────────────────────────
          Positioned( // Posición absoluta
            top: 0, // Pegado arriba
            left: 0, // Pegado a la izquierda
            right: 0, // Pegado a la derecha
            child: const BarraAdmin(), // Widget de barra de navegación
          ),
          // ─────────────────────────────────────────────────────────────────
          // MODALES OVERLAY (cubren toda la pantalla incluyendo barra)
          // ─────────────────────────────────────────────────────────────────
          if (_mostrarRegistrar || _mostrarEditar || // Si algún modal está activo
              _mostrarVisualizar || _mostrarEliminar)
            _buildModalOverlay(), // Muestra el modal activo
        ],
      ),
    );
  }

  // ═══════════════════════════════════════════════════════════════════════════
  // MÉTODO: _buildHeader - Construye header con título y botón registrar
  // ═══════════════════════════════════════════════════════════════════════════
  Widget _buildHeader(bool isMobile) {
    // ─── TEXTOS DEL HEADER ───
    final textos = Column( // Columna con textos
      crossAxisAlignment: CrossAxisAlignment.start, // Alinea a la izquierda
      children: const [
        Text('ADMINISTRACIÓN', style: RecomendacionesStyles.eyebrowText), // Texto superior pequeño
        SizedBox(height: 8), // Espacio vertical
        Text('Recomendaciones de acción', style: RecomendacionesStyles.h1Text), // Título principal
        SizedBox(height: 10), // Espacio vertical
        Text( // Descripción
          'Registre y administre las recomendaciones que verá el agricultor en su panel.',
          style: RecomendacionesStyles.headerDesc, // Estilo de descripción
        ),
      ],
    );

    // ─── BOTÓN REGISTRAR ───
    final boton = GestureDetector( // Detector de toques
      onTap: () => setState(() => _mostrarRegistrar = true), // Abre modal de registro
      child: Container( // Contenedor del botón
        decoration: RecomendacionesStyles.createBtnDecoration, // Estilo del botón (fondo verde)
        padding: const EdgeInsets.symmetric(horizontal: 18), // Padding horizontal
        constraints: const BoxConstraints(minHeight: 46), // Altura mínima
        child: const Row( // Fila: ícono + texto
          mainAxisSize: MainAxisSize.min, // Ocupa solo espacio necesario
          children: [
            FaIcon(FontAwesomeIcons.plus, color: Colors.white, size: 18), // Ícono +
            SizedBox(width: 8), // Espacio entre ícono y texto
            Text( // Texto del botón
              'Registrar recomendación',
              style: TextStyle(color: Colors.white, fontSize: 15, fontWeight: FontWeight.w800), // Estilo blanco bold
            ),
          ],
        ),
      ),
    );

    // ─── LAYOUT RESPONSIVE ───
    if (isMobile) { // Vista móvil: columna vertical
      return Column(
        crossAxisAlignment: CrossAxisAlignment.stretch, // Ocupa ancho completo
        children: [textos, const SizedBox(height: 14), boton], // Textos arriba, botón abajo
      );
    }
    // Vista desktop: fila horizontal
    return Row(
      crossAxisAlignment: CrossAxisAlignment.start, // Alinea arriba
      children: [
        Expanded(child: textos), // Textos ocupan espacio disponible
        const SizedBox(width: 20), // Espacio entre textos y botón
        boton, // Botón a la derecha
      ],
    );
  }

  // ─── Barra de filtros (búsqueda + dropdown de prioridad) ──────────────────
  Widget _buildFiltersBar(bool isMobile) {
    return Container( // Contenedor de la barra
      padding: const EdgeInsets.all(18), // Padding interno
      decoration: RecomendacionesStyles.filterBarDecoration, // Estilo del contenedor (borde, fondo)
      child: isMobile
          ? Column( // Móvil: apila filtros verticalmente
              crossAxisAlignment: CrossAxisAlignment.stretch, // Filtros ocupan ancho completo
              children: [
                _buildSearchField(), // Campo de búsqueda
                const SizedBox(height: 14), // Espaciado vertical
                _buildPrioridadDropdown(double.infinity), // Dropdown de prioridad (ancho completo)
              ],
            )
          : Row( // Desktop: dispone filtros horizontalmente
              crossAxisAlignment: CrossAxisAlignment.end, // Alinea al final (bottom) para que estén nivelados
              children: [
                Expanded(flex: 14, child: _buildSearchField()), // Campo de búsqueda (14 partes de 22)
                const SizedBox(width: 14), // Espaciado horizontal
                Expanded(flex: 8, child: _buildPrioridadDropdown(double.infinity)), // Dropdown de prioridad (8 partes de 22)
              ],
            ),
    );
  }

  // ─── Campo de búsqueda con label ──────────────────────────────────────────
  Widget _buildSearchField() {
    return _LabeledField( // Widget auxiliar que agrega label
      label: 'Buscar recomendación', // Label del campo
      child: _SearchBox( // Widget personalizado de búsqueda
        placeholder: 'Título o descripción', // Placeholder del input
        onChanged: (v) { // Al escribir
          _busqueda = v; // Actualiza término de búsqueda
          _aplicarFiltros(); // Vuelve a aplicar filtros con nuevo término
        },
      ),
    );
  }

  // ─── Dropdown de filtro por prioridad ─────────────────────────────────────
  Widget _buildPrioridadDropdown(double width) {
    return _LabeledField( // Widget auxiliar que agrega label
      label: 'Prioridad', // Label del dropdown
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // Campo del dropdown (siempre visible)
          GestureDetector(
            onTap: () => setState(() => _prioridadExpanded = !_prioridadExpanded),
            child: AnimatedContainer( // AnimatedContainer para transición suave
              duration: const Duration(milliseconds: 200), // Duración de la animación
              height: 48,
              decoration: RecomendacionesStyles.inputDecoration(focused: _prioridadExpanded), // Glow si está expandido
              padding: const EdgeInsets.symmetric(horizontal: 14),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Expanded(
                    child: Text(
                      _filtroPrioridad.label,
                      style: const TextStyle(
                        color: RecomendacionesStyles.darkGreen,
                        fontSize: 14,
                        fontFamily: 'Arial',
                      ),
                      overflow: TextOverflow.ellipsis,
                    ),
                  ),
                  FaIcon(
                    _prioridadExpanded ? FontAwesomeIcons.chevronUp : FontAwesomeIcons.chevronDown,
                    color: RecomendacionesStyles.primaryGreen,
                    size: 14,
                  ),
                ],
              ),
            ),
          ),
          
          // Lista de opciones expandible
          AnimatedContainer(
            duration: const Duration(milliseconds: 200),
            height: _prioridadExpanded ? (FiltroPrioridad.values.length * 48.0).clamp(0, 240) : 0,
            child: _prioridadExpanded
                ? Container(
                    margin: const EdgeInsets.only(top: 4),
                    decoration: BoxDecoration(
                      color: RecomendacionesStyles.backgroundWhite,
                      border: Border.all(color: RecomendacionesStyles.borderInput),
                      borderRadius: BorderRadius.circular(8),
                    ),
                    child: ClipRRect(
                      borderRadius: BorderRadius.circular(8),
                      child: Material(
                        color: Colors.transparent,
                        child: ListView.builder(
                          padding: EdgeInsets.zero,
                          itemCount: FiltroPrioridad.values.length,
                          itemBuilder: (context, index) {
                            final prioridad = FiltroPrioridad.values[index];
                            final isSelected = prioridad == _filtroPrioridad;
                            
                            return InkWell(
                              onTap: () {
                                setState(() {
                                  _filtroPrioridad = prioridad;
                                  _prioridadExpanded = false;
                                  _aplicarFiltros();
                                });
                              },
                              hoverColor: RecomendacionesStyles.backgroundInput,
                              splashColor: RecomendacionesStyles.primaryGreen.withValues(alpha: 0.1),
                              highlightColor: RecomendacionesStyles.backgroundInput,
                              child: Container(
                                height: 48,
                                padding: const EdgeInsets.symmetric(horizontal: 14),
                                alignment: Alignment.centerLeft,
                                decoration: BoxDecoration(
                                  color: isSelected 
                                      ? const Color(0xFFE8EDE6)
                                      : Colors.transparent,
                                ),
                                child: Text(
                                  prioridad.label,
                                  style: const TextStyle(
                                    color: RecomendacionesStyles.textGreen,
                                    fontSize: 14,
                                    fontFamily: 'Arial',
                                  ),
                                ),
                              ),
                            );
                          },
                        ),
                      ),
                    ),
                  )
                : null,
          ),
        ],
      ),
    );
  }

  // ─── Lista de recomendaciones registradas ─────────────────────────────────
  Widget _buildListaRecomendaciones(bool isMobile) {
    return Container( // Contenedor de la sección
      padding: const EdgeInsets.all(18), // Padding interno
      decoration: RecomendacionesStyles.sectionDecoration, // Estilo del contenedor (borde, fondo)
      child: Column( // Apila título y lista verticalmente
        crossAxisAlignment: CrossAxisAlignment.stretch, // Widgets ocupan ancho completo
        children: [
          // ── Título de la sección con contador ──
          Text(
            'Recomendaciones registradas (${_vistaPrevia.length})', // Muestra cantidad de recomendaciones filtradas
            style: RecomendacionesStyles.sectionTitle, // Estilo del título
          ),
          const SizedBox(height: 14), // Espaciado vertical
          
          // ── Caso: No hay recomendaciones ──
          if (_vistaPrevia.isEmpty) // Si lista filtrada está vacía
            const Text(
              'No hay recomendaciones con los filtros actuales.', // Mensaje de estado vacío
              style: RecomendacionesStyles.emptyText, // Estilo del texto
            )
          // ── Caso: Hay recomendaciones para mostrar ──
          else
            Column( // Apila tarjetas de recomendaciones verticalmente
              children: _vistaPrevia
                  .asMap() // Convierte lista a mapa con índices
                  .entries // Obtiene pares (índice, recomendación)
                  .map((e) => Padding( // Agrega padding entre tarjetas
                        padding: EdgeInsets.only(
                            bottom: e.key < _vistaPrevia.length - 1 ? 10 : 0), // Padding inferior excepto última tarjeta
                        child: _buildRecCard(e.value, isMobile), // Construye tarjeta de recomendación
                      ))
                  .toList(), // Convierte a lista de widgets
            ),
        ],
      ),
    );
  }

  // ─── Tarjeta individual de recomendación ──────────────────────────────────
  Widget _buildRecCard(RecomendacionRegistrada rec, bool isMobile) {
    // ── Obtiene colores y estilos según prioridad y color de la recomendación ──
    final bg     = RecomendacionesStyles.cardBg(rec.color); // Color de fondo de la tarjeta
    final border = RecomendacionesStyles.cardBorder(rec.color); // Color del borde de la tarjeta
    final priBg  = RecomendacionesStyles.prioridadBg(rec.prioridad); // Color de fondo del badge de prioridad
    final priTxt = RecomendacionesStyles.prioridadText(rec.prioridad); // Color del texto del badge
    final icono  = RecomendacionesStyles.prioridadIcon(rec.color); // Icono según prioridad

    // ═══ SECCIÓN: Cuerpo de la tarjeta (badge, título, descripción, acción) ═══
    final body = Column( // Apila elementos verticalmente
      crossAxisAlignment: CrossAxisAlignment.start, // Alinea a la izquierda
      children: [
        // ── Badge de prioridad (icono + texto) ──
        Container(
          padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 3), // Padding interno del badge
          decoration: BoxDecoration(color: priBg, borderRadius: BorderRadius.circular(99)), // Fondo redondeado (píldora)
          child: Row( // Fila con icono y texto
            mainAxisSize: MainAxisSize.min, // Tamaño mínimo necesario
            children: [
              FaIcon(icono, size: 11, color: priTxt), // Icono de prioridad
              const SizedBox(width: 4), // Espaciado entre icono y texto
              Text(
                rec.prioridad.label.toUpperCase(), // Texto de prioridad en mayúsculas
                style: RecomendacionesStyles.badgeText.copyWith(color: priTxt), // Estilo con color personalizado
              ),
            ],
          ),
        ),
        const SizedBox(height: 6), // Espaciado vertical
        
        // ── Título de la recomendación ──
        Text(rec.titulo, style: RecomendacionesStyles.cardTitle), // Título en negritas
        const SizedBox(height: 4), // Espaciado vertical
        
        // ── Descripción de la recomendación ──
        Text(rec.descripcion, style: RecomendacionesStyles.cardDesc), // Descripción en texto normal
        
        // ── Acción recomendada (solo si existe) ──
        if (rec.accion.isNotEmpty) ...[ // Solo muestra si hay acción definida
          const SizedBox(height: 10), // Espaciado vertical
          Container( // Contenedor con borde superior
            padding: const EdgeInsets.only(top: 10), // Padding superior
            decoration: const BoxDecoration( // Decoración con línea divisoria superior
              border: Border(
                top: BorderSide(color: Color.fromRGBO(7, 61, 43, 0.1)), // Línea gris claro
              ),
            ),
            child: Column( // Apila label y texto de acción
              crossAxisAlignment: CrossAxisAlignment.start, // Alinea a la izquierda
              children: [
                const Text('ACCIÓN RECOMENDADA:', style: RecomendacionesStyles.accionLabel), // Label en mayúsculas
                const SizedBox(height: 4), // Espaciado vertical
                Text(rec.accion, style: RecomendacionesStyles.accionText), // Texto de la acción
              ],
            ),
          ),
        ],
      ],
    );

    // ═══ SECCIÓN: Botones de acciones (editar, visualizar, eliminar) ═══
    final acciones = isMobile
        ? Row( // Móvil: botones en fila horizontal
            children: [
              // Botón: Editar
              _buildIconBtn(FontAwesomeIcons.pen, onTap: () => setState(() {
                _seleccionada = rec; // Selecciona recomendación
                _mostrarEditar = true; // Activa modal de edición
              })),
              const SizedBox(width: 8), // Espaciado horizontal
              // Botón: Visualizar
              _buildIconBtn(FontAwesomeIcons.eye, onTap: () => setState(() {
                _seleccionada = rec; // Selecciona recomendación
                _mostrarVisualizar = true; // Activa modal de visualización
              })),
              const SizedBox(width: 8), // Espaciado horizontal
              // Botón: Eliminar (estilo de peligro)
              _buildIconBtn(FontAwesomeIcons.trash, danger: true, onTap: () => setState(() {
                _seleccionada = rec; // Selecciona recomendación
                _mostrarEliminar = true; // Activa modal de eliminación
              })),
            ],
          )
        : Column( // Desktop: botones en columna vertical
            children: [
              // Botón: Editar
              _buildIconBtn(FontAwesomeIcons.pen, onTap: () => setState(() {
                _seleccionada = rec; // Selecciona recomendación
                _mostrarEditar = true; // Activa modal de edición
              })),
              const SizedBox(height: 8), // Espaciado vertical
              // Botón: Visualizar
              _buildIconBtn(FontAwesomeIcons.eye, onTap: () => setState(() {
                _seleccionada = rec; // Selecciona recomendación
                _mostrarVisualizar = true; // Activa modal de visualización
              })),
              const SizedBox(height: 8), // Espaciado vertical
              // Botón: Eliminar (estilo de peligro)
              _buildIconBtn(FontAwesomeIcons.trash, danger: true, onTap: () => setState(() {
                _seleccionada = rec; // Selecciona recomendación
                _mostrarEliminar = true; // Activa modal de eliminación
              })),
            ],
          );

    // ═══ LAYOUT: Móvil (columna) ═══
    if (isMobile) {
      return Container( // Contenedor de la tarjeta
        padding: const EdgeInsets.all(14), // Padding interno
        decoration: BoxDecoration( // Estilo de la tarjeta
          color: bg, // Color de fondo
          border: Border.all(color: border), // Borde
          borderRadius: BorderRadius.circular(8), // Esquinas redondeadas
        ),
        child: Column( // Apila cuerpo y acciones verticalmente
          crossAxisAlignment: CrossAxisAlignment.stretch, // Widgets ocupan ancho completo
          children: [body, const SizedBox(height: 12), acciones], // Cuerpo + espaciado + acciones
        ),
      );
    }

    // ═══ LAYOUT: Desktop (fila) ===
    return Container( // Contenedor de la tarjeta
      padding: const EdgeInsets.all(14), // Padding interno
      decoration: BoxDecoration( // Estilo de la tarjeta
        color: bg, // Color de fondo
        border: Border.all(color: border), // Borde
        borderRadius: BorderRadius.circular(8), // Esquinas redondeadas
      ),
      child: Row( // Dispone cuerpo y acciones horizontalmente
        crossAxisAlignment: CrossAxisAlignment.start, // Alinea al inicio (arriba)
        children: [
          Expanded(child: body), // Cuerpo toma espacio disponible
          const SizedBox(width: 16), // Espaciado horizontal
          acciones, // Botones de acciones a la derecha
        ],
      ),
    );
  }

  // ─── Botón de icono (editar, visualizar, eliminar) ────────────────────────
  Widget _buildIconBtn(FaIconData icon,
      {bool danger = false, required VoidCallback onTap}) { // danger=true para botón rojo (eliminar)
    return GestureDetector( // Detector de gestos
      onTap: onTap, // Ejecuta callback al tocar
      child: Container( // Contenedor del botón
        width: 36, // Ancho fijo del botón
        height: 36, // Altura fija del botón (cuadrado)
        decoration: RecomendacionesStyles.iconBtnDecoration(danger: danger), // Estilo: normal o peligro
        child: Center( // Centra icono
          child: FaIcon(
            icon, // Icono de FontAwesome
            size: 16, // Tamaño del icono
            color: danger
                ? RecomendacionesStyles.dangerText // Color rojo si es peligro
                : RecomendacionesStyles.darkGreen, // Color verde oscuro si es normal
          ),
        ),
      ),
    );
  }

  // ═══════════════════════════════════════════════════════════════════════════
  // MÉTODO: Modal Overlay - Renderiza el modal activo con fondo oscuro
  // ═══════════════════════════════════════════════════════════════════════════
  Widget _buildModalOverlay() {
    // ── CASO 1: Modal de confirmación de eliminación ──
    if (_mostrarEliminar && _seleccionada != null) { // Si modal de eliminar está activo
      return EliminarRecomendacion( // Renderiza modal de confirmación de eliminación
        recomendacion: _seleccionada!, // Recomendación a eliminar
        onCerrar: _cerrarTodosModales, // Callback para cancelar
        onConfirmar: _confirmarEliminacion, // Callback para confirmar eliminación
      );
    }
    
    // ── CASO 2: Modal de visualización (solo lectura) ──
    if (_mostrarVisualizar && _seleccionada != null) { // Si modal de visualizar está activo
      return VisualizarRecomendacion( // Renderiza modal de visualización
        recomendacion: _seleccionada!, // Recomendación a visualizar
        onCerrar: _cerrarTodosModales, // Callback para cerrar modal
      );
    }
    
    // ── CASO 3: Modal de edición ──
    if (_mostrarEditar && _seleccionada != null) { // Si modal de editar está activo
      return EditarRecomendacion( // Renderiza modal de edición
        recomendacion: _seleccionada!, // Recomendación a editar
        onCerrar: _cerrarTodosModales, // Callback para cerrar modal
        onGuardar: _guardarEdicion, // Callback para guardar cambios
      );
    }
    
    // ── CASO 4: Modal de registro de nueva recomendación ──
    if (_mostrarRegistrar) { // Si modal de registrar está activo
      return RegistrarRecomendacion( // Renderiza modal de registro
        onCerrar: _cerrarTodosModales, // Callback para cerrar modal
        onGuardar: _guardarRegistro, // Callback para guardar nueva recomendación
      );
    }
    
    // ── CASO 5: No hay modal activo (no debería llegar aquí) ──
    return const SizedBox.shrink(); // Retorna widget vacío sin tamaño
  }
}

// ═══════════════════════════════════════════════════════════════════════════
// WIDGETS AUXILIARES - Componentes reutilizables
// ═══════════════════════════════════════════════════════════════════════════

// ─── Widget: Campo con label ───────────────────────────────────────────────
// Envuelve un campo (input/dropdown) agregando un label arriba
class _LabeledField extends StatelessWidget {
  final String label; // Texto del label
  final Widget child; // Widget del campo (input, dropdown, etc.)
  
  const _LabeledField({required this.label, required this.child}); // Constructor

  @override
  Widget build(BuildContext context) {
    return Column( // Apila label y campo verticalmente
      crossAxisAlignment: CrossAxisAlignment.start, // Alinea a la izquierda
      children: [
        Text(label, style: RecomendacionesStyles.labelText), // Label del campo
        const SizedBox(height: 8), // Espaciado vertical
        child, // Campo (input, dropdown, etc.)
      ],
    );
  }
}

// ═══════════════════════════════════════════════════════════════════════════
// Widget: Caja de búsqueda - Campo de texto con icono y botón de limpiar
// ═══════════════════════════════════════════════════════════════════════════
class _SearchBox extends StatefulWidget {
  final String placeholder; // Texto placeholder del input
  final ValueChanged<String> onChanged; // Callback cuando cambia el texto
  
  const _SearchBox({required this.placeholder, required this.onChanged}); // Constructor

  @override
  State<_SearchBox> createState() => _SearchBoxState(); // Crea el estado
}

// ─── Estado del widget _SearchBox ──────────────────────────────────────────
class _SearchBoxState extends State<_SearchBox> {
  final _ctrl  = TextEditingController(); // Controlador del TextField (gestiona texto)
  final _focus = FocusNode(); // Nodo de foco (detecta si input tiene foco)
  bool _focused = false; // Variable de estado: indica si input está enfocado

  // ═══ INICIALIZACIÓN ═══
  @override
  void initState() {
    super.initState(); // Llama al initState del padre
    // Escucha cambios de foco y actualiza estado cuando cambia
    _focus.addListener(() => setState(() => _focused = _focus.hasFocus)); // Cuando cambia foco, actualiza _focused
    // Escucha cambios en el texto para reconstruir widget (necesario para botón de limpiar)
    _ctrl.addListener(() => setState(() {})); // Reconstruye cuando cambia el texto
  }

  // ═══ LIMPIEZA ═══
  @override
  void dispose() {
    _ctrl.dispose(); // Libera recursos del controlador
    _focus.dispose(); // Libera recursos del nodo de foco
    super.dispose(); // Llama al dispose del padre
  }

  // ═══ BUILD ═══
  @override
  Widget build(BuildContext context) {
    return Focus( // Envuelve en Focus para detectar cambios de foco
      onFocusChange: (focus) => setState(() => _focused = focus), // Actualiza estado cuando cambia foco
      child: AnimatedContainer( // AnimatedContainer para transición suave
        duration: const Duration(milliseconds: 200), // Duración de la animación
        height: 48, // Altura fija del campo
        decoration: RecomendacionesStyles.inputDecoration(focused: _focused), // Estilo del input (cambia si está enfocado)
        child: Row( // Fila con icono, campo de texto y botón de limpiar
          children: [
            const SizedBox(width: 14), // Espaciado izquierdo
            const FaIcon(FontAwesomeIcons.magnifyingGlass, // Icono de lupa (búsqueda)
                color: RecomendacionesStyles.primaryGreen, size: 20), // Color verde, tamaño 20px
            const SizedBox(width: 10), // Espaciado entre icono y campo
            
            // ── Campo de texto ──
            Expanded( // Toma espacio disponible
              child: TextField( // Widget de campo de texto
                controller: _ctrl, // Controlador de texto
                focusNode: _focus, // Nodo de foco
                decoration: InputDecoration( // Decoración del TextField
                  hintText: widget.placeholder, // Texto placeholder
                  hintStyle: const TextStyle( // Estilo del placeholder
                      color: Color(0xFF6B8177), fontSize: 14), // Color gris, tamaño 14px
                  border: InputBorder.none, // Sin borde (contenedor ya tiene borde)
                  isDense: true, // Reduce espaciado vertical interno
                  contentPadding:
                      const EdgeInsets.symmetric(vertical: 12), // Padding vertical interno
                ),
                style: const TextStyle( // Estilo del texto ingresado
                    color: RecomendacionesStyles.darkGreen, fontSize: 14), // Color verde oscuro, tamaño 14px
                onChanged: widget.onChanged, // Callback cuando cambia el texto
              ),
            ),
            
            // ── Botón de limpiar (solo visible si hay texto) ──
            if (_ctrl.text.isNotEmpty) // Solo muestra si hay texto en el campo
              GestureDetector( // Detector de gestos
                onTap: () { // Al tocar
                  _ctrl.clear(); // Limpia el texto del controlador
                  widget.onChanged(''); // Notifica cambio a vacío al callback
                },
                child: const Padding( // Padding del icono
                  padding: EdgeInsets.symmetric(horizontal: 10), // Padding horizontal
                  child: FaIcon(FontAwesomeIcons.xmark, // Icono X
                      color: Color(0xFF6B8177), size: 18), // Color gris, tamaño 18px
                ),
              ),
          ],
        ),
      ),
    );
  }
}


