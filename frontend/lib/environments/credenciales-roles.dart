class Credenciales {
  final String correo;
  final String password;
  final String rol;

  const Credenciales({
    required this.correo,
    required this.password,
    required this.rol,
  });
}

const Map<String, Credenciales> credenciales = {
  'agricultor': Credenciales(
    correo: 'agricultor@agrovision.com',
    password: 'agricultor123',
    rol: 'AGRICULTOR',
  ),
  'admin': Credenciales(
    correo: 'admin@agrovision.com',
    password: 'admin123',
    rol: 'ADMIN',
  ),
};

const Map<String, List<String>> rolesAcceso = {
  'AGRICULTOR': ['panel-agricultor', 'historial', 'alertas', 'boton-iot'],
  'ADMIN': ['panel-admin', 'usuarios', 'reportes', 'configuracion'],
};
