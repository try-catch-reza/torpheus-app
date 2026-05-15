import 'package:flutter/material.dart';
import 'package:torpheus/core/constants/custom_colors.dart';

/// Drawer lateral padrão Torphéus.
///
/// Uso:
/// ```dart
/// Scaffold(
///   drawer: TorpheusDrawer(
///     onClientesTap: () => Navigator.pushNamed(context, '/clientes'),
///     onMecanicosTap: () => Navigator.pushNamed(context, '/mecanicos'),
///     onVeiculosTap: () => Navigator.pushNamed(context, '/veiculos'),
///   ),
/// )
/// ```
class TorpheusDrawer extends StatelessWidget {
  const TorpheusDrawer({
    super.key,
    required this.onClientesTap,
    required this.onMecanicosTap,
    required this.onVeiculosTap,
  });

  final VoidCallback onClientesTap;
  final VoidCallback onMecanicosTap;
  final VoidCallback onVeiculosTap;

  @override
  Widget build(BuildContext context) {
    return Drawer(
      backgroundColor: ColorConstants.chambray,
      child: SafeArea(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const _DrawerHeader(),

            const SizedBox(height: 8),

            const Divider(color: Color(0xFF304D7A), height: 1),

            const SizedBox(height: 8),

            // ── Itens ─────────────────────────────────────────────────────
            _DrawerItem(
              icon: Icons.person_rounded,
              label: 'Clientes',
              onTap: () {
                Navigator.of(context).pop();
                onClientesTap();
              },
            ),
            _DrawerItem(
              icon: Icons.engineering_rounded,
              label: 'Mecânicos',
              onTap: () {
                Navigator.of(context).pop();
                onMecanicosTap();
              },
            ),
            _DrawerItem(
              icon: Icons.directions_car_rounded,
              label: 'Veículos',
              onTap: () {
                Navigator.of(context).pop();
                onVeiculosTap();
              },
            ),

            const Spacer(),

            const Divider(color: Color(0xFF304D7A), height: 1),

            // ── Rodapé ────────────────────────────────────────────────────
            const _DrawerFooter(),
          ],
        ),
      ),
    );
  }
}

// ── Header ────────────────────────────────────────────────────────────────────

class _DrawerHeader extends StatelessWidget {
  const _DrawerHeader();

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.fromLTRB(20, 20, 20, 16),
      child: Row(
        children: [
          Container(
            width: 40,
            height: 40,
            decoration: BoxDecoration(
              color: const Color(0xFF253A60),
              borderRadius: BorderRadius.circular(10),
              border: Border.all(color: const Color(0xFF304D7A)),
            ),
            child: const Icon(
              Icons.build_rounded,
              color: Colors.white,
              size: 20,
            ),
          ),
          const SizedBox(width: 12),
          const Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                'TORPHÉUS',
                style: TextStyle(
                  fontSize: 13,
                  fontWeight: FontWeight.w800,
                  color: Colors.white,
                  letterSpacing: 1.5,
                  decoration: TextDecoration.none,
                ),
              ),
              Text(
                'Gestão de Oficina Mecânica',
                style: TextStyle(
                  fontSize: 10,
                  color: Color(0xFF8FA3C0),
                  decoration: TextDecoration.none,
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}

// ── Item ──────────────────────────────────────────────────────────────────────

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