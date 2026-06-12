import 'package:flutter/material.dart';
import 'package:torpheus/presentation/screens/cadastrar_cliente/bloc/cadastrar_cliente_bloc.dart';
import 'package:torpheus/presentation/screens/cadastrar_veiculo/bloc/cadastrar_veiculo_bloc.dart';
import 'package:torpheus/presentation/screens/cadastrar_usuario/bloc/cadastrar_usuario_bloc.dart';
import 'package:torpheus/presentation/screens/cadastrar_usuario/cadastrar_usuario_screen.dart';
import 'package:torpheus/presentation/screens/cadastrar_veiculo/cadastrar_veiculo_screen.dart';
import 'package:torpheus/presentation/screens/cliente/cliente_screen.dart';
import 'package:torpheus/presentation/screens/funcionario/funcionario_screen.dart';
import 'package:torpheus/presentation/screens/ordens_servico/ordens_servico_screen.dart';
import 'package:torpheus/presentation/screens/painel/bloc/painel_bloc.dart';
import 'package:torpheus/presentation/screens/painel/painel_screen.dart';
import 'package:torpheus/presentation/screens/login/bloc/login_bloc.dart';
import 'package:torpheus/presentation/screens/menu/bloc/menu_bloc.dart';
import 'package:torpheus/presentation/screens/perfil/perfil_screen.dart';
import 'package:torpheus/presentation/screens/perfis/perfis_screen.dart';
import 'package:torpheus/presentation/screens/recuperar_senha/recuperar_senha_screen.dart';
import 'package:torpheus/presentation/screens/relatorios/relatorios_screen.dart';
import 'package:torpheus/presentation/screens/usuario/bloc/usuario_bloc.dart';
import 'package:torpheus/presentation/screens/veiculos/bloc/veiculos_bloc.dart';
import 'package:torpheus/presentation/screens/veiculos/veiculos_screen.dart';
import '../presentation/components/animation/face_page_route.dart';
import '../presentation/screens/authentication/authentication_bloc/authentication_bloc.dart';

import '../injector.dart';
import '../presentation/components/animation/modal_page_route.dart';
import '../presentation/screens/authentication/authentication_screen.dart';
import '../presentation/screens/cadastrar_cliente/cadastrar_cliente_screen.dart';
import '../presentation/screens/cadastrar_funcionario/bloc/cadastrar_funcionario_bloc.dart';
import '../presentation/screens/cliente/bloc/cliente_bloc.dart';
import '../presentation/screens/cliente_detalhe/bloc/cliente_detalhe_bloc.dart';
import '../presentation/screens/cliente_detalhe/cliente_detalhe_screen.dart';
import '../presentation/screens/perfis/bloc/perfis_bloc.dart';
import '../presentation/screens/usuario/usuario_screen.dart';
import '../presentation/screens/veiculo_detalhe/bloc/veiculo_detalhe_bloc.dart';
import '../presentation/screens/veiculo_detalhe/veiculo_detalhe_screen.dart';
import '../presentation/screens/funcionario_detalhe/bloc/funcionario_detalhe_bloc.dart';
import '../presentation/screens/funcionario_detalhe/funcionario_detalhe_screen.dart';
import '../presentation/screens/funcionario/bloc/funcionario_bloc.dart';
import '../presentation/screens/login/login_screen.dart';
import '../presentation/screens/ordens_servico/bloc/ordens_servico_bloc.dart';
import '../presentation/screens/perfil/bloc/perfil_bloc.dart';
import '../presentation/screens/recuperar_senha/bloc/recuperar_senha_bloc.dart';
import '../presentation/screens/relatorios/bloc/relatorios_bloc.dart';
import '../presentation/screens/cadastrar_funcionario/cadastrar_funcionario_screen.dart';

enum NavigationFlow { simple, modalBottomUp, fade }

enum AppRoutes {
  root('/', NavigationFlow.fade),
  login('/login', NavigationFlow.fade),
  home('/home', NavigationFlow.fade),
  recuperarSenha('/recuperar-senha', NavigationFlow.fade),
  perfil('/perfil', NavigationFlow.simple),
  cliente('/cliente', NavigationFlow.fade),
  funcionario('/mecanicos', NavigationFlow.fade),
  veiculos('/veiculos', NavigationFlow.fade),
  ordensServico('/ordens-servico', NavigationFlow.fade),
  relatorios('/relatorios', NavigationFlow.fade),
  clienteDetalhe('/cliente-detalhe', NavigationFlow.modalBottomUp),
  veiculoDetalhe('/veiculo-detalhe', NavigationFlow.modalBottomUp),
  funcionarioDetalhe('/funcionario-detalhe', NavigationFlow.modalBottomUp),
  cadastrarCliente('/cadastrar-cliente', NavigationFlow.modalBottomUp),
  cadastrarFuncionario('/cadastrar-mecanico', NavigationFlow.modalBottomUp),
  cadastrarVeiculo('/cadastrar-veiculo', NavigationFlow.modalBottomUp),
  cadastrarUsuario('/cadastrar-usuario', NavigationFlow.modalBottomUp),
  usuario('usuario', NavigationFlow.fade),
  perfis('perfis', NavigationFlow.fade);

  final String route;
  final NavigationFlow flow;

  const AppRoutes(this.route, this.flow);

  static AppRoutes fromName(String? screenName) {
    return AppRoutes.values.firstWhere(
      (e) => e.route == screenName,
      orElse: () => root,
    );
  }
}

class Routes {
  static PageRoute router(RouteSettings settings, Injector injector) {
    final appRoute = AppRoutes.fromName(settings.name);

    final Widget screen = switch (appRoute) {
      AppRoutes.login => LoginScreen(
          loginBloc: injector.getIt.get<LoginBloc>(),
        ),
      AppRoutes.root => AuthenticationScreen(
          authenticationBloc: injector.getIt.get<AuthenticationBloc>(),
          loginBloc: injector.getIt.get<LoginBloc>(),
          menuBloc: injector.getIt.get<MenuBloc>(),
          painelBloc: injector.getIt.get<PainelBloc>(),
          perfilBloc: injector.getIt.get<PerfilBloc>(),
          clienteBloc: injector.getIt.get<ClienteBloc>(),
          mecanicosBloc: injector.getIt.get<FuncionarioBloc>(),
          veiculosBloc: injector.getIt.get<VeiculosBloc>(),
          ordensServicoBloc: injector.getIt.get<OrdensServicoBloc>(),
          relatoriosBloc: injector.getIt.get<RelatoriosBloc>(),
          perfisBloc: injector.getIt.get<PerfisBloc>(),
          usuarioBloc: injector.getIt.get<UsuarioBloc>(),
        ),
      AppRoutes.home => PainelScreen(
          painelBloc: injector.getIt.get<PainelBloc>(),
        ),
      AppRoutes.recuperarSenha => RecuperarSenhaScreen(
          recuperarSenhaBloc: injector.getIt.get<RecuperarSenhaBloc>(),
        ),
      AppRoutes.perfil => PerfilScreen(
          perfilBloc: injector.getIt.get<PerfilBloc>(),
        ),
      AppRoutes.cliente => ClienteScreen(
          clienteBloc: injector.getIt.get<ClienteBloc>(),
        ),
      AppRoutes.funcionario => FuncionarioScreen(
          funcionarioBloc: injector.getIt.get<FuncionarioBloc>(),
        ),
      AppRoutes.veiculos => VeiculosScreen(
          veiculosBloc: injector.getIt.get<VeiculosBloc>(),
        ),
      AppRoutes.ordensServico => OrdensServicoScreen(
          ordensServicoBloc: injector.getIt.get<OrdensServicoBloc>(),
        ),
      AppRoutes.relatorios => RelatoriosScreen(
          relatoriosBloc: injector.getIt.get<RelatoriosBloc>(),
        ),
      AppRoutes.clienteDetalhe => ClienteDetalheScreen(
          clienteDetalheBloc: injector.getIt.get<ClienteDetalheBloc>(),
          arguments: settings.arguments as ClienteDetalheArguments,
        ),
      AppRoutes.veiculoDetalhe => VeiculoDetalheScreen(
          veiculoDetalheBloc: injector.getIt.get<VeiculoDetalheBloc>(),
          arguments: settings.arguments as VeiculoDetalheArguments,
        ),
      AppRoutes.funcionarioDetalhe => FuncionarioDetalheScreen(
          funcionarioDetalheBloc: injector.getIt.get<FuncionarioDetalheBloc>(),
          arguments: settings.arguments as FuncionarioDetalheArguments,
        ),
      AppRoutes.cadastrarCliente => CadastrarClienteScreen(
          cadastrarClienteBloc: injector.getIt.get<CadastrarClienteBloc>(),
          arguments: settings.arguments as CadastrarClienteArguments,
        ),
      AppRoutes.cadastrarFuncionario => CadastrarFuncionarioScreen(
          cadastrarFuncionarioBloc:
              injector.getIt.get<CadastrarFuncionarioBloc>(),
          arguments: settings.arguments as CadastrarFuncionarioArguments,
        ),
      AppRoutes.cadastrarVeiculo => CadastrarVeiculoScreen(
          cadastrarVeiculoBloc: injector.getIt.get<CadastrarVeiculoBloc>(),
          arguments: settings.arguments as CadastrarVeiculoArguments,
        ),
      AppRoutes.cadastrarUsuario => CadastrarUsuarioScreen(
          cadastrarUsuarioBloc: injector.getIt.get<CadastrarUsuarioBloc>(),
        ),
      AppRoutes.usuario => UsuarioScreen(
          usuarioBloc: injector.getIt.get<UsuarioBloc>(),
        ),
      AppRoutes.perfis => PerfisScreen(
          perfisBloc: injector.getIt.get<PerfisBloc>(),
        ),
    };

    return switch (appRoute.flow) {
      NavigationFlow.modalBottomUp => ModalPageRoute(
          builder: (context) => screen,
          modalSettings: settings,
        ),
      NavigationFlow.fade => FadePageRoute(
          builder: (context) => screen,
          fadeSettings: settings,
        ),
      NavigationFlow.simple => MaterialPageRoute(
          builder: (context) => screen,
          settings: settings,
        )
    };
  }
}
