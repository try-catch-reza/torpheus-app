import 'package:flutter/material.dart';
import 'package:torpheus/data/models/veiculo_model.dart';

import '../../../../core/constants/color_constants.dart';
import '../../../components/status_ativo.dart';

class VeiculoDetalheMobileTitle extends StatelessWidget {
  const VeiculoDetalheMobileTitle({super.key, required this.veiculo});

  final VeiculoModel? veiculo;

  @override
  Widget build(BuildContext context) {
    return Container(
      width: MediaQuery.of(context).size.width,
      padding: const EdgeInsets.all(16.0),
      decoration: const BoxDecoration(
        border: Border(
          bottom: BorderSide(color: ColorConstants.mercury, width: 2.0),
        ),
        color: Colors.white,
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                veiculo?.modelo ?? 'Modelo não informado',
                style: const TextStyle(
                  color: ColorConstants.chromaphobicBlack,
                  fontSize: 16,
                  fontWeight: FontWeight.w700,
                ),
              ),
              const SizedBox(height: 5),
              Text(
                veiculo?.placa ?? 'Placa não informada',
                style: const TextStyle(color: ColorConstants.steel),
              ),
            ],
          ),
          StatusAtivo(
            dot: veiculo?.isActive ?? false,
          ),
        ],
      ),
    );
  }
}
