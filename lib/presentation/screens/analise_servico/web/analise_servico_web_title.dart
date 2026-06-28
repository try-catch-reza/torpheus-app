import 'package:flutter/material.dart';
import 'package:torpheus/core/constants/extension/string_extension.dart';
import 'package:torpheus/data/models/servico_model.dart';

import '../../../../core/constants/color_constants.dart';

class AnaliseServicoWebTitle extends StatelessWidget {
  const AnaliseServicoWebTitle({super.key, required this.servico});

  final ServicoModel? servico;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(24),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(12),
        border: Border.all(
          color: const Color(0xFFE8ECF0),
        ),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Text(
            'Descrição',
            style: TextStyle(
              fontSize: 12,
              color: ColorConstants.steel,
            ),
          ),
          const SizedBox(height: 6),
          Text(
            servico?.descricao ?? '',
            style: const TextStyle(
              fontSize: 15,
              color: ColorConstants.chromaphobicBlack,
            ),
          ),
          const SizedBox(height: 28),
          const Divider(
            height: 1,
            thickness: 1,
            color: Color(0xFFEEF0F3),
          ),
          const SizedBox(height: 20),
          Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const Text(
                      'Funcionário',
                      style: TextStyle(
                        fontSize: 12,
                        color: ColorConstants.steel,
                      ),
                    ),
                    const SizedBox(height: 4),
                    Text(
                      servico?.funcionarioNome ?? '',
                      style: const TextStyle(
                        fontSize: 16,
                        fontWeight: FontWeight.w600,
                        color: ColorConstants.chromaphobicBlack,
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
                      'Início',
                      style: TextStyle(
                        fontSize: 12,
                        color: ColorConstants.steel,
                      ),
                    ),
                    const SizedBox(height: 4),
                    Text(
                      servico?.dataCriacao.toString().formataData ?? '',
                      style: const TextStyle(
                        fontSize: 16,
                        fontWeight: FontWeight.w600,
                        color: ColorConstants.chromaphobicBlack,
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}
