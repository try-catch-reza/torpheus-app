import 'package:flutter/material.dart';
import 'package:torpheus/presentation/screens/funcionario_detalhe/bloc/funcionario_detalhe_bloc.dart';

import 'funcionario_detalhe_mobile_info.dart';
import 'funcionario_detalhe_mobile_title.dart';

class FuncionarioDetalheMobileBody extends StatelessWidget {
  const FuncionarioDetalheMobileBody({super.key, required this.state});

  final FuncionarioDetalheState state;

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        FuncionarioDetalheMobileTitle(funcionario: state.funcionario),
        const SizedBox(height: 15),
        FuncionarioDetalheMobileInfo(funcionario: state.funcionario),
      ],
    );
  }
}

