import 'package:flutter/material.dart';
import 'package:torpheus/data/models/cliente_model.dart';

import '../../../../core/constants/custom_colors.dart';

class ClienteCard extends StatelessWidget {
  const ClienteCard({super.key, required this.cliente, required this.onTap});

  final ClienteModel cliente;
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
          cliente.nome ?? '',
          style: TextStyle(
            color: ColorConstants.chambray,
            fontSize: 17,
            fontWeight: FontWeight.w600,
          ),
        ),
        subtitle: Padding(
          padding: const EdgeInsets.only(top: 5.0),
          child: Text(
            cliente.email ?? '',
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
