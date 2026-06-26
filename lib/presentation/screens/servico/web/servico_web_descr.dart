import 'package:flutter/material.dart';
import 'package:torpheus/data/models/servico_model.dart';

import '../../../../core/constants/color_constants.dart';

class ServicoWebDescr extends StatelessWidget {
  const ServicoWebDescr({super.key, required this.servico});

  final ServicoModel servico;

  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            servico.descricao ?? '',
            style: const TextStyle(
              color: ColorConstants.steel,
              fontSize: 15,
            ),
          ),
          const SizedBox(height: 2),
          Text(
            servico.funcionarioId != null
                ? 'Funcionário: ${servico.funcionarioNome}'
                : 'Funcionário não informado',
          ),
        ],
      ),
    );
  }
}
