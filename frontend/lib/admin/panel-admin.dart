// ═══════════════════════════════════════════════════════════════════════════
// IMPORTACIONES
// ═══════════════════════════════════════════════════════════════════════════
import 'package:flutter/material.dart'; // Framework de Flutter para widgets
import '../styles/admin-styles/panel-admin.dart'; // Estilos específicos del panel admin
import '../navbars/barra-admin.dart'; // Widget de barra de navegación
import '../styles/navbars-styles/barra-admin.dart'; // Estilos de la barra admin
import '../environments/datos-simulados-admin.dart'; // Datos simulados de usuarios
import 'modales/registro-usuario.dart'; // Modal de registro de usuario
import 'modales/editar-usuario.dart'; // Modal de edición de usuario
import 'modales/eliminar-usuario.dart'; // Modal de eliminación de usuario
import 'modales/perfil-usuario.dart'; // Modal de visualización de perfil

// ═══════════════════════════════════════════════════════════════════════════
// ENUMS - Tipos enumerados para filtros y estado de modales
// ═══════════════════════════════════════════════════════════════════════════
enum FiltroRol { todos, admin, agricultor } // Filtro por rol de usuario
enum FiltroEstado { todos, activo, inactivo, enLinea, sinSesion } // Filtro por estado de cuenta/sesión
enum FiltroDispositivo { todos, vinculado, noVinculado } // Filtro por estado de vinculación de dispositivo
enum OrdenAlfabetico { az, za } // Orden alfabético ascendente (A-Z) o descendente (Z-A)
enum ModalModo { registro, editar, perfil } // Modo del modal activo (registro, edición o perfil)

// ═══════════════════════════════════════════════════════════════════════════
// WIDGET PRINCIPAL: PanelAdmin - Pantalla de administración de usuarios
// Permite listar, filtrar, crear, editar, visualizar y eliminar usuarios
// ═══════════════════════════════════════════════════════════════════════════
class PanelAdmin extends StatefulWidget {
  const PanelAdmin({super.key}); // Constructor

  @override
  State<PanelAdmin> createState() => _PanelAdminState(); // Crea el estado
}

// ═══════════════════════════════════════════════════════════════════════════
// ESTADO: _PanelAdminState - Gestiona el estado del panel de administración
// ═══════════════════════════════════════════════════════════════════════════
class _PanelAdminState extends State<PanelAdmin> {
  // ─── VARIABLES DE ESTADO - FILTROS ───
  String _busqueda = ''; // Término de búsqueda (nombre completo o correo)
  FiltroRol _filtroRol = FiltroRol.todos; // Filtro de rol seleccionado (todos/admin/agricultor)
  FiltroEstado _filtroEstado = FiltroEstado.todos; // Filtro de estado seleccionado
  FiltroDispositivo _filtroDispositivo = FiltroDispositivo.todos; // Filtro de dispositivo seleccionado
  DateTime? _fechaInicio; // Fecha de inicio del rango de filtro (null = sin filtro)
  DateTime? _fechaFin; // Fecha de fin del rango de filtro (null = sin filtro)
  OrdenAlfabetico _orden = OrdenAlfabetico.az; // Orden alfabético actual (A-Z por defecto)

  // ─── VARIABLES DE ESTADO - MODALES ───
  ModalModo? _modalModo; // Modo del modal activo (null = ningún modal abierto)
  UsuarioAdmin? _usuarioSeleccionado; // Usuario seleccionado para editar/ver perfil (null = ninguno)
  UsuarioAdmin? _usuarioParaEliminar; // Usuario marcado para eliminar (null = ninguno)

  // ─── DATOS ───
  late List<UsuarioAdmin> _usuarios; // Lista de usuarios (mutable, cargada desde datos simulados)

  // ═══════════════════════════════════════════════════════════════════════════
  // INICIALIZACIÓN
  // ═══════════════════════════════════════════════════════════════════════════
  @override
  void initState() {
    super.initState(); // Llama al initState del padre
    _usuarios = List.from(datosSimuladosAdmin); // Crea copia de datos simulados (permite modificaciones locales)
  }

  // ═══════════════════════════════════════════════════════════════════════════
  // MÉTODOS COMPUTADOS Y UTILIDADES
  // ═══════════════════════════════════════════════════════════════════════════

  // Normaliza string: elimina acentos, convierte a minúsculas, elimina espacios extra
  // Usado para búsquedas sin importar acentuación o capitalización
  String _normalizar(String v) => v
      .toLowerCase() // Convierte a minúsculas
      .replaceAll(RegExp(r'[áàäâ]'), 'a') // Reemplaza variantes de 'a' con acento
      .replaceAll(RegExp(r'[éèëê]'), 'e') // Reemplaza variantes de 'e' con acento
      .replaceAll(RegExp(r'[íìïî]'), 'i') // Reemplaza variantes de 'i' con acento
      .replaceAll(RegExp(r'[óòöô]'), 'o') // Reemplaza variantes de 'o' con acento
      .replaceAll(RegExp(r'[úùüû]'), 'u') // Reemplaza variantes de 'u' con acento
      .trim(); // Elimina espacios al inicio y final

  // Getter computado: retorna lista de usuarios filtrados y ordenados
  List<UsuarioAdmin> get _usuariosFiltrados {
    final termino = _normalizar(_busqueda); // Normaliza término de búsqueda

    // ─── FASE 1: FILTRAR usuarios según criterios activos ───
    final resultado = _usuarios.where((u) { // Itera sobre todos los usuarios
      // Normaliza campos del usuario para comparación
      final nombre = _normalizar(u.nombreCompleto); // Nombre completo sin acentos/minúsculas
      final correo = _normalizar(u.correoElectronico); // Correo sin acentos/minúsculas

      // ── Filtro de búsqueda (por nombre o correo) ──
      final coincideBusqueda =
          termino.isEmpty || // Si no hay búsqueda, todos coinciden
          nombre.contains(termino) || // Búsqueda en nombre
          correo.contains(termino); // Búsqueda en correo

      // ── Filtro de rol ──
      final coincideRol = _filtroRol == FiltroRol.todos || // Si filtro es "todos", todos coinciden
          (_filtroRol == FiltroRol.admin && u.rol == RolUsuario.admin) || // Filtra admins
          (_filtroRol == FiltroRol.agricultor && u.rol == RolUsuario.agricultor); // Filtra agricultores

      // ── Filtro de estado (cuenta/sesión) ──
      final coincideEstado = _filtroEstado == FiltroEstado.todos || // Si filtro es "todos"
          (_filtroEstado == FiltroEstado.activo && u.cuenta == EstadoCuenta.activo) || // Cuenta activa
          (_filtroEstado == FiltroEstado.inactivo && u.cuenta == EstadoCuenta.inactivo) || // Cuenta inactiva
          (_filtroEstado == FiltroEstado.enLinea && u.sesion == EstadoSesion.enLinea) || // Sesión activa
          (_filtroEstado == FiltroEstado.sinSesion && u.sesion == EstadoSesion.sinSesion); // Sin sesión

      // ── Filtro de dispositivo ──
      final coincideDispositivo = _filtroDispositivo == FiltroDispositivo.todos || // Si filtro es "todos"
          (_filtroDispositivo == FiltroDispositivo.vinculado && // Dispositivo vinculado
              u.dispositivo == EstadoDispositivo.vinculado) ||
          (_filtroDispositivo == FiltroDispositivo.noVinculado && // Dispositivo NO vinculado
              u.dispositivo == EstadoDispositivo.noVinculado);

      // ── Filtro de fecha de registro ──
      final coincideFecha = _coincideFecha(u.fechaRegistro); // Verifica si fecha está en rango

      // Usuario debe cumplir TODOS los filtros activos
      return coincideBusqueda && coincideRol && coincideEstado && coincideDispositivo && coincideFecha;
    }).toList(); // Convierte resultado filtrado a lista

    // ─── FASE 2: ORDENAR usuarios alfabéticamente ───
    resultado.sort((a, b) { // Ordena lista in-place
      // Construye nombre completo para ordenar: apellidos + nombre
      final na = '${a.apellido} ${a.segundoApellido} ${a.nombre}';
      final nb = '${b.apellido} ${b.segundoApellido} ${b.nombre}';
      final cmp = na.compareTo(nb); // Compara strings (orden natural A-Z)
      return _orden == OrdenAlfabetico.az ? cmp : -cmp; // Invierte si orden es Z-A
    });

    return resultado; // Retorna lista filtrada y ordenada
  }

  // Getter computado: retorna total de usuarios con rol de agricultor
  int get _totalAgricultores =>
      _usuarios.where((u) => u.rol == RolUsuario.agricultor).length; // Filtra usuarios con rol agricultor y cuenta cuántos son

  // Getter computado: retorna total de usuarios con sesión activa (en línea)
  int get _totalSesionesActivas =>
      _usuarios.where((u) => u.sesion == EstadoSesion.enLinea).length; // Filtra usuarios en línea y cuenta cuántos son

  // Verifica si una fecha (string) está dentro del rango seleccionado (_fechaInicio - _fechaFin)
  // Retorna true si coincide, false si está fuera del rango
  bool _coincideFecha(String fechaStr) {
    // Si no hay rango de fechas seleccionado, todas las fechas coinciden
    if (_fechaInicio == null && _fechaFin == null) return true; // Sin filtro de fecha, todo pasa
    
    // Parsea string de fecha en formato 'YYYY-MM-DD'
    final parts = fechaStr.split('-'); // Divide fecha por guiones
    if (parts.length < 3) return true; // Si formato es inválido, lo deja pasar (no filtra)
    
    // Construye objeto DateTime desde los componentes parseados
    final fecha = DateTime(
      int.parse(parts[0]), // Año (índice 0)
      int.parse(parts[1]), // Mes (índice 1)
      int.parse(parts[2])); // Día (índice 2)
    
    // Verifica límite inferior: si fecha es anterior a _fechaInicio, NO coincide
    if (_fechaInicio != null && fecha.isBefore(_fechaInicio!)) return false;
    
    // Verifica límite superior: si fecha es posterior a _fechaFin, NO coincide
    if (_fechaFin != null && fecha.isAfter(_fechaFin!)) return false;
    
    return true; // Fecha está dentro del rango (o sin límites), coincide
  }

  // ═══════════════════════════════════════════════════════════════════════════
  // MÉTODOS DE ACCIONES - Gestionan interacciones del usuario
  // ═══════════════════════════════════════════════════════════════════════════

  // ─── Cerrar modal activo ───
  // Resetea variables de estado relacionadas con modales (registro, edición, perfil)
  void _cerrarModal() {
    setState(() { // Marca el estado para reconstrucción
      _modalModo = null; // Elimina el modo del modal (cierra el modal)
      _usuarioSeleccionado = null; // Limpia el usuario seleccionado (limpia datos del modal)
    });
  }

  // ─── Alternar estado de cuenta de un usuario ───
  // Cambia entre activo/inactivo y gestiona efectos secundarios (desconecta sesión si se desactiva)
  void _cambiarEstado(UsuarioAdmin u) {
    setState(() { // Marca el estado para reconstrucción
      // Alterna estado de cuenta: si está activo → inactivo, si está inactivo → activo
      u.cuenta = u.cuenta == EstadoCuenta.activo
          ? EstadoCuenta.inactivo // Si está activo, cambia a inactivo
          : EstadoCuenta.activo; // Si está inactivo, cambia a activo
      
      // Efecto secundario: si cuenta se desactiva, forzar cierre de sesión
      if (u.cuenta == EstadoCuenta.inactivo) { // Si cuenta fue desactivada
        u.sesion = EstadoSesion.sinSesion; // Desconecta la sesión (seguridad)
      }
    });
  }

  // ─── Confirmar y ejecutar eliminación de usuario ───
  // Elimina el usuario marcado en _usuarioParaEliminar de la lista de usuarios
  void _confirmarEliminacion() {
    if (_usuarioParaEliminar == null) return; // Validación: si no hay usuario marcado, no hace nada
    
    setState(() { // Marca el estado para reconstrucción
      // Elimina el usuario de la lista donde el ID coincida con el usuario a eliminar
      _usuarios.removeWhere((u) => u.id == _usuarioParaEliminar!.id);
      
      _usuarioParaEliminar = null; // Limpia variable (cierra modal de confirmación)
    });
  }

  // ─── Guardar usuario (registro o edición) ───
  // Maneja tanto registro de nuevo usuario como edición de usuario existente
  void _guardarUsuario(DatosUsuario datos) {
    setState(() { // Marca el estado para reconstrucción
      // ── CASO 1: REGISTRAR nuevo usuario ──
      if (_modalModo == ModalModo.registro) {
        // Calcula el próximo ID disponible (máximo ID existente + 1, o 1 si lista vacía)
        final nuevoId = _usuarios.isEmpty 
            ? 1 // Si no hay usuarios, ID es 1
            : _usuarios.map((u) => u.id).reduce((a, b) => a > b ? a : b) + 1; // Encuentra ID máximo y suma 1
        
        // Inserta nuevo usuario al INICIO de la lista (aparece primero en UI)
        _usuarios.insert(
          0, // Posición 0 (inicio de la lista)
          UsuarioAdmin( // Crea instancia de UsuarioAdmin con datos del modal
            id: nuevoId, // ID calculado
            nombre: datos.nombre, // Nombre del formulario
            segundoNombre: datos.segundoNombre, // Segundo nombre del formulario
            apellido: datos.apellido, // Apellido del formulario
            segundoApellido: datos.segundoApellido, // Segundo apellido del formulario
            correoCorporativo: datos.correoCorporativo, // Correo corporativo del formulario
            correoElectronico: datos.correoElectronico, // Correo electrónico del formulario
            telefono: datos.telefono, // Teléfono del formulario
            rol: datos.rol, // Rol del formulario (admin/agricultor)
            cuenta: EstadoCuenta.activo, // Nueva cuenta siempre empieza activa
            sesion: EstadoSesion.sinSesion, // Nueva cuenta no tiene sesión aún
            fechaRegistro: DateTime.now().toIso8601String(), // Fecha actual en formato ISO
          ),
        );
      } 
      // ── CASO 2: EDITAR usuario existente ──
      else if (_modalModo == ModalModo.editar && _usuarioSeleccionado != null) {
        // Busca índice del usuario en la lista por ID
        final index = _usuarios.indexWhere((u) => u.id == _usuarioSeleccionado!.id);
        
        if (index != -1) { // Si se encontró el usuario (índice válido)
          // Actualiza todos los campos editables del usuario encontrado
          _usuarios[index].nombre = datos.nombre; // Actualiza nombre
          _usuarios[index].segundoNombre = datos.segundoNombre; // Actualiza segundo nombre
          _usuarios[index].apellido = datos.apellido; // Actualiza apellido
          _usuarios[index].segundoApellido = datos.segundoApellido; // Actualiza segundo apellido
          _usuarios[index].correoCorporativo = datos.correoCorporativo; // Actualiza correo corporativo
          _usuarios[index].correoElectronico = datos.correoElectronico; // Actualiza correo electrónico
          _usuarios[index].telefono = datos.telefono; // Actualiza teléfono
          _usuarios[index].rol = datos.rol; // Actualiza rol
        }
      }
      
      _cerrarModal(); // Cierra el modal tras guardar (resetea variables de estado)
    });
  }

  // ─── Seleccionar fecha (inicio o fin) mediante DatePicker ───
  // Muestra selector de fechas nativo y actualiza rango de filtro
  Future<void> _seleccionarFecha(BuildContext context, bool esInicio) async {
    // Muestra el DatePicker nativo de Material
    final picked = await showDatePicker(
      context: context, // Contexto de la app
      initialDate: DateTime.now(), // Fecha inicial mostrada (hoy)
      firstDate: DateTime(2020), // Fecha mínima seleccionable (2020)
      lastDate: DateTime.now().add(const Duration(days: 365)), // Fecha máxima (hoy + 1 año)
      builder: (context, child) { // Personaliza tema del DatePicker
        return Theme(
          data: Theme.of(context).copyWith( // Copia tema actual y modifica colores
            colorScheme: const ColorScheme.light( // Esquema de color claro
              primary: PanelAdminStyles.primaryGreen, // Color primario (encabezado, botones)
              onPrimary: Colors.white, // Color de texto sobre primario
            ),
          ),
          child: child!, // Widget del DatePicker
        );
      },
    );
    
    // Si usuario seleccionó una fecha (no canceló)
    if (picked != null) {
      setState(() { // Actualiza estado
        if (esInicio) { // Si es fecha de inicio
          _fechaInicio = picked; // Actualiza fecha de inicio del rango
        } else { // Si es fecha de fin
          _fechaFin = picked; // Actualiza fecha de fin del rango
        }
      });
    }
  }

  // ═══════════════════════════════════════════════════════════════════════════
  // MÉTODO BUILD - Construye la interfaz del panel de administración
  // ═══════════════════════════════════════════════════════════════════════════
  @override
  Widget build(BuildContext context) {
    // ─── Obtiene dimensiones de pantalla para responsive ───
    final screenWidth = MediaQuery.of(context).size.width; // Ancho de pantalla en px
    final isMobile = screenWidth < 700; // Determina si es vista móvil (<700px)

    // ─── Estructura principal: Scaffold con Stack ───
    return Scaffold(
      backgroundColor: PanelAdminStyles.backgroundPage, // Color de fondo de toda la página
      body: Stack( // Stack permite superponer widgets (navbar encima del contenido)
        children: [
          // ═══ CAPA 1: Contenido principal (debajo de la navbar) ═══
          Positioned.fill( // Ocupa todo el espacio disponible
            child: Column( // Columna: espacio superior + contenido scrolleable
              children: [
                // ─── Espacio vacío para evitar que navbar tape contenido ───
                SizedBox(
                  // Calcula altura necesaria según tamaño de pantalla
                  height: screenWidth > 991
                      ? BarraAdminStyles.navbarHeight + // Altura de la barra
                          BarraAdminStyles.contentPaddingTop + // Padding superior del contenido
                          (BarraAdminStyles.navbarPaddingVertical * 2) // Padding vertical de la barra (arriba y abajo)
                      : BarraAdminStyles.navbarHeight + // Altura de la barra (móvil)
                          BarraAdminStyles.contentPaddingTop + // Padding superior del contenido
                          (BarraAdminStyles.navbarPaddingVertical * 2), // Padding vertical de la barra
                ),
                
                // ─── Contenido scrolleable principal ───
                Expanded( // Ocupa todo el espacio restante (permite scroll)
                  child: SingleChildScrollView( // Permite scroll vertical
                    padding: EdgeInsets.all(isMobile ? 16 : 32), // Padding adaptativo (16px móvil, 32px desktop)
                    child: Center( // Centra contenido horizontalmente
                      child: ConstrainedBox( // Limita ancho máximo del contenido
                        constraints: const BoxConstraints(maxWidth: 1220), // Ancho máximo 1220px (no se estira infinito)
                        child: Column( // Columna de secciones del panel
                          crossAxisAlignment: CrossAxisAlignment.stretch, // Widgets ocupan ancho completo
                          children: [
                            _buildHeader(isMobile), // Encabezado con título y botón de registro
                            const SizedBox(height: 18), // Espaciado vertical
                            _buildFiltersBar(isMobile), // Barra de filtros (búsqueda, rol, estado, etc.)
                            const SizedBox(height: 18), // Espaciado vertical
                            _buildSummaryStrip(isMobile), // Tira de resumen (totales, estadísticas)
                            const SizedBox(height: 18), // Espaciado vertical
                            _buildUsersGrid(isMobile), // Grid de tarjetas de usuarios
                            const SizedBox(height: 32), // Espaciado inferior
                          ],
                        ),
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ),
          
          // ═══ CAPA 2: Barra de navegación fija en la parte superior ═══
          Positioned(
            top: 0, // Fija en la parte superior
            left: 0, // Fija al borde izquierdo
            right: 0, // Fija al borde derecho
            child: const BarraAdmin(), // Widget de barra de navegación
          ),
          
          // ═══ CAPA 3: Modales con overlay de pantalla completa ═══
          // Solo se muestra si hay un modal activo o un usuario para eliminar
          if (_modalModo != null || _usuarioParaEliminar != null)
            _buildModalOverlay(), // Construye modal correspondiente con fondo oscuro
        ],
      ),
    );
  }

  // ═══════════════════════════════════════════════════════════════════════════
  // MÉTODOS HELPER - UI: Construcción de secciones de la interfaz
  // ═══════════════════════════════════════════════════════════════════════════

  // ─── Header (encabezado con título y botón de registro) ───────────────────
  Widget _buildHeader(bool isMobile) {
    // Layout adaptativo: columna en móvil, fila en desktop
    return isMobile
        ? Column( // Móvil: apila verticalmente
            crossAxisAlignment: CrossAxisAlignment.stretch, // Widgets ocupan ancho completo
            children: [
              _buildHeaderText(), // Texto del encabezado (título, descripción)
              const SizedBox(height: 14), // Espaciado vertical
              _buildCreateButton(), // Botón de registrar usuario
            ],
          )
        : Row( // Desktop: dispone horizontalmente
            crossAxisAlignment: CrossAxisAlignment.start, // Alinea widgets al inicio (arriba)
            children: [
              Expanded(child: _buildHeaderText()), // Texto toma espacio disponible
              const SizedBox(width: 20), // Espaciado horizontal
              _buildCreateButton(), // Botón a la derecha
            ],
          );
  }

  // ─── Texto del encabezado (eyebrow, título, descripción) ──────────────────
  Widget _buildHeaderText() {
    return Column( // Apila textos verticalmente
      crossAxisAlignment: CrossAxisAlignment.start, // Alinea textos a la izquierda
      children: [
        const Text('ADMINISTRACIÓN', style: PanelAdminStyles.eyebrowText), // Etiqueta superior (eyebrow)
        const SizedBox(height: 8), // Espaciado vertical
        const Text('Panel Administrador', style: PanelAdminStyles.h1Text), // Título principal
        const SizedBox(height: 10), // Espaciado vertical
        const Text( // Descripción del panel
          'Gestiona agricultores y administradores por nombre, correo, rol, estado de cuenta y fecha de registro.',
          style: PanelAdminStyles.headerDesc, // Estilo de descripción
        ),
      ],
    );
  }

  // ─── Botón de crear/registrar usuario ─────────────────────────────────────
  Widget _buildCreateButton() {
    return GestureDetector( // Detector de gestos (toques/clics)
      onTap: () => setState(() { // Al tocar, actualiza estado
        _modalModo = ModalModo.registro; // Activa modal de registro
        _usuarioSeleccionado = null; // Limpia selección (no hay usuario a editar)
      }),
      child: Container( // Contenedor del botón
        decoration: PanelAdminStyles.createBtnDecoration, // Estilo del botón (color, bordes)
        padding: const EdgeInsets.symmetric(horizontal: 18), // Padding horizontal interno
        constraints: const BoxConstraints(minHeight: 46), // Altura mínima del botón
        child: const Row( // Fila con icono y texto
          mainAxisSize: MainAxisSize.min, // Tamaño mínimo necesario (no se expande)
          children: [
            Icon(Icons.person_add, color: Colors.white, size: 18), // Icono de agregar persona
            SizedBox(width: 8), // Espaciado entre icono y texto
            Text( // Texto del botón
              'Registrar usuario',
              style: TextStyle(color: Colors.white, fontSize: 15, fontWeight: FontWeight.w800), // Estilo del texto
            ),
          ],
        ),
      ),
    );
  }

  // ─── Barra de filtros (búsqueda y filtros) ────────────────────────────────
  Widget _buildFiltersBar(bool isMobile) {
    return Container( // Contenedor de la barra
      padding: const EdgeInsets.all(18), // Padding interno
      decoration: PanelAdminStyles.filterBarDecoration, // Estilo del contenedor (borde, fondo)
      child: Column( // Apila filtros verticalmente
        crossAxisAlignment: CrossAxisAlignment.stretch, // Widgets ocupan ancho completo
        children: [
          // ── Campo de búsqueda (ancho completo, arriba) ──
          _buildSearchField(), // Campo de búsqueda por nombre/correo
          const SizedBox(height: 14), // Espaciado vertical
          
          // ── Filtros en grid/columna según vista ──
          isMobile
              ? Column( // Móvil: apila filtros en columna
                  crossAxisAlignment: CrossAxisAlignment.stretch, // Filtros ocupan ancho completo
                  children: _buildFilterFields(isMobile), // Lista de filtros
                )
              : Wrap( // Desktop: dispone filtros en grid flexible (wrap cuando no caben)
                  spacing: 14, // Espaciado horizontal entre filtros
                  runSpacing: 14, // Espaciado vertical entre filas
                  children: _buildFilterFields(isMobile), // Lista de filtros
                ),
        ],
      ),
    );
  }

  // ─── Campo de búsqueda con label ──────────────────────────────────────────
  Widget _buildSearchField() {
    return Column( // Apila label y campo verticalmente
      crossAxisAlignment: CrossAxisAlignment.start, // Alinea a la izquierda
      children: [
        const Text('Buscar usuario', style: PanelAdminStyles.labelText), // Label del campo
        const SizedBox(height: 8), // Espaciado vertical
        _SearchInput( // Widget personalizado de búsqueda (con icono y botón de limpiar)
          placeholder: 'Nombre, apellido, nombre completo o correo', // Placeholder del input
          onChanged: (v) => setState(() => _busqueda = v), // Al escribir, actualiza variable _busqueda
        ),
      ],
    );
  }

  // ─── Lista de widgets de filtros (dropdowns y fecha) ──────────────────────
  List<Widget> _buildFilterFields(bool isMobile) {
    // Determina ancho de cada filtro según vista
    final fieldWidth = isMobile ? double.infinity : 180.0; // Móvil: ancho completo, Desktop: 180px

    // Retorna lista de widgets de filtro
    return [
      // ── Filtro: Orden alfabético (A-Z / Z-A) ──
      _buildDropdownField<OrdenAlfabetico>(
        label: 'Orden alfabético', // Label del dropdown
        value: _orden, // Valor actual seleccionado
        width: fieldWidth, // Ancho del campo
        items: const [ // Opciones del dropdown
          DropdownMenuItem(value: OrdenAlfabetico.az, child: Text('A-Z')), // Opción A-Z
          DropdownMenuItem(value: OrdenAlfabetico.za, child: Text('Z-A')), // Opción Z-A
        ],
        onChanged: (v) => setState(() => _orden = v!), // Al cambiar, actualiza _orden
      ),
      
      // ── Filtro: Rol (Todos / Admin / Agricultor) ──
      _buildDropdownField<FiltroRol>(
        label: 'Rol', // Label del dropdown
        value: _filtroRol, // Valor actual seleccionado
        width: fieldWidth, // Ancho del campo
        items: const [ // Opciones del dropdown
          DropdownMenuItem(value: FiltroRol.todos, child: Text('Todos')), // Todos los roles
          DropdownMenuItem(value: FiltroRol.admin, child: Text('Admin')), // Solo admins
          DropdownMenuItem(value: FiltroRol.agricultor, child: Text('Agricultor')), // Solo agricultores
        ],
        onChanged: (v) => setState(() => _filtroRol = v!), // Al cambiar, actualiza _filtroRol
      ),
      
      // ── Filtro: Estado (Todos / Activo / Inactivo / En línea / Sin sesión) ──
      _buildDropdownField<FiltroEstado>(
        label: 'Estado', // Label del dropdown
        value: _filtroEstado, // Valor actual seleccionado
        width: fieldWidth, // Ancho del campo
        items: const [ // Opciones del dropdown
          DropdownMenuItem(value: FiltroEstado.todos, child: Text('Todos')), // Sin filtro
          DropdownMenuItem(value: FiltroEstado.activo, child: Text('Activo')), // Cuenta activa
          DropdownMenuItem(value: FiltroEstado.inactivo, child: Text('Inactivo')), // Cuenta inactiva
          DropdownMenuItem(value: FiltroEstado.enLinea, child: Text('En linea')), // Sesión activa
          DropdownMenuItem(value: FiltroEstado.sinSesion, child: Text('Sin sesion')), // Sin sesión
        ],
        onChanged: (v) => setState(() => _filtroEstado = v!), // Al cambiar, actualiza _filtroEstado
      ),
      
      // ── Filtro: Dispositivo (Todos / Vinculado / No vinculado) ──
      _buildDropdownField<FiltroDispositivo>(
        label: 'Dispositivo', // Label del dropdown
        value: _filtroDispositivo, // Valor actual seleccionado
        width: fieldWidth, // Ancho del campo
        items: const [ // Opciones del dropdown
          DropdownMenuItem(value: FiltroDispositivo.todos, child: Text('Todos')), // Sin filtro
          DropdownMenuItem(value: FiltroDispositivo.vinculado, child: Text('Dispositivo vinculado')), // Con dispositivo
          DropdownMenuItem(value: FiltroDispositivo.noVinculado, child: Text('Dispositivo no vinculado')), // Sin dispositivo
        ],
        onChanged: (v) => setState(() => _filtroDispositivo = v!), // Al cambiar, actualiza _filtroDispositivo
      ),
      
      // ── Filtro: Rango de fechas (Inicio - Fin) ──
      _buildDateRangeField(fieldWidth, isMobile), // Campo de selección de rango de fechas
    ];
  }

  // ─── Widget genérico de dropdown con label ────────────────────────────────
  // Construye un campo dropdown reutilizable con label y estilo consistente
  Widget _buildDropdownField<T>({
    required String label, // Texto del label
    required T value, // Valor actual seleccionado
    required List<DropdownMenuItem<T>> items, // Lista de opciones
    required ValueChanged<T?> onChanged, // Callback al cambiar selección
    required double width, // Ancho del campo
  }) {
    return SizedBox( // Contenedor con ancho fijo
      width: width, // Aplica ancho especificado
      child: Column( // Apila label y dropdown verticalmente
        crossAxisAlignment: CrossAxisAlignment.start, // Alinea a la izquierda
        children: [
          Text(label, style: PanelAdminStyles.labelText), // Label del dropdown
          const SizedBox(height: 8), // Espaciado vertical
          Container( // Contenedor del dropdown
            height: 44, // Altura fija del campo
            decoration: PanelAdminStyles.inputDecoration(), // Estilo del input (borde, fondo)
            padding: const EdgeInsets.symmetric(horizontal: 12), // Padding horizontal interno
            child: DropdownButtonHideUnderline( // Oculta línea inferior del dropdown
              child: DropdownButton<T>( // Widget dropdown nativo
                value: value, // Valor seleccionado
                isExpanded: true, // Ocupa ancho completo del contenedor
                icon: const Icon(Icons.keyboard_arrow_down, color: PanelAdminStyles.primaryGreen), // Icono de flecha
                style: const TextStyle( // Estilo del texto seleccionado
                  color: PanelAdminStyles.darkGreen, // Color del texto
                  fontSize: 14, // Tamaño del texto
                  fontFamily: 'Arial', // Fuente
                ),
                dropdownColor: PanelAdminStyles.backgroundWhite, // Color de fondo del menú desplegable
                menuMaxHeight: 300, // Altura máxima del menú (scroll si hay muchas opciones)
                items: items, // Opciones del dropdown
                onChanged: onChanged, // Callback al cambiar selección
              ),
            ),
          ),
        ],
      ),
    );
  }

  // ─── Campo de rango de fechas (inicio - fin) ──────────────────────────────
  Widget _buildDateRangeField(double width, bool isMobile) {
    return SizedBox( // Contenedor con ancho adaptativo
      width: isMobile ? double.infinity : 280, // Móvil: ancho completo, Desktop: 280px
      child: Column( // Apila label y campos de fecha verticalmente
        crossAxisAlignment: CrossAxisAlignment.start, // Alinea a la izquierda
        children: [
          const Text('Rango de fecha', style: PanelAdminStyles.labelText), // Label del campo
          const SizedBox(height: 8), // Espaciado vertical
          Row( // Fila con dos campos de fecha (inicio y fin)
            children: [
              Expanded(child: _buildDatePicker(esInicio: true)), // Campo de fecha de inicio
              const SizedBox(width: 10), // Espaciado horizontal entre campos
              Expanded(child: _buildDatePicker(esInicio: false)), // Campo de fecha de fin
            ],
          ),
        ],
      ),
    );
  }

  // ─── Widget de selector de fecha (inicio o fin) ───────────────────────────
  Widget _buildDatePicker({required bool esInicio}) {
    // Obtiene fecha actual según tipo (inicio o fin)
    final fecha = esInicio ? _fechaInicio : _fechaFin;
    // Label del campo según tipo
    final label = esInicio ? 'Inicio' : 'Fin';
    
    return GestureDetector( // Detector de gestos (toques/clics)
      onTap: () => _seleccionarFecha(context, esInicio), // Al tocar, abre DatePicker
      child: Container( // Contenedor del campo
        height: 44, // Altura fija del campo
        decoration: PanelAdminStyles.inputDecoration(), // Estilo del input (borde, fondo)
        padding: const EdgeInsets.symmetric(horizontal: 10), // Padding horizontal interno
        child: Row( // Fila con icono, texto y botón de limpiar
          children: [
            const Icon(Icons.calendar_today, size: 14, color: PanelAdminStyles.primaryGreen), // Icono de calendario
            const SizedBox(width: 6), // Espaciado entre icono y texto
            Expanded( // Texto toma espacio disponible
              child: Text(
                // Muestra fecha formateada si existe, o label placeholder si no
                fecha != null
                    ? '${fecha.day.toString().padLeft(2,'0')}/${fecha.month.toString().padLeft(2,'0')}/${fecha.year}' // Formato: DD/MM/YYYY
                    : label, // Placeholder: 'Inicio' o 'Fin'
                style: TextStyle(
                  fontSize: 13, // Tamaño del texto
                  color: fecha != null
                      ? PanelAdminStyles.darkGreen // Color si hay fecha seleccionada
                      : PanelAdminStyles.dtColor, // Color placeholder si no hay fecha
                ),
                overflow: TextOverflow.ellipsis, // Trunca texto si es muy largo
              ),
            ),
            // ── Botón de limpiar fecha (solo si hay fecha seleccionada) ──
            if (fecha != null)
              GestureDetector( // Detector de gestos
                onTap: () => setState(() { // Al tocar, limpia fecha
                  if (esInicio) { _fechaInicio = null; } // Limpia fecha de inicio
                  else { _fechaFin = null; } // Limpia fecha de fin
                }),
                child: const Icon(Icons.close, size: 14, color: PanelAdminStyles.dtColor), // Icono X
              ),
          ],
        ),
      ),
    );
  }

  // ─── Tira de resumen con estadísticas ─────────────────────────────────────
  Widget _buildSummaryStrip(bool isMobile) {
    // Obtiene lista de usuarios filtrados para mostrar estadísticas
    final filtrados = _usuariosFiltrados;
    
    // Define lista de items a mostrar: (número, etiqueta)
    final items = [
      (_usuarios.length.toString(), 'Usuarios registrados'), // Total de usuarios en sistema
      (filtrados.length.toString(), 'Resultados visibles'), // Total de usuarios tras aplicar filtros
      (_totalAgricultores.toString(), 'Agricultores'), // Total de usuarios con rol agricultor
      (_totalSesionesActivas.toString(), 'Con sesion activa'), // Total de usuarios con sesión activa
    ];

    // Layout adaptativo: columna en móvil, fila en desktop
    if (isMobile) {
      return Column( // Móvil: apila tarjetas verticalmente
        crossAxisAlignment: CrossAxisAlignment.stretch, // Tarjetas ocupan ancho completo
        children: items
            .asMap() // Convierte lista a mapa con índices
            .entries // Obtiene pares (índice, item)
            .map((e) => Padding( // Agrega padding entre tarjetas
                  padding: EdgeInsets.only(bottom: e.key < items.length - 1 ? 10 : 0), // Padding inferior excepto última tarjeta
                  child: _buildSummaryCard(e.value.$1, e.value.$2), // Construye tarjeta (número, etiqueta)
                ))
            .toList(), // Convierte a lista de widgets
      );
    }
    
    // Desktop: dispone tarjetas horizontalmente en fila
    return Row(
      children: items
          .asMap() // Convierte lista a mapa con índices
          .entries // Obtiene pares (índice, item)
          .map((e) => Expanded( // Cada tarjeta ocupa espacio equitativo
                child: Padding( // Agrega padding entre tarjetas
                  padding: EdgeInsets.only(left: e.key == 0 ? 0 : 7, right: e.key == items.length - 1 ? 0 : 7), // Padding horizontal excepto primera y última
                  child: _buildSummaryCard(e.value.$1, e.value.$2), // Construye tarjeta (número, etiqueta)
                ),
              ))
          .toList(), // Convierte a lista de widgets
    );
  }

  // ─── Tarjeta individual de resumen (número + etiqueta) ────────────────────
  Widget _buildSummaryCard(String numero, String etiqueta) {
    return Container( // Contenedor de la tarjeta
      padding: const EdgeInsets.all(18), // Padding interno
      decoration: PanelAdminStyles.summaryCardDecoration, // Estilo de la tarjeta (borde, fondo)
      child: Column( // Apila número y etiqueta verticalmente
        crossAxisAlignment: CrossAxisAlignment.start, // Alinea a la izquierda
        children: [
          Text(numero, style: PanelAdminStyles.summaryNumber), // Número grande (valor estadístico)
          const SizedBox(height: 5), // Espaciado vertical
          Text(etiqueta, style: PanelAdminStyles.summaryLabel), // Etiqueta descriptiva pequeña
        ],
      ),
    );
  }

  // ─── Grid de tarjetas de usuarios ─────────────────────────────────────────
  Widget _buildUsersGrid(bool isMobile) {
    // Obtiene lista de usuarios filtrados
    final filtrados = _usuariosFiltrados;
    
    // ── Caso: no hay usuarios que coincidan con filtros ──
    if (filtrados.isEmpty) {
      return Container( // Contenedor de estado vacío
        padding: const EdgeInsets.all(26), // Padding interno
        decoration: BoxDecoration( // Estilo del contenedor
          border: Border.all(color: PanelAdminStyles.borderGrey, style: BorderStyle.solid), // Borde gris
          borderRadius: BorderRadius.circular(8), // Esquinas redondeadas
        ),
        child: const Text( // Mensaje de estado vacío
          'No se encontraron usuarios con los filtros seleccionados.',
          style: PanelAdminStyles.emptyStateText, // Estilo del texto
          textAlign: TextAlign.center, // Centra texto
        ),
      );
    }

    // ── Caso: hay usuarios para mostrar en grid ──
    return LayoutBuilder(builder: (context, constraints) { // Construye layout según ancho disponible
      // Determina número de columnas según ancho disponible (responsive)
      final crossAxisCount = constraints.maxWidth > 900
          ? 3 // Desktop grande: 3 columnas
          : constraints.maxWidth > 600
              ? 2 // Tablet: 2 columnas
              : 1; // Móvil: 1 columna
      
      final spacing = 16.0; // Espaciado entre tarjetas
      // Calcula ancho de cada tarjeta según número de columnas y espaciado
      final itemWidth = (constraints.maxWidth - (spacing * (crossAxisCount - 1))) / crossAxisCount;

      // Usa Wrap para disponer tarjetas en grid flexible (wrap cuando no caben)
      return Wrap(
        spacing: spacing, // Espaciado horizontal entre tarjetas
        runSpacing: spacing, // Espaciado vertical entre filas
        children: filtrados.map((u) => SizedBox( // Para cada usuario filtrado
          width: itemWidth, // Ancho calculado por tarjeta
          child: _buildUserCard(u), // Construye tarjeta del usuario
        )).toList(), // Convierte a lista de widgets
      );
    });
  }

  // ─── Tarjeta individual de usuario ────────────────────────────────────────
  Widget _buildUserCard(UsuarioAdmin u) {
    return Container( // Contenedor de la tarjeta
      padding: const EdgeInsets.all(20), // Padding interno
      decoration: PanelAdminStyles.cardDecoration, // Estilo de la tarjeta (borde, sombra, fondo)
      child: Column( // Apila secciones verticalmente
        crossAxisAlignment: CrossAxisAlignment.start, // Alinea contenido a la izquierda
        children: [
          // ═══ SECCIÓN 1: Header (avatar + nombre + correo) ═══
          Row( // Fila con avatar y datos del usuario
            children: [
              // ── Avatar circular con iniciales ──
              Container(
                width: 52, // Ancho del avatar
                height: 52, // Altura del avatar
                decoration: PanelAdminStyles.avatarDecoration, // Estilo del avatar (circular, color)
                child: Center( // Centra contenido del avatar
                  child: Text(
                    u.iniciales, // Iniciales del usuario (ej: "JD")
                    style: const TextStyle( // Estilo de las iniciales
                        color: Colors.white, // Color blanco
                        fontWeight: FontWeight.w800, // Peso extra bold
                        fontSize: 18), // Tamaño 18px
                  ),
                ),
              ),
              const SizedBox(width: 14), // Espaciado horizontal entre avatar y texto
              
              // ── Información del usuario (nombre + correo) ──
              Expanded( // Toma espacio disponible (evita overflow)
                child: Column( // Apila nombre y correo verticalmente
                  crossAxisAlignment: CrossAxisAlignment.start, // Alinea a la izquierda
                  children: [
                    Text(u.nombreCompleto, style: PanelAdminStyles.cardName, overflow: TextOverflow.ellipsis), // Nombre completo truncado
                    const SizedBox(height: 4), // Espaciado vertical
                    Text(u.correoElectronico, style: PanelAdminStyles.cardEmail, overflow: TextOverflow.ellipsis), // Correo truncado
                  ],
                ),
              ),
            ],
          ),
          const SizedBox(height: 16), // Espaciado vertical entre secciones
          
          // ═══ SECCIÓN 2: Badges (rol, estado cuenta, estado sesión, dispositivo) ═══
          Wrap( // Wrap permite que badges fluyan y hagan wrap si no caben
            spacing: 8, // Espaciado horizontal entre badges
            runSpacing: 8, // Espaciado vertical entre filas de badges
            children: [
              // ── Badge: Rol (Admin / Agricultor) ──
              _buildBadge(u.rol.label, // Texto del rol
                  PanelAdminStyles.roleBg, PanelAdminStyles.roleText), // Colores del badge
              
              // ── Badge: Estado de cuenta (Activo / Inactivo) ──
              _buildBadge(
                u.cuenta.label, // Texto del estado de cuenta
                u.cuenta == EstadoCuenta.activo
                    ? PanelAdminStyles.activeBg // Fondo verde si activo
                    : PanelAdminStyles.inactiveBg, // Fondo rojo si inactivo
                u.cuenta == EstadoCuenta.activo
                    ? PanelAdminStyles.activeText // Texto verde si activo
                    : PanelAdminStyles.inactiveText, // Texto rojo si inactivo
              ),
              
              // ── Badge: Estado de sesión (En línea / Sin sesión) ──
              _buildBadge(
                u.sesion.label, // Texto del estado de sesión
                u.sesion == EstadoSesion.enLinea
                    ? PanelAdminStyles.activeBg // Fondo verde si en línea
                    : PanelAdminStyles.inactiveBg, // Fondo rojo si sin sesión
                u.sesion == EstadoSesion.enLinea
                    ? PanelAdminStyles.activeText // Texto verde si en línea
                    : PanelAdminStyles.inactiveText, // Texto rojo si sin sesión
              ),
              
              // ── Badge: Dispositivo (solo si existe dato de dispositivo) ──
              if (u.dispositivo != null)
                _buildBadge(
                  u.dispositivo!.label, // Texto del estado de dispositivo
                  u.dispositivo == EstadoDispositivo.vinculado
                      ? PanelAdminStyles.deviceLinkedBg // Fondo azul si vinculado
                      : PanelAdminStyles.deviceUnlinkedBg, // Fondo gris si no vinculado
                  u.dispositivo == EstadoDispositivo.vinculado
                      ? PanelAdminStyles.deviceLinkedText // Texto azul si vinculado
                      : PanelAdminStyles.deviceUnlinkedText, // Texto gris si no vinculado
                ),
            ],
          ),
          const SizedBox(height: 14), // Espaciado vertical entre secciones
          
          // ═══ SECCIÓN 3: Detalles (fecha de registro + teléfono) ═══
          Row( // Fila con dos columnas de detalles
            children: [
              Expanded(child: _buildDetail('Fecha', u.fechaRegistro)), // Columna 1: Fecha de registro
              const SizedBox(width: 12), // Espaciado horizontal entre columnas
              Expanded(child: _buildDetail('Teléfono', u.telefono)), // Columna 2: Teléfono
            ],
          ),
          const SizedBox(height: 18), // Espaciado vertical entre secciones
          
          // ═══ SECCIÓN 4: Acciones (botones de acciones del usuario) ═══
          _buildCardActions(u), // Construye grupo de botones de acciones
        ],
      ),
    );
  }

  // ─── Widget auxiliar: Badge (etiqueta de estado) ──────────────────────────
  Widget _buildBadge(String text, Color bg, Color color) {
    return Container( // Contenedor del badge
      padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 5), // Padding interno (horizontal y vertical)
      decoration: BoxDecoration(color: bg, borderRadius: BorderRadius.circular(8)), // Estilo: color de fondo y esquinas redondeadas
      child: Text(text, style: PanelAdminStyles.badgeText.copyWith(color: color)), // Texto con color personalizado según estado
    );
  }

  // ─── Widget auxiliar: Detalle (par dt-dd: término-definición) ─────────────
  Widget _buildDetail(String dt, String dd) {
    return Column( // Apila término y definición verticalmente
      crossAxisAlignment: CrossAxisAlignment.start, // Alinea a la izquierda
      children: [
        Text(dt, style: PanelAdminStyles.dtText), // Término (label): ej. "Fecha"
        const SizedBox(height: 4), // Espaciado vertical
        Text(dd, style: PanelAdminStyles.ddText, overflow: TextOverflow.ellipsis), // Definición (valor): ej. "2024-01-15", trunca si es largo
      ],
    );
  }

  // ─── Grupo de botones de acciones de la tarjeta ───────────────────────────
  Widget _buildCardActions(UsuarioAdmin u) {
    return Column( // Apila botones verticalmente
      crossAxisAlignment: CrossAxisAlignment.stretch, // Botones ocupan ancho completo
      children: [
        // ═══ BOTÓN CONDICIONAL: Acceder al panel (solo para agricultores) ═══
        if (u.rol == RolUsuario.agricultor) ...[ // Solo muestra si es agricultor
          _buildActionButton(
            label: 'Acceder al panel', // Texto del botón
            icon: Icons.login, // Icono de login
            decoration: PanelAdminStyles.accessPanelDecoration, // Estilo verde distintivo
            textColor: Colors.white, // Texto blanco
            onTap: () => Navigator.pushReplacementNamed(context, '/panel-agricultor'), // Navega a panel de agricultor (reemplaza ruta actual)
          ),
          const SizedBox(height: 8), // Espaciado vertical
        ],
        
        // ═══ FILA 1: Botones Editar y Perfil ═══
        Row( // Fila con 2 botones de igual tamaño
          children: [
            // ── Botón: Editar usuario ──
            Expanded( // Toma 50% del ancho
              child: _buildActionButton(
                label: 'Editar', // Texto del botón
                icon: Icons.edit, // Icono de editar
                decoration: PanelAdminStyles.actionBtnDecoration, // Estilo botón secundario
                textColor: PanelAdminStyles.darkGreen, // Texto verde oscuro
                onTap: () => setState(() { // Al tocar, actualiza estado
                  _modalModo = ModalModo.editar; // Activa modal de edición
                  _usuarioSeleccionado = u; // Guarda usuario a editar
                }),
              ),
            ),
            const SizedBox(width: 8), // Espaciado horizontal entre botones
            
            // ── Botón: Ver perfil usuario ──
            Expanded( // Toma 50% del ancho
              child: _buildActionButton(
                label: 'Perfil', // Texto del botón
                icon: Icons.badge, // Icono de credencial
                decoration: PanelAdminStyles.actionBtnDecoration, // Estilo botón secundario
                textColor: PanelAdminStyles.darkGreen, // Texto verde oscuro
                onTap: () => setState(() { // Al tocar, actualiza estado
                  _modalModo = ModalModo.perfil; // Activa modal de perfil
                  _usuarioSeleccionado = u; // Guarda usuario a visualizar
                }),
              ),
            ),
          ],
        ),
        const SizedBox(height: 8), // Espaciado vertical entre filas
        
        // ═══ FILA 2: Botones Activar/Desactivar y Eliminar ═══
        Row( // Fila con 2 botones de igual tamaño
          children: [
            // ── Botón: Activar/Desactivar cuenta ──
            Expanded( // Toma 50% del ancho
              child: _buildActionButton(
                label: u.cuenta == EstadoCuenta.activo ? 'Desactivar' : 'Activar', // Texto dinámico según estado actual
                icon: Icons.power_settings_new, // Icono de encendido/apagado
                decoration: PanelAdminStyles.actionBtnDecoration, // Estilo botón secundario
                textColor: PanelAdminStyles.darkGreen, // Texto verde oscuro
                onTap: () => _cambiarEstado(u), // Al tocar, alterna estado de cuenta
              ),
            ),
            const SizedBox(width: 8), // Espaciado horizontal entre botones
            
            // ── Botón: Eliminar usuario ──
            Expanded( // Toma 50% del ancho
              child: _buildActionButton(
                label: 'Eliminar', // Texto del botón
                icon: Icons.delete, // Icono de eliminar
                decoration: PanelAdminStyles.dangerBtnDecoration, // Estilo rojo de peligro
                textColor: PanelAdminStyles.dangerText, // Texto rojo
                onTap: () => setState(() => _usuarioParaEliminar = u), // Al tocar, marca usuario para eliminar (abre modal de confirmación)
              ),
            ),
          ],
        ),
      ],
    );
  }

  // ─── Widget genérico de botón de acción ───────────────────────────────────
  Widget _buildActionButton({
    required String label, // Texto del botón
    required IconData icon, // Icono del botón
    required BoxDecoration decoration, // Decoración (estilo del botón: color, bordes)
    required Color textColor, // Color del texto e icono
    required VoidCallback onTap, // Callback al tocar el botón
  }) {
    return GestureDetector( // Detector de gestos (toques/clics)
      onTap: onTap, // Ejecuta callback al tocar
      child: Container( // Contenedor del botón
        constraints: const BoxConstraints(minHeight: 40), // Altura mínima del botón (40px)
        decoration: decoration, // Aplica estilo del botón
        child: Center( // Centra contenido del botón
          child: Row( // Fila con icono y texto
            mainAxisSize: MainAxisSize.min, // Tamaño mínimo necesario (no se expande)
            children: [
              Icon(icon, size: 14, color: textColor), // Icono con tamaño 14px y color personalizado
              const SizedBox(width: 6), // Espaciado entre icono y texto
              Text(label, // Texto del botón
                  style: PanelAdminStyles.actionBtnText.copyWith(color: textColor)), // Estilo con color personalizado
            ],
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
    if (_usuarioParaEliminar != null) { // Si hay usuario marcado para eliminar
      return EliminarUsuario( // Renderiza modal de confirmación de eliminación
        usuario: _usuarioParaEliminar!, // Usuario a eliminar
        onCerrar: () => setState(() => _usuarioParaEliminar = null), // Callback para cancelar (limpia variable)
        onConfirmar: _confirmarEliminacion, // Callback para confirmar eliminación
      );
    }
    
    // ── CASO 2: Modal de registro de nuevo usuario ──
    if (_modalModo == ModalModo.registro) { // Si modo es registro
      return RegistroUsuario( // Renderiza modal de registro
        onCerrar: _cerrarModal, // Callback para cerrar modal (limpia variables de estado)
        onGuardar: _guardarUsuario, // Callback para guardar nuevo usuario
      );
    }
    
    // ── CASO 3: Modal de edición de usuario existente ──
    if (_modalModo == ModalModo.editar && _usuarioSeleccionado != null) { // Si modo es editar y hay usuario seleccionado
      return EditarUsuario( // Renderiza modal de edición
        usuario: _usuarioSeleccionado!, // Usuario a editar
        onCerrar: _cerrarModal, // Callback para cerrar modal
        onGuardar: _guardarUsuario, // Callback para guardar cambios
      );
    }
    
    // ── CASO 4: Modal de visualización de perfil ──
    if (_modalModo == ModalModo.perfil && _usuarioSeleccionado != null) { // Si modo es perfil y hay usuario seleccionado
      return PerfilUsuario( // Renderiza modal de visualización de perfil
        usuario: _usuarioSeleccionado!, // Usuario a visualizar
        onCerrar: _cerrarModal, // Callback para cerrar modal
      );
    }
    
    // ── CASO 5: No hay modal activo (no debería llegar aquí por la condición del if en build) ──
    return const SizedBox.shrink(); // Retorna widget vacío sin tamaño
  }
}

// ═══════════════════════════════════════════════════════════════════════════
// WIDGET AUXILIAR: _SearchInput - Campo de búsqueda personalizado
// Campo de texto con icono de búsqueda y botón de limpiar
// ═══════════════════════════════════════════════════════════════════════════
class _SearchInput extends StatefulWidget {
  final String placeholder; // Texto placeholder del input
  final ValueChanged<String> onChanged; // Callback cuando cambia el texto

  const _SearchInput({required this.placeholder, required this.onChanged}); // Constructor

  @override
  State<_SearchInput> createState() => _SearchInputState(); // Crea el estado
}

// ─── Estado del widget _SearchInput ────────────────────────────────────────
class _SearchInputState extends State<_SearchInput> {
  final _controller = TextEditingController(); // Controlador del TextField (gestiona texto)
  final _focus = FocusNode(); // Nodo de foco (detecta si input tiene foco)
  bool _focused = false; // Variable de estado: indica si input está enfocado

  // ═══ INICIALIZACIÓN ═══
  @override
  void initState() {
    super.initState(); // Llama al initState del padre
    // Escucha cambios de foco y actualiza estado cuando cambia
    _focus.addListener(() => setState(() => _focused = _focus.hasFocus)); // Cuando cambia foco, actualiza _focused
  }

  // ═══ LIMPIEZA ═══
  @override
  void dispose() {
    _controller.dispose(); // Libera recursos del controlador
    _focus.dispose(); // Libera recursos del nodo de foco
    super.dispose(); // Llama al dispose del padre
  }

  // ═══ BUILD ═══
  @override
  Widget build(BuildContext context) {
    return Container( // Contenedor principal del input
      decoration: PanelAdminStyles.inputDecoration(focused: _focused), // Estilo del input (cambia si está enfocado)
      child: Row( // Fila con icono, campo de texto y botón de limpiar
        children: [
          const SizedBox(width: 14), // Espaciado izquierdo
          const Icon(Icons.search, color: PanelAdminStyles.primaryGreen, size: 20), // Icono de búsqueda
          const SizedBox(width: 10), // Espaciado entre icono y campo
          
          // ── Campo de texto ──
          Expanded( // Toma espacio disponible
            child: TextField( // Widget de campo de texto
              controller: _controller, // Controlador de texto
              focusNode: _focus, // Nodo de foco
              decoration: InputDecoration( // Decoración del TextField
                hintText: widget.placeholder, // Texto placeholder
                hintStyle: const TextStyle(color: PanelAdminStyles.dtColor, fontSize: 14), // Estilo del placeholder
                border: InputBorder.none, // Sin borde (contenedor ya tiene borde)
                isDense: true, // Reduce espaciado vertical interno
                contentPadding: const EdgeInsets.symmetric(vertical: 12), // Padding vertical interno
              ),
              style: const TextStyle( // Estilo del texto ingresado
                  color: PanelAdminStyles.darkGreen, fontSize: 14), // Color verde oscuro, tamaño 14px
              onChanged: widget.onChanged, // Callback cuando cambia el texto
            ),
          ),
          
          // ── Botón de limpiar (solo visible si hay texto) ──
          if (_controller.text.isNotEmpty) // Solo muestra si hay texto en el campo
            GestureDetector( // Detector de gestos
              onTap: () { // Al tocar
                _controller.clear(); // Limpia el texto del controlador
                widget.onChanged(''); // Notifica cambio a vacío al callback
              },
              child: const Padding( // Padding del icono
                padding: EdgeInsets.symmetric(horizontal: 10), // Padding horizontal
                child: Icon(Icons.close, color: PanelAdminStyles.dtColor, size: 18), // Icono X
              ),
            ),
        ],
      ),
    );
  }
}
