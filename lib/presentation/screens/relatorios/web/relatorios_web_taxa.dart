import 'package:flutter/material.dart';

class RelatoriosWebTaxa extends StatelessWidget {
  const RelatoriosWebTaxa({super.key});

  @override
  Widget build(BuildContext context) {
    final itens = [
      (
        label: 'Concluídas',
        pct: 0.33,
        pctText: '33%',
        count: '(3)',
        color: const Color(0xFF12B76A)
      ),
      (
        label: 'Não realizadas',
        pct: 0.11,
        pctText: '11%',
        count: '(1)',
        color: const Color(0xFFF97066)
      ),
      (
        label: 'Em aberto',
        pct: 0.56,
        pctText: '56%',
        count: '(5)',
        color: const Color(0xFF2E90FA)
      ),
    ];

    return Container(
      padding: const EdgeInsets.all(20),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(12),
        border: Border.all(color: const Color(0xFFE8ECF0)),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Text(
            'Taxa de conclusão',
            style: TextStyle(
              fontSize: 15,
              fontWeight: FontWeight.w700,
              color: Color(0xFF1B2A4A),
            ),
          ),
          const SizedBox(height: 20),
          ...itens.map((item) {
            return Padding(
              padding: const EdgeInsets.only(bottom: 16),
              child: Row(
                children: [
                  SizedBox(
                    width: 120,
                    child: Text(
                      item.label,
                      style: TextStyle(
                        fontSize: 13,
                        color: item.color,
                        fontWeight: FontWeight.w500,
                      ),
                    ),
                  ),
                  Expanded(
                    child: ClipRRect(
                      borderRadius: BorderRadius.circular(4),
                      child: LinearProgressIndicator(
                        value: item.pct,
                        minHeight: 8,
                        backgroundColor: const Color(0xFFF2F4F7),
                        valueColor: AlwaysStoppedAnimation(item.color),
                      ),
                    ),
                  ),
                  const SizedBox(width: 16),
                  SizedBox(
                    width: 60,
                    child: Row(
                      children: [
                        Text(
                          item.pctText,
                          style: const TextStyle(
                            fontSize: 13,
                            fontWeight: FontWeight.w700,
                            color: Color(0xFF1B2A4A),
                          ),
                        ),
                        const SizedBox(width: 4),
                        Text(
                          item.count,
                          style: const TextStyle(
                            fontSize: 12,
                            color: Color(0xFF6B7A99),
                          ),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            );
          }),
        ],
      ),
    );
  }
}
