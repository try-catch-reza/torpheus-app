import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:torpheus/config/routes.dart';
import 'package:torpheus/presentation/screens/menu/web/menu_web_item.dart';

import '../../../../core/constants/color_constants.dart';
import '../../../../data/models/menu_item.dart';
import '../../../components/dialog/dialog_confirm.dart';
import '../../../components/header_usuario.dart';
import '../../login/bloc/login_bloc.dart';
import '../bloc/menu_bloc.dart';

class MenuWebSidebar extends StatelessWidget {
  const MenuWebSidebar({
    super.key,
    required this.indexScreen,
    required this.nome,
    required this.permissoesUsuario,
    required this.state,
  });

  final int indexScreen;
  final String nome;
  final List<String> permissoesUsuario;
  final MenuState state;

  List<({MenuItem item, int originalIndex})> _itensFiltrados() {
    return _menuItems
        .asMap()
        .entries
        .where((entry) {
          final permissao = entry.value.permissaoNecessaria;
          // sem permissão exigida = sempre mostra
          if (permissao == null) return true;
          return permissoesUsuario.contains(permissao);
        })
        .map((entry) => (item: entry.value, originalIndex: entry.key))
        .toList();
  }

  static const List<MenuItem> _menuItems = [
    MenuItem(icon: Icons.dashboard_rounded, label: 'Painel'),
    MenuItem(
      icon: Icons.person_rounded,
      label: 'Clientes',
      permissaoNecessaria: 'clients.read',
    ),
    MenuItem(
      icon: Icons.group,
      label: 'Funcionários',
      permissaoNecessaria: 'employees.read',
    ),
    MenuItem(
      icon: Icons.receipt_long_rounded,
      label: 'Ordens de Serviço',
      permissaoNecessaria: 'service_orders.read',
    ),
    MenuItem(
      icon: Icons.security,
      label: 'Perfis de Acesso',
      permissaoNecessaria: 'roles.read',
    ),
    MenuItem(
      icon: Icons.supervised_user_circle_rounded,
      label: 'Usuários',
      permissaoNecessaria: 'users.read',
    ),
    MenuItem(
      icon: Icons.directions_car_rounded,
      label: 'Veículos',
      permissaoNecessaria: 'vehicles.read',
    ),
    MenuItem(icon: Icons.bar_chart, label: 'Relatório'),
    MenuItem(icon: Icons.logout, label: 'Sair'),
  ];

  @override
  Widget build(BuildContext context) {
    final itensFiltrados = _itensFiltrados();

    return Container(
      width: 220,
      color: ColorConstants.chambray,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          HeaderUsuario(
            emailUsuario: state.email,
            nomeUsuario: state.nome,
          ),
          const SizedBox(height: 8),
          Expanded(
            child: ListView.builder(
              padding: EdgeInsets.zero,
              itemCount: itensFiltrados.length,
              itemBuilder: (context, index) {
                final entrada = itensFiltrados[index];
                final isSair = entrada.item.label == 'Sair';

                return MenuWebItem(
                  item: entrada.item,
                  isSelected: indexScreen == entrada.originalIndex,
                  onTap: () {
                    if (isSair) {
                      ConfirmDialog.show(
                        context,
                        titulo: 'Sair do aplicativo',
                        mensagem: 'Tem certeza que deseja sair?',
                        onConfirmar: () {
                          context.read<LoginBloc>().add(const LoginLogout());
                          Navigator.of(context)
                              .pushReplacementNamed(AppRoutes.root.route);
                        },
                      );
                      return;
                    }

                    context.read<MenuBloc>().add(
                          MenuTrocarTela(entrada.originalIndex),
                        );
                  },
                );
              },
            ),
          ),
        ],
      ),
    );
  }
}
