import 'package:flutter/material.dart';
import 'package:torpheus/config/responsive.dart';
import 'mobile/cadastrar_mecanico_mobile_content.dart';
import 'web/cadastrar_mecanico_web_content.dart';
import 'bloc/cadastrar_mecanico_bloc.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class CadastrarMecanicoScreen extends StatelessWidget {
  const CadastrarMecanicoScreen({super.key, required this.cadastrarMecanicoBloc});

  final CadastrarMecanicoBloc cadastrarMecanicoBloc;

  @override
  Widget build(BuildContext context) {
    return BlocProvider.value(
      value: cadastrarMecanicoBloc..add(const CadastrarMecanicoLoad()),
      child: Responsive.isDesktop(context) || Responsive.isTablet(context)
          ? const CadastrarMecanicoWebContent()
          : const CadastrarMecanicoMobileContent(),
    );
  }
}
