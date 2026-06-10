import 'package:flutter/material.dart';
import '../styles/admin-styles/panel-admin.dart';
import '../navbars/barra-admin.dart';
import '../environments/datos-simulados-admin.dart';
import 'modalesUsuario/registro-usuario.dart';
import 'modalesUsuario/editar-usuario.dart';
import 'modalesUsuario/eliminar-usuario.dart';
import 'modalesUsuario/perfil-usuario.dart';

enum FiltroRol { todos, admin, agricultor }
enum FiltroEstado { todos, activo, inactivo, enLinea, sinSesion }
enum FiltroDispositivo { todos, vinculado, noVinculado }
enum OrdenAlfabetico { az, za }
enum ModalModo { registro, editar, perfil }

// ─── Widget principal ─────────────────────────────────────────────────────────

class PanelAdmin extends StatefulWidget {
  const PanelAdmin({super.key});

  @override
  State<PanelAdmin> createState() => _PanelAdminState();
}

class _PanelAdminState extends State<PanelAdmin> {
  // ── Filtros ────────────────────────────────────────────────────────────────
  String _busqueda = '';
  FiltroRol _filtroRol = FiltroRol.todos;
  FiltroEstado _filtroEstado = FiltroEstado.todos;
  FiltroDispositivo _filtroDispositivo = FiltroDispositivo.todos;
  DateTime? _fechaInicio;
  DateTime? _fechaFin;
  OrdenAlfabetico _orden = OrdenAlfabetico.az;

  // ── Modal ──────────────────────────────────────────────────────────────────
  ModalModo? _modalModo;
  UsuarioAdmin? _usuarioSeleccionado;
  UsuarioAdmin? _usuarioParaEliminar;

  // ── Datos ──────────────────────────────────────────────────────────────────
  late List<UsuarioAdmin> _usuarios;

  @override
  void initState() {
    super.initState();
    _usuarios = List.from(datosSimuladosAdmin);
  }

  // ── Computed ───────────────────────────────────────────────────────────────

  String _normalizar(String v) => v
      .toLowerCase()
      .replaceAll(RegExp(r'[áàäâ]'), 'a')
      .replaceAll(RegExp(r'[éèëê]'), 'e')
      .replaceAll(RegExp(r'[íìïî]'), 'i')
      .replaceAll(RegExp(r'[óòöô]'), 'o')
      .replaceAll(RegExp(r'[úùüû]'), 'u')
      .trim();

  List<UsuarioAdmin> get _usuariosFiltrados {
    final termino = _normalizar(_busqueda);

    final resultado = _usuarios.where((u) {
      final nombre = _normalizar(u.nombreCompleto);
      final correo = _normalizar(u.correoElectronico);

      final coincideBusqueda =
          termino.isEmpty || nombre.contains(termino) || correo.contains(termino);

      final coincideRol = _filtroRol == FiltroRol.todos ||
          (_filtroRol == FiltroRol.admin && u.rol == RolUsuario.admin) ||
          (_filtroRol == FiltroRol.agricultor && u.rol == RolUsuario.agricultor);

      final coincideEstado = _filtroEstado == FiltroEstado.todos ||
          (_filtroEstado == FiltroEstado.activo && u.cuenta == EstadoCuenta.activo) ||
          (_filtroEstado == FiltroEstado.inactivo && u.cuenta == EstadoCuenta.inactivo) ||
          (_filtroEstado == FiltroEstado.enLinea && u.sesion == EstadoSesion.enLinea) ||
          (_filtroEstado == FiltroEstado.sinSesion && u.sesion == EstadoSesion.sinSesion);

      final coincideDispositivo = _filtroDispositivo == FiltroDispositivo.todos ||
          (_filtroDispositivo == FiltroDispositivo.vinculado &&
              u.dispositivo == EstadoDispositivo.vinculado) ||
          (_filtroDispositivo == FiltroDispositivo.noVinculado &&
              u.dispositivo == EstadoDispositivo.noVinculado);

      final coincideFecha = _coincideFecha(u.fechaRegistro);

      return coincideBusqueda && coincideRol && coincideEstado && coincideDispositivo && coincideFecha;
    }).toList();

    resultado.sort((a, b) {
      final na = '${a.apellido} ${a.segundoApellido} ${a.nombre}';
      final nb = '${b.apellido} ${b.segundoApellido} ${b.nombre}';
      final cmp = na.compareTo(nb);
      return _orden == OrdenAlfabetico.az ? cmp : -cmp;
    });

    return resultado;
  }

  int get _totalAgricultores =>
      _usuarios.where((u) => u.rol == RolUsuario.agricultor).length;

  int get _totalSesionesActivas =>
      _usuarios.where((u) => u.sesion == EstadoSesion.enLinea).length;

  bool _coincideFecha(String fechaStr) {
    if (_fechaInicio == null && _fechaFin == null) return true;
    final parts = fechaStr.split('-');
    if (parts.length < 3) return true;
    final fecha = DateTime(
      int.parse(parts[0]), int.parse(parts[1]), int.parse(parts[2]));
    if (_fechaInicio != null && fecha.isBefore(_fechaInicio!)) return false;
    if (_fechaFin != null && fecha.isAfter(_fechaFin!)) return false;
    return true;
  }

  // ── Acciones ───────────────────────────────────────────────────────────────

  void _cerrarModal() {
    setState(() {
      _modalModo = null;
      _usuarioSeleccionado = null;
    });
  }

  void _cambiarEstado(UsuarioAdmin u) {
    setState(() {
      u.cuenta = u.cuenta == EstadoCuenta.activo
          ? EstadoCuenta.inactivo
          : EstadoCuenta.activo;
      if (u.cuenta == EstadoCuenta.inactivo) {
        u.sesion = EstadoSesion.sinSesion;
      }
    });
  }

  void _confirmarEliminacion() {
    if (_usuarioParaEliminar == null) return;
    setState(() {
      _usuarios.removeWhere((u) => u.id == _usuarioParaEliminar!.id);
      _usuarioParaEliminar = null;
    });
  }

  void _guardarUsuario(DatosUsuario datos) {
    setState(() {
      if (_modalModo == ModalModo.registro) {
        final nuevoId = _usuarios.isEmpty ? 1 : _usuarios.map((u) => u.id).reduce((a, b) => a > b ? a : b) + 1;
        _usuarios.insert(
          0,
          UsuarioAdmin(
            id: nuevoId,
            nombre: datos.nombre,
            segundoNombre: datos.segundoNombre,
            apellido: datos.apellido,
            segundoApellido: datos.segundoApellido,
            correoCorporativo: datos.correoCorporativo,
            correoElectronico: datos.correoElectronico,
            telefono: datos.telefono,
            rol: datos.rol,
            cuenta: EstadoCuenta.activo,
            sesion: EstadoSesion.sinSesion,
            fechaRegistro: DateTime.now().toIso8601String(),
          ),
        );
      } else if (_modalModo == ModalModo.editar && _usuarioSeleccionado != null) {
        final index = _usuarios.indexWhere((u) => u.id == _usuarioSeleccionado!.id);
        if (index != -1) {
          _usuarios[index].nombre = datos.nombre;
          _usuarios[index].segundoNombre = datos.segundoNombre;
          _usuarios[index].apellido = datos.apellido;
          _usuarios[index].segundoApellido = datos.segundoApellido;
          _usuarios[index].correoCorporativo = datos.correoCorporativo;
          _usuarios[index].correoElectronico = datos.correoElectronico;
          _usuarios[index].telefono = datos.telefono;
          _usuarios[index].rol = datos.rol;
        }
      }
      _cerrarModal();
    });
  }

  Future<void> _seleccionarFecha(BuildContext context, bool esInicio) async {
    final picked = await showDatePicker(
      context: context,
      initialDate: DateTime.now(),
      firstDate: DateTime(2020),
      lastDate: DateTime.now().add(const Duration(days: 365)),
      builder: (context, child) {
        return Theme(
          data: Theme.of(context).copyWith(
            colorScheme: const ColorScheme.light(
              primary: PanelAdminStyles.primaryGreen,
              onPrimary: Colors.white,
            ),
          ),
          child: child!,
        );
      },
    );
    if (picked != null) {
      setState(() {
        if (esInicio) {
          _fechaInicio = picked;
        } else {
          _fechaFin = picked;
        }
      });
    }
  }

  // ─────────────────────────────────────────────────────────────────────────
  // BUILD
  // ─────────────────────────────────────────────────────────────────────────

  @override
  Widget build(BuildContext context) {
    final screenWidth = MediaQuery.of(context).size.width;
    final isMobile = screenWidth < 700;

    return Scaffold(
      backgroundColor: PanelAdminStyles.backgroundPage,
      body: Column(
        children: [
          const BarraAdmin(),
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
                          _buildSummaryStrip(isMobile),
                          const SizedBox(height: 18),
                          _buildUsersGrid(isMobile),
                          const SizedBox(height: 32),
                        ],
                      ),
                    ),
                  ),
                ),
                // ── Modales overlay ─────────────────────────────────────────
                if (_modalModo != null || _usuarioParaEliminar != null)
                  _buildModalOverlay(),
              ],
            ),
          ),
        ],
      ),
    );
  }

  // ─── Header ───────────────────────────────────────────────────────────────

  Widget _buildHeader(bool isMobile) {
    return isMobile
        ? Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              _buildHeaderText(),
              const SizedBox(height: 14),
              _buildCreateButton(),
            ],
          )
        : Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Expanded(child: _buildHeaderText()),
              const SizedBox(width: 20),
              _buildCreateButton(),
            ],
          );
  }

  Widget _buildHeaderText() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const Text('ADMINISTRACIÓN', style: PanelAdminStyles.eyebrowText),
        const SizedBox(height: 8),
        const Text('Panel Administrador', style: PanelAdminStyles.h1Text),
        const SizedBox(height: 10),
        const Text(
          'Gestiona agricultores y administradores por nombre, correo, rol, estado de cuenta y fecha de registro.',
          style: PanelAdminStyles.headerDesc,
        ),
      ],
    );
  }

  Widget _buildCreateButton() {
    return GestureDetector(
      onTap: () => setState(() {
        _modalModo = ModalModo.registro;
        _usuarioSeleccionado = null;
      }),
      child: Container(
        decoration: PanelAdminStyles.createBtnDecoration,
        padding: const EdgeInsets.symmetric(horizontal: 18),
        constraints: const BoxConstraints(minHeight: 46),
        child: const Row(
          mainAxisSize: MainAxisSize.min,
          children: [
            Icon(Icons.person_add, color: Colors.white, size: 18),
            SizedBox(width: 8),
            Text(
              'Registrar usuario',
              style: TextStyle(color: Colors.white, fontSize: 15, fontWeight: FontWeight.w800),
            ),
          ],
        ),
      ),
    );
  }

  // ─── Filters bar ──────────────────────────────────────────────────────────

  Widget _buildFiltersBar(bool isMobile) {
    return Container(
      padding: const EdgeInsets.all(18),
      decoration: PanelAdminStyles.filterBarDecoration,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          // Búsqueda (ancho completo)
          _buildSearchField(),
          const SizedBox(height: 14),
          // Filtros en grid
          isMobile
              ? Column(
                  crossAxisAlignment: CrossAxisAlignment.stretch,
                  children: _buildFilterFields(isMobile),
                )
              : Wrap(
                  spacing: 14,
                  runSpacing: 14,
                  children: _buildFilterFields(isMobile),
                ),
        ],
      ),
    );
  }

  Widget _buildSearchField() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const Text('Buscar usuario', style: PanelAdminStyles.labelText),
        const SizedBox(height: 8),
        _SearchInput(
          placeholder: 'Nombre, apellido, nombre completo o correo',
          onChanged: (v) => setState(() => _busqueda = v),
        ),
      ],
    );
  }

  List<Widget> _buildFilterFields(bool isMobile) {
    final fieldWidth = isMobile ? double.infinity : 180.0;

    return [
      _buildDropdownField<OrdenAlfabetico>(
        label: 'Orden alfabético',
        value: _orden,
        width: fieldWidth,
        items: const [
          DropdownMenuItem(value: OrdenAlfabetico.az, child: Text('A-Z')),
          DropdownMenuItem(value: OrdenAlfabetico.za, child: Text('Z-A')),
        ],
        onChanged: (v) => setState(() => _orden = v!),
      ),
      _buildDropdownField<FiltroRol>(
        label: 'Rol',
        value: _filtroRol,
        width: fieldWidth,
        items: const [
          DropdownMenuItem(value: FiltroRol.todos, child: Text('Todos')),
          DropdownMenuItem(value: FiltroRol.admin, child: Text('Admin')),
          DropdownMenuItem(value: FiltroRol.agricultor, child: Text('Agricultor')),
        ],
        onChanged: (v) => setState(() => _filtroRol = v!),
      ),
      _buildDropdownField<FiltroEstado>(
        label: 'Estado',
        value: _filtroEstado,
        width: fieldWidth,
        items: const [
          DropdownMenuItem(value: FiltroEstado.todos, child: Text('Todos')),
          DropdownMenuItem(value: FiltroEstado.activo, child: Text('Activo')),
          DropdownMenuItem(value: FiltroEstado.inactivo, child: Text('Inactivo')),
          DropdownMenuItem(value: FiltroEstado.enLinea, child: Text('En linea')),
          DropdownMenuItem(value: FiltroEstado.sinSesion, child: Text('Sin sesion')),
        ],
        onChanged: (v) => setState(() => _filtroEstado = v!),
      ),
      _buildDropdownField<FiltroDispositivo>(
        label: 'Dispositivo',
        value: _filtroDispositivo,
        width: fieldWidth,
        items: const [
          DropdownMenuItem(value: FiltroDispositivo.todos, child: Text('Todos')),
          DropdownMenuItem(value: FiltroDispositivo.vinculado, child: Text('Dispositivo vinculado')),
          DropdownMenuItem(value: FiltroDispositivo.noVinculado, child: Text('Dispositivo no vinculado')),
        ],
        onChanged: (v) => setState(() => _filtroDispositivo = v!),
      ),
      _buildDateRangeField(fieldWidth, isMobile),
    ];
  }

  Widget _buildDropdownField<T>({
    required String label,
    required T value,
    required List<DropdownMenuItem<T>> items,
    required ValueChanged<T?> onChanged,
    required double width,
  }) {
    return SizedBox(
      width: width,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(label, style: PanelAdminStyles.labelText),
          const SizedBox(height: 8),
          Container(
            height: 44,
            decoration: PanelAdminStyles.inputDecoration(),
            padding: const EdgeInsets.symmetric(horizontal: 12),
            child: DropdownButtonHideUnderline(
              child: DropdownButton<T>(
                value: value,
                isExpanded: true,
                icon: const Icon(Icons.keyboard_arrow_down, color: PanelAdminStyles.primaryGreen),
                style: const TextStyle(
                  color: PanelAdminStyles.darkGreen,
                  fontSize: 14,
                  fontFamily: 'Arial',
                ),
                items: items,
                onChanged: onChanged,
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildDateRangeField(double width, bool isMobile) {
    return SizedBox(
      width: isMobile ? double.infinity : 280,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Text('Rango de fecha', style: PanelAdminStyles.labelText),
          const SizedBox(height: 8),
          Row(
            children: [
              Expanded(child: _buildDatePicker(esInicio: true)),
              const SizedBox(width: 10),
              Expanded(child: _buildDatePicker(esInicio: false)),
            ],
          ),
        ],
      ),
    );
  }

  Widget _buildDatePicker({required bool esInicio}) {
    final fecha = esInicio ? _fechaInicio : _fechaFin;
    final label = esInicio ? 'Inicio' : 'Fin';
    return GestureDetector(
      onTap: () => _seleccionarFecha(context, esInicio),
      child: Container(
        height: 44,
        decoration: PanelAdminStyles.inputDecoration(),
        padding: const EdgeInsets.symmetric(horizontal: 10),
        child: Row(
          children: [
            const Icon(Icons.calendar_today, size: 14, color: PanelAdminStyles.primaryGreen),
            const SizedBox(width: 6),
            Expanded(
              child: Text(
                fecha != null
                    ? '${fecha.day.toString().padLeft(2,'0')}/${fecha.month.toString().padLeft(2,'0')}/${fecha.year}'
                    : label,
                style: TextStyle(
                  fontSize: 13,
                  color: fecha != null
                      ? PanelAdminStyles.darkGreen
                      : PanelAdminStyles.dtColor,
                ),
                overflow: TextOverflow.ellipsis,
              ),
            ),
            if (fecha != null)
              GestureDetector(
                onTap: () => setState(() {
                  if (esInicio) { _fechaInicio = null; }
                  else { _fechaFin = null; }
                }),
                child: const Icon(Icons.close, size: 14, color: PanelAdminStyles.dtColor),
              ),
          ],
        ),
      ),
    );
  }

  // ─── Summary strip ────────────────────────────────────────────────────────

  Widget _buildSummaryStrip(bool isMobile) {
    final filtrados = _usuariosFiltrados;
    final items = [
      (_usuarios.length.toString(), 'Usuarios registrados'),
      (filtrados.length.toString(), 'Resultados visibles'),
      (_totalAgricultores.toString(), 'Agricultores'),
      (_totalSesionesActivas.toString(), 'Con sesion activa'),
    ];

    if (isMobile) {
      return Column(
        children: items
            .asMap()
            .entries
            .map((e) => Padding(
                  padding: EdgeInsets.only(bottom: e.key < items.length - 1 ? 10 : 0),
                  child: _buildSummaryCard(e.value.$1, e.value.$2),
                ))
            .toList(),
      );
    }
    return Row(
      children: items
          .asMap()
          .entries
          .map((e) => Expanded(
                child: Padding(
                  padding: EdgeInsets.only(left: e.key == 0 ? 0 : 7, right: e.key == items.length - 1 ? 0 : 7),
                  child: _buildSummaryCard(e.value.$1, e.value.$2),
                ),
              ))
          .toList(),
    );
  }

  Widget _buildSummaryCard(String numero, String etiqueta) {
    return Container(
      padding: const EdgeInsets.all(18),
      decoration: PanelAdminStyles.summaryCardDecoration,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(numero, style: PanelAdminStyles.summaryNumber),
          const SizedBox(height: 5),
          Text(etiqueta, style: PanelAdminStyles.summaryLabel),
        ],
      ),
    );
  }

  // ─── Users grid ───────────────────────────────────────────────────────────

  Widget _buildUsersGrid(bool isMobile) {
    final filtrados = _usuariosFiltrados;
    if (filtrados.isEmpty) {
      return Container(
        padding: const EdgeInsets.all(26),
        decoration: BoxDecoration(
          border: Border.all(color: PanelAdminStyles.borderGrey, style: BorderStyle.solid),
          borderRadius: BorderRadius.circular(8),
        ),
        child: const Text(
          'No se encontraron usuarios con los filtros seleccionados.',
          style: PanelAdminStyles.emptyStateText,
          textAlign: TextAlign.center,
        ),
      );
    }

    return LayoutBuilder(builder: (context, constraints) {
      final crossAxisCount = constraints.maxWidth > 900
          ? 3
          : constraints.maxWidth > 600
              ? 2
              : 1;
      
      final spacing = 16.0;
      final itemWidth = (constraints.maxWidth - (spacing * (crossAxisCount - 1))) / crossAxisCount;

      return Wrap(
        spacing: spacing,
        runSpacing: spacing,
        children: filtrados.map((u) => SizedBox(
          width: itemWidth,
          child: _buildUserCard(u),
        )).toList(),
      );
    });
  }

  Widget _buildUserCard(UsuarioAdmin u) {
    return Container(
      padding: const EdgeInsets.all(20),
      decoration: PanelAdminStyles.cardDecoration,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // Header
          Row(
            children: [
              Container(
                width: 52,
                height: 52,
                decoration: PanelAdminStyles.avatarDecoration,
                child: Center(
                  child: Text(
                    u.iniciales,
                    style: const TextStyle(
                        color: Colors.white, fontWeight: FontWeight.w800, fontSize: 18),
                  ),
                ),
              ),
              const SizedBox(width: 14),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(u.nombreCompleto, style: PanelAdminStyles.cardName, overflow: TextOverflow.ellipsis),
                    const SizedBox(height: 4),
                    Text(u.correoElectronico, style: PanelAdminStyles.cardEmail, overflow: TextOverflow.ellipsis),
                  ],
                ),
              ),
            ],
          ),
          const SizedBox(height: 16),
          // Badges
          Wrap(
            spacing: 8,
            runSpacing: 8,
            children: [
              _buildBadge(u.rol.label,
                  PanelAdminStyles.roleBg, PanelAdminStyles.roleText),
              _buildBadge(
                u.cuenta.label,
                u.cuenta == EstadoCuenta.activo
                    ? PanelAdminStyles.activeBg
                    : PanelAdminStyles.inactiveBg,
                u.cuenta == EstadoCuenta.activo
                    ? PanelAdminStyles.activeText
                    : PanelAdminStyles.inactiveText,
              ),
              _buildBadge(
                u.sesion.label,
                u.sesion == EstadoSesion.enLinea
                    ? PanelAdminStyles.activeBg
                    : PanelAdminStyles.inactiveBg,
                u.sesion == EstadoSesion.enLinea
                    ? PanelAdminStyles.activeText
                    : PanelAdminStyles.inactiveText,
              ),
              if (u.dispositivo != null)
                _buildBadge(
                  u.dispositivo!.label,
                  u.dispositivo == EstadoDispositivo.vinculado
                      ? PanelAdminStyles.deviceLinkedBg
                      : PanelAdminStyles.deviceUnlinkedBg,
                  u.dispositivo == EstadoDispositivo.vinculado
                      ? PanelAdminStyles.deviceLinkedText
                      : PanelAdminStyles.deviceUnlinkedText,
                ),
            ],
          ),
          const SizedBox(height: 14),
          // Detalles
          Row(
            children: [
              Expanded(child: _buildDetail('Fecha', u.fechaRegistro)),
              const SizedBox(width: 12),
              Expanded(child: _buildDetail('Teléfono', u.telefono)),
            ],
          ),
          const SizedBox(height: 18),
          // Acciones
          _buildCardActions(u),
        ],
      ),
    );
  }

  Widget _buildBadge(String text, Color bg, Color color) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 5),
      decoration: BoxDecoration(color: bg, borderRadius: BorderRadius.circular(8)),
      child: Text(text, style: PanelAdminStyles.badgeText.copyWith(color: color)),
    );
  }

  Widget _buildDetail(String dt, String dd) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(dt, style: PanelAdminStyles.dtText),
        const SizedBox(height: 4),
        Text(dd, style: PanelAdminStyles.ddText, overflow: TextOverflow.ellipsis),
      ],
    );
  }

  Widget _buildCardActions(UsuarioAdmin u) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: [
        // Acceder al panel (solo agricultores, ancho completo)
        if (u.rol == RolUsuario.agricultor) ...[
          _buildActionButton(
            label: 'Acceder al panel',
            icon: Icons.login,
            decoration: PanelAdminStyles.accessPanelDecoration,
            textColor: Colors.white,
            onTap: () => Navigator.pushReplacementNamed(context, '/panel-agricultor'),
          ),
          const SizedBox(height: 8),
        ],
        // Fila de 2 botones
        Row(
          children: [
            Expanded(
              child: _buildActionButton(
                label: 'Editar',
                icon: Icons.edit,
                decoration: PanelAdminStyles.actionBtnDecoration,
                textColor: PanelAdminStyles.darkGreen,
                onTap: () => setState(() {
                  _modalModo = ModalModo.editar;
                  _usuarioSeleccionado = u;
                }),
              ),
            ),
            const SizedBox(width: 8),
            Expanded(
              child: _buildActionButton(
                label: 'Perfil',
                icon: Icons.badge,
                decoration: PanelAdminStyles.actionBtnDecoration,
                textColor: PanelAdminStyles.darkGreen,
                onTap: () => setState(() {
                  _modalModo = ModalModo.perfil;
                  _usuarioSeleccionado = u;
                }),
              ),
            ),
          ],
        ),
        const SizedBox(height: 8),
        Row(
          children: [
            Expanded(
              child: _buildActionButton(
                label: u.cuenta == EstadoCuenta.activo ? 'Desactivar' : 'Activar',
                icon: Icons.power_settings_new,
                decoration: PanelAdminStyles.actionBtnDecoration,
                textColor: PanelAdminStyles.darkGreen,
                onTap: () => _cambiarEstado(u),
              ),
            ),
            const SizedBox(width: 8),
            Expanded(
              child: _buildActionButton(
                label: 'Eliminar',
                icon: Icons.delete,
                decoration: PanelAdminStyles.dangerBtnDecoration,
                textColor: PanelAdminStyles.dangerText,
                onTap: () => setState(() => _usuarioParaEliminar = u),
              ),
            ),
          ],
        ),
      ],
    );
  }

  Widget _buildActionButton({
    required String label,
    required IconData icon,
    required BoxDecoration decoration,
    required Color textColor,
    required VoidCallback onTap,
  }) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        constraints: const BoxConstraints(minHeight: 40),
        decoration: decoration,
        child: Center(
          child: Row(
            mainAxisSize: MainAxisSize.min,
            children: [
              Icon(icon, size: 14, color: textColor),
              const SizedBox(width: 6),
              Text(label,
                  style: PanelAdminStyles.actionBtnText.copyWith(color: textColor)),
            ],
          ),
        ),
      ),
    );
  }

  // ─── Modal overlay ────────────────────────────────────────────────────────

  Widget _buildModalOverlay() {
    if (_usuarioParaEliminar != null) {
      return EliminarUsuario(
        usuario: _usuarioParaEliminar!,
        onCerrar: () => setState(() => _usuarioParaEliminar = null),
        onConfirmar: _confirmarEliminacion,
      );
    }
    
    if (_modalModo == ModalModo.registro) {
      return RegistroUsuario(
        onCerrar: _cerrarModal,
        onGuardar: _guardarUsuario,
      );
    }
    
    if (_modalModo == ModalModo.editar && _usuarioSeleccionado != null) {
      return EditarUsuario(
        usuario: _usuarioSeleccionado!,
        onCerrar: _cerrarModal,
        onGuardar: _guardarUsuario,
      );
    }
    
    if (_modalModo == ModalModo.perfil && _usuarioSeleccionado != null) {
      return PerfilUsuario(
        usuario: _usuarioSeleccionado!,
        onCerrar: _cerrarModal,
      );
    }
    
    return const SizedBox.shrink();
  }
}

// ─── Widget auxiliar: campo de búsqueda ───────────────────────────────────────

class _SearchInput extends StatefulWidget {
  final String placeholder;
  final ValueChanged<String> onChanged;

  const _SearchInput({required this.placeholder, required this.onChanged});

  @override
  State<_SearchInput> createState() => _SearchInputState();
}

class _SearchInputState extends State<_SearchInput> {
  final _controller = TextEditingController();
  final _focus = FocusNode();
  bool _focused = false;

  @override
  void initState() {
    super.initState();
    _focus.addListener(() => setState(() => _focused = _focus.hasFocus));
  }

  @override
  void dispose() {
    _controller.dispose();
    _focus.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: PanelAdminStyles.inputDecoration(focused: _focused),
      child: Row(
        children: [
          const SizedBox(width: 14),
          const Icon(Icons.search, color: PanelAdminStyles.primaryGreen, size: 20),
          const SizedBox(width: 10),
          Expanded(
            child: TextField(
              controller: _controller,
              focusNode: _focus,
              decoration: InputDecoration(
                hintText: widget.placeholder,
                hintStyle: const TextStyle(color: PanelAdminStyles.dtColor, fontSize: 14),
                border: InputBorder.none,
                isDense: true,
                contentPadding: const EdgeInsets.symmetric(vertical: 12),
              ),
              style: const TextStyle(
                  color: PanelAdminStyles.darkGreen, fontSize: 14),
              onChanged: widget.onChanged,
            ),
          ),
          if (_controller.text.isNotEmpty)
            GestureDetector(
              onTap: () {
                _controller.clear();
                widget.onChanged('');
              },
              child: const Padding(
                padding: EdgeInsets.symmetric(horizontal: 10),
                child: Icon(Icons.close, color: PanelAdminStyles.dtColor, size: 18),
              ),
            ),
        ],
      ),
    );
  }
}
