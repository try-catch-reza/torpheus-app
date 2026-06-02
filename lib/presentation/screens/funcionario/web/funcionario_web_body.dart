import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:torpheus/presentation/components/lista_vazia_custom.dart';
import 'package:torpheus/presentation/screens/funcionario/mobile/funcionario_mobile_lista.dart';

import '../../../components/search_custom.dart';
import '../../../components/web/header_web_custom.dart';
import '../bloc/funcionario_bloc.dart';

class FuncionarioWebBody extends StatelessWidget {
  const FuncionarioWebBody({
    super.key,
    required this.state,
    required this.controller,
  });

  final FuncionarioState state;
  final TextEditingController controller;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(32.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          HeaderWebCustom(
            title: 'Funcionários',
            subtitle: 'Cadastro e histórico de funcionários',
            buttonText: 'Cadastrar funcionário',
            onPressed: () {
              context.read<FuncionarioBloc>().add(const FuncionarioCadastrar());
            },
          ),
          SearchCustom(controller: controller),
          if (state.funcionarios.isEmpty)
            const ListaVaziaCustom(
              message: 'Nenhum funcionário encontrado.',
              subMessage: 'Cadastre um novo funcionário',
            ),
          if (state.funcionarios.isNotEmpty)
            FuncionarioMobileLista(
              funcionarios: state.funcionarios,
              onFuncionarioTap: (funcionario) {},
            ),
        ],
      ),
    );
  }
}
