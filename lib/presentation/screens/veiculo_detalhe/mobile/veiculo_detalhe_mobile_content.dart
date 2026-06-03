import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:torpheus/presentation/components/app_bar_padrao.dart';
import 'package:torpheus/presentation/screens/veiculo_detalhe/bloc/veiculo_detalhe_bloc.dart';
import 'package:torpheus/presentation/screens/veiculo_detalhe/mobile/veiculo_detalhe_mobile_atualizar.dart';
import 'package:torpheus/presentation/screens/veiculo_detalhe/mobile/veiculo_detalhe_mobile_body.dart';

import '../../../components/loading_state.dart';

class VeiculoDetalheMobileContent extends StatelessWidget {
  const VeiculoDetalheMobileContent({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: const AppBarPadrao(title: 'Dados do veículo', hasLeading: true),
      body: BlocBuilder<VeiculoDetalheBloc, VeiculoDetalheState>(
        builder: (context, state) {
          if (state is VeiculoDetalheLoading) {
            return const LoadingState();
          }

          if (state is VeiculoDetalheLoaded) {
            return VeiculoDetalheMobileBody(state: state);
          }

          return const SizedBox.shrink();
        },
      ),
      bottomNavigationBar: const VeiculoDetalheMobileAtualizar(),
    );
  }
}

