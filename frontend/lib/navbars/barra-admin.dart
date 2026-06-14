import 'package:flutter/material.dart';
import '../styles/navbars-styles/barra-admin.dart';

class BarraAdmin extends StatefulWidget {
  const BarraAdmin({super.key});

  @override
  State<BarraAdmin> createState() => _BarraAdminState();
}

class _BarraAdminState extends State<BarraAdmin>
    with SingleTickerProviderStateMixin {
  bool _isMenuOpen = false;
  late AnimationController _menuAnimController;

  @override
  void initState() {
    super.initState();
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
            Container(
              constraints: const BoxConstraints(
                minHeight: BarraAdminStyles.navbarHeight,
              ),
              decoration: BarraAdminStyles.navbarDecoration,
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  Container(
                    padding: EdgeInsets.only(
                      left: isDesktop ? 28 : 16,
                      right: isDesktop ? 28 : 16,
                      top:
                          BarraAdminStyles.navbarPaddingVertical +
                          BarraAdminStyles.contentPaddingTop,
                      bottom: BarraAdminStyles.navbarPaddingVertical,
                    ),
                    child: isDesktop
                        ? _buildDesktopNavbar(context)
                        : _buildMobileTopBar(context),
                  ),
                  if (!isDesktop) _buildAnimatedMobileMenu(context),
                ],
              ),
            ),
            Positioned.fill(
              child: IgnorePointer(
                child: Container(decoration: BarraAdminStyles.radialOverlay),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildDesktopNavbar(BuildContext context) {
    final currentRoute = ModalRoute.of(context)?.settings.name ?? '';
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        _buildBrand(context),
        Row(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            _buildNavLink(context, 'Usuarios', '/panel-admin', currentRoute),
            const SizedBox(width: 16),
            _buildNavLink(
              context,
              'Recomendaciones',
              '/panel-admin/recomendaciones',
              currentRoute,
            ),
            const SizedBox(width: 16),
            _buildNavLink(
              context,
              'Editar plataforma',
              '/panel-admin/editar-plataforma',
              currentRoute,
            ),
            const SizedBox(width: 24),
            _buildLogoutButton(context),
          ],
        ),
      ],
    );
  }

  Widget _buildMobileTopBar(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        _buildBrand(context),
        _AnimatedHamburgerButton(
          animation: _menuAnimController,
          onTap: _toggleMenu,
        ),
      ],
    );
  }

  Widget _buildMobileMenu(BuildContext context) {
    final currentRoute = ModalRoute.of(context)?.settings.name ?? '';
    return Container(
      width: double.infinity,
      padding: const EdgeInsets.fromLTRB(12, 8, 12, 16),
      decoration: const BoxDecoration(
        border: Border(
          top: BorderSide(color: BarraAdminStyles.borderColor, width: 1),
        ),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          _buildMobileNavLink(context, 'Usuarios', '/panel-admin', currentRoute),
          _buildMobileNavLink(
            context,
            'Recomendaciones',
            '/panel-admin/recomendaciones',
            currentRoute,
          ),
          _buildMobileNavLink(
            context,
            'Editar plataforma',
            '/panel-admin/editar-plataforma',
            currentRoute,
          ),
          const SizedBox(height: 8),
          _buildLogoutButton(context, fullWidth: true),
        ],
      ),
    );
  }

  Widget _buildAnimatedMobileMenu(BuildContext context) {
    return ClipRect(
      child: AnimatedAlign(
        duration: const Duration(milliseconds: 300),
        curve: Curves.easeInOut,
        heightFactor: _isMenuOpen ? 1.0 : 0.0,
        alignment: Alignment.topCenter,
        child: _buildMobileMenu(context),
      ),
    );
  }

  Widget _buildBrand(BuildContext context) {
    return InkWell(
      onTap: () {
        Navigator.pushReplacementNamed(context, '/panel-admin');
      },
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
              errorBuilder: (context, error, stackTrace) => const Icon(
                Icons.shield,
                size: 38,
                color: BarraAdminStyles.darkGreen,
              ),
            ),
            const SizedBox(width: 10),
            const Text('Administrador', style: BarraAdminStyles.brandText),
          ],
        ),
      ),
    );
  }

  Widget _buildNavLink(BuildContext context, String text, String route, String currentRoute) {
    final isActive = currentRoute == route;
    return _HoverNavLink(
      text: text,
      isActive: isActive,
      onTap: () {
        if (currentRoute != route) {
          Navigator.pushReplacementNamed(context, route);
        }
        if (_isMenuOpen) _toggleMenu();
      },
    );
  }

  Widget _buildMobileNavLink(BuildContext context, String text, String route, String currentRoute) {
    final isActive = currentRoute == route;
    return InkWell(
      onTap: () {
        _toggleMenu();
        if (currentRoute != route) {
          Navigator.pushReplacementNamed(context, route);
        }
      },
      child: Container(
        padding: const EdgeInsets.symmetric(vertical: 10, horizontal: 12),
        decoration: null,
        child: Text(
          text,
          style: BarraAdminStyles.navLinkText.copyWith(
            color: BarraAdminStyles.linkNormal,
            fontWeight: isActive ? FontWeight.w800 : FontWeight.w700,
          ),
        ),
      ),
    );
  }

  Widget _buildLogoutButton(BuildContext context, {bool fullWidth = false}) {
    return Container(
      width: fullWidth ? double.infinity : null,
      decoration: BarraAdminStyles.logoutButtonDecoration,
      child: ElevatedButton(
        onPressed: () {
          Navigator.pushReplacementNamed(context, '/login');
        },
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


// ─── ANIMATED HAMBURGER BUTTON ─────────────────────────────────────────
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
              color: BarraAdminStyles.darkGreen,
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
  final bool isActive;

  const _HoverNavLink({required this.text, required this.onTap, this.isActive = false});

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
          decoration: null,
          child: Text(
            widget.text,
            style: TextStyle(
              color: BarraAdminStyles.linkNormal,
              fontSize: 15,
              fontWeight: widget.isActive || _hovered ? FontWeight.w800 : FontWeight.w700,
            ),
          ),
        ),
      ),
    );
  }
}
