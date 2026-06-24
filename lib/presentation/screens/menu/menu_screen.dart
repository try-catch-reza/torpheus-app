import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:torpheus/presentation/screens/cliente/bloc/cliente_bloc.dart';
import 'package:torpheus/presentation/screens/ordens_servico/bloc/ordens_servico_bloc.dart';
import 'package:torpheus/presentation/screens/painel/bloc/painel_bloc.dart';
import 'package:torpheus/presentation/screens/menu/bloc/menu_bloc.dart';
import 'package:torpheus/presentation/screens/menu/web/menu_web_content.dart';
import 'package:torpheus/presentation/screens/perfil/bloc/perfil_bloc.dart';
import 'package:torpheus/presentation/screens/relatorios/bloc/relatorios_bloc.dart';
import 'package:torpheus/presentation/screens/servico/bloc/servico_bloc.dart';
import 'package:torpheus/presentation/screens/usuario/bloc/usuario_bloc.dart';

import '../../../config/responsive.dart';
import '../funcionario/bloc/funcionario_bloc.dart';
import '../perfis/bloc/perfis_bloc.dart';
import '../veiculos/bloc/veiculos_bloc.dart';
import 'mobile/menu_mobile_content.dart';

class MenuScreen extends StatefulWidget {
  const MenuScreen({super.key, required this.menuParametros});

  final MenuParametros menuParametros;

  @override
  State<MenuScreen> createState() => _MenuScreenState();
}

class _MenuScreenState extends State<MenuScreen> {
  @override
  Widget build(BuildContext context) {
    return BlocProvider.value(
      value: widget.menuParametros.menuBloc..add(const MenuCarregar()),
      child: LayoutBuilder(
        builder: (context, constraints) {
          if (Responsive.isMobile(context)) {
            return MenuMobileContent(
              menuParametros: widget.menuParametros,
            );
          }
          return MenuWebContent(
            menuParametros: widget.menuParametros,
          );
        },
      ),
    );
  }
}

class MenuParametros {
  const MenuParametros({
    required this.painelBloc,
    required this.menuBloc,
    required this.perfilBloc,
    required this.clienteBloc,
    required this.mecanicosBloc,
    required this.veiculosBloc,
    required this.ordensServicoBloc,
    required this.relatoriosBloc,
    required this.perfisBloc,
    required this.usuarioBloc,
    required this.servicoBloc,
  });

  final PainelBloc painelBloc;
  final MenuBloc menuBloc;
  final PerfilBloc perfilBloc;
  final ClienteBloc clienteBloc;
  final FuncionarioBloc mecanicosBloc;
  final VeiculosBloc veiculosBloc;
  final OrdensServicoBloc ordensServicoBloc;
  final RelatoriosBloc relatoriosBloc;
  final PerfisBloc perfisBloc;
  final UsuarioBloc usuarioBloc;
  final ServicoBloc servicoBloc;
}
