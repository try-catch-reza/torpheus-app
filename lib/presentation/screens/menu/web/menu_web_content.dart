import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:torpheus/presentation/components/dialog/dialog_confirm.dart';
import 'package:torpheus/presentation/screens/menu/menu_screen.dart';

import '../../../../config/routes.dart';
import '../../login/bloc/login_bloc.dart';
import '../bloc/menu_bloc.dart';
import 'menu_web_body.dart';

class MenuWebContent extends StatelessWidget {
  const MenuWebContent({super.key, required this.menuParametros});

  final MenuParametros menuParametros;

  @override
  Widget build(BuildContext context) {
    return Material(
      child: BlocConsumer<MenuBloc, MenuState>(
        listener: _listener,
        builder: (context, state) {
          return MenuWebBody(
            indexScreen: state.indexScreen,
            menuParametros: menuParametros,
            nome: state.nome,
          );
        },
      ),
    );
  }

  void _listener(BuildContext context, MenuState state) {
    if (state.indexScreen == 6) {
      ConfirmDialog.show(
        context,
        titulo: 'Sair do aplicativo',
        mensagem: 'Tem certeza que deseja sair do aplicativo?',
        onConfirmar: () {
          context.read<LoginBloc>().add(const LoginLogout());
          Navigator.of(context).pushReplacementNamed(AppRoutes.root.route);
        },
        onCancelar: () {
          context.read<MenuBloc>().add(const MenuTrocarTela(0));
        },
      );
    }
  }
}
