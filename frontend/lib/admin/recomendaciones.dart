import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import '../styles/admin-styles/recomendaciones.dart';
import '../navbars/barra-admin.dart';
import '../styles/navbars-styles/barra-admin.dart';
import '../environments/modales-recomendacion.dart';
import 'modalesRecomendacion/eliminar-recomendacion.dart';
import 'modalesRecomendacion/visualizar-recomendacion.dart';
import 'modalesRecomendacion/editar-recomendacion.dart';
import 'modalesRecomendacion/registrar-recomendacion.dart';

// ─── Enum filtro prioridad ────────────────────────────────────────────────────

enum FiltroPrioridad { todas, baja, media, alta, critica }

extension FiltroPrioridadLabel on FiltroPrioridad {
  String get label {
    switch (this) {
      case FiltroPrioridad.todas:   return 'Todas';
      case FiltroPrioridad.baja:    return 'Baja';
      case FiltroPrioridad.media:   return 'Media';
      case FiltroPrioridad.alta:    return 'Alta';
      case FiltroPrioridad.critica: return 'Critica';
    }
  }
}

// ─── Widget principal ─────────────────────────────────────────────────────────

class Recomendaciones extends StatefulWidget {
  const Recomendaciones({super.key});

  @override
  State<Recomendaciones> createState() => _RecomendacionesState();
}

class _RecomendacionesState extends State<Recomendaciones> {
  // ── Estado de filtros ──────────────────────────────────────────────────────
  String _busqueda = '';
  FiltroPrioridad _filtroPrioridad = FiltroPrioridad.todas;

  // ── Datos ──────────────────────────────────────────────────────────────────
  List<RecomendacionRegistrada> _lista = [];
  List<RecomendacionRegistrada> _vistaPrevia = [];

  // ── Modal ──────────────────────────────────────────────────────────────────
  bool _mostrarRegistrar   = false;
  bool _mostrarEditar      = false;
  bool _mostrarVisualizar  = false;
  bool _mostrarEliminar    = false;
  RecomendacionRegistrada? _seleccionada;

  @override
  void initState() {
    super.initState();
    _refrescar();
  }

  // ── Lógica ─────────────────────────────────────────────────────────────────

  void _refrescar() {
    _lista = RecomendacionesStore.obtenerTodas();
    _aplicarFiltros();
  }

  void _aplicarFiltros() {
    final termino = _normalizar(_busqueda);
    setState(() {
      _vistaPrevia = _lista.where((r) {
        final coincideBusqueda = termino.isEmpty ||
            _normalizar(r.titulo).contains(termino) ||
            _normalizar(r.descripcion).contains(termino);
        final coincidePrioridad = _filtroPrioridad == FiltroPrioridad.todas ||
            r.prioridad.label.toLowerCase() == _filtroPrioridad.label.toLowerCase();
        return coincideBusqueda && coincidePrioridad;
      }).toList();
    });
  }

  String _normalizar(String v) => v
      .toLowerCase()
      .replaceAll(RegExp(r'[áàäâ]'), 'a')
      .replaceAll(RegExp(r'[éèëê]'), 'e')
      .replaceAll(RegExp(r'[íìïî]'), 'i')
      .replaceAll(RegExp(r'[óòöô]'), 'o')
      .replaceAll(RegExp(r'[úùüû]'), 'u')
      .trim();

  // ── Acciones modal ─────────────────────────────────────────────────────────

  void _cerrarTodosModales() => setState(() {
    _mostrarRegistrar  = false;
    _mostrarEditar     = false;
    _mostrarVisualizar = false;
    _mostrarEliminar   = false;
    _seleccionada      = null;
  });

  void _guardarRegistro(DatosRecomendacionForm datos) {
    RecomendacionesStore.agregar(datos);
    setState(() => _mostrarRegistrar = false);
    _refrescar();
  }

  void _guardarEdicion(DatosRecomendacionForm datos) {
    if (_seleccionada == null) return;
    RecomendacionesStore.actualizar(_seleccionada!.id, datos);
    setState(() { _mostrarEditar = false; _seleccionada = null; });
    _refrescar();
  }

  void _confirmarEliminacion() {
    if (_seleccionada == null) return;
    RecomendacionesStore.eliminar(_seleccionada!.id);
    setState(() { _mostrarEliminar = false; _seleccionada = null; });
    _refrescar();
  }

  // ─────────────────────────────────────────────────────────────────────────
  // BUILD
  // ─────────────────────────────────────────────────────────────────────────

  @override
  Widget build(BuildContext context) {
    final isMobile = MediaQuery.of(context).size.width < 768;
    final screenWidth = MediaQuery.of(context).size.width;

    return Scaffold(
      backgroundColor: RecomendacionesStyles.backgroundPage,
      body: Stack(
        children: [
          // Contenido con padding superior
          Positioned.fill(
            child: Column(
              children: [
                // Espacio para la barra
                SizedBox(
                  height: screenWidth > 991
                      ? BarraAdminStyles.navbarHeight +
                          BarraAdminStyles.contentPaddingTop +
                          (BarraAdminStyles.navbarPaddingVertical * 2)
                      : BarraAdminStyles.navbarHeight +
                          BarraAdminStyles.contentPaddingTop +
                          (BarraAdminStyles.navbarPaddingVertical * 2),
                ),
                // Contenido scrolleable
                Expanded(
                  child: Stack(
                    children: [
                      SingleChildScrollView(
                        padding: EdgeInsets.all(isMobile ? 16 : 32),
                        child: Center(
                          child: ConstrainedBox(
                            constraints: const BoxConstraints(maxWidth: 1220),
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.stretch,
                              children: [
                                _buildHeader(isMobile),
                                const SizedBox(height: 18),
                                _buildFiltersBar(isMobile),
                                const SizedBox(height: 18),
                                _buildListaRecomendaciones(isMobile),
                                const SizedBox(height: 32),
                              ],
                            ),
                          ),
                        ),
                      ),
                      // ── Modales overlay ──────────────────────────────────────────
                      if (_mostrarRegistrar || _mostrarEditar ||
                          _mostrarVisualizar || _mostrarEliminar)
                        _buildModalOverlay(),
                    ],
                  ),
                ),
              ],
            ),
          ),
          // Barra fija en la parte superior
          Positioned(
            top: 0,
            left: 0,
            right: 0,
            child: const BarraAdmin(),
          ),
        ],
      ),
    );
  }

  // ─── Header ───────────────────────────────────────────────────────────────

  Widget _buildHeader(bool isMobile) {
    final textos = Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: const [
        Text('ADMINISTRACIÓN', style: RecomendacionesStyles.eyebrowText),
        SizedBox(height: 8),
        Text('Recomendaciones de acción', style: RecomendacionesStyles.h1Text),
        SizedBox(height: 10),
        Text(
          'Registre y administre las recomendaciones que verá el agricultor en su panel.',
          style: RecomendacionesStyles.headerDesc,
        ),
      ],
    );

    final boton = GestureDetector(
      onTap: () => setState(() => _mostrarRegistrar = true),
      child: Container(
        decoration: RecomendacionesStyles.createBtnDecoration,
        padding: const EdgeInsets.symmetric(horizontal: 18),
        constraints: const BoxConstraints(minHeight: 46),
        child: const Row(
          mainAxisSize: MainAxisSize.min,
          children: [
            FaIcon(FontAwesomeIcons.plus, color: Colors.white, size: 18),
            SizedBox(width: 8),
            Text(
              'Registrar recomendación',
              style: TextStyle(color: Colors.white, fontSize: 15, fontWeight: FontWeight.w800),
            ),
          ],
        ),
      ),
    );

    if (isMobile) {
      return Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [textos, const SizedBox(height: 14), boton],
      );
    }
    return Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Expanded(child: textos),
        const SizedBox(width: 20),
        boton,
      ],
    );
  }

  // ─── Barra de filtros ─────────────────────────────────────────────────────

  Widget _buildFiltersBar(bool isMobile) {
    return Container(
      padding: const EdgeInsets.all(18),
      decoration: RecomendacionesStyles.filterBarDecoration,
      child: isMobile
          ? Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                _buildSearchField(),
                const SizedBox(height: 14),
                _buildPrioridadDropdown(double.infinity),
              ],
            )
          : Row(
              crossAxisAlignment: CrossAxisAlignment.end,
              children: [
                Expanded(flex: 14, child: _buildSearchField()),
                const SizedBox(width: 14),
                Expanded(flex: 8, child: _buildPrioridadDropdown(double.infinity)),
              ],
            ),
    );
  }

  Widget _buildSearchField() {
    return _LabeledField(
      label: 'Buscar recomendación',
      child: _SearchBox(
        placeholder: 'Título o descripción',
        onChanged: (v) {
          _busqueda = v;
          _aplicarFiltros();
        },
      ),
    );
  }

  Widget _buildPrioridadDropdown(double width) {
    return _LabeledField(
      label: 'Prioridad',
      child: Container(
        height: 48,
        decoration: RecomendacionesStyles.inputDecoration(),
        padding: const EdgeInsets.symmetric(horizontal: 14),
        child: DropdownButtonHideUnderline(
          child: DropdownButton<FiltroPrioridad>(
            value: _filtroPrioridad,
            isExpanded: true,
            icon: const FaIcon(FontAwesomeIcons.chevronDown,
                color: RecomendacionesStyles.primaryGreen),
            style: const TextStyle(
                color: RecomendacionesStyles.darkGreen,
                fontSize: 14,
                fontFamily: 'Arial'),
            items: FiltroPrioridad.values
                .map((p) => DropdownMenuItem(
                      value: p,
                      child: Text(p.label),
                    ))
                .toList(),
            onChanged: (v) {
              _filtroPrioridad = v!;
              _aplicarFiltros();
            },
          ),
        ),
      ),
    );
  }

  // ─── Lista de recomendaciones ─────────────────────────────────────────────

  Widget _buildListaRecomendaciones(bool isMobile) {
    return Container(
      padding: const EdgeInsets.all(18),
      decoration: RecomendacionesStyles.sectionDecoration,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          Text(
            'Recomendaciones registradas (${_vistaPrevia.length})',
            style: RecomendacionesStyles.sectionTitle,
          ),
          const SizedBox(height: 14),
          if (_vistaPrevia.isEmpty)
            const Text(
              'No hay recomendaciones con los filtros actuales.',
              style: RecomendacionesStyles.emptyText,
            )
          else
            Column(
              children: _vistaPrevia
                  .asMap()
                  .entries
                  .map((e) => Padding(
                        padding: EdgeInsets.only(
                            bottom: e.key < _vistaPrevia.length - 1 ? 10 : 0),
                        child: _buildRecCard(e.value, isMobile),
                      ))
                  .toList(),
            ),
        ],
      ),
    );
  }

  Widget _buildRecCard(RecomendacionRegistrada rec, bool isMobile) {
    final bg     = RecomendacionesStyles.cardBg(rec.color);
    final border = RecomendacionesStyles.cardBorder(rec.color);
    final priBg  = RecomendacionesStyles.prioridadBg(rec.prioridad);
    final priTxt = RecomendacionesStyles.prioridadText(rec.prioridad);
    final icono  = RecomendacionesStyles.prioridadIcon(rec.color);

    final body = Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        // Badge prioridad
        Container(
          padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 3),
          decoration: BoxDecoration(color: priBg, borderRadius: BorderRadius.circular(99)),
          child: Row(
            mainAxisSize: MainAxisSize.min,
            children: [
              FaIcon(icono, size: 11, color: priTxt),
              const SizedBox(width: 4),
              Text(
                rec.prioridad.label.toUpperCase(),
                style: RecomendacionesStyles.badgeText.copyWith(color: priTxt),
              ),
            ],
          ),
        ),
        const SizedBox(height: 6),
        Text(rec.titulo, style: RecomendacionesStyles.cardTitle),
        const SizedBox(height: 4),
        Text(rec.descripcion, style: RecomendacionesStyles.cardDesc),
        if (rec.accion.isNotEmpty) ...[
          const SizedBox(height: 10),
          Container(
            padding: const EdgeInsets.only(top: 10),
            decoration: const BoxDecoration(
              border: Border(
                top: BorderSide(color: Color.fromRGBO(7, 61, 43, 0.1)),
              ),
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const Text('ACCIÓN RECOMENDADA:', style: RecomendacionesStyles.accionLabel),
                const SizedBox(height: 4),
                Text(rec.accion, style: RecomendacionesStyles.accionText),
              ],
            ),
          ),
        ],
      ],
    );

    final acciones = isMobile
        ? Row(
            children: [
              _buildIconBtn(FontAwesomeIcons.pen, onTap: () => setState(() {
                _seleccionada = rec; _mostrarEditar = true;
              })),
              const SizedBox(width: 8),
              _buildIconBtn(FontAwesomeIcons.eye, onTap: () => setState(() {
                _seleccionada = rec; _mostrarVisualizar = true;
              })),
              const SizedBox(width: 8),
              _buildIconBtn(FontAwesomeIcons.trash, danger: true, onTap: () => setState(() {
                _seleccionada = rec; _mostrarEliminar = true;
              })),
            ],
          )
        : Column(
            children: [
              _buildIconBtn(FontAwesomeIcons.pen, onTap: () => setState(() {
                _seleccionada = rec; _mostrarEditar = true;
              })),
              const SizedBox(height: 8),
              _buildIconBtn(FontAwesomeIcons.eye, onTap: () => setState(() {
                _seleccionada = rec; _mostrarVisualizar = true;
              })),
              const SizedBox(height: 8),
              _buildIconBtn(FontAwesomeIcons.trash, danger: true, onTap: () => setState(() {
                _seleccionada = rec; _mostrarEliminar = true;
              })),
            ],
          );

    if (isMobile) {
      return Container(
        padding: const EdgeInsets.all(14),
        decoration: BoxDecoration(
          color: bg,
          border: Border.all(color: border),
          borderRadius: BorderRadius.circular(8),
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [body, const SizedBox(height: 12), acciones],
        ),
      );
    }

    return Container(
      padding: const EdgeInsets.all(14),
      decoration: BoxDecoration(
        color: bg,
        border: Border.all(color: border),
        borderRadius: BorderRadius.circular(8),
      ),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Expanded(child: body),
          const SizedBox(width: 16),
          acciones,
        ],
      ),
    );
  }

  Widget _buildIconBtn(FaIconData icon,
      {bool danger = false, required VoidCallback onTap}) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        width: 36,
        height: 36,
        decoration: RecomendacionesStyles.iconBtnDecoration(danger: danger),
        child: Center(
          child: FaIcon(
            icon,
            size: 16,
            color: danger
                ? RecomendacionesStyles.dangerText
                : RecomendacionesStyles.darkGreen,
          ),
        ),
      ),
    );
  }

  // ─── Modal overlay ────────────────────────────────────────────────────────

  Widget _buildModalOverlay() {
    if (_mostrarEliminar && _seleccionada != null) {
      return EliminarRecomendacion(
        recomendacion: _seleccionada!,
        onCerrar: _cerrarTodosModales,
        onConfirmar: _confirmarEliminacion,
      );
    }
    if (_mostrarVisualizar && _seleccionada != null) {
      return VisualizarRecomendacion(
        recomendacion: _seleccionada!,
        onCerrar: _cerrarTodosModales,
      );
    }
    if (_mostrarEditar && _seleccionada != null) {
      return EditarRecomendacion(
        recomendacion: _seleccionada!,
        onCerrar: _cerrarTodosModales,
        onGuardar: _guardarEdicion,
      );
    }
    if (_mostrarRegistrar) {
      return RegistrarRecomendacion(
        onCerrar: _cerrarTodosModales,
        onGuardar: _guardarRegistro,
      );
    }
    return const SizedBox.shrink();
  }
}

// ─────────────────────────────────────────────────────────────────────────────
// WIDGETS AUXILIARES
// ─────────────────────────────────────────────────────────────────────────────



// ── Campo con label ───────────────────────────────────────────────────────────

class _LabeledField extends StatelessWidget {
  final String label;
  final Widget child;
  const _LabeledField({required this.label, required this.child});

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(label, style: RecomendacionesStyles.labelText),
        const SizedBox(height: 8),
        child,
      ],
    );
  }
}

// ── Caja de búsqueda ──────────────────────────────────────────────────────────

class _SearchBox extends StatefulWidget {
  final String placeholder;
  final ValueChanged<String> onChanged;
  const _SearchBox({required this.placeholder, required this.onChanged});

  @override
  State<_SearchBox> createState() => _SearchBoxState();
}

class _SearchBoxState extends State<_SearchBox> {
  final _ctrl  = TextEditingController();
  final _focus = FocusNode();
  bool _focused = false;

  @override
  void initState() {
    super.initState();
    _focus.addListener(() => setState(() => _focused = _focus.hasFocus));
  }

  @override
  void dispose() {
    _ctrl.dispose();
    _focus.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 48,
      decoration: RecomendacionesStyles.inputDecoration(focused: _focused),
      child: Row(
        children: [
          const SizedBox(width: 14),
          const FaIcon(FontAwesomeIcons.magnifyingGlass,
              color: RecomendacionesStyles.primaryGreen, size: 20),
          const SizedBox(width: 10),
          Expanded(
            child: TextField(
              controller: _ctrl,
              focusNode: _focus,
              decoration: InputDecoration(
                hintText: widget.placeholder,
                hintStyle: const TextStyle(
                    color: Color(0xFF6B8177), fontSize: 14),
                border: InputBorder.none,
                isDense: true,
                contentPadding:
                    const EdgeInsets.symmetric(vertical: 12),
              ),
              style: const TextStyle(
                  color: RecomendacionesStyles.darkGreen, fontSize: 14),
              onChanged: widget.onChanged,
            ),
          ),
          if (_ctrl.text.isNotEmpty)
            GestureDetector(
              onTap: () {
                _ctrl.clear();
                widget.onChanged('');
              },
              child: const Padding(
                padding: EdgeInsets.symmetric(horizontal: 10),
                child: FaIcon(FontAwesomeIcons.xmark,
                    color: Color(0xFF6B8177), size: 18),
              ),
            ),
        ],
      ),
    );
  }
}


