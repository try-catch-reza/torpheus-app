import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:torpheus/presentation/screens/painel/bloc/painel_bloc.dart';
import 'package:torpheus/presentation/screens/menu/bloc/menu_bloc.dart';
import 'package:torpheus/presentation/screens/menu/web/menu_web_content.dart';

import '../../../config/responsive.dart';
import 'mobile/menu_mobile_content.dart';

class MenuScreen extends StatelessWidget {
  const MenuScreen({super.key, required this.menuParametros});

  final MenuParametros menuParametros;

  @override
  Widget build(BuildContext context) {
    return BlocProvider.value(
      value: menuParametros.menuBloc..add(const MenuCarregar()),
      child: Responsive.isDesktop(context) || Responsive.isTablet(context)
          ? MenuWebContent(menuParametros: menuParametros)
          : MenuMobileContent(menuParametros: menuParametros),
    );
  }
}

class MenuParametros {
  const MenuParametros({required this.homeBloc, required this.menuBloc});

  final PainelBloc homeBloc;
  final MenuBloc menuBloc;
}
