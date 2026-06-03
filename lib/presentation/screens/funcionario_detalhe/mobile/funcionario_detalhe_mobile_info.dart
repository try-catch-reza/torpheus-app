import 'package:flutter/material.dart';
import 'package:torpheus/core/constants/extension/string_extension.dart';
import 'package:torpheus/data/models/mecanico_model.dart';
import 'package:torpheus/presentation/screens/funcionario_detalhe/mobile/funcionario_detalhe_mobile_tile.dart';

import '../../../../core/constants/color_constants.dart';

class FuncionarioDetalheMobileInfo extends StatelessWidget {
  const FuncionarioDetalheMobileInfo({super.key, required this.funcionario});

  final FuncionarioModel? funcionario;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 8.0, vertical: 8.0),
      decoration: BoxDecoration(
        border: Border.all(color: ColorConstants.mercury, width: 2.0),
        color: Colors.white,
      ),
      child: Column(
        children: [
          FuncionarioDetalheMobileTile(
            title: 'Telefone',
            value: funcionario?.telefone ?? 'Telefone não informado',
          ),
          FuncionarioDetalheMobileTile(
            title: 'Função',
            value: funcionario?.funcao ?? 'Função não informada',
          ),
          FuncionarioDetalheMobileTile(
            title: 'Data de contratação',
            value: funcionario?.hiredAt?.toString().formataData ??
                'Data não informada',
            isDivider: false,
          ),
        ],
      ),
    );
  }
}

