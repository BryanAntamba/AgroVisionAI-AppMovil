enum RolUsuario { admin, agricultor }

enum EstadoCuenta { activo, inactivo }

enum EstadoSesion { enLinea, sinSesion }

extension RolUsuarioLabel on RolUsuario {
  String get label => this == RolUsuario.admin ? 'Admin' : 'Agricultor';

  static RolUsuario fromLabel(String value) =>
      value == 'Admin' ? RolUsuario.admin : RolUsuario.agricultor;
}

extension EstadoCuentaLabel on EstadoCuenta {
  String get label => this == EstadoCuenta.activo ? 'Activo' : 'Inactivo';
}

extension EstadoSesionLabel on EstadoSesion {
  String get label => this == EstadoSesion.enLinea ? 'En linea' : 'Sin sesion';
}

class UsuarioAdmin {
  UsuarioAdmin({
    required this.id,
    required this.nombre,
    required this.segundoNombre,
    required this.apellido,
    required this.segundoApellido,
    required this.correoCorporativo,
    required this.correoElectronico,
    required this.telefono,
    required this.rol,
    required this.cuenta,
    required this.sesion,
    required this.fechaRegistro,
  });

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
  final String fechaRegistro;

  String get nombreCompleto => [
        nombre,
        segundoNombre,
        apellido,
        segundoApellido,
      ].where((p) => p.isNotEmpty).join(' ');

  String get iniciales {
    final n = nombre.isNotEmpty ? nombre[0] : '';
    final a = apellido.isNotEmpty ? apellido[0] : '';
    return '$n$a'.toUpperCase();
  }

  static List<UsuarioAdmin> datosIniciales() => [
        UsuarioAdmin(
          id: 1,
          nombre: 'Carlos',
          segundoNombre: 'Andres',
          apellido: 'Mendoza',
          segundoApellido: 'Ruiz',
          correoCorporativo: 'carlos.mendoza@agrovision.com',
          correoElectronico: 'carlos.mendoza@gmail.com',
          telefono: '994521188',
          rol: RolUsuario.agricultor,
          cuenta: EstadoCuenta.activo,
          sesion: EstadoSesion.enLinea,
          fechaRegistro: '2026-05-18',
        ),
        UsuarioAdmin(
          id: 2,
          nombre: 'Mariana',
          segundoNombre: 'Isabel',
          apellido: 'Lopez',
          segundoApellido: 'Vera',
          correoCorporativo: 'mariana.lopez@agrovision.com',
          correoElectronico: 'mariana.lopez@gmail.com',
          telefono: '982146701',
          rol: RolUsuario.agricultor,
          cuenta: EstadoCuenta.inactivo,
          sesion: EstadoSesion.sinSesion,
          fechaRegistro: '2026-04-28',
        ),
        UsuarioAdmin(
          id: 3,
          nombre: 'Jose',
          segundoNombre: 'Miguel',
          apellido: 'Cabrera',
          segundoApellido: 'Solis',
          correoCorporativo: 'jose.cabrera@agrovision.com',
          correoElectronico: 'jose.cabrera@gmail.com',
          telefono: '973358902',
          rol: RolUsuario.admin,
          cuenta: EstadoCuenta.activo,
          sesion: EstadoSesion.enLinea,
          fechaRegistro: '2026-03-12',
        ),
        UsuarioAdmin(
          id: 4,
          nombre: 'Daniela',
          segundoNombre: 'Sofia',
          apellido: 'Paredes',
          segundoApellido: 'Mora',
          correoCorporativo: 'daniela.paredes@agrovision.com',
          correoElectronico: 'daniela.paredes@gmail.com',
          telefono: '968812034',
          rol: RolUsuario.agricultor,
          cuenta: EstadoCuenta.activo,
          sesion: EstadoSesion.sinSesion,
          fechaRegistro: '2026-02-07',
        ),
        UsuarioAdmin(
          id: 5,
          nombre: 'Luis',
          segundoNombre: 'Fernando',
          apellido: 'Aguirre',
          segundoApellido: 'Torres',
          correoCorporativo: 'luis.aguirre@agrovision.com',
          correoElectronico: 'luis.aguirre@gmail.com',
          telefono: '951147790',
          rol: RolUsuario.admin,
          cuenta: EstadoCuenta.inactivo,
          sesion: EstadoSesion.sinSesion,
          fechaRegistro: '2025-12-21',
        ),
        UsuarioAdmin(
          id: 6,
          nombre: 'Valeria',
          segundoNombre: 'Emilia',
          apellido: 'Sanchez',
          segundoApellido: 'Castro',
          correoCorporativo: 'valeria.sanchez@agrovision.com',
          correoElectronico: 'valeria.sanchez@gmail.com',
          telefono: '997804432',
          rol: RolUsuario.agricultor,
          cuenta: EstadoCuenta.activo,
          sesion: EstadoSesion.enLinea,
          fechaRegistro: '2026-01-15',
        ),
      ];
}
