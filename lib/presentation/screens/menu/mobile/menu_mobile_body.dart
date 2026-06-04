import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:torpheus/core/constants/color_constants.dart';
import 'package:torpheus/presentation/screens/cliente/cliente_screen.dart';
import 'package:torpheus/presentation/screens/funcionario/funcionario_screen.dart';
import 'package:torpheus/presentation/screens/ordens_servico/ordens_servico_screen.dart';
import 'package:torpheus/presentation/screens/veiculos/veiculos_screen.dart';

import '../../painel/painel_screen.dart';
import '../bloc/menu_bloc.dart';
import '../menu_screen.dart';

// Estrutura interna para guardar item + índice original
typedef _MenuEntry = ({BottomNavigationBarItem item, int originalIndex});

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

  // Mapa: índice original → permissão necessária (null = sempre visível)
  static const Map<int, String?> _permissaoPorIndice = {
    0: null,              // Painel
    1: null,              // Ordens de Serviço
    2: 'vehicles.read',   // Veículos
    3: 'employees.read',  // Funcionários
    4: 'clients.read',    // Clientes
  };

  static const List<BottomNavigationBarItem> _todosItems = [
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
      icon: Icon(Icons.directions_car_rounded, size: 28),
      activeIcon: Icon(Icons.directions_car_rounded, size: 28),
      label: 'Veículos',
    ),
    BottomNavigationBarItem(
      icon: Icon(Icons.group, size: 28),
      activeIcon: Icon(Icons.group, size: 28),
      label: 'Funcionários',
    ),
    BottomNavigationBarItem(
      icon: Icon(Icons.person, size: 28),
      activeIcon: Icon(Icons.person, size: 28),
      label: 'Clientes',
    ),
  ];

  List<_MenuEntry> get _itensFiltrados {
    return _todosItems
        .asMap()
        .entries
        .where((entry) {
      final permissao = _permissaoPorIndice[entry.key];
      if (permissao == null) return true;
      return permissoesUsuario.contains(permissao);
    })
        .map((entry) => (item: entry.value, originalIndex: entry.key))
        .toList();
  }

  // Converte o índice original → índice na lista filtrada (para o currentIndex)
  int _indexFiltrado(List<_MenuEntry> itens) {
    final pos = itens.indexWhere((e) => e.originalIndex == indexScreen);
    return pos < 0 ? 0 : pos;
  }

  @override
  Widget build(BuildContext context) {
    final itens = _itensFiltrados;
    final currentIndexFiltrado = _indexFiltrado(itens);

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
          items: itens.map((e) => e.item).toList(),
          currentIndex: currentIndexFiltrado,       // índice na lista filtrada
          onTap: (indexFiltrado) {
            final originalIndex = itens[indexFiltrado].originalIndex;
            context.read<MenuBloc>().add(MenuTrocarTela(originalIndex));
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
      FuncionarioScreen(funcionarioBloc: menuParametros.mecanicosBloc),
      ClienteScreen(clienteBloc: menuParametros.clienteBloc),
    ];
  }
}