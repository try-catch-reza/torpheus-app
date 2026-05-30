import 'package:flutter/material.dart';
import 'package:torpheus/presentation/components/divider_custom.dart';
import 'package:torpheus/presentation/screens/veiculos/widgets/veiculos_card.dart';

import '../../../../data/models/veiculo_model.dart';

class VeiculosLista extends StatelessWidget {
  const VeiculosLista({
    super.key,
    required this.veiculos,
    required this.onVeiculoTap,
  });

  final List<VeiculoModel> veiculos;
  final ValueChanged<VeiculoModel> onVeiculoTap;

  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: ListView.separated(
        padding: const EdgeInsets.only(top: 12),
        separatorBuilder: (context, index) => DividerCustom.dividerListMobile,
        itemCount: veiculos.length,
        itemBuilder: (context, index) {
          final veiculo = veiculos[index];

          return VeiculosCard(
            veiculo: veiculo,
            onTap: () => onVeiculoTap(veiculo),
          );
        },
      ),
    );
  }
}
