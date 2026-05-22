import 'package:flutter/material.dart';
import 'package:torpheus/presentation/screens/cliente/cliente_screen.dart';
import 'package:torpheus/presentation/screens/mecanicos/mecanicos_screen.dart';
import 'package:torpheus/presentation/screens/ordens_servico/ordens_servico_screen.dart';
import 'package:torpheus/presentation/screens/relatorios/relatorios_screen.dart';
import 'package:torpheus/presentation/screens/veiculos/veiculos_screen.dart';

import '../../painel/painel_screen.dart';
import '../menu_screen.dart';
import 'menu_web_sidebar.dart';

class MenuWebBody extends StatelessWidget {
  const MenuWebBody({
    super.key,
    required this.indexScreen,
    required this.menuParametros,
    required this.nome,
  });

  final int indexScreen;
  final MenuParametros menuParametros;
  final String nome;

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        MenuWebSidebar(indexScreen: indexScreen, nome: nome),
        Expanded(child: Center(child: _widgetPages().elementAt(indexScreen))),
      ],
    );
  }

  List<Widget> _widgetPages() {
    return [
      PainelScreen(painelBloc: menuParametros.homeBloc),
      OrdensServicoScreen(ordensServicoBloc: menuParametros.ordensServicoBloc),
      VeiculosScreen(veiculosBloc: menuParametros.veiculosBloc),
      MecanicosScreen(mecanicosBloc: menuParametros.mecanicosBloc),
      ClienteScreen(clienteBloc: menuParametros.clienteBloc),
      RelatoriosScreen(relatoriosBloc: menuParametros.relatoriosBloc),
    ];
  }
}
