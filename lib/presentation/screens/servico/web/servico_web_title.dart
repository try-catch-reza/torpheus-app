import 'package:flutter/material.dart';
import 'package:torpheus/core/constants/color_constants.dart';
import 'package:torpheus/data/models/ordem_servico_model.dart';

class ServicoWebTitle extends StatelessWidget {
  const ServicoWebTitle({super.key, required this.ordemServico});

  final OrdemServicoModel? ordemServico;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(24),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(12),
        border: Border.all(color: const Color(0xFFE8ECF0)),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const Text(
                      'Cliente',
                      style: TextStyle(
                        color: ColorConstants.steel,
                      ),
                    ),
                    const SizedBox(height: 4),
                    Text(
                      ordemServico?.clienteNome ?? '',
                      style: const TextStyle(
                        color: ColorConstants.chromaphobicBlack,
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                  ],
                ),
              ),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const Text(
                      'Veículo',
                      style: TextStyle(
                        color: ColorConstants.steel,
                      ),
                    ),
                    const SizedBox(height: 4),
                    Text(
                      '${ordemServico?.veiculoPlaca} - '
                      '${ordemServico?.veiculoModelo}',
                      style: const TextStyle(
                        color: ColorConstants.chromaphobicBlack,
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
          const SizedBox(height: 20),
          const Divider(height: 1, thickness: 1, color: Color(0xFFEEF0F3)),
          const SizedBox(height: 20),
          const Text(
            'Descrição do cliente',
            style: TextStyle(
              color: ColorConstants.steel,
            ),
          ),
          const SizedBox(height: 4),
          Text(
            ordemServico?.descricaoCliente ?? '',
            style: const TextStyle(
              color: ColorConstants.chromaphobicBlack,
              fontWeight: FontWeight.w600,
            ),
          ),
        ],
      ),
    );
  }
}
