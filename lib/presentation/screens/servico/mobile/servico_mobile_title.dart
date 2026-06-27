import 'package:flutter/material.dart';
import 'package:torpheus/data/models/ordem_servico_model.dart';

import '../../../../core/constants/color_constants.dart';

class ServicoMobileTitle extends StatelessWidget {
  const ServicoMobileTitle({super.key, required this.ordemServico});

  final OrdemServicoModel? ordemServico;

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
                ordemServico?.clienteNome ?? '',
                style: const TextStyle(
                  color: ColorConstants.chromaphobicBlack,
                  fontSize: 16,
                  fontWeight: FontWeight.w700,
                ),
              ),
              const SizedBox(height: 5),
              Text(
                ordemServico?.descricaoCliente ?? '',
                style: const TextStyle(color: ColorConstants.steel),
              ),
              const SizedBox(height: 5),
              Text(
                '${ordemServico?.veiculoPlaca} - ${ordemServico?.veiculoModelo}',
                style: const TextStyle(color: ColorConstants.steel),
              ),
            ],
          ),
        ],
      ),
    );
  }
}
