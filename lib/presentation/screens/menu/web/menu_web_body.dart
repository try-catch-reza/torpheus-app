import 'package:flutter/material.dart';

import '../../painel/painel_screen.dart';
import '../menu_screen.dart';
import 'menu_web_sidebar.dart';

class MenuWebBody extends StatelessWidget {
  const MenuWebBody({
    super.key,
    required this.indexScreen,
    required this.menuParametros,
  });

  final int indexScreen;
  final MenuParametros menuParametros;

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        MenuWebSidebar(indexScreen: indexScreen),
        Expanded(child: Center(child: _widgetPages().elementAt(indexScreen))),
      ],
    );
  }

  List<Widget> _widgetPages() {
    return [
      PainelScreen(painelBloc: menuParametros.homeBloc),
      const Text('Ordens de serviço'),
      const Text('Veículos'),
      const Text('Mecânicos'),
      const Text('Clientes'),
      const Text('Relatório'),
    ];
  }
}
