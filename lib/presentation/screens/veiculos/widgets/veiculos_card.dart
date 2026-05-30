import 'package:flutter/material.dart';
import 'package:torpheus/core/constants/custom_colors.dart';
import 'package:torpheus/data/models/veiculo_model.dart';

class VeiculosCard extends StatelessWidget {
  const VeiculosCard({
    super.key,
    required this.veiculo,
    required this.onTap,
  });

  final VeiculoModel veiculo;
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
          veiculo.placa ?? '',
          style: TextStyle(
            color: ColorConstants.chambray,
            fontSize: 17,
            fontWeight: FontWeight.w600,
          ),
        ),
        subtitle: Padding(
          padding: const EdgeInsets.only(top: 5.0),
          child: Text(
            veiculo.modelo ?? '',
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
