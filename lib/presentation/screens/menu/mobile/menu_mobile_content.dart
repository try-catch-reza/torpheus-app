import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:torpheus/presentation/screens/menu/menu_screen.dart';
import 'package:torpheus/presentation/screens/menu/mobile/menu_mobile_body.dart';

import '../bloc/menu_bloc.dart';

class MenuMobileContent extends StatelessWidget {
  const MenuMobileContent({super.key, required this.menuParametros});

  final MenuParametros menuParametros;

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<MenuBloc, MenuState>(
      builder: (context, state) {
        return MenuMobileBody(
          indexScreen: state.indexScreen,
          menuParametros: menuParametros,
          permissoesUsuario: state.permissoesUsuarios,
        );
      },
    );
  }
}
