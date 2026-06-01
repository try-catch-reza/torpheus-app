import 'package:flutter/material.dart';
import 'package:torpheus/config/routes.dart';
import 'package:torpheus/presentation/screens/funcionario/widgets/funcionario_lista.dart';

import '../../../components/lista_vazia_custom.dart';
import '../../../components/mobile/header_mobile_custom.dart';
import '../../../components/search_custom.dart';
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
        HeaderMobileCustom(
          title: 'Funcionários',
          subtitle: 'Cadastro e histórico de funcionários',
          onPressed: () {
            Navigator.of(context).pushNamed(
              AppRoutes.cadastrarFuncionario.route,
            );
          },
        ),
        SearchCustom(controller: controller, width: double.infinity),
        if (state.funcionarios.isEmpty)
          const ListaVaziaCustom(
            message: 'Nenhum funcionário encontrado.',
            subMessage: 'Cadastre um novo funcionário',
          ),
        if (state.funcionarios.isNotEmpty)
          FuncionarioLista(
            funcionarios: state.funcionarios,
            onFuncionarioTap: (value) {},
          ),
      ],
    );
  }
}
