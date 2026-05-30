import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_native_splash/flutter_native_splash.dart';
import 'package:torpheus/presentation/screens/painel/bloc/painel_bloc.dart';
import 'package:torpheus/presentation/screens/login/bloc/login_bloc.dart';
import 'package:torpheus/presentation/screens/menu/bloc/menu_bloc.dart';
import 'package:torpheus/presentation/screens/menu/menu_screen.dart';
import 'package:torpheus/presentation/screens/perfil/bloc/perfil_bloc.dart';
import '../cliente/bloc/cliente_bloc.dart';
import '../funcionario/bloc/funcionario_bloc.dart';
import '../login/login_screen.dart';

import '../../../config/routes.dart';
import '../ordens_servico/bloc/ordens_servico_bloc.dart';
import '../relatorios/bloc/relatorios_bloc.dart';
import '../veiculos/bloc/veiculos_bloc.dart';
import 'authentication_bloc/authentication_bloc.dart';

class AuthenticationScreen extends StatefulWidget {
  const AuthenticationScreen({
    super.key,
    required this.authenticationBloc,
    required this.loginBloc,
    required this.menuBloc,
    required this.homeBloc,
    required this.perfilBloc,
    required this.clienteBloc,
    required this.mecanicosBloc,
    required this.veiculosBloc,
    required this.ordensServicoBloc,
    required this.relatoriosBloc,
  });

  final AuthenticationBloc authenticationBloc;
  final LoginBloc loginBloc;
  final MenuBloc menuBloc;
  final PainelBloc homeBloc;
  final PerfilBloc perfilBloc;
  final ClienteBloc clienteBloc;
  final FuncionarioBloc mecanicosBloc;
  final VeiculosBloc veiculosBloc;
  final OrdensServicoBloc ordensServicoBloc;
  final RelatoriosBloc relatoriosBloc;

  @override
  State<AuthenticationScreen> createState() => _AuthenticationScreenState();
}

class _AuthenticationScreenState extends State<AuthenticationScreen> {
  late final AuthenticationBloc _authenticationBloc;
  late final LoginBloc _loginBloc;
  late final MenuBloc _menuBloc;
  late final PainelBloc _homeBloc;
  late final PerfilBloc _perfilBloc;
  late final ClienteBloc _clienteBloc;
  late final FuncionarioBloc _mecanicosBloc;
  late final VeiculosBloc _veiculosBloc;
  late final OrdensServicoBloc _ordensServicoBloc;
  late final RelatoriosBloc _relatoriosBloc;

  @override
  void initState() {
    _authenticationBloc = widget.authenticationBloc;
    _loginBloc = widget.loginBloc;
    _menuBloc = widget.menuBloc;
    _homeBloc = widget.homeBloc;
    _perfilBloc = widget.perfilBloc;
    _clienteBloc = widget.clienteBloc;
    _mecanicosBloc = widget.mecanicosBloc;
    _veiculosBloc = widget.veiculosBloc;
    _ordensServicoBloc = widget.ordensServicoBloc;
    _relatoriosBloc = widget.relatoriosBloc;

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
                  clienteBloc: _clienteBloc,
                  mecanicosBloc: _mecanicosBloc,
                  veiculosBloc: _veiculosBloc,
                  ordensServicoBloc: _ordensServicoBloc,
                  relatoriosBloc: _relatoriosBloc,
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
