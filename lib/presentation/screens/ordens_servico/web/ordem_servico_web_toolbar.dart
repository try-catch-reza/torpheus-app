import 'package:flutter/material.dart';

import '../../../../core/constants/color_constants.dart';

/// Barra da seção de serviços com contador e botão de adicionar.
class OrdemServicoWebServicosToolbar extends StatelessWidget {
  const OrdemServicoWebServicosToolbar({
    super.key,
    required this.totalServicos,
    required this.onAdicionar,
  });

  final int totalServicos;
  final VoidCallback onAdicionar;

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        const Text(
          'Serviços',
          style: TextStyle(
            fontSize: 14,
            fontWeight: FontWeight.w600,
            color: Color(0xFF1B2A4A),
            decoration: TextDecoration.none,
          ),
        ),
        const SizedBox(width: 8),
        Container(
          padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 2),
          decoration: BoxDecoration(
            color: const Color(0xFFE8ECF4),
            borderRadius: BorderRadius.circular(20),
          ),
          child: Text(
            '$totalServicos',
            style: const TextStyle(
              fontSize: 11,
              fontWeight: FontWeight.w600,
              color: Color(0xFF1B2A4A),
              decoration: TextDecoration.none,
            ),
          ),
        ),

        const Spacer(),

        SizedBox(
          height: 36,
          child: ElevatedButton.icon(
            onPressed: onAdicionar,
            style: ElevatedButton.styleFrom(
              backgroundColor: ColorConstants.chambray,
              foregroundColor: Colors.white,
              elevation: 0,
              padding: const EdgeInsets.symmetric(horizontal: 14),
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(8),
              ),
            ),
            icon: const Icon(Icons.add_rounded, size: 16),
            label: const Text(
              'Adicionar serviço',
              style: TextStyle(
                fontSize: 12,
                fontWeight: FontWeight.w600,
                decoration: TextDecoration.none,
              ),
            ),
          ),
        ),
      ],
    );
  }
}