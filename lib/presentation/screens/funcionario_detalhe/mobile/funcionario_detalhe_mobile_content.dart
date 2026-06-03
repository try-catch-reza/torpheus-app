import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:torpheus/presentation/components/app_bar_padrao.dart';
import 'package:torpheus/presentation/screens/funcionario_detalhe/bloc/funcionario_detalhe_bloc.dart';
import 'package:torpheus/presentation/screens/funcionario_detalhe/mobile/funcionario_detalhe_mobile_atualizar.dart';
import 'package:torpheus/presentation/screens/funcionario_detalhe/mobile/funcionario_detalhe_mobile_body.dart';

import '../../../components/loading_state.dart';

class FuncionarioDetalheMobileContent extends StatelessWidget {
  const FuncionarioDetalheMobileContent({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: const AppBarPadrao(title: 'Dados do funcionário', hasLeading: true),
      body: BlocBuilder<FuncionarioDetalheBloc, FuncionarioDetalheState>(
        builder: (context, state) {
          if (state is FuncionarioDetalheLoading) {
            return const LoadingState();
          }

          if (state is FuncionarioDetalheLoaded) {
            return FuncionarioDetalheMobileBody(state: state);
          }

          return const SizedBox.shrink();
        },
      ),
      bottomNavigationBar: const FuncionarioDetalheMobileAtualizar(),
    );
  }
}

