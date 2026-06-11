import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:torpheus/data/models/funcionario_model.dart';

import 'bloc/funcionario_detalhe_bloc.dart';
import 'mobile/funcionario_detalhe_mobile_content.dart';

class FuncionarioDetalheScreen extends StatelessWidget {
  const FuncionarioDetalheScreen({
    super.key,
    required this.funcionarioDetalheBloc,
    required this.arguments,
  });

  final FuncionarioDetalheBloc funcionarioDetalheBloc;
  final FuncionarioDetalheArguments arguments;

  @override
  Widget build(BuildContext context) {
    return BlocProvider.value(
      value: funcionarioDetalheBloc
        ..add(FuncionarioDetalheLoad(arguments.funcionario)),
      child: const FuncionarioDetalheMobileContent(),
    );
  }
}

class FuncionarioDetalheArguments {
  FuncionarioDetalheArguments({this.funcionario});

  final FuncionarioModel? funcionario;
}
