import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:shared_preferences/shared_preferences.dart';
import '../app.dart';
import '../styles/navbars-styles/barra-agricultor.dart';

class BarraAgricultor extends StatefulWidget {
  const BarraAgricultor({super.key});

  @override
  State<BarraAgricultor> createState() => _BarraAgricultorState();
}

class _BarraAgricultorState extends State<BarraAgricultor>
    with SingleTickerProviderStateMixin {
  bool _isMenuOpen = false;
  bool _historialHabilitado = true;

  // Animación hamburguesa
  late AnimationController _menuAnimController;

  @override
  void initState() {
    super.initState();
    _cargarConfiguracion();

    _menuAnimController = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 300),
    );
  }

  @override
  void dispose() {
    _menuAnimController.dispose();
    super.dispose();
  }

  Future<void> _cargarConfiguracion() async {
    try {
      final prefs = await SharedPreferences.getInstance();
      final historialConfig = prefs.getString(
        'agrovision_historial_habilitado',
      );
      if (historialConfig != null && mounted) {
        setState(() {
          _historialHabilitado = historialConfig.toLowerCase() == 'true';
        });
      }
    } catch (e) {
      debugPrint('Error cargando SharedPreferences: $e');
    }
  }

  void _toggleMenu() {
    setState(() {
      _isMenuOpen = !_isMenuOpen;
    });
    if (_isMenuOpen) {
      _menuAnimController.forward();
    } else {
      _menuAnimController.reverse();
    }
  }

  Future<void> _cerrarSesion() async {
    try {
      final prefs = await SharedPreferences.getInstance();
      await prefs.setString('dispositivoConectado', 'false');
      await prefs.setString('dispositivoDesconectado', 'true');
    } catch (e) {
      debugPrint('Error guardando en SharedPreferences: $e');
    }
    if (mounted) {
      AppRoutes.irAlLogin(context);
    }
  }

  @override
  Widget build(BuildContext context) {
    final screenWidth = MediaQuery.of(context).size.width;
    final isDesktop = screenWidth > 991;

    return Material(
      elevation: 0,
      child: Container(
        decoration: const BoxDecoration(
          color: Colors.white,
        ),
        child: Stack(
          children: [
            // Fondo blanco con sombra
            Container(
              constraints: const BoxConstraints(
                minHeight: BarraAgricultorStyles.navbarHeight,
              ),
              decoration: BarraAgricultorStyles.navbarDecoration,
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  Container(
                    padding: EdgeInsets.only(
                      left: isDesktop ? 28 : 16,
                      right: isDesktop ? 28 : 16,
                      top:
                          BarraAgricultorStyles.navbarPaddingVertical +
                          BarraAgricultorStyles.contentPaddingTop,
                      bottom: BarraAgricultorStyles.navbarPaddingVertical,
                    ),
                    child: isDesktop ? _buildDesktopNavbar() : _buildMobileTopBar(),
                  ),
                  // Menú expandido móvil con animación
                  if (!isDesktop) _buildAnimatedMobileMenu(),
                ],
              ),
            ),
            // Overlay radial verde top-right (decorativo, no bloquea eventos)
            Positioned.fill(
              child: IgnorePointer(
                child: Container(decoration: BarraAgricultorStyles.radialOverlay),
              ),
            ),
          ],
        ),
      ),
    );
  }

  // ─── DESKTOP ─────────────────────────────────────────────────────────────
  Widget _buildDesktopNavbar() {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        _buildBrand(),
        Row(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            if (_historialHabilitado) ...[
              _buildNavLink('Historial', '/historial'),
              const SizedBox(width: 4),
            ],
            _buildNavLink('Reporte', '/panel-agricultor'),
            const SizedBox(width: 24),
            _buildLogoutButton(),
          ],
        ),
      ],
    );
  }

  // ─── MOBILE TOP BAR ──────────────────────────────────────────────────────
  Widget _buildMobileTopBar() {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        _buildBrand(),
        _AnimatedHamburgerButton(
          animation: _menuAnimController,
          onTap: _toggleMenu,
        ),
      ],
    );
  }

  // ─── MOBILE EXPANDED MENU ────────────────────────────────────────────────
  Widget _buildMobileMenu() {
    return Container(
      width: double.infinity,
      padding: const EdgeInsets.fromLTRB(12, 8, 12, 16),
      decoration: const BoxDecoration(
        border: Border(
          top: BorderSide(color: BarraAgricultorStyles.borderColor, width: 1),
        ),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          if (_historialHabilitado)
            _buildMobileNavLink('Historial', '/historial'),
          _buildMobileNavLink('Reporte', '/panel-agricultor'),
          const SizedBox(height: 8),
          _buildLogoutButton(fullWidth: true),
        ],
      ),
    );
  }

  // ─── MOBILE ANIMATED MENU (con animación suave) ─────────────────────
  Widget _buildAnimatedMobileMenu() {
    return ClipRect(
      child: AnimatedAlign(
        duration: const Duration(milliseconds: 300),
        curve: Curves.easeInOut,
        heightFactor: _isMenuOpen ? 1.0 : 0.0,
        alignment: Alignment.topCenter,
        child: _buildMobileMenu(),
      ),
    );
  }

  // ─── BRAND ───────────────────────────────────────────────────────────────
  Widget _buildBrand() {
    return InkWell(
      onTap: () => Navigator.pushReplacementNamed(context, '/panel-agricultor'),
      borderRadius: BorderRadius.circular(6),
      child: Padding(
        padding: const EdgeInsets.symmetric(vertical: 4, horizontal: 2),
        child: Row(
          mainAxisSize: MainAxisSize.min,
          children: [
            Image.asset(
              'assets/logotipos/escudo.png',
              width: 42,
              height: 42,
              fit: BoxFit.contain,
              errorBuilder: (context, error, stackTrace) => const FaIcon(
                FontAwesomeIcons.shield,
                size: 38,
                color: BarraAgricultorStyles.darkGreen,
              ),
            ),
            const SizedBox(width: 10),
            const Text('Agricultor', style: BarraAgricultorStyles.brandText),
          ],
        ),
      ),
    );
  }

  // ─── DESKTOP NAV LINK ────────────────────────────────────────────────────
  Widget _buildNavLink(String text, String route) {
    return _HoverNavLink(
      text: text,
      onTap: () => Navigator.pushReplacementNamed(context, route),
    );
  }

  // ─── MOBILE NAV LINK ─────────────────────────────────────────────────────
  Widget _buildMobileNavLink(String text, String route) {
    return InkWell(
      onTap: () {
        _toggleMenu();
        Navigator.pushReplacementNamed(context, route);
      },
      child: Padding(
        padding: const EdgeInsets.symmetric(vertical: 10, horizontal: 12),
        child: Text(text, style: BarraAgricultorStyles.navLinkText),
      ),
    );
  }

  // ─── LOGOUT BUTTON ───────────────────────────────────────────────────────
  Widget _buildLogoutButton({bool fullWidth = false}) {
    return Container(
      width: fullWidth ? double.infinity : null,
      decoration: BarraAgricultorStyles.logoutButtonDecoration,
      child: ElevatedButton(
        onPressed: _cerrarSesion,
        style: ElevatedButton.styleFrom(
          backgroundColor: Colors.transparent,
          shadowColor: Colors.transparent,
          minimumSize: Size(fullWidth ? double.infinity : 120, 46),
          padding: const EdgeInsets.symmetric(horizontal: 18, vertical: 10),
          shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8)),
        ),
        child: const Text(
          'Cerrar Sesión',
          style: TextStyle(
            color: Colors.white,
            fontSize: 16,
            fontWeight: FontWeight.w800,
          ),
        ),
      ),
    );
  }
}

class _AnimatedHamburgerButton extends StatelessWidget {
  final Animation<double> animation;
  final VoidCallback onTap;

  const _AnimatedHamburgerButton({
    required this.animation,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return Semantics(
      button: true,
      label: 'Abrir navegación',
      child: GestureDetector(
        onTap: onTap,
        child: SizedBox(
          width: 40,
          height: 40,
          child: Center(
            child: AnimatedBuilder(
              animation: animation,
              builder: (context, child) {
                final value = Curves.ease.transform(animation.value);

                return SizedBox(
                  width: 24,
                  height: 18,
                  child: Stack(
                    alignment: Alignment.center,
                    children: [
                      _HamburgerLine(
                        offsetY: -8 * (1 - value),
                        rotation: 0.785398 * value,
                      ),
                      _HamburgerLine(opacity: 1 - value),
                      _HamburgerLine(
                        offsetY: 8 * (1 - value),
                        rotation: -0.785398 * value,
                      ),
                    ],
                  ),
                );
              },
            ),
          ),
        ),
      ),
    );
  }
}

class _HamburgerLine extends StatelessWidget {
  final double offsetY;
  final double rotation;
  final double opacity;

  const _HamburgerLine({this.offsetY = 0, this.rotation = 0, this.opacity = 1});

  @override
  Widget build(BuildContext context) {
    return Transform.translate(
      offset: Offset(0, offsetY),
      child: Transform.rotate(
        angle: rotation,
        child: Opacity(
          opacity: opacity,
          child: Container(
            width: 24,
            height: 2,
            decoration: BoxDecoration(
              color: BarraAgricultorStyles.darkGreen,
              borderRadius: BorderRadius.circular(1),
            ),
          ),
        ),
      ),
    );
  }
}

// ─── HOVER NAV LINK (desktop) ──────────────────────────────────────────────
class _HoverNavLink extends StatefulWidget {
  final String text;
  final VoidCallback onTap;

  const _HoverNavLink({required this.text, required this.onTap});

  @override
  State<_HoverNavLink> createState() => _HoverNavLinkState();
}

class _HoverNavLinkState extends State<_HoverNavLink> {
  bool _hovered = false;

  @override
  Widget build(BuildContext context) {
    return MouseRegion(
      onEnter: (_) => setState(() => _hovered = true),
      onExit: (_) => setState(() => _hovered = false),
      child: GestureDetector(
        onTap: widget.onTap,
        child: AnimatedContainer(
          duration: const Duration(milliseconds: 150),
          padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 8),
          child: Text(
            widget.text,
            style: TextStyle(
              color: BarraAgricultorStyles.linkNormal,
              fontSize: 15,
              fontWeight: _hovered ? FontWeight.w800 : FontWeight.w700,
            ),
          ),
        ),
      ),
    );
  }
}
