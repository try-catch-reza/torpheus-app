import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:torpheus/presentation/screens/menu/menu_screen.dart';

import '../bloc/menu_bloc.dart';
import 'menu_web_body.dart';

class MenuWebContent extends StatelessWidget {
  const MenuWebContent({super.key, required this.menuParametros});

  final MenuParametros menuParametros;

  @override
  Widget build(BuildContext context) {
    return Material(
      child: BlocBuilder<MenuBloc, MenuState>(
        builder: (context, state) {
          return MenuWebBody(
            indexScreen: state.indexScreen,
            menuParametros: menuParametros,
            nome: state.nome,
            permissoesUsuarios: state.permissoesUsuarios,
            state: state,
          );
        },
      ),
    );
  }
}
