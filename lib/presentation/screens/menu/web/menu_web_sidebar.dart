import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:torpheus/config/routes.dart';
import 'package:torpheus/presentation/screens/menu/web/menu_web_item.dart';

import '../../../../core/constants/color_constants.dart';
import '../../../../data/models/menu_item.dart';
import '../../../components/header_usuario.dart';
import '../bloc/menu_bloc.dart';

class MenuWebSidebar extends StatelessWidget {
  const MenuWebSidebar({
    super.key,
    required this.indexScreen,
    required this.nome,
  });

  final int indexScreen;
  final String nome;

  static const List<MenuItem> _menuItems = [
    MenuItem(icon: Icons.dashboard_rounded, label: 'Painel'),
    MenuItem(icon: Icons.receipt_long_rounded, label: 'Ordens de Serviço'),
    MenuItem(icon: Icons.directions_car_rounded, label: 'Veículos'),
    MenuItem(icon: Icons.group, label: 'Funcionários'),
    MenuItem(icon: Icons.person_rounded, label: 'Clientes'),
    MenuItem(icon: Icons.security, label: 'Perfis de Acesso'),
    MenuItem(icon: Icons.logout, label: 'Sair'),
  ];

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 220,
      color: ColorConstants.chambray,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          HeaderUsuario(
            nomeUsuario: 'Huandres Schmidt',
            cargoUsuario: 'Administrador',
            emailUsuario: 'huandreschmidt@gmail.com',
            onTap: () {
              Navigator.of(context).pushNamed(AppRoutes.perfil.route);
            },
          ),
          const SizedBox(height: 8),
          Expanded(
            child: ListView.builder(
              padding: EdgeInsets.zero,
              itemCount: _menuItems.length,
              itemBuilder: (context, index) {
                return MenuWebItem(
                  item: _menuItems[index],
                  isSelected: indexScreen == index,
                  onTap: () {
                    context.read<MenuBloc>().add(MenuTrocarTela(index));
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
