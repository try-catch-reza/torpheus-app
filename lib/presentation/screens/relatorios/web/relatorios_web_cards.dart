import 'package:flutter/material.dart';
import 'package:torpheus/presentation/screens/relatorios/bloc/relatorios_bloc.dart';

class RelatoriosWebCards extends StatelessWidget {
  const RelatoriosWebCards({super.key, required this.state});

  final RelatoriosState state;

  @override
  Widget build(BuildContext context) {
    final cards = [
      (
        label: 'OS ABERTAS',
        value: state.indicador?.ordensAbertas,
        icon: Icons.list_alt_outlined,
        iconColor: const Color(0xFF2E90FA),
        iconBg: const Color(0xFFEFF8FF)
      ),
      (
      label: 'ANDAMENTO',
      value: state.indicador?.ordensAndamento,
      icon: Icons.pending,
      iconColor: Colors.amber,
      iconBg: Colors.amberAccent.withOpacity(0.2)
      ),
      (
        label: 'CONCLUÍDAS',
        value: state.indicador?.ordensConcluidas,
        icon: Icons.check_circle_outline,
        iconColor: const Color(0xFF12B76A),
        iconBg: const Color(0xFFECFDF3)
      ),
      (
        label: 'CANCELADAS',
        value: state.indicador?.ordensCanceladas,
        icon: Icons.access_time_outlined,
        iconColor: const Color(0xFFF97066),
        iconBg: const Color(0xFFFFF1F0)
      ),
    ];

    return Row(
      children: cards.map((c) {
        return Expanded(
          child: Container(
            margin: EdgeInsets.only(right: c != cards.last ? 16 : 0),
            padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 18),
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(12),
              border: Border.all(color: const Color(0xFFE8ECF0)),
            ),
            child: Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        c.label,
                        style: const TextStyle(
                          fontSize: 11,
                          fontWeight: FontWeight.w600,
                          color: Color(0xFF6B7A99),
                          letterSpacing: 0.8,
                        ),
                      ),
                      const SizedBox(height: 8),
                      Text(
                        '${c.value}',
                        style: const TextStyle(
                          fontSize: 28,
                          fontWeight: FontWeight.w800,
                          color: Color(0xFF1B2A4A),
                          height: 1,
                        ),
                      ),
                    ],
                  ),
                ),
                Container(
                  padding: const EdgeInsets.all(8),
                  decoration: BoxDecoration(
                    color: c.iconBg,
                    borderRadius: BorderRadius.circular(8),
                  ),
                  child: Icon(c.icon, size: 18, color: c.iconColor),
                ),
              ],
            ),
          ),
        );
      }).toList(),
    );
  }
}
