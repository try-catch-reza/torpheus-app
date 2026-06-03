import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:torpheus/presentation/components/loading_state.dart';
import 'package:torpheus/presentation/screens/funcionario_detalhe/bloc/funcionario_detalhe_bloc.dart';
import 'package:torpheus/presentation/screens/funcionario_detalhe/web/funcionario_detalhe_web_body.dart';

class FuncionarioDetalheWebContent extends StatelessWidget {
  const FuncionarioDetalheWebContent({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<FuncionarioDetalheBloc, FuncionarioDetalheState>(
      builder: (context, state) {
        if (state is FuncionarioDetalheLoading) {
          return const LoadingState();
        }

        if (state is FuncionarioDetalheLoaded) {
          return FuncionarioDetalheWebBody(state: state);
        }

        return const SizedBox();
      },
    );
  }
}

