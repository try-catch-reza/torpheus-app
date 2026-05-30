import 'package:flutter/material.dart';
import 'package:torpheus/data/models/mecanico_model.dart';

import '../../../../core/constants/custom_colors.dart';

class FuncionarioCard extends StatelessWidget {
  const FuncionarioCard({
    super.key,
    required this.funcionario,
    required this.onTap,
  });

  final FuncionarioModel funcionario;
  final VoidCallback onTap;

  @override
  Widget build(BuildContext context) {
    return Container(
      color: Colors.white,
      child: ListTile(
        onTap: onTap,
        dense: true,
        minTileHeight: 1.0,
        contentPadding: const EdgeInsets.symmetric(horizontal: 22),
        title: Text(
          funcionario.nome ?? '',
          style: TextStyle(
            color: ColorConstants.chambray,
            fontSize: 17,
            fontWeight: FontWeight.w600,
          ),
        ),
        subtitle: Padding(
          padding: const EdgeInsets.only(top: 5.0),
          child: Text(
            funcionario.funcao ?? '',
            style: TextStyle(
              fontSize: 15,
              color: ColorConstants.squant,
            ),
          ),
        ),
        trailing: const Icon(Icons.arrow_forward_ios_outlined),
      ),
    );
  }
}
