import 'package:flutter/material.dart';
import 'package:torpheus/presentation/screens/veiculos/mobile/veiculos_mobile_card.dart';

import '../../../../data/models/veiculo_model.dart';
import '../../../components/divider_custom.dart';

class VeiculosMobileLista extends StatelessWidget {
  const VeiculosMobileLista({
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
        padding: EdgeInsets.zero,
        separatorBuilder: (context, index) => DividerCustom.dividerList,
        itemCount: veiculos.length,
        itemBuilder: (context, index) {
          final veiculo = veiculos[index];

          return VeiculosMobileCard(
            veiculo: veiculo,
            onTap: () => onVeiculoTap(veiculo),
          );
        },
      ),
    );
  }
}
