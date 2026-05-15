import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_native_splash/flutter_native_splash.dart';
import 'package:torpheus/presentation/screens/painel/bloc/painel_bloc.dart';
import 'package:torpheus/presentation/screens/login/bloc/login_bloc.dart';
import 'package:torpheus/presentation/screens/menu/bloc/menu_bloc.dart';
import 'package:torpheus/presentation/screens/menu/menu_screen.dart';
import 'package:torpheus/presentation/screens/perfil/bloc/perfil_bloc.dart';
import '../login/login_screen.dart';

import '../../../config/routes.dart';
import 'authentication_bloc/authentication_bloc.dart';

class AuthenticationScreen extends StatefulWidget {
  const AuthenticationScreen({
    super.key,
    required this.authenticationBloc,
    required this.loginBloc,
    required this.menuBloc,
    required this.homeBloc,
    required this.perfilBloc,
  });

  final AuthenticationBloc authenticationBloc;
  final LoginBloc loginBloc;
  final MenuBloc menuBloc;
  final PainelBloc homeBloc;
  final PerfilBloc perfilBloc;

  @override
  State<AuthenticationScreen> createState() => _AuthenticationScreenState();
}

class _AuthenticationScreenState extends State<AuthenticationScreen> {
  late final AuthenticationBloc _authenticationBloc;
  late final LoginBloc _loginBloc;
  late final MenuBloc _menuBloc;
  late final PainelBloc _homeBloc;
  late final PerfilBloc _perfilBloc;

  @override
  void initState() {
    _authenticationBloc = widget.authenticationBloc;
    _loginBloc = widget.loginBloc;
    _menuBloc = widget.menuBloc;
    _homeBloc = widget.homeBloc;
    _perfilBloc = widget.perfilBloc;

    _authenticationBloc.add(const AuthenticationLoad());

    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<AuthenticationBloc, AuthenticationState>(
      listener: _listener,
      bloc: _authenticationBloc,
      builder: (BuildContext context, AuthenticationState state) {
        return state.isAuthenticated
            ? MenuScreen(
                menuParametros: MenuParametros(
                  homeBloc: _homeBloc,
                  menuBloc: _menuBloc,
                  perfilBloc: _perfilBloc,
                ),
              )
            : LoginScreen(loginBloc: _loginBloc);
      },
    );
  }

  void _listener(BuildContext context, AuthenticationState state) async {
    if (!state.isAuthenticating) {
      FlutterNativeSplash.remove();
    }

    if (state.isUnauthenticated) {
      if (context.mounted) {
        Navigator.of(context)
            .popUntil(ModalRoute.withName(AppRoutes.root.route));
      }
    }
  }
}
