import 'package:flutter/material.dart';
import 'package:torpheus/presentation/components/mobile/card_mobile_custom.dart';

import '../../../../data/models/veiculo_model.dart';

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
      child: ListView.builder(
        padding: EdgeInsets.zero,
        itemCount: veiculos.length,
        itemBuilder: (context, index) {
          final veiculo = veiculos[index];

          return CardMobileCustom(
            title: veiculo.placa ?? '',
            subTitle: veiculo.subTitle,
            onTap: () => onVeiculoTap(veiculo),
            isActive: veiculo.isActive ?? false,
          );
        },
      ),
    );
  }
}
