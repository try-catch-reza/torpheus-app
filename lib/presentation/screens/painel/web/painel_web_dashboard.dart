import 'package:flutter/material.dart';
import 'package:torpheus/presentation/screens/painel/web/painel_web_card.dart';

class PainelWebDashboard extends StatelessWidget {
  const PainelWebDashboard({super.key});

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.start,
      children: [
        Expanded(
          child: PainelWebCard(
            value: '12',
            label: 'OS abertas',
            subtitle: 'Ordens de serviço abertas no sistema',
            icon: Icons.checklist_outlined,
            onTap: () {},
          ),
        ),
        const SizedBox(width: 16),
        Expanded(
          child: PainelWebCard(
            value: '12',
            label: 'Em andamento',
            subtitle: 'Ordens de serviço em andamento no sistema',
            icon: Icons.watch_later,
            onTap: () {},
          ),
        ),
        const SizedBox(width: 16),
        Expanded(
          child: PainelWebCard(
            value: '12',
            label: 'Finalizadas',
            subtitle: 'Ordens de serviço finalizadas no sistema',
            icon: Icons.check,
            onTap: () {},
          ),
        ),
      ],
    );
  }
}
