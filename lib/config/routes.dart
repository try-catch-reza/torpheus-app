import 'package:flutter/material.dart';
import 'package:torpheus/presentation/screens/cliente/cliente_screen.dart';
import 'package:torpheus/presentation/screens/mecanicos/bloc/mecanicos_bloc.dart';
import 'package:torpheus/presentation/screens/mecanicos/mecanicos_screen.dart';
import 'package:torpheus/presentation/screens/ordens_servico/ordens_servico_screen.dart';
import 'package:torpheus/presentation/screens/painel/bloc/painel_bloc.dart';
import 'package:torpheus/presentation/screens/painel/painel_screen.dart';
import 'package:torpheus/presentation/screens/login/bloc/login_bloc.dart';
import 'package:torpheus/presentation/screens/menu/bloc/menu_bloc.dart';
import 'package:torpheus/presentation/screens/perfil/perfil_screen.dart';
import 'package:torpheus/presentation/screens/recuperar_senha/recuperar_senha_screen.dart';
import 'package:torpheus/presentation/screens/relatorios/relatorios_screen.dart';
import 'package:torpheus/presentation/screens/veiculos/bloc/veiculos_bloc.dart';
import 'package:torpheus/presentation/screens/veiculos/veiculos_screen.dart';
import '../presentation/components/animation/face_page_route.dart';
import '../presentation/screens/authentication/authentication_bloc/authentication_bloc.dart';

import '../injector.dart';
import '../presentation/components/animation/modal_page_route.dart';
import '../presentation/screens/authentication/authentication_screen.dart';
import '../presentation/screens/cliente/bloc/cliente_bloc.dart';
import '../presentation/screens/cliente_detalhe/bloc/cliente_detalhe_bloc.dart';
import '../presentation/screens/cliente_detalhe/cliente_detalhe_screen.dart';
import '../presentation/screens/login/login_screen.dart';
import '../presentation/screens/ordens_servico/bloc/ordens_servico_bloc.dart';
import '../presentation/screens/perfil/bloc/perfil_bloc.dart';
import '../presentation/screens/recuperar_senha/bloc/recuperar_senha_bloc.dart';
import '../presentation/screens/relatorios/bloc/relatorios_bloc.dart';

enum NavigationFlow { simple, modalBottomUp, fade }

enum AppRoutes {
  root('/', NavigationFlow.simple),
  login('/login', NavigationFlow.fade),
  home('/home', NavigationFlow.fade),
  recuperarSenha('/recuperar-senha', NavigationFlow.fade),
  perfil('/perfil', NavigationFlow.simple),
  cliente('/cliente', NavigationFlow.fade),
  mecanicos('/mecanicos', NavigationFlow.fade),
  veiculos('/veiculos', NavigationFlow.fade),
  ordensServico('/ordens-servico', NavigationFlow.fade),
  relatorios('/relatorios', NavigationFlow.fade),
  clienteDetalhe('/cliente-detalhe', NavigationFlow.modalBottomUp);

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
          homeBloc: injector.getIt.get<PainelBloc>(),
          perfilBloc: injector.getIt.get<PerfilBloc>(),
          clienteBloc: injector.getIt.get<ClienteBloc>(),
          mecanicosBloc: injector.getIt.get<MecanicosBloc>(),
          veiculosBloc: injector.getIt.get<VeiculosBloc>(),
          ordensServicoBloc: injector.getIt.get<OrdensServicoBloc>(),
          relatoriosBloc: injector.getIt.get<RelatoriosBloc>(),
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
      AppRoutes.mecanicos => MecanicosScreen(
          mecanicosBloc: injector.getIt.get<MecanicosBloc>(),
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
