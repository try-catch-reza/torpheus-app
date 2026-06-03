import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:torpheus/presentation/screens/veiculo_detalhe/bloc/veiculo_detalhe_bloc.dart';
import 'package:torpheus/presentation/screens/veiculo_detalhe/web/veiculo_detalhe_web_card_info.dart';
import 'package:torpheus/presentation/screens/veiculo_detalhe/web/veiculo_detalhe_web_card_estatisticas.dart';
import 'package:torpheus/presentation/screens/veiculo_detalhe/web/veiculo_detalhe_web_header.dart';

import '../../veiculos/bloc/veiculos_bloc.dart';

class VeiculoDetalheWebBody extends StatelessWidget {
  const VeiculoDetalheWebBody({super.key, required this.state});

  final VeiculoDetalheState state;

  @override
  Widget build(BuildContext context) {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Expanded(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              VeiculoDetalheWebHeader(
                modeloVeiculo: state.veiculo?.modelo ?? '',
                onVoltar: () {
                  context.read<VeiculosBloc>().add(const VeiculosLoad());
                },
              ),
              const SizedBox(height: 20),
              VeiculoDetalheWebCardInfo(veiculo: state.veiculo),
            ],
          ),
        ),
        const SizedBox(width: 16),
        const VeiculoDetalheWebCardEstatisticas(),
      ],
    );
  }
}

