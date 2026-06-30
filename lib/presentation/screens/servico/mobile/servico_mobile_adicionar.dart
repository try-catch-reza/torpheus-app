import 'package:flutter/material.dart';
import 'package:torpheus/core/constants/enum/status_ordem.dart';

import '../../../../core/constants/color_constants.dart';

class ServicoMobileAdicionar extends StatelessWidget {
  const ServicoMobileAdicionar({
    super.key,
    required this.quantServico,
    required this.onPressed,
    required this.statusOrdem,
  });

  final int? quantServico;
  final VoidCallback onPressed;
  final StatusOrdem? statusOrdem;

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
          Visibility(
            visible: statusOrdem != StatusOrdem.completado &&
                statusOrdem != StatusOrdem.cancelado,
            child: ElevatedButton.icon(
              onPressed: onPressed,
              label: const Text('Adicionar serviço'),
              icon: const Icon(Icons.add),
            ),
          )
        ],
      ),
    );
  }
}
