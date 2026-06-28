import 'package:flutter/material.dart';
import 'package:torpheus/presentation/screens/painel/bloc/painel_bloc.dart';

class PainelWebDashboard extends StatelessWidget {
  const PainelWebDashboard({super.key, required this.state});

  final PainelState state;

  @override
  Widget build(BuildContext context) {
    final cards = [
      (
        label: 'OS ABERTAS',
        value: state.totalOrdensAbertas,
        icon: Icons.list_alt_outlined,
        iconColor: const Color(0xFF2E90FA),
        iconBg: const Color(0xFFEFF8FF),
      ),
      (
        label: 'ANDAMENTO',
        value: state.totalOrdensAndamento,
        icon: Icons.pending,
        iconColor: Colors.amber,
        iconBg: Colors.amberAccent.withOpacity(0.2),
      ),
    ];

    return GridView.count(
      crossAxisCount: 2,
      shrinkWrap: true,
      physics: const NeverScrollableScrollPhysics(),
      crossAxisSpacing: 6,
      mainAxisSpacing: 6,
      childAspectRatio: 7,
      children: cards.map((c) {
        return Container(
          padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 14),
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
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text(
                      c.label,
                      style: const TextStyle(
                        fontSize: 10,
                        fontWeight: FontWeight.w600,
                        color: Color(0xFF6B7A99),
                        letterSpacing: 0.6,
                      ),
                    ),
                    const SizedBox(height: 6),
                    Text(
                      '${c.value}',
                      style: const TextStyle(
                        fontSize: 24,
                        fontWeight: FontWeight.w800,
                        color: Color(0xFF1B2A4A),
                        height: 1,
                      ),
                    ),
                  ],
                ),
              ),
              Container(
                padding: const EdgeInsets.all(7),
                decoration: BoxDecoration(
                  color: c.iconBg,
                  borderRadius: BorderRadius.circular(8),
                ),
                child: Icon(c.icon, size: 16, color: c.iconColor),
              ),
            ],
          ),
        );
      }).toList(),
    );
  }
}
