import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:torpheus/presentation/screens/funcionario_detalhe/bloc/funcionario_detalhe_bloc.dart';
import 'package:torpheus/presentation/screens/funcionario_detalhe/web/funcionario_detalhe_web_card_info.dart';
import 'package:torpheus/presentation/screens/funcionario_detalhe/web/funcionario_detalhe_web_card_estatisticas.dart';
import 'package:torpheus/presentation/screens/funcionario_detalhe/web/funcionario_detalhe_web_header.dart';

import '../../funcionario/bloc/funcionario_bloc.dart';

class FuncionarioDetalheWebBody extends StatelessWidget {
  const FuncionarioDetalheWebBody({super.key, required this.state});

  final FuncionarioDetalheState state;

  @override
  Widget build(BuildContext context) {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Expanded(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              FuncionarioDetalheWebHeader(
                nomeFuncionario: state.funcionario?.nome ?? '',
                onVoltar: () {
                  context.read<FuncionarioBloc>().add(const FuncionarioLoad());
                },
              ),
              const SizedBox(height: 20),
              FuncionarioDetalheWebCardInfo(funcionario: state.funcionario),
            ],
          ),
        ),
        const SizedBox(width: 16),
        const FuncionarioDetalheWebCardEstatisticas(),
      ],
    );
  }
}

