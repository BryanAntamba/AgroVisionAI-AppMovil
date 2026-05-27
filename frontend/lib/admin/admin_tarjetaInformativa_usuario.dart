import 'package:flutter/material.dart';
import '../models/usuariosRandom_admin.dart';
import '../styles/app_colors.dart';
import '../styles/panel_admin_style.dart';

class PanelAdminUserCard extends StatelessWidget {
  const PanelAdminUserCard({
    super.key,
    required this.usuario,
    required this.onEditar,
    required this.onPerfil,
    required this.onCambiarEstado,
    required this.onEliminar,
  });

  final UsuarioAdmin usuario;
  final VoidCallback onEditar;
  final VoidCallback onPerfil;
  final VoidCallback onCambiarEstado;
  final VoidCallback onEliminar;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(20),
      decoration: PanelAdminStyle.userCard,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              Container(
                width: 52,
                height: 52,
                alignment: Alignment.center,
                decoration: PanelAdminStyle.avatar,
                child: Text(usuario.iniciales, style: PanelAdminStyle.avatarText),
              ),
              const SizedBox(width: 14),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(usuario.nombreCompleto, style: PanelAdminStyle.cardTitle),
                    const SizedBox(height: 5),
                    Text(usuario.correoElectronico, style: PanelAdminStyle.cardEmail),
                  ],
                ),
              ),
            ],
          ),
          const SizedBox(height: 16),
          Wrap(
            spacing: 8,
            runSpacing: 8,
            children: [
              _Badge(text: usuario.rol.label, style: PanelAdminStyle.badgeRole),
              _Badge(
                text: usuario.cuenta.label,
                style: usuario.cuenta == EstadoCuenta.activo
                    ? PanelAdminStyle.badgeActive
                    : PanelAdminStyle.badgeInactive,
              ),
              _Badge(
                text: usuario.sesion.label,
                style: usuario.sesion == EstadoSesion.enLinea
                    ? PanelAdminStyle.badgeActive
                    : PanelAdminStyle.badgeInactive,
              ),
            ],
          ),
          const SizedBox(height: 16),
          Row(
            children: [
              Expanded(child: _Detail(label: 'Fecha', value: usuario.fechaRegistro)),
              Expanded(child: _Detail(label: 'Telefono', value: usuario.telefono)),
            ],
          ),
          const SizedBox(height: 18),
          GridView.count(
            crossAxisCount: 2,
            shrinkWrap: true,
            physics: const NeverScrollableScrollPhysics(),
            mainAxisSpacing: 8,
            crossAxisSpacing: 8,
            childAspectRatio: 3.2,
            children: [
              _ActionButton(icon: Icons.edit, label: 'Editar', onPressed: onEditar),
              _ActionButton(icon: Icons.badge_outlined, label: 'Perfil', onPressed: onPerfil),
              _ActionButton(
                icon: Icons.power_settings_new,
                label: usuario.cuenta == EstadoCuenta.activo ? 'Desactivar' : 'Activar',
                onPressed: onCambiarEstado,
              ),
              _ActionButton(
                icon: Icons.delete_outline,
                label: 'Eliminar',
                onPressed: onEliminar,
                danger: true,
              ),
            ],
          ),
        ],
      ),
    );
  }
}

class _Badge extends StatelessWidget {
  const _Badge({required this.text, required this.style});

  final String text;
  final BadgeStyle style;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 6),
      decoration: BoxDecoration(
        color: style.background,
        borderRadius: BorderRadius.circular(8),
      ),
      child: Text(
        text,
        style: TextStyle(
          fontSize: 12,
          fontWeight: FontWeight.w800,
          color: style.foreground,
        ),
      ),
    );
  }
}

class _Detail extends StatelessWidget {
  const _Detail({required this.label, required this.value});

  final String label;
  final String value;

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(label, style: PanelAdminStyle.detailLabel),
        const SizedBox(height: 4),
        Text(value, style: PanelAdminStyle.detailValue),
      ],
    );
  }
}

class _ActionButton extends StatelessWidget {
  const _ActionButton({
    required this.icon,
    required this.label,
    required this.onPressed,
    this.danger = false,
  });

  final IconData icon;
  final String label;
  final VoidCallback onPressed;
  final bool danger;

  @override
  Widget build(BuildContext context) {
    return OutlinedButton.icon(
      onPressed: onPressed,
      icon: Icon(icon, size: 16),
      label: Text(label, style: const TextStyle(fontSize: 13, fontWeight: FontWeight.w800)),
      style: OutlinedButton.styleFrom(
        foregroundColor: danger ? AppColors.danger : AppColors.primaryDark,
        side: BorderSide(color: danger ? const Color(0xFFF0C8C8) : AppColors.borderLight),
        backgroundColor: AppColors.inputBackground,
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8)),
        minimumSize: const Size(0, 42),
      ),
    );
  }
}
