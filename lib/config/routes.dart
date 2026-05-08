import 'package:flutter/material.dart';
import 'package:torpheus/presentation/screens/painel/bloc/painel_bloc.dart';
import 'package:torpheus/presentation/screens/painel/painel_screen.dart';
import 'package:torpheus/presentation/screens/login/bloc/login_bloc.dart';
import 'package:torpheus/presentation/screens/menu/bloc/menu_bloc.dart';
import 'package:torpheus/presentation/screens/recuperar_senha/recuperar_senha_screen.dart';
import '../presentation/components/animation/face_page_route.dart';
import '../presentation/screens/authentication/authentication_bloc/authentication_bloc.dart';

import '../injector.dart';
import '../presentation/components/animation/modal_page_route.dart';
import '../presentation/screens/authentication/authentication_screen.dart';
import '../presentation/screens/login/login_screen.dart';
import '../presentation/screens/recuperar_senha/bloc/recuperar_senha_bloc.dart';

enum NavigationFlow { simple, modalBottomUp, fade}

enum AppRoutes {
  root('/', NavigationFlow.simple),
  login('/login', NavigationFlow.fade),
  home('/home', NavigationFlow.fade),
  recuperarSenha('/recuperar-senha', NavigationFlow.fade);

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
        ),
      AppRoutes.home => PainelScreen(
          painelBloc: injector.getIt.get<PainelBloc>(),
        ),
      AppRoutes.recuperarSenha => RecuperarSenhaScreen(
        recuperarSenhaBloc: injector.getIt.get<RecuperarSenhaBloc>(),
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
