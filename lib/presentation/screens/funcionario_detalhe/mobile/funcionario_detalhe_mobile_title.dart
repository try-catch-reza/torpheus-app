import 'package:flutter/material.dart';
import 'package:torpheus/data/models/funcionario_model.dart';

import '../../../../core/constants/color_constants.dart';
import '../../../components/status_ativo.dart';

class FuncionarioDetalheMobileTitle extends StatelessWidget {
  const FuncionarioDetalheMobileTitle({super.key, required this.funcionario});

  final FuncionarioModel? funcionario;

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
                funcionario?.nome ?? 'Nome não informado',
                style: const TextStyle(
                  color: ColorConstants.chromaphobicBlack,
                  fontSize: 16,
                  fontWeight: FontWeight.w700,
                ),
              ),
              const SizedBox(height: 5),
              Text(
                'CPF - ${funcionario?.documento}',
                style: const TextStyle(color: ColorConstants.steel),
              ),
            ],
          ),
          StatusAtivo(
            dot: funcionario?.isActive ?? false,
          ),
        ],
      ),
    );
  }
}
