import 'package:flutter/material.dart';
import 'package:torpheus/presentation/screens/cliente/cliente_screen.dart';
import 'package:torpheus/presentation/screens/funcionario/funcionario_screen.dart';
import 'package:torpheus/presentation/screens/ordens_servico/ordens_servico_screen.dart';
import 'package:torpheus/presentation/screens/perfis/perfis_screen.dart';
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
    required this.permissoesUsuarios,
  });

  final int indexScreen;
  final MenuParametros menuParametros;
  final String nome;
  final List<String> permissoesUsuarios;

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        MenuWebSidebar(
          indexScreen: indexScreen,
          nome: nome,
          permissoesUsuario: permissoesUsuarios,
        ),
        Expanded(child: Center(child: _widgetPages().elementAt(indexScreen))),
      ],
    );
  }

  List<Widget> _widgetPages() {
    return [
      PainelScreen(painelBloc: menuParametros.painelBloc),
      OrdensServicoScreen(ordensServicoBloc: menuParametros.ordensServicoBloc),
      VeiculosScreen(veiculosBloc: menuParametros.veiculosBloc),
      FuncionarioScreen(funcionarioBloc: menuParametros.mecanicosBloc),
      ClienteScreen(clienteBloc: menuParametros.clienteBloc),
      PerfisScreen(perfisBloc: menuParametros.perfisBloc),
      const Text(''),
    ];
  }
}
