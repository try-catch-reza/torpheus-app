import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:torpheus/presentation/screens/menu/web/menu_web_footer.dart';
import 'package:torpheus/presentation/screens/menu/web/menu_web_item.dart';

import '../../../../core/constants/custom_colors.dart';
import '../../../../data/models/menu_item.dart';
import '../bloc/menu_bloc.dart';
import 'menu_web_header.dart';

class MenuWebSidebar extends StatelessWidget {
  const MenuWebSidebar({
    super.key,
    required this.indexScreen,
  });

  final int indexScreen;

  static const List<MenuItem> _menuItems = [
    MenuItem(icon: Icons.dashboard_rounded, label: 'Painel'),
    MenuItem(icon: Icons.receipt_long_rounded, label: 'Ordens de Serviço'),
    MenuItem(icon: Icons.directions_car_rounded, label: 'Veículos'),
    MenuItem(icon: Icons.engineering_rounded, label: 'Mecânicos'),
    MenuItem(icon: Icons.person_rounded, label: 'Clientes'),
    MenuItem(icon: Icons.bar_chart_rounded, label: 'Relatórios'),
  ];

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 220,
      color: ColorConstants.chambray,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const MenuWebHeader(nomeEmpresa: 'Torpheus'),
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
          const MenuWebFooter(
            nomeUsuario: 'Huandres Schmidt',
            cargoUsuario: 'Técnico',
          ),
        ],
      ),
    );
  }
}