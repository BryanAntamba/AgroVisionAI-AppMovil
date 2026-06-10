// ─── Tipos / Enums ────────────────────────────────────────────────────────────

enum RolUsuario { admin, agricultor }

extension RolUsuarioLabel on RolUsuario {
  String get label {
    switch (this) {
      case RolUsuario.admin:
        return 'Admin';
      case RolUsuario.agricultor:
        return 'Agricultor';
    }
  }
}

enum EstadoCuenta { activo, inactivo }

extension EstadoCuentaLabel on EstadoCuenta {
  String get label => this == EstadoCuenta.activo ? 'Activo' : 'Inactivo';
}

enum EstadoSesion { enLinea, sinSesion }

extension EstadoSesionLabel on EstadoSesion {
  String get label => this == EstadoSesion.enLinea ? 'En linea' : 'Sin sesion';
}

enum EstadoDispositivo { vinculado, noVinculado }

extension EstadoDispositivoLabel on EstadoDispositivo {
  String get label =>
      this == EstadoDispositivo.vinculado
          ? 'Dispositivo vinculado'
          : 'Dispositivo no vinculado';
}

// ─── Modelo ──────────────────────────────────────────────────────────────────

class UsuarioAdmin {
  final int id;
  String nombre;
  String segundoNombre;
  String apellido;
  String segundoApellido;
  String correoCorporativo;
  String correoElectronico;
  String telefono;
  RolUsuario rol;
  EstadoCuenta cuenta;
  EstadoSesion sesion;
  EstadoDispositivo? dispositivo;
  String fechaRegistro;

  UsuarioAdmin({
    required this.id,
    required this.nombre,
    this.segundoNombre = '',
    required this.apellido,
    this.segundoApellido = '',
    required this.correoCorporativo,
    required this.correoElectronico,
    required this.telefono,
    required this.rol,
    this.cuenta = EstadoCuenta.activo,
    this.sesion = EstadoSesion.sinSesion,
    this.dispositivo,
    required this.fechaRegistro,
  });

  String get nombreCompleto => [nombre, segundoNombre, apellido, segundoApellido]
      .where((p) => p.isNotEmpty)
      .join(' ');

  String get iniciales =>
      '${nombre.isNotEmpty ? nombre[0] : ''}${apellido.isNotEmpty ? apellido[0] : ''}'
          .toUpperCase();
}

// ─── Datos simulados ─────────────────────────────────────────────────────────

final List<UsuarioAdmin> datosSimuladosAdmin = [
  UsuarioAdmin(
    id: 1,
    nombre: 'Carlos',
    segundoNombre: 'Andrés',
    apellido: 'Ramírez',
    segundoApellido: 'Mora',
    correoCorporativo: 'c.ramirez@agrovision.com',
    correoElectronico: 'carlos.ramirez@gmail.com',
    telefono: '987654321',
    rol: RolUsuario.agricultor,
    cuenta: EstadoCuenta.activo,
    sesion: EstadoSesion.enLinea,
    dispositivo: EstadoDispositivo.vinculado,
    fechaRegistro: '2025-03-12',
  ),
  UsuarioAdmin(
    id: 2,
    nombre: 'María',
    segundoNombre: '',
    apellido: 'González',
    segundoApellido: 'Ríos',
    correoCorporativo: 'm.gonzalez@agrovision.com',
    correoElectronico: 'maria.gonzalez@gmail.com',
    telefono: '976543210',
    rol: RolUsuario.agricultor,
    cuenta: EstadoCuenta.activo,
    sesion: EstadoSesion.sinSesion,
    dispositivo: EstadoDispositivo.noVinculado,
    fechaRegistro: '2025-04-05',
  ),
  UsuarioAdmin(
    id: 3,
    nombre: 'Jorge',
    segundoNombre: 'Luis',
    apellido: 'Peña',
    segundoApellido: '',
    correoCorporativo: 'j.pena@agrovision.com',
    correoElectronico: 'jorge.pena@outlook.com',
    telefono: '965432109',
    rol: RolUsuario.admin,
    cuenta: EstadoCuenta.activo,
    sesion: EstadoSesion.enLinea,
    fechaRegistro: '2025-01-20',
  ),
  UsuarioAdmin(
    id: 4,
    nombre: 'Ana',
    segundoNombre: 'Sofía',
    apellido: 'Torres',
    segundoApellido: 'Vega',
    correoCorporativo: 'a.torres@agrovision.com',
    correoElectronico: 'ana.torres@gmail.com',
    telefono: '954321098',
    rol: RolUsuario.agricultor,
    cuenta: EstadoCuenta.inactivo,
    sesion: EstadoSesion.sinSesion,
    dispositivo: EstadoDispositivo.noVinculado,
    fechaRegistro: '2025-02-18',
  ),
  UsuarioAdmin(
    id: 5,
    nombre: 'Pedro',
    segundoNombre: '',
    apellido: 'Castro',
    segundoApellido: 'Lima',
    correoCorporativo: 'p.castro@agrovision.com',
    correoElectronico: 'pedro.castro@gmail.com',
    telefono: '943210987',
    rol: RolUsuario.agricultor,
    cuenta: EstadoCuenta.activo,
    sesion: EstadoSesion.enLinea,
    dispositivo: EstadoDispositivo.vinculado,
    fechaRegistro: '2025-05-30',
  ),
  UsuarioAdmin(
    id: 6,
    nombre: 'Lucía',
    segundoNombre: 'Fernanda',
    apellido: 'Díaz',
    segundoApellido: '',
    correoCorporativo: 'l.diaz@agrovision.com',
    correoElectronico: 'lucia.diaz@gmail.com',
    telefono: '932109876',
    rol: RolUsuario.admin,
    cuenta: EstadoCuenta.activo,
    sesion: EstadoSesion.sinSesion,
    fechaRegistro: '2025-06-01',
  ),
];
