import 'package:flutter/material.dart';
import 'package:torpheus/core/constants/color_constants.dart';
import 'package:torpheus/core/constants/extension/string_extension.dart';

class PainelWebTitle extends StatelessWidget {
  const PainelWebTitle({super.key});

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Column(
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
        ),
        ElevatedButton.icon(
          onPressed: () {},
          style: ElevatedButton.styleFrom(
            backgroundColor: ColorConstants.chambray,
            foregroundColor: Colors.white,
            elevation: 0,
            padding: const EdgeInsets.symmetric(horizontal: 18, vertical: 20),
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(8),
            ),
          ),
          icon: const Icon(Icons.add_rounded, size: 18),
          label: const Text(
            'Nova OS',
            style: TextStyle(
              fontSize: 13,
              decoration: TextDecoration.none,
            ),
          ),
        )
      ],
    );
  }
}
