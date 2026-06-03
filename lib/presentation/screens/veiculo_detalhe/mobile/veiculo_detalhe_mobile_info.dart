import 'package:flutter/material.dart';
import 'package:torpheus/data/models/veiculo_model.dart';
import 'package:torpheus/presentation/screens/veiculo_detalhe/mobile/veiculo_detalhe_mobile_tile.dart';

import '../../../../core/constants/color_constants.dart';

class VeiculoDetalheMobileInfo extends StatelessWidget {
  const VeiculoDetalheMobileInfo({super.key, required this.veiculo});

  final VeiculoModel? veiculo;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 8.0, vertical: 8.0),
      decoration: BoxDecoration(
        border: Border.all(color: ColorConstants.mercury, width: 2.0),
        color: Colors.white,
      ),
      child: Column(
        children: [
          VeiculoDetalheMobileTile(
            title: 'Tipo',
            value: veiculo?.tipo ?? 'Tipo não informado',
          ),
          VeiculoDetalheMobileTile(
            title: 'Marca',
            value: veiculo?.marca ?? 'Marca não informada',
          ),
          VeiculoDetalheMobileTile(
            title: 'Ano',
            value: veiculo?.ano ?? 'Ano não informado',
          ),
          VeiculoDetalheMobileTile(
            title: 'Motor',
            value: veiculo?.motor ?? 'Motor não informado',
          ),
          VeiculoDetalheMobileTile(
            title: 'Câmbio',
            value: veiculo?.cambio ?? 'Câmbio não informado',
          ),
          VeiculoDetalheMobileTile(
            title: 'Combustível',
            value: veiculo?.combustivel ?? 'Combustível não informado',
            isDivider: false,
          ),
        ],
      ),
    );
  }
}

