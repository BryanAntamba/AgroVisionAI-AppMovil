import 'package:flutter/material.dart';
import '../core/validaciones/formulario_validaciones_widget.dart';
import '../models/usuariosRandom_admin.dart';
import '../nadvars/barra_admin_widget.dart';
import '../styles/app_colors.dart';
import '../styles/formulario_autenticacion_style.dart';
import '../styles/panel_admin_style.dart';
import 'admin_eliminar_modal.dart';
import 'admin_tarjetaInformativa_usuario.dart';
import 'admin_registrar_editar_perfil_modal.dart';

class PanelAdminScreen extends StatefulWidget {
  const PanelAdminScreen({super.key});

  @override
  State<PanelAdminScreen> createState() => _PanelAdminScreenState();
}

class _PanelAdminScreenState extends State<PanelAdminScreen> {
  List<UsuarioAdmin> _usuarios = UsuarioAdmin.datosIniciales();

  String _busqueda = '';
  String _filtroRol = 'Todos';
  String _filtroEstado = 'Todos';
  String _fechaInicio = '';
  String _fechaFin = '';
  String _ordenAlfabetico = 'az';

  ModalModoUsuario? _modalModo;
  UsuarioAdmin? _usuarioSeleccionado;
  UsuarioAdmin? _usuarioParaEliminar;

  List<UsuarioAdmin> get _filtrados {
    final termino = FormValidators.normalizar(_busqueda);
    final lista = _usuarios.where((u) {
      final nombre = FormValidators.normalizar(u.nombreCompleto);
      final correo = FormValidators.normalizar(u.correoElectronico);
      final coincideBusqueda =
          termino.isEmpty || nombre.contains(termino) || correo.contains(termino);
      final coincideRol = _filtroRol == 'Todos' || u.rol.label == _filtroRol;
      final coincideEstado = _filtroEstado == 'Todos' ||
          u.cuenta.label == _filtroEstado ||
          u.sesion.label == _filtroEstado;
      return coincideBusqueda && coincideRol && coincideEstado && _coincideFecha(u.fechaRegistro);
    }).toList();

    lista.sort((a, b) {
      final nombreA = '${a.apellido} ${a.segundoApellido} ${a.nombre}';
      final nombreB = '${b.apellido} ${b.segundoApellido} ${b.nombre}';
      final r = nombreA.compareTo(nombreB);
      return _ordenAlfabetico == 'az' ? r : -r;
    });
    return lista;
  }

  int get _totalAgricultores =>
      _usuarios.where((u) => u.rol == RolUsuario.agricultor).length;

  int get _totalSesionesActivas =>
      _usuarios.where((u) => u.sesion == EstadoSesion.enLinea).length;

  bool _coincideFecha(String fechaRegistro) {
    if (_fechaInicio.isEmpty && _fechaFin.isEmpty) return true;
    final fecha = DateTime.parse('${fechaRegistro}T00:00:00');
    if (_fechaInicio.isNotEmpty) {
      final inicio = DateTime.parse('${_fechaInicio}T00:00:00');
      if (fecha.isBefore(inicio)) return false;
    }
    if (_fechaFin.isNotEmpty) {
      final fin = DateTime.parse('${_fechaFin}T23:59:59');
      if (fecha.isAfter(fin)) return false;
    }
    return true;
  }

  void _abrirRegistro() => setState(() {
        _modalModo = ModalModoUsuario.registro;
        _usuarioSeleccionado = null;
      });

  void _abrirEditar(UsuarioAdmin u) => setState(() {
        _modalModo = ModalModoUsuario.editar;
        _usuarioSeleccionado = u;
      });

  void _abrirPerfil(UsuarioAdmin u) => setState(() {
        _modalModo = ModalModoUsuario.perfil;
        _usuarioSeleccionado = u;
      });

  void _cerrarModal() => setState(() {
        _modalModo = null;
        _usuarioSeleccionado = null;
      });

  void _guardarUsuario(Map<String, String> valores, RolUsuario rol) {
    final tel = FormValidators.telefonoParaCartilla(valores['telefono']!);

    if (_modalModo == ModalModoUsuario.registro) {
      final nuevoId = _usuarios.map((u) => u.id).fold(0, (a, b) => a > b ? a : b) + 1;
      _usuarios = [
        ..._usuarios,
        UsuarioAdmin(
          id: nuevoId,
          nombre: valores['nombre']!,
          segundoNombre: valores['segundoNombre']!,
          apellido: valores['apellido']!,
          segundoApellido: valores['segundoApellido']!,
          correoCorporativo: valores['correoCorporativo']!,
          correoElectronico: valores['correoElectronico']!,
          telefono: tel,
          rol: rol,
          cuenta: EstadoCuenta.activo,
          sesion: EstadoSesion.sinSesion,
          fechaRegistro: DateTime.now().toIso8601String().substring(0, 10),
        ),
      ];
    } else if (_modalModo == ModalModoUsuario.editar && _usuarioSeleccionado != null) {
      final u = _usuarioSeleccionado!;
      u.nombre = valores['nombre']!;
      u.segundoNombre = valores['segundoNombre']!;
      u.apellido = valores['apellido']!;
      u.segundoApellido = valores['segundoApellido']!;
      u.correoCorporativo = valores['correoCorporativo']!;
      u.correoElectronico = valores['correoElectronico']!;
      u.telefono = tel;
      u.rol = rol;
    }
    _cerrarModal();
    setState(() {});
  }

  void _cambiarEstado(UsuarioAdmin u) {
    setState(() {
      if (u.cuenta == EstadoCuenta.activo) {
        u.cuenta = EstadoCuenta.inactivo;
        u.sesion = EstadoSesion.sinSesion;
      } else {
        u.cuenta = EstadoCuenta.activo;
      }
    });
  }

  void _confirmarEliminacion() {
    if (_usuarioParaEliminar == null) return;
    setState(() {
      _usuarios =
          _usuarios.where((u) => u.id != _usuarioParaEliminar!.id).toList();
      _usuarioParaEliminar = null;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: [
          SafeArea(
            child: Column(
              children: [
                const BarraAdminWidget(),
                Expanded(
                  child: Container(
                    decoration: PanelAdminStyle.dashboardBackground,
                    child: LayoutBuilder(
                      builder: (context, constraints) {
                        final isNarrow = constraints.maxWidth < 720;
                        final padding =
                            EdgeInsets.all(isNarrow ? 16 : 32);
                        return SingleChildScrollView(
                          padding: padding,
                          child: Center(
                            child: ConstrainedBox(
                              constraints: const BoxConstraints(
                                maxWidth: PanelAdminStyle.maxContentWidth,
                              ),
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.stretch,
                                children: [
                                  _header(isNarrow: isNarrow),
                                  const SizedBox(height: 18),
                                  _filtersBar(),
                                  const SizedBox(height: 18),
                                  _summaryStrip(isNarrow: isNarrow),
                                  const SizedBox(height: 18),
                                  _usersGrid(),
                                ],
                              ),
                            ),
                          ),
                        );
                      },
                    ),
                  ),
                ),
              ],
            ),
          ),
          if (_modalModo != null)
            Positioned.fill(
              child: PanelAdminUsuarioModal(
                key: ValueKey(
                  '${_modalModo!.name}_${_usuarioSeleccionado?.id ?? 'nuevo'}',
                ),
                modo: _modalModo!,
                usuario: _usuarioSeleccionado,
                onCerrar: _cerrarModal,
                onGuardar: _guardarUsuario,
              ),
            ),
          if (_usuarioParaEliminar != null)
            Positioned.fill(
              child: PanelAdminDeleteModal(
                usuario: _usuarioParaEliminar!,
                onCancelar: () => setState(() => _usuarioParaEliminar = null),
                onConfirmar: _confirmarEliminacion,
              ),
            ),
        ],
      ),
    );
  }

  Widget _header({required bool isNarrow}) {
    final titleBlock = Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text('ADMINISTRACION', style: PanelAdminStyle.eyebrow),
        const SizedBox(height: 8),
        Text('Panel Administrador', style: PanelAdminStyle.pageTitle),
        const SizedBox(height: 10),
        Text(
          'Gestiona agricultores y administradores por nombre, correo, rol, '
          'estado de cuenta y fecha de registro.',
          style: PanelAdminStyle.subtitle,
        ),
      ],
    );

    final action = DecoratedBox(
      decoration: AuthFormStyle.submitButtonDecoration,
      child: ElevatedButton(
        onPressed: _abrirRegistro,
        style: AuthFormStyle.submitButtonStyle.copyWith(
          minimumSize: WidgetStateProperty.all(
            Size(isNarrow ? double.infinity : 0, 54),
          ),
          padding: WidgetStateProperty.all(
            const EdgeInsets.symmetric(horizontal: 18, vertical: 14),
          ),
        ),
        child: const Row(
          mainAxisSize: MainAxisSize.min,
          children: [
            Icon(Icons.person_add_alt_1, size: 18),
            SizedBox(width: 8),
            Text('Registrar usuario'),
          ],
        ),
      ),
    );

    if (isNarrow) {
      return Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          titleBlock,
          const SizedBox(height: 14),
          SizedBox(width: double.infinity, child: action),
        ],
      );
    }

    return Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Expanded(child: titleBlock),
        action,
      ],
    );
  }

  Widget _filtersBar() {
    return Container(
      padding: const EdgeInsets.all(18),
      decoration: PanelAdminStyle.filterBar,
      child: Wrap(
        spacing: 14,
        runSpacing: 14,
        children: [
          SizedBox(
            width: 280,
            child: _filterSearch(),
          ),
          _filterSelect('Orden alfabetico', _ordenAlfabetico, const ['az', 'za'],
              (v) => setState(() => _ordenAlfabetico = v), labels: const {'az': 'A-Z', 'za': 'Z-A'}),
          _filterSelect('Rol', _filtroRol,
              const ['Todos', 'Admin', 'Agricultor'], (v) => setState(() => _filtroRol = v)),
          _filterSelect(
            'Estado',
            _filtroEstado,
            const ['Todos', 'Activo', 'Inactivo', 'En linea', 'Sin sesion'],
            (v) => setState(() => _filtroEstado = v),
          ),
        ],
      ),
    );
  }

  Widget _filterSearch() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text('Buscar usuario', style: PanelAdminStyle.detailLabel),
        const SizedBox(height: 8),
        TextField(
          decoration: InputDecoration(
            hintText: 'Nombre, apellido, nombre completo o correo',
            prefixIcon: const Icon(Icons.search, color: AppColors.primaryGreen),
            filled: true,
            fillColor: AppColors.inputBackground,
            border: OutlineInputBorder(borderRadius: BorderRadius.circular(8)),
          ),
          onChanged: (v) => setState(() => _busqueda = v),
        ),
      ],
    );
  }

  Widget _filterSelect(
    String label,
    String value,
    List<String> options,
    ValueChanged<String> onChanged, {
    Map<String, String>? labels,
  }) {
    return SizedBox(
      width: 160,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(label, style: PanelAdminStyle.detailLabel),
          const SizedBox(height: 8),
          DropdownButtonFormField<String>(
            value: value,
            decoration: InputDecoration(
              filled: true,
              fillColor: AppColors.inputBackground,
              border: OutlineInputBorder(borderRadius: BorderRadius.circular(8)),
            ),
            items: options
                .map((o) => DropdownMenuItem(
                      value: o,
                      child: Text(labels?[o] ?? o),
                    ))
                .toList(),
            onChanged: (v) {
              if (v != null) onChanged(v);
            },
          ),
        ],
      ),
    );
  }

  Widget _summaryStrip({required bool isNarrow}) {
    final cards = [
      _summaryCard('${_usuarios.length}', 'Usuarios registrados'),
      _summaryCard('${_filtrados.length}', 'Resultados visibles'),
      _summaryCard('$_totalAgricultores', 'Agricultores'),
      _summaryCard('$_totalSesionesActivas', 'Con sesion activa'),
    ];

    if (isNarrow) {
      return Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          for (var i = 0; i < cards.length; i++) ...[
            cards[i],
            if (i != cards.length - 1) const SizedBox(height: 14),
          ],
        ],
      );
    }

    return Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Expanded(child: cards[0]),
        const SizedBox(width: 14),
        Expanded(child: cards[1]),
        const SizedBox(width: 14),
        Expanded(child: cards[2]),
        const SizedBox(width: 14),
        Expanded(child: cards[3]),
      ],
    );
  }

  Widget _summaryCard(String value, String label) {
    return Container(
      width: double.infinity,
      padding: const EdgeInsets.all(18),
      decoration: PanelAdminStyle.summaryCard,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            value,
            style: const TextStyle(
              fontSize: 26,
              fontWeight: FontWeight.w800,
              color: AppColors.primaryGreenDark,
            ),
          ),
          const SizedBox(height: 5),
          Text(label, style: const TextStyle(fontWeight: FontWeight.w700)),
        ],
      ),
    );
  }

  Widget _usersGrid() {
    if (_filtrados.isEmpty) {
      return Container(
        padding: const EdgeInsets.all(26),
        decoration: BoxDecoration(
          border: Border.all(color: const Color(0xFFAAC0B3), style: BorderStyle.solid),
          borderRadius: BorderRadius.circular(8),
        ),
        child: const Center(
          child: Text('No se encontraron usuarios con los filtros seleccionados.'),
        ),
      );
    }

    return LayoutBuilder(
      builder: (context, constraints) {
        final twoColumns = constraints.maxWidth > 700;
        final cardWidth =
            twoColumns ? (constraints.maxWidth - 16) / 2 : constraints.maxWidth;

        return Wrap(
          spacing: 16,
          runSpacing: 16,
          children: [
            for (final u in _filtrados)
              SizedBox(
                width: cardWidth,
                child: PanelAdminUserCard(
                  usuario: u,
                  onEditar: () => _abrirEditar(u),
                  onPerfil: () => _abrirPerfil(u),
                  onCambiarEstado: () => _cambiarEstado(u),
                  onEliminar: () => setState(() => _usuarioParaEliminar = u),
                ),
              ),
          ],
        );
      },
    );
  }
}
