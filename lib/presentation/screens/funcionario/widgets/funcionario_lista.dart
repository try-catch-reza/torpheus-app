import 'package:flutter/material.dart';
import 'package:torpheus/presentation/screens/funcionario/widgets/funcionario_card.dart';

import '../../../../data/models/mecanico_model.dart';

class FuncionarioLista extends StatelessWidget {
  const FuncionarioLista({
    super.key,
    required this.funcionarios,
    required this.onFuncionarioTap,
  });

  final List<FuncionarioModel> funcionarios;
  final ValueChanged<FuncionarioModel> onFuncionarioTap;

  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: ListView.builder(
        padding: const EdgeInsets.only(top: 12),
        itemCount: funcionarios.length,
        itemBuilder: (context, index) {
          final funcionario = funcionarios[index];

          return FuncionarioCard(
            funcionario: funcionario,
            onEdit: () {},
            onTap: () => onFuncionarioTap(funcionario),
          );
        },
      ),
    );
  }
}
