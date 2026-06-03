import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:torpheus/presentation/components/loading_state.dart';
import 'package:torpheus/presentation/screens/veiculo_detalhe/bloc/veiculo_detalhe_bloc.dart';
import 'package:torpheus/presentation/screens/veiculo_detalhe/web/veiculo_detalhe_web_body.dart';

class VeiculoDetalheWebContent extends StatelessWidget {
  const VeiculoDetalheWebContent({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<VeiculoDetalheBloc, VeiculoDetalheState>(
      builder: (context, state) {
        if (state is VeiculoDetalheLoading) {
          return const LoadingState();
        }

        if (state is VeiculoDetalheLoaded) {
          return VeiculoDetalheWebBody(state: state);
        }

        return const SizedBox();
      },
    );
  }
}

