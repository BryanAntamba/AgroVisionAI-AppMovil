// ════════════════════════════════════════════════════════════════════════════════
// ESTILOS PARA MODAL DE DESCONECTAR DISPOSITIVO IoT
// ════════════════════════════════════════════════════════════════════════════════
// Define estilos para el modal de confirmación destructiva que pregunta al usuario
// si desea desconectar el dispositivo IoT. Incluye overlay oscuro, botón rojo
// destructivo con sombra y botón de cancelar. Acción irreversible.
// ════════════════════════════════════════════════════════════════════════════════

import 'package:flutter/material.dart';

/// Clase que contiene todos los estilos estáticos para el modal de desconectar dispositivo
/// Incluye decoraciones para acción destructiva con color rojo de advertencia
class DesconectarDispositivoStyles {
  // ══════════════════════════════════════════════════════════════════════════════
  // CONSTANTES DE DISEÑO
  // ══════════════════════════════════════════════════════════════════════════════
  
  /// Ancho máximo del modal en píxeles (480px para modal compacto)
  static const double maxWidth = 480.0;
  
  // ══════════════════════════════════════════════════════════════════════════════
  // PALETA DE COLORES
  // ══════════════════════════════════════════════════════════════════════════════
  
  /// Color del overlay de fondo (verde oscuro con 45% de opacidad)
  static const Color overlayColor = Color.fromRGBO(7, 61, 43, 0.45);
  
  /// Fondo blanco puro del modal
  static const Color backgroundColor = Colors.white;
  
  /// Color de bordes gris verdoso (RGB: 215, 228, 220)
  static const Color borderColor = Color(0xFFd7e4dc);
  
  /// Color verde oscuro para título (RGB: 7, 61, 43)
  static const Color titleColor = Color(0xFF073d2b);
  
  /// Color verde medio para mensaje (RGB: 69, 102, 87)
  static const Color messageColor = Color(0xFF456657);
  
  /// Fondo verde claro para botón cerrar (RGB: 245, 250, 243)
  static const Color closeBtnBg = Color(0xFFf5faf3);
  
  /// Color verde oscuro para ícono de cerrar (RGB: 7, 61, 43)
  static const Color closeBtnColor = Color(0xFF073d2b);

  /// Fondo crema claro para botón cancelar (RGB: 251, 253, 249)
  static const Color cancelBtnBg = Color(0xFFfbfdf9);
  
  /// Rojo destructivo para botón desconectar (RGB: 163, 38, 38)
  static const Color destructBtnBg = Color(0xFFa32626);
  
  /// Sombra roja para botón destructivo (163, 38, 38 con 24% opacidad)
  static const Color destructBtnShadow = Color.fromRGBO(163, 38, 38, 0.24);

  // ══════════════════════════════════════════════════════════════════════════════
  // DECORACIONES DE COMPONENTES
  // ══════════════════════════════════════════════════════════════════════════════
  
  /// Decoración del contenedor del modal
  /// - Fondo: blanco puro
  /// - Borde: gris verdoso de 1px
  /// - Border radius: 8px
  /// - Sombra: verde oscuro 20% opacidad, desplazada 24px hacia abajo
  static BoxDecoration modalDecoration = BoxDecoration(
    color: backgroundColor,
    border: Border.all(color: borderColor),
    borderRadius: BorderRadius.circular(8),
    boxShadow: const [
      BoxShadow(
        color: Color.fromRGBO(7, 61, 43, 0.2),
        blurRadius: 48,
        offset: Offset(0, 24),
      ),
    ],
  );

  /// Decoración del botón de cerrar (X) en esquina superior derecha
  /// - Fondo: verde claro
  /// - Border radius: 8px
  static BoxDecoration closeBtnDecoration = BoxDecoration(
    color: closeBtnBg,
    borderRadius: BorderRadius.circular(8),
  );

  /// Decoración del botón "Cancelar"
  /// - Fondo: crema claro
  /// - Borde: gris verdoso de 1px
  /// - Border radius: 8px
  static BoxDecoration cancelBtnDecoration = BoxDecoration(
    color: cancelBtnBg,
    border: Border.all(color: borderColor),
    borderRadius: BorderRadius.circular(8),
  );

  /// Decoración del botón destructivo "Desconectar" (acción peligrosa)
  /// - Fondo: rojo oscuro sólido
  /// - Border radius: 8px
  /// - Sombra: roja 24% opacidad, desplazada 12px hacia abajo
  static BoxDecoration disconnectBtnDecoration = BoxDecoration(
    color: destructBtnBg,
    borderRadius: BorderRadius.circular(8),
    boxShadow: const [
      BoxShadow(
        color: destructBtnShadow,
        blurRadius: 24,
        offset: Offset(0, 12),
      ),
    ],
  );

  // ══════════════════════════════════════════════════════════════════════════════
  // ESTILOS DE TEXTO
  // ══════════════════════════════════════════════════════════════════════════════
  
  /// Estilo para el título del modal "¿Desconectar dispositivo?"
  /// - Color: verde oscuro
  /// - Tamaño: 28px
  /// - Peso: 800 (extra bold)
  /// - Line height: 1.15
  static const TextStyle titleStyle = TextStyle(
    color: titleColor,
    fontSize: 28,
    fontWeight: FontWeight.w800,
    height: 1.15,
  );

  /// Estilo para el mensaje de confirmación/advertencia
  /// - Color: verde medio
  /// - Tamaño: 15px
  /// - Line height: 1.5
  static const TextStyle messageStyle = TextStyle(
    color: messageColor,
    fontSize: 15,
    height: 1.5,
  );

  /// Estilo para el botón de cancelar
  /// - Color: verde oscuro
  /// - Tamaño: 16px
  /// - Peso: 800 (extra bold)
  static const TextStyle cancelBtnStyle = TextStyle(
    color: titleColor,
    fontSize: 16,
    fontWeight: FontWeight.w800,
  );

  /// Estilo para el botón destructivo "Desconectar"
  /// - Color: blanco
  /// - Tamaño: 16px
  /// - Peso: 800 (extra bold)
  static const TextStyle disconnectBtnStyle = TextStyle(
    color: Colors.white,
    fontSize: 16,
    fontWeight: FontWeight.w800,
  );
}
