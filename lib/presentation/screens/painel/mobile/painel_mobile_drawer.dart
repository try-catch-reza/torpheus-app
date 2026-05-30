import 'package:flutter/material.dart';
import 'package:torpheus/core/constants/custom_colors.dart';

import '../../../components/header_usuario.dart';

class TorpheusDrawer extends StatelessWidget {
  const TorpheusDrawer({
    super.key,
    required this.nomeUsuario,
    required this.cargoUsuario,
    required this.emailUsuario,
    required this.onSairTap,
  });

  final String nomeUsuario;
  final String cargoUsuario;
  final String emailUsuario;
  final VoidCallback onSairTap;

  @override
  Widget build(BuildContext context) {
    return Drawer(
      backgroundColor: ColorConstants.chambray,
      child: SafeArea(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            HeaderUsuario(
              nomeUsuario: nomeUsuario,
              cargoUsuario: cargoUsuario,
              emailUsuario: emailUsuario,
            ),
            const Divider(color: Color(0xFF304D7A), height: 1),
            const SizedBox(height: 8),
            _DrawerItemDanger(
              onTap: () {
                Navigator.of(context).pop();
                onSairTap();
              },
            ),
            const Spacer(),
            const Divider(color: Color(0xFF304D7A), height: 1),
            const _DrawerFooter(),
          ],
        ),
      ),
    );
  }
}

// ── Item padrão ───────────────────────────────────────────────────────────────

class _DrawerItem extends StatelessWidget {
  const _DrawerItem({
    required this.icon,
    required this.label,
    required this.onTap,
  });

  final IconData icon;
  final String label;
  final VoidCallback onTap;

  @override
  Widget build(BuildContext context) {
    return Material(
      color: Colors.transparent,
      child: InkWell(
        onTap: onTap,
        splashColor: const Color(0xFF304D7A),
        highlightColor: const Color(0xFF253A60),
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 14),
          child: Row(
            children: [
              Container(
                width: 36,
                height: 36,
                decoration: BoxDecoration(
                  color: const Color(0xFF253A60),
                  borderRadius: BorderRadius.circular(9),
                  border: Border.all(color: const Color(0xFF304D7A)),
                ),
                child: Icon(icon, color: const Color(0xFF8FA3C0), size: 18),
              ),
              const SizedBox(width: 14),
              Text(
                label,
                style: const TextStyle(
                  fontSize: 14,
                  fontWeight: FontWeight.w500,
                  color: Colors.white,
                  decoration: TextDecoration.none,
                ),
              ),
              const Spacer(),
              const Icon(
                Icons.chevron_right_rounded,
                color: Color(0xFF8FA3C0),
                size: 18,
              ),
            ],
          ),
        ),
      ),
    );
  }
}

// ── Item Sair (vermelho) ──────────────────────────────────────────────────────

class _DrawerItemDanger extends StatelessWidget {
  const _DrawerItemDanger({required this.onTap});

  final VoidCallback onTap;

  @override
  Widget build(BuildContext context) {
    return Material(
      color: Colors.transparent,
      child: InkWell(
        onTap: onTap,
        splashColor: const Color(0xFFFEE2E2).withOpacity(0.2),
        highlightColor: const Color(0xFFFEE2E2).withOpacity(0.1),
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 14),
          child: Row(
            children: [
              Container(
                width: 36,
                height: 36,
                decoration: BoxDecoration(
                  color: const Color(0xFFC0392B).withOpacity(0.15),
                  borderRadius: BorderRadius.circular(9),
                  border: Border.all(
                    color: const Color(0xFFC0392B).withOpacity(0.3),
                  ),
                ),
                child: const Icon(
                  Icons.logout_rounded,
                  color: Color(0xFFC0392B),
                  size: 18,
                ),
              ),
              const SizedBox(width: 14),
              const Text(
                'Sair da conta',
                style: TextStyle(
                  fontSize: 14,
                  fontWeight: FontWeight.w500,
                  color: Color(0xFFC0392B),
                  decoration: TextDecoration.none,
                ),
              ),
              const Spacer(),
              const Icon(
                Icons.chevron_right_rounded,
                color: Color(0xFFC0392B),
                size: 18,
              ),
            ],
          ),
        ),
      ),
    );
  }
}

// ── Footer ────────────────────────────────────────────────────────────────────

class _DrawerFooter extends StatelessWidget {
  const _DrawerFooter();

  @override
  Widget build(BuildContext context) {
    return const Padding(
      padding: EdgeInsets.fromLTRB(20, 14, 20, 20),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Text(
            'v1.0.0',
            style: TextStyle(
              fontSize: 10,
              color: Color(0xFF8FA3C0),
              decoration: TextDecoration.none,
            ),
          ),
          Padding(
            padding: EdgeInsets.symmetric(horizontal: 6),
            child: Text(
              '·',
              style: TextStyle(
                fontSize: 10,
                color: Color(0xFF4A5E7A),
                decoration: TextDecoration.none,
              ),
            ),
          ),
          Text(
            'UniSenai Chapecó',
            style: TextStyle(
              fontSize: 10,
              color: Color(0xFF8FA3C0),
              decoration: TextDecoration.none,
            ),
          ),
        ],
      ),
    );
  }
}
