import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:torpheus/config/routes.dart';
import 'package:torpheus/core/constants/color_constants.dart';
import 'package:torpheus/presentation/screens/painel/bloc/painel_bloc.dart';

import '../../../components/header_usuario.dart';

class TorpheusDrawer extends StatelessWidget {
  const TorpheusDrawer({
    super.key,
    required this.onSairTap,
  });

  final VoidCallback onSairTap;

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<PainelBloc, PainelState>(
      builder: (context, state) {
        return Drawer(
          backgroundColor: ColorConstants.chambray,
          child: SafeArea(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                HeaderUsuario(
                  nomeUsuario: state.nome,
                  cargoUsuario: state.cargo,
                  emailUsuario: state.email,
                ),
                const Divider(color: Color(0xFF304D7A), height: 1),
                Visibility(
                  visible: state.hasAccessCliente,
                  child: Padding(
                    padding: const EdgeInsets.only(top: 8.0),
                    child: _DrawerItem(
                      icon: Icons.person,
                      label: 'Clientes',
                      onTap: () {
                        Navigator.of(context)
                            .pushNamed(AppRoutes.cliente.route);
                      },
                    ),
                  ),
                ),
                Visibility(
                  visible: state.hasAccessFuncionario,
                  child: Padding(
                    padding: const EdgeInsets.only(top: 8.0),
                    child: _DrawerItem(
                      icon: Icons.group,
                      label: 'Funcionários',
                      onTap: () {
                        Navigator.of(context).pushNamed(
                          AppRoutes.funcionario.route,
                        );
                      },
                    ),
                  ),
                ),
                Visibility(
                  visible: state.hasAccessPerfis,
                  child: Padding(
                    padding: const EdgeInsets.only(top: 8.0),
                    child: _DrawerItem(
                      icon: Icons.security,
                      label: 'Perfis de acesso',
                      onTap: () {
                        Navigator.of(context)
                            .pushNamed(AppRoutes.perfis.route);
                      },
                    ),
                  ),
                ),
                Visibility(
                  visible: state.hasAccessUsuario,
                  child: Padding(
                    padding: const EdgeInsets.only(top: 8.0),
                    child: _DrawerItem(
                      icon: Icons.supervised_user_circle_rounded,
                      label: 'Usuários',
                      onTap: () {
                        Navigator.of(context)
                            .pushNamed(AppRoutes.usuario.route);
                      },
                    ),
                  ),
                ),
                Visibility(
                  visible: state.hasAccessVeiculo,
                  child: Padding(
                    padding: const EdgeInsets.only(top: 8.0),
                    child: _DrawerItem(
                      icon: Icons.directions_car_sharp,
                      label: 'Veículos',
                      onTap: () {
                        Navigator.of(context)
                            .pushNamed(AppRoutes.veiculos.route);
                      },
                    ),
                  ),
                ),
                const SizedBox(height: 8),
                _DrawerItemDanger(
                  onTap: () {
                    Navigator.of(context).pop();
                    onSairTap();
                  },
                ),
              ],
            ),
          ),
        );
      },
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
