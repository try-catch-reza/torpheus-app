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
      width: MediaQuery.of(context).size.width,
      padding: const EdgeInsets.all(24.0),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(12),
        border: Border.all(color: const Color(0xFFE8ECF0)),
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                servico?.descricao ?? '',
                style: const TextStyle(
                  color: ColorConstants.chromaphobicBlack,
                  fontSize: 16,
                  fontWeight: FontWeight.w700,
                ),
              ),
              const SizedBox(height: 5),
              Text(
                servico?.funcionarioNome ?? '',
                style: const TextStyle(color: ColorConstants.steel),
              ),
              const SizedBox(height: 5),
              Text(
                servico?.dataCriacao.toString().formataData ?? '',
                style: const TextStyle(color: ColorConstants.steel),
              ),
            ],
          ),
        ],
      ),
    );
  }
}
