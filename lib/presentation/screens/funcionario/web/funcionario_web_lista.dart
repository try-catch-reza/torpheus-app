import 'package:flutter/material.dart';

import '../../../../data/models/mecanico_model.dart';
import 'funcionario_web_card.dart';

class FuncionarioWebLista extends StatelessWidget {
  const FuncionarioWebLista({
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

          return FuncionarioWebCard(
            funcionario: funcionario,
            onEdit: () {},
            onTap: () => onFuncionarioTap(funcionario),
          );
        },
      ),
    );
  }
}
