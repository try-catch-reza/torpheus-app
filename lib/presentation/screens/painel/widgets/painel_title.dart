import 'package:flutter/material.dart';
import 'package:torpheus/core/constants/color_constants.dart';
import 'package:torpheus/core/constants/extension/string_extension.dart';

class PainelTitle extends StatelessWidget {
  const PainelTitle({super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const Text(
          'Painel Geral',
          style: TextStyle(
            color: ColorConstants.chromaphobicBlack,
            fontSize: 20,
            fontWeight: FontWeight.bold,
          ),
        ),
        const SizedBox(height: 8),
        Text(
          'Hoje, ${DateTime.now().toString().formataDataExtenso}',
          style: const TextStyle(
            color: ColorConstants.steel,
          ),
        )
      ],
    );
  }
}
