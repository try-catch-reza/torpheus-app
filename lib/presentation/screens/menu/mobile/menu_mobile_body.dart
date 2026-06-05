import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:torpheus/core/constants/color_constants.dart';
import 'package:torpheus/presentation/screens/ordens_servico/ordens_servico_screen.dart';
import 'package:torpheus/presentation/screens/perfil/perfil_screen.dart';
import 'package:torpheus/presentation/screens/relatorios/relatorios_screen.dart';

import '../../painel/painel_screen.dart';
import '../bloc/menu_bloc.dart';
import '../menu_screen.dart';

class MenuMobileBody extends StatelessWidget {
  const MenuMobileBody({
    super.key,
    required this.indexScreen,
    required this.menuParametros,
    required this.permissoesUsuario,
  });

  final int indexScreen;
  final MenuParametros menuParametros;
  final List<String> permissoesUsuario;

  static const List<BottomNavigationBarItem> _items = [
    BottomNavigationBarItem(
      icon: Icon(Icons.dashboard, size: 28),
      activeIcon: Icon(Icons.dashboard, size: 28),
      label: 'Painel',
    ),
    BottomNavigationBarItem(
      icon: Icon(Icons.receipt_long_rounded, size: 28),
      activeIcon: Icon(Icons.receipt_long_rounded, size: 28),
      label: 'OS',
    ),
    BottomNavigationBarItem(
      icon: Icon(Icons.bar_chart, size: 28),
      activeIcon: Icon(Icons.bar_chart, size: 28),
      label: 'Relatório',
    ),
    BottomNavigationBarItem(
      icon: Icon(Icons.account_circle, size: 28),
      activeIcon: Icon(Icons.account_circle, size: 28),
      label: 'Meu perfil',
    ),
  ];

  @override
  Widget build(BuildContext context) {
    return PopScope(
      canPop: false,
      child: Scaffold(
        body: Center(child: _widgetPages().elementAt(indexScreen)),
        bottomNavigationBar: BottomNavigationBar(
          selectedLabelStyle: TextStyle(color: ColorConstants.chambray),
          unselectedLabelStyle: const TextStyle(color: Colors.grey),
          showSelectedLabels: true,
          type: BottomNavigationBarType.fixed,
          selectedItemColor: ColorConstants.chambray,
          unselectedIconTheme: const IconThemeData(color: Colors.grey),
          elevation: 5.0,
          backgroundColor: ColorConstants.corFundo,
          items: _items,
          currentIndex: indexScreen,
          onTap: (index) {
            context.read<MenuBloc>().add(MenuTrocarTela(index));
          },
        ),
      ),
    );
  }

  List<Widget> _widgetPages() {
    return [
      PainelScreen(painelBloc: menuParametros.homeBloc),
      OrdensServicoScreen(ordensServicoBloc: menuParametros.ordensServicoBloc),
      RelatoriosScreen(relatoriosBloc: menuParametros.relatoriosBloc),
      PerfilScreen(perfilBloc: menuParametros.perfilBloc),
    ];
  }
}
