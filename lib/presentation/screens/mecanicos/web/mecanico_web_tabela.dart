import 'package:flutter/material.dart';
import 'package:torpheus/presentation/screens/mecanicos/widgets/mecanico_card.dart';

import '../../../../data/models/mecanico_model.dart';

class MecanicoWebTabela extends StatelessWidget {
  const MecanicoWebTabela({
    super.key,
    required this.mecanicos,
    required this.onMecanicoTap,
  });

  final List<FuncionarioModel> mecanicos;
  final ValueChanged<FuncionarioModel> onMecanicoTap;

  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: GridView.builder(
        itemCount: mecanicos.length,
        gridDelegate: const SliverGridDelegateWithMaxCrossAxisExtent(
          maxCrossAxisExtent: 700,
          crossAxisSpacing: 16,
          mainAxisSpacing: 16,
          mainAxisExtent: 130,
        ),
        itemBuilder: (context, index) {
          final mecanico = mecanicos[index];

          return MecanicoCard(mecanico: mecanico);
        },
      ),
    );
  }
}
