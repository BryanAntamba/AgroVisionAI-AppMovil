// ═══════════════════════════════════════════════════════════════════════════
// CREDENCIALES Y ROLES - CONFIGURACIÓN DE AUTENTICACIÓN
// ═══════════════════════════════════════════════════════════════════════════
// Define las credenciales hardcodeadas para usuarios del sistema y
// los permisos de acceso basados en roles.
// ═══════════════════════════════════════════════════════════════════════════

/// Clase que representa las credenciales de un usuario
/// Contiene correo, contraseña y rol asociado
class Credenciales {
  final String correo;       // Correo electrónico del usuario
  final String password;     // Contraseña sin encriptar (solo para simulación)
  final String rol;          // Rol asignado (AGRICULTOR o ADMIN)

  /// Constructor con parámetros nombrados requeridos
  const Credenciales({
    required this.correo,
    required this.password,
    required this.rol,
  });
}

/// Mapa de credenciales predefinidas para autenticación simulada
/// Clave: identificador del usuario (agricultor, admin)
/// Valor: objeto Credenciales con los datos de acceso
const Map<String, Credenciales> credenciales = {
  // Usuario agricultor con acceso a funciones de monitoreo y datos IoT
  'agricultor': Credenciales(
    correo: 'agricultor@agrovision.com',      // Correo corporativo del agricultor
    password: 'agricultor123',                // Contraseña de prueba
    rol: 'AGRICULTOR',                        // Rol con permisos limitados
  ),
  // Usuario administrador con acceso completo al sistema
  'admin': Credenciales(
    correo: 'admin@agrovision.com',           // Correo corporativo del admin
    password: 'admin123',                     // Contraseña de prueba
    rol: 'ADMIN',                             // Rol con todos los permisos
  ),
};

/// Mapa que define las rutas/funciones accesibles por cada rol
/// Clave: nombre del rol (AGRICULTOR, ADMIN)
/// Valor: lista de rutas o secciones permitidas
const Map<String, List<String>> rolesAcceso = {
  // Permisos del rol AGRICULTOR: acceso a funciones operativas
  'AGRICULTOR': ['panel-agricultor', 'historial', 'alertas', 'boton-iot'],
  // Permisos del rol ADMIN: acceso a gestión y configuración
  'ADMIN': ['panel-admin', 'usuarios', 'reportes', 'configuracion'],
};
