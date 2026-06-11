import 'package:flutter/material.dart';

class ClienteDetalheWebCardEstatisticas extends StatelessWidget {
  const ClienteDetalheWebCardEstatisticas({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      height: MediaQuery.of(context).size.height,
      width: 200,
      padding: const EdgeInsets.all(20),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(12),
        border: Border.all(color: const Color(0xFFEAEDF2)),
      ),
      child: const Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            'Estatísticas',
            style: TextStyle(
              fontSize: 14,
              fontWeight: FontWeight.w700,
              color: Color(0xFF1B2A4A),
              decoration: TextDecoration.none,
            ),
          ),
          SizedBox(height: 16),
          _StatRow(
            label: 'Veículos atendidos',
            value: '',
            valueColor: Color(0xFF1B2A4A),
          ),
          SizedBox(height: 14),
          _StatRow(
            label: 'OS deste cliente',
            value: '',
            valueColor: Color(0xFF1B4FA8),
          ),
          SizedBox(height: 14),
          _StatRow(
            label: 'Concluídas',
            value: '',
            valueColor: Color(0xFF16A34A),
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
