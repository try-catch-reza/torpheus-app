import 'package:flutter/material.dart';

import '../../../../data/models/cliente_estatisticas.dart';

class ClienteDetalheMobileEstatisticas extends StatelessWidget {
  const ClienteDetalheMobileEstatisticas({super.key, required this.estatisticas});

  final ClienteEstatisticas? estatisticas;

  @override
  Widget build(BuildContext context) {
    return Container(
      height: MediaQuery.of(context).size.height * 0.18,
      width: MediaQuery.of(context).size.width,
      padding: const EdgeInsets.all(20),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(12),
        border: Border.all(color: const Color(0xFFEAEDF2)),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Text(
            'Estatísticas',
            style: TextStyle(
              fontSize: 14,
              fontWeight: FontWeight.w700,
              color: Color(0xFF1B2A4A),
              decoration: TextDecoration.none,
            ),
          ),
          const SizedBox(height: 16),
          _StatRow(
            label: 'Veículos atendidos',
            value: '${estatisticas?.veiculosAtendidos}',
            valueColor: const Color(0xFF1B2A4A),
          ),
          const SizedBox(height: 14),
          _StatRow(
            label: 'OS deste cliente',
            value: '${estatisticas?.osDoCliente}',
            valueColor: const Color(0xFF1B4FA8),
          ),
          const SizedBox(height: 14),
          _StatRow(
            label: 'Concluídas',
            value: '${estatisticas?.osConcluidas}',
            valueColor: const Color(0xFF16A34A),
          ),
        ],
      ),
    );
  }
}

class _StatRow extends StatelessWidget {
  const _StatRow({
    required this.label,
    required this.value,
    required this.valueColor,
  });

  final String label;
  final String value;
  final Color valueColor;

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Text(
          label,
          style: const TextStyle(
            fontSize: 12,
            color: Color(0xFF6B7A99),
            decoration: TextDecoration.none,
          ),
        ),
        Text(
          value,
          style: TextStyle(
            fontSize: 14,
            fontWeight: FontWeight.w700,
            color: valueColor,
            decoration: TextDecoration.none,
          ),
        ),
      ],
    );
  }
}
