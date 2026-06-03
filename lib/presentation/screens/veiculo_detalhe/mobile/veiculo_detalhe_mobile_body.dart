import 'package:flutter/material.dart';
import 'package:torpheus/presentation/screens/veiculo_detalhe/bloc/veiculo_detalhe_bloc.dart';

import 'veiculo_detalhe_mobile_info.dart';
import 'veiculo_detalhe_mobile_title.dart';

class VeiculoDetalheMobileBody extends StatelessWidget {
  const VeiculoDetalheMobileBody({super.key, required this.state});

  final VeiculoDetalheState state;

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        VeiculoDetalheMobileTitle(veiculo: state.veiculo),
        const SizedBox(height: 15),
        VeiculoDetalheMobileInfo(veiculo: state.veiculo),
      ],
    );
  }
}

