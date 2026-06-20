import 'package:flutter/material.dart';
import 'package:torpheus/core/constants/extension/string_extension.dart';
import 'package:torpheus/data/models/ordem_servico_model.dart';

import 'ordem_servico_mobile_card.dart';

class OrdensServicoMobileLista extends StatelessWidget {
  const OrdensServicoMobileLista({
    super.key,
    required this.ordens,
    required this.onOrdemTap,
  });

  final List<OrdemServicoModel> ordens;
  final ValueChanged<OrdemServicoModel> onOrdemTap;

  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: ListView.builder(
        padding: EdgeInsets.zero,
        itemCount: ordens.length,
        itemBuilder: (context, index) {
          final ordem = ordens[index];

          return OrdemServicoMobileCard(
            title: '${ordem.veiculoPlaca} / ${ordem.veiculoModelo}',
            subTitle: '${ordem.clienteNome} - '
                '${ordem.dataCriacao.toString().formataData}',
            statusOrdem: ordem.statusOrdem!,
            onTap: () => onOrdemTap(ordem),
          );
        },
      ),
    );
  }
}
