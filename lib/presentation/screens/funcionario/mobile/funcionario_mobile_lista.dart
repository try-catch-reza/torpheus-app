import 'package:flutter/material.dart';
import 'package:torpheus/presentation/screens/funcionario/mobile/funcionario_mobile_card.dart';

import '../../../../data/models/funcionario_model.dart';

class FuncionarioMobileLista extends StatelessWidget {
  const FuncionarioMobileLista({
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
        padding: EdgeInsets.zero,
        itemCount: funcionarios.length,
        itemBuilder: (context, index) {
          final funcionario = funcionarios[index];

          return FuncionarioMobileCard(
            funcionario: funcionario,
            onEdit: () {},
            onTap: () => onFuncionarioTap(funcionario),
          );
        },
      ),
    );
  }
}
