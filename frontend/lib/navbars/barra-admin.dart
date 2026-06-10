import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
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
      duration: const Duration(milliseconds: 250),
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

    return Stack(
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
              if (!isDesktop && _isMenuOpen) _buildMobileMenu(context),
            ],
          ),
        ),
        Positioned.fill(
          child: IgnorePointer(
            child: Container(decoration: BarraAdminStyles.radialOverlay),
          ),
        ),
      ],
    );
  }

  Widget _buildDesktopNavbar(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        _buildBrand(context),
        Row(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            _buildNavLink(context, 'Usuarios', '/panel-admin'),
            const SizedBox(width: 16),
            _buildNavLink(
              context,
              'Recomendaciones',
              '/panel-admin/recomendaciones',
            ),
            const SizedBox(width: 16),
            _buildNavLink(
              context,
              'Editar plataforma',
              '/panel-admin/editar-plataforma',
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
        GestureDetector(
          onTap: _toggleMenu,
          child: SizedBox(
            width: 44,
            height: 44,
            child: Center(
              child: AnimatedRotation(
                turns: _isMenuOpen ? 0.125 : 0.0,
                duration: const Duration(milliseconds: 250),
                child: FaIcon(
                  _isMenuOpen ? FontAwesomeIcons.xmark : FontAwesomeIcons.bars,
                  color: BarraAdminStyles.darkGreen,
                  size: 24,
                ),
              ),
            ),
          ),
        ),
      ],
    );
  }

  Widget _buildMobileMenu(BuildContext context) {
    return Column(
      mainAxisSize: MainAxisSize.min,
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: [
        Container(
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
              _buildMobileNavLink(context, 'Usuarios', '/panel-admin'),
              _buildMobileNavLink(
                context,
                'Recomendaciones',
                '/panel-admin/recomendaciones',
              ),
              _buildMobileNavLink(
                context,
                'Editar plataforma',
                '/panel-admin/editar-plataforma',
              ),
              const SizedBox(height: 8),
              _buildLogoutButton(context, fullWidth: true),
            ],
          ),
        ),
      ],
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

  Widget _buildNavLink(BuildContext context, String text, String route) {
    return InkWell(
      onTap: () {
        Navigator.pushReplacementNamed(context, route);
        if (_isMenuOpen) _toggleMenu();
      },
      borderRadius: BorderRadius.circular(6),
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 12.0, vertical: 8.0),
        child: Text(text, style: BarraAdminStyles.navLinkText),
      ),
    );
  }

  Widget _buildMobileNavLink(BuildContext context, String text, String route) {
    return InkWell(
      onTap: () {
        _toggleMenu();
        Navigator.pushReplacementNamed(context, route);
      },
      child: Padding(
        padding: const EdgeInsets.symmetric(vertical: 10, horizontal: 12),
        child: Text(text, style: BarraAdminStyles.navLinkText),
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
