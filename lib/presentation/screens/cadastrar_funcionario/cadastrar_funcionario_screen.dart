import 'package:flutter/material.dart';
import 'package:torpheus/config/responsive.dart';
import 'bloc/cadastrar_funcionario_bloc.dart';
import 'mobile/cadastrar_funcionario_mobile_content.dart';
import 'web/cadastrar_funcionario_web_content.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class CadastrarFuncionarioScreen extends StatelessWidget {
  const CadastrarFuncionarioScreen({
    super.key,
    required this.cadastrarFuncionarioBloc,
  });

  final CadastrarFuncionarioBloc cadastrarFuncionarioBloc;

  @override
  Widget build(BuildContext context) {
    return BlocProvider.value(
      value: cadastrarFuncionarioBloc..add(const CadastrarFuncionarioLoad()),
      child: Responsive.isDesktop(context) || Responsive.isTablet(context)
          ? const CadastrarFuncionarioWebContent()
          : const CadastrarFuncionarioMobileContent(),
    );
  }
}
