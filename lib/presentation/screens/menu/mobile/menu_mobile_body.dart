import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:torpheus/core/constants/custom_colors.dart';
import 'package:torpheus/presentation/screens/cliente/cliente_screen.dart';
import 'package:torpheus/presentation/screens/mecanicos/mecanicos_screen.dart';
import 'package:torpheus/presentation/screens/ordens_servico/ordens_servico_screen.dart';
import 'package:torpheus/presentation/screens/veiculos/veiculos_screen.dart';

import '../../painel/painel_screen.dart';
import '../bloc/menu_bloc.dart';
import '../menu_screen.dart';

class MenuMobileBody extends StatelessWidget {
  const MenuMobileBody({
    super.key,
    required this.indexScreen,
    required this.menuParametros,
  });

  final int indexScreen;
  final MenuParametros menuParametros;

  @override
  Widget build(BuildContext context) {
    return PopScope(
      canPop: false,
      child: Scaffold(
        body: Center(child: _widgetPages().elementAt(indexScreen)),
        bottomNavigationBar: BottomNavigationBar(
          selectedLabelStyle: TextStyle(color: ColorConstants.chambray),
          unselectedLabelStyle: const TextStyle(color: Colors.white),
          showSelectedLabels: true,
          type: BottomNavigationBarType.fixed,
          selectedItemColor: ColorConstants.chambray,
          unselectedIconTheme: const IconThemeData(color: Colors.grey),
          elevation: 5.0,
          backgroundColor: Colors.white,
          items: items,
          currentIndex: indexScreen,
          onTap: (value) {
            context.read<MenuBloc>().add(MenuTrocarTela(value));
          },
        ),
      ),
    );
  }

  List<Widget> _widgetPages() {
    return [
      PainelScreen(painelBloc: menuParametros.homeBloc),
      OrdensServicoScreen(ordensServicoBloc: menuParametros.ordensServicoBloc),
      VeiculosScreen(veiculosBloc: menuParametros.veiculosBloc),
      MecanicosScreen(mecanicosBloc: menuParametros.mecanicosBloc),
      ClienteScreen(clienteBloc: menuParametros.clienteBloc),
    ];
  }

  List<BottomNavigationBarItem> get items => [
    BottomNavigationBarItem(
      icon: const Icon(Icons.dashboard, size: 28.0),
      label: 'Painel',
      activeIcon: Icon(
        Icons.dashboard,
        color: ColorConstants.chambray,
        size: 28.0,
      ),
    ),
     BottomNavigationBarItem(
      icon: const Icon(Icons.folder, size: 28.0),
      label: 'OS',
      activeIcon: Icon(
        Icons.folder,
        color: ColorConstants.chambray,
        size: 28.0,
      ),
    ),
    BottomNavigationBarItem(
      icon: const Icon(Icons.car_repair_sharp, size: 28.0),
      label: 'OS',
      activeIcon: Icon(
        Icons.car_repair_sharp,
        color: ColorConstants.chambray,
        size: 28.0,
      ),
    ),
     BottomNavigationBarItem(
      icon: const Icon(Icons.group, size: 28.0),
      label: 'Mecânicos',
      activeIcon: Icon(
        Icons.group,
        color: ColorConstants.chambray,
        size: 28.0,
      ),
    ),
    BottomNavigationBarItem(
      icon: const Icon(Icons.person, size: 28.0),
      label: 'Clientes',
      activeIcon: Icon(
        Icons.person,
        color: ColorConstants.chambray,
        size: 28.0,
      ),
    ),
  ];
}
