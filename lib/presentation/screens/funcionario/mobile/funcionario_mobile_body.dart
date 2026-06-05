import 'package:flutter/material.dart';
import 'package:torpheus/presentation/components/mobile/app_bar_mobile_search.dart';
import 'package:torpheus/presentation/screens/funcionario/mobile/funcionario_mobile_lista.dart';
import 'package:torpheus/presentation/screens/funcionario_detalhe/funcionario_detalhe_screen.dart';

import '../../../../config/routes.dart';
import '../../../components/lista_vazia_custom.dart';
import '../bloc/funcionario_bloc.dart';

class FuncionarioMobileBody extends StatelessWidget {
  const FuncionarioMobileBody({
    super.key,
    required this.state,
    required this.controller,
  });

  final FuncionarioState state;
  final TextEditingController controller;

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        AppBarMobileSearch(
          onPressed: () {
            Navigator.of(context).pushNamed(
              AppRoutes.cadastrarFuncionario.route,
            );
          },
          title: 'Funcionários',
          subtitle: 'Cadastro e histórico de funcionários',
          controller: controller,
          hasPodeCriar: state.hasCriarFuncionario,
        ),
        if (state.funcionarios.isEmpty)
          const ListaVaziaCustom(
            message: 'Nenhum funcionário encontrado.',
            subMessage: 'Cadastre um novo funcionário',
          ),
        if (state.funcionarios.isNotEmpty)
          FuncionarioMobileLista(
            funcionarios: state.funcionarios,
            onFuncionarioTap: (value) {
              Navigator.of(context).pushNamed(
                AppRoutes.funcionarioDetalhe.route,
                arguments: FuncionarioDetalheArguments(funcionario: value),
              );
            },
          ),
      ],
    );
  }
}
