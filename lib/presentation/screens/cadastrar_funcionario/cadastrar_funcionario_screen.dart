import 'package:flutter/material.dart';
import 'bloc/cadastrar_funcionario_bloc.dart';
import 'mobile/cadastrar_funcionario_mobile_content.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class CadastrarFuncionarioScreen extends StatelessWidget {
  const CadastrarFuncionarioScreen({
    super.key,
    required this.cadastrarFuncionarioBloc,
    required this.arguments,
  });

  final CadastrarFuncionarioBloc cadastrarFuncionarioBloc;
  final CadastrarFuncionarioArguments arguments;

  @override
  Widget build(BuildContext context) {
    return BlocProvider<CadastrarFuncionarioBloc>(
      create: (context) {
        return cadastrarFuncionarioBloc
          ..add(
            CadastrarFuncionarioLoad(id: arguments.id),
          );
      },
      child: const CadastrarFuncionarioMobileContent(),
    );
  }
}

class CadastrarFuncionarioArguments {
  CadastrarFuncionarioArguments({this.id});

  final String? id;
}
