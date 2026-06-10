import 'package:flutter/material.dart';
import '../styles/navbars-styles/barra-admin.dart';

class BarraAdmin extends StatefulWidget {
  const BarraAdmin({super.key});

  @override
  State<BarraAdmin> createState() => _BarraAdminState();
}

class _BarraAdminState extends State<BarraAdmin> {
  bool _isMenuOpen = false;

  void _toggleMenu() {
    setState(() {
      _isMenuOpen = !_isMenuOpen;
    });
  }

  @override
  Widget build(BuildContext context) {
    final screenWidth = MediaQuery.of(context).size.width;
    final isDesktop = screenWidth > 991;

    return Container(
      constraints: const BoxConstraints(minHeight: BarraAdminStyles.navbarHeight),
      decoration: BarraAdminStyles.navbarDecoration,
      padding: EdgeInsets.symmetric(
        horizontal: isDesktop ? 28 : 16,
        vertical: BarraAdminStyles.navbarPaddingVertical,
      ),
      child: isDesktop ? _buildDesktopNavbar(context) : _buildMobileNavbar(context),
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
            _buildNavLink(context, 'Recomendaciones', '/panel-admin/recomendaciones'),
            const SizedBox(width: 16),
            _buildNavLink(context, 'Editar plataforma', '/panel-admin/editar-plataforma'),
            const SizedBox(width: 24),
            _buildLogoutButton(context),
          ],
        ),
      ],
    );
  }

  Widget _buildMobileNavbar(BuildContext context) {
    return Column(
      mainAxisSize: MainAxisSize.min,
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            _buildBrand(context),
            IconButton(
              icon: Icon(
                _isMenuOpen ? Icons.close : Icons.menu,
                color: BarraAdminStyles.darkGreen,
                size: 28,
              ),
              onPressed: _toggleMenu,
            ),
          ],
        ),
        if (_isMenuOpen) ...[
          const SizedBox(height: 12),
          _buildNavLink(context, 'Usuarios', '/panel-admin'),
          _buildNavLink(context, 'Recomendaciones', '/panel-admin/recomendaciones'),
          _buildNavLink(context, 'Editar plataforma', '/panel-admin/editar-plataforma'),
          const SizedBox(height: 12),
          _buildLogoutButton(context),
        ]
      ],
    );
  }

  Widget _buildBrand(BuildContext context) {
    return InkWell(
      onTap: () {
        Navigator.pushReplacementNamed(context, '/panel-admin');
      },
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          Image.asset(
            'assets/logotipos/escudo.png',
            width: 36,
            height: 36,
            fit: BoxFit.contain,
            errorBuilder: (context, error, stackTrace) => const Icon(
              Icons.shield, size: 36, color: BarraAdminStyles.darkGreen
            ),
          ),
          const SizedBox(width: 8),
          const Text('Administrador', style: BarraAdminStyles.brandText),
        ],
      ),
    );
  }

  Widget _buildNavLink(BuildContext context, String text, String route) {
    return InkWell(
      onTap: () {
        Navigator.pushReplacementNamed(context, route);
        if (_isMenuOpen) _toggleMenu();
      },
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 12.0, vertical: 10.0),
        child: Text(
          text,
          style: BarraAdminStyles.navLinkText,
        ),
      ),
    );
  }

  Widget _buildLogoutButton(BuildContext context) {
    return Container(
      decoration: BarraAdminStyles.logoutButtonDecoration,
      child: ElevatedButton(
        onPressed: () {
          Navigator.pushReplacementNamed(context, '/login');
        },
        style: ElevatedButton.styleFrom(
          backgroundColor: Colors.transparent,
          shadowColor: Colors.transparent,
          minimumSize: const Size(120, 46),
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
