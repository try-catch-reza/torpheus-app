import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:torpheus/presentation/components/app_bar_padrao.dart';
import 'package:torpheus/presentation/components/loading_state.dart';
import 'package:torpheus/presentation/screens/analise_servico/bloc/analise_servico_bloc.dart';

class AnaliseServicoMobileContent extends StatelessWidget {
  const AnaliseServicoMobileContent({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: const AppBarPadrao(
        title: 'Análise do Serviço',
        hasLeading: true,
      ),
      body: BlocBuilder<AnaliseServicoBloc, AnaliseServicoState>(
        builder: (context, state) {
          if (state is AnaliseServicoLoading) {
            return const LoadingState();
          }

          if (state is AnaliseServicoLoaded) {
            return Center(
              child: Text(state.servico?.descricao ?? ''),
            );
          }

          if (state is AnaliseServicoFail) {
            return Center(child: Text(state.message));
          }

          return const SizedBox.shrink();
        },
      ),
    );
  }
}
