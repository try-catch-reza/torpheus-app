import 'package:flutter/material.dart';
import 'package:torpheus/core/constants/enum/status_ordem.dart';

import '../../../../core/constants/color_constants.dart';

class ServicoWebTitleList extends StatelessWidget {
  const ServicoWebTitleList({
    super.key,
    required this.quantServicos,
    required this.onPressed,
    required this.statusOrdem,
  });

  final int quantServicos;
  final VoidCallback onPressed;
  final StatusOrdem? statusOrdem;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 16),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(
            'Serviços ($quantServicos)',
            style: const TextStyle(
              color: ColorConstants.steel,
              fontSize: 16,
              fontWeight: FontWeight.w700,
            ),
          ),
          Visibility(
            visible: statusOrdem != StatusOrdem.completado &&
                statusOrdem != StatusOrdem.cancelado,
            child: OutlinedButton.icon(
              onPressed: onPressed,
              icon: const Icon(Icons.add, size: 16, color: Colors.white),
              label: const Text(
                'Adicionar serviço',
                style: TextStyle(color: Colors.white),
              ),
              style: OutlinedButton.styleFrom(
                backgroundColor: ColorConstants.chambray,
                textStyle: const TextStyle(
                  fontSize: 13,
                  fontWeight: FontWeight.w600,
                ),
                padding: const EdgeInsets.symmetric(
                  horizontal: 14,
                  vertical: 10,
                ),
                side: const BorderSide(
                  color: Color(0xFFD0D5DD),
                ),
                foregroundColor: const Color(0xFF344054),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(8),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
