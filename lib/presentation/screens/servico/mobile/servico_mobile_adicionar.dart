import 'package:flutter/material.dart';

import '../../../../core/constants/color_constants.dart';

class ServicoMobileAdicionar extends StatelessWidget {
  const ServicoMobileAdicionar({
    super.key,
    required this.quantServico,
    required this.onPressed,
  });

  final int? quantServico;
  final VoidCallback onPressed;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(
            'Serviços ($quantServico)',
            style: const TextStyle(
              color: ColorConstants.steel,
              fontSize: 16,
              fontWeight: FontWeight.w700,
            ),
          ),
          ElevatedButton.icon(
            onPressed: onPressed,
            label: const Text('Adicionar serviço'),
            icon: const Icon(Icons.add),
          )
        ],
      ),
    );
  }
}
