import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:torpheus/presentation/components/app_bar_padrao.dart';
import 'package:torpheus/presentation/screens/cadastrar_veiculo/bloc/cadastrar_veiculo_bloc.dart';

import '../../../components/loading_state.dart';

class CadastrarVeiculoMobileContent extends StatelessWidget {
  const CadastrarVeiculoMobileContent({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: const AppBarPadrao(title: 'Cadastrar Veículo', hasLeading: true),
      body: BlocConsumer<CadastrarVeiculoBloc, CadastrarVeiculoState>(
        listener: _listener,
        builder: (context, state) {
          if (state is CadastrarVeiculoLoading ||
              state is CadastrarVeiculoEditando) {
            return const LoadingState();
          }

          if (state is CadastrarVeiculoLoaded) {
            /// Implementar body
          }

          return const SizedBox.shrink();
        },
      ),
    );
  }

  void _listener(BuildContext context, CadastrarVeiculoState state) {
  }
}
