import 'package:flutter/material.dart';
import 'package:torpheus/data/models/servico_model.dart';

/// Card de um serviço individual da OS.
class OrdemServicoWebServicoItem extends StatelessWidget {
  const OrdemServicoWebServicoItem({
    super.key,
    required this.servico,
    required this.onRemover,
  });

  final ServicoModel servico;
  final VoidCallback onRemover;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(10),
        border: Border.all(color: const Color(0xFFEAEDF2)),
      ),
      child: Row(
        children: [
          // Ícone
          Container(
            width: 36,
            height: 36,
            decoration: BoxDecoration(
              color: const Color(0xFFE8ECF4),
              borderRadius: BorderRadius.circular(8),
            ),
            child: const Icon(
              Icons.build_outlined,
              size: 18,
              color: Color(0xFF1B2A4A),
            ),
          ),

          const SizedBox(width: 12),

          // Descrição + funcionário
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  servico.descricao ?? '—',
                  style: const TextStyle(
                    fontSize: 13,
                    fontWeight: FontWeight.w600,
                    color: Color(0xFF1B2A4A),
                    decoration: TextDecoration.none,
                  ),
                ),
                if (servico.dataCriacao != null) ...[
                  const SizedBox(height: 2),
                  Text(
                    _formatarData(servico.dataCriacao!),
                    style: const TextStyle(
                      fontSize: 11,
                      color: Color(0xFF9BAABB),
                      decoration: TextDecoration.none,
                    ),
                  ),
                ],
              ],
            ),
          ),
          const SizedBox(width: 12),
          IconButton(
            onPressed: onRemover,
            icon: const Icon(Icons.delete_outline_rounded),
            color: const Color(0xFFC0392B),
            iconSize: 18,
            splashRadius: 16,
            padding: EdgeInsets.zero,
            constraints: const BoxConstraints(minWidth: 28, minHeight: 28),
          ),
        ],
      ),
    );
  }

  String _formatarData(DateTime data) {
    return '${data.day.toString().padLeft(2, '0')}/'
        '${data.month.toString().padLeft(2, '0')}/'
        '${data.year}';
  }
}
