import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:torpheus/presentation/screens/cadastrar_funcionario/cadastrar_funcionario_screen.dart';
import 'package:torpheus/presentation/screens/funcionario_detalhe/bloc/funcionario_detalhe_bloc.dart';

import '../../../../config/routes.dart';
import '../../../components/app_button_bottom_navigation.dart';

class FuncionarioDetalheMobileAtualizar extends StatelessWidget {
  const FuncionarioDetalheMobileAtualizar({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<FuncionarioDetalheBloc, FuncionarioDetalheState>(
      builder: (context, state) {
        return Visibility(
          visible: state.hasEditarFuncionario,
          child: AppButtonBottomNavigation(
            icon: Icons.edit,
            text: 'Editar dados do funcionário',
            onPressed: () {
              Navigator.of(context).pushNamed(
                AppRoutes.cadastrarFuncionario.route,
                arguments: CadastrarFuncionarioArguments(
                  id: state.funcionario?.id ?? '',
                ),
              ).then((_) {
                context.read<FuncionarioDetalheBloc>()
                    .add(FuncionarioDetalheLoad(state.funcionario));
              });
            },
          ),
        );
      },
    );
  }
}
