// ═══════════════════════════════════════════════════════════════════════════
// DATOS SIMULADOS ADMIN - GESTIÓN DE USUARIOS DEL SISTEMA
// ═══════════════════════════════════════════════════════════════════════════
// Define tipos, modelos y datos de usuarios para el panel de administración
// ═══════════════════════════════════════════════════════════════════════════

// ─── Tipos / Enums ────────────────────────────────────────────────────────────

/// Enumeración de los roles disponibles en el sistema
enum RolUsuario { 
  admin,        // Administrador con acceso completo
  agricultor    // Usuario operativo con acceso limitado
}

/// Extensión para obtener etiquetas legibles de los roles
extension RolUsuarioLabel on RolUsuario {
  String get label {
    switch (this) {
      case RolUsuario.admin:       // Si el rol es admin
        return 'Admin';            // Retorna "Admin"
      case RolUsuario.agricultor:  // Si el rol es agricultor
        return 'Agricultor';       // Retorna "Agricultor"
    }
  }
}

/// Enumeración del estado de la cuenta del usuario
enum EstadoCuenta { 
  activo,    // Cuenta habilitada y funcional
  inactivo   // Cuenta deshabilitada temporalmente
}

/// Extensión para obtener etiquetas legibles del estado de cuenta
extension EstadoCuentaLabel on EstadoCuenta {
  String get label => this == EstadoCuenta.activo ? 'Activo' : 'Inactivo'; // Operador ternario para etiqueta
}

/// Enumeración del estado de sesión del usuario
enum EstadoSesion { 
  enLinea,    // Usuario actualmente conectado
  sinSesion   // Usuario desconectado
}

/// Extensión para obtener etiquetas legibles del estado de sesión
extension EstadoSesionLabel on EstadoSesion {
  String get label => this == EstadoSesion.enLinea ? 'En linea' : 'Sin sesion'; // Operador ternario para etiqueta
}

/// Enumeración del estado de vinculación con dispositivos IoT
enum EstadoDispositivo { 
  vinculado,     // Dispositivo IoT vinculado al usuario
  noVinculado    // Sin dispositivo vinculado
}

/// Extensión para obtener etiquetas legibles del estado de dispositivo
extension EstadoDispositivoLabel on EstadoDispositivo {
  String get label =>
      this == EstadoDispositivo.vinculado              // Si está vinculado
          ? 'Dispositivo vinculado'                    // Retorna texto de vinculación
          : 'Dispositivo no vinculado';                // Retorna texto de no vinculación
}

// ─── Modelo ──────────────────────────────────────────────────────────────────

/// Clase que representa un usuario en el panel de administración
/// Contiene toda la información personal y de estado del usuario
class UsuarioAdmin {
  final int id;                       // Identificador único del usuario (no modificable)
  String nombre;                      // Primer nombre (modificable)
  String segundoNombre;               // Segundo nombre opcional (modificable)
  String apellido;                    // Primer apellido (modificable)
  String segundoApellido;             // Segundo apellido opcional (modificable)
  String correoCorporativo;           // Email corporativo @agrovision.com (modificable)
  String correoElectronico;           // Email personal del usuario (modificable)
  String telefono;                    // Número de teléfono de contacto (modificable)
  RolUsuario rol;                     // Rol asignado en el sistema (modificable)
  EstadoCuenta cuenta;                // Estado de la cuenta (modificable)
  EstadoSesion sesion;                // Estado de conexión actual (modificable)
  EstadoDispositivo? dispositivo;     // Estado del dispositivo IoT (opcional, modificable)
  String fechaRegistro;               // Fecha de registro en el sistema (no modificable)

  /// Constructor con parámetros nombrados (algunos con valores por defecto)
  UsuarioAdmin({
    required this.id,                              // ID obligatorio
    required this.nombre,                          // Nombre obligatorio
    this.segundoNombre = '',                       // Segundo nombre por defecto vacío
    required this.apellido,                        // Apellido obligatorio
    this.segundoApellido = '',                     // Segundo apellido por defecto vacío
    required this.correoCorporativo,               // Correo corporativo obligatorio
    required this.correoElectronico,               // Correo personal obligatorio
    required this.telefono,                        // Teléfono obligatorio
    required this.rol,                             // Rol obligatorio
    this.cuenta = EstadoCuenta.activo,             // Cuenta activa por defecto
    this.sesion = EstadoSesion.sinSesion,          // Sin sesión por defecto
    this.dispositivo,                              // Dispositivo opcional (puede ser null)
    required this.fechaRegistro,                   // Fecha de registro obligatoria
  });

  /// Getter que construye el nombre completo concatenando todos los nombres
  /// Filtra valores vacíos y los une con espacios
  String get nombreCompleto => [nombre, segundoNombre, apellido, segundoApellido]
      .where((p) => p.isNotEmpty)                  // Filtra strings no vacíos
      .join(' ');                                  // Une con espacios

  /// Getter que genera iniciales tomando primera letra de nombre y apellido
  /// Convierte a mayúsculas para consistencia visual
  String get iniciales =>
      '${nombre.isNotEmpty ? nombre[0] : ''}${apellido.isNotEmpty ? apellido[0] : ''}'
          .toUpperCase();                          // Convierte a mayúsculas
}

// ─── Datos simulados ─────────────────────────────────────────────────────────

/// Lista de usuarios simulados para el panel de administración
/// Representa diferentes escenarios de usuarios (activos, inactivos, con/sin dispositivo)
final List<UsuarioAdmin> datosSimuladosAdmin = [
  // Usuario 1: Agricultor activo con dispositivo vinculado y sesión activa
  UsuarioAdmin(
    id: 1,                                            // Primer usuario del sistema
    nombre: 'Carlos',                                 // Primer nombre
    segundoNombre: 'Andrés',                          // Segundo nombre
    apellido: 'Ramírez',                              // Primer apellido
    segundoApellido: 'Mora',                          // Segundo apellido
    correoCorporativo: 'c.ramirez@agrovision.com',   // Email corporativo
    correoElectronico: 'carlos.ramirez@gmail.com',   // Email personal
    telefono: '987654321',                            // Teléfono de contacto
    rol: RolUsuario.agricultor,                       // Rol operativo
    cuenta: EstadoCuenta.activo,                      // Cuenta habilitada
    sesion: EstadoSesion.enLinea,                     // Actualmente conectado
    dispositivo: EstadoDispositivo.vinculado,         // Tiene dispositivo IoT vinculado
    fechaRegistro: '2025-03-12',                      // Registrado en marzo 2025
  ),
  // Usuario 2: Agricultor activo sin dispositivo y sin sesión
  UsuarioAdmin(
    id: 2,                                            // Segundo usuario del sistema
    nombre: 'María',                                  // Primer nombre
    segundoNombre: '',                                // Sin segundo nombre
    apellido: 'González',                             // Primer apellido
    segundoApellido: 'Ríos',                          // Segundo apellido
    correoCorporativo: 'm.gonzalez@agrovision.com',  // Email corporativo
    correoElectronico: 'maria.gonzalez@gmail.com',   // Email personal
    telefono: '976543210',                            // Teléfono de contacto
    rol: RolUsuario.agricultor,                       // Rol operativo
    cuenta: EstadoCuenta.activo,                      // Cuenta habilitada
    sesion: EstadoSesion.sinSesion,                   // Desconectado
    dispositivo: EstadoDispositivo.noVinculado,       // Sin dispositivo IoT
    fechaRegistro: '2025-04-05',                      // Registrado en abril 2025
  ),
  // Usuario 3: Administrador activo con sesión activa (sin dispositivo)
  UsuarioAdmin(
    id: 3,                                            // Tercer usuario del sistema
    nombre: 'Jorge',                                  // Primer nombre
    segundoNombre: 'Luis',                            // Segundo nombre
    apellido: 'Peña',                                 // Primer apellido
    segundoApellido: '',                              // Sin segundo apellido
    correoCorporativo: 'j.pena@agrovision.com',      // Email corporativo
    correoElectronico: 'jorge.pena@outlook.com',     // Email personal (Outlook)
    telefono: '965432109',                            // Teléfono de contacto
    rol: RolUsuario.admin,                            // Rol administrativo
    cuenta: EstadoCuenta.activo,                      // Cuenta habilitada
    sesion: EstadoSesion.enLinea,                     // Actualmente conectado
    fechaRegistro: '2025-01-20',                      // Registrado en enero 2025
  ),
  // Usuario 4: Agricultor inactivo sin sesión y sin dispositivo
  UsuarioAdmin(
    id: 4,                                            // Cuarto usuario del sistema
    nombre: 'Ana',                                    // Primer nombre
    segundoNombre: 'Sofía',                           // Segundo nombre
    apellido: 'Torres',                               // Primer apellido
    segundoApellido: 'Vega',                          // Segundo apellido
    correoCorporativo: 'a.torres@agrovision.com',    // Email corporativo
    correoElectronico: 'ana.torres@gmail.com',       // Email personal
    telefono: '954321098',                            // Teléfono de contacto
    rol: RolUsuario.agricultor,                       // Rol operativo
    cuenta: EstadoCuenta.inactivo,                    // Cuenta deshabilitada
    sesion: EstadoSesion.sinSesion,                   // Desconectado
    dispositivo: EstadoDispositivo.noVinculado,       // Sin dispositivo IoT
    fechaRegistro: '2025-02-18',                      // Registrado en febrero 2025
  ),
  // Usuario 5: Agricultor activo con dispositivo vinculado y sesión activa
  UsuarioAdmin(
    id: 5,                                            // Quinto usuario del sistema
    nombre: 'Pedro',                                  // Primer nombre
    segundoNombre: '',                                // Sin segundo nombre
    apellido: 'Castro',                               // Primer apellido
    segundoApellido: 'Lima',                          // Segundo apellido
    correoCorporativo: 'p.castro@agrovision.com',    // Email corporativo
    correoElectronico: 'pedro.castro@gmail.com',     // Email personal
    telefono: '943210987',                            // Teléfono de contacto
    rol: RolUsuario.agricultor,                       // Rol operativo
    cuenta: EstadoCuenta.activo,                      // Cuenta habilitada
    sesion: EstadoSesion.enLinea,                     // Actualmente conectado
    dispositivo: EstadoDispositivo.vinculado,         // Tiene dispositivo IoT vinculado
    fechaRegistro: '2025-05-30',                      // Registrado en mayo 2025
  ),
  // Usuario 6: Administrador activo sin sesión (sin dispositivo)
  UsuarioAdmin(
    id: 6,                                            // Sexto usuario del sistema
    nombre: 'Lucía',                                  // Primer nombre
    segundoNombre: 'Fernanda',                        // Segundo nombre
    apellido: 'Díaz',                                 // Primer apellido
    segundoApellido: '',                              // Sin segundo apellido
    correoCorporativo: 'l.diaz@agrovision.com',      // Email corporativo
    correoElectronico: 'lucia.diaz@gmail.com',       // Email personal
    telefono: '932109876',                            // Teléfono de contacto
    rol: RolUsuario.admin,                            // Rol administrativo
    cuenta: EstadoCuenta.activo,                      // Cuenta habilitada
    sesion: EstadoSesion.sinSesion,                   // Desconectado
    fechaRegistro: '2025-06-01',                      // Registrado en junio 2025
  ),
];
