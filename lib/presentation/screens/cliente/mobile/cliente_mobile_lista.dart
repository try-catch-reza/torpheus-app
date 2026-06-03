import 'package:flutter/material.dart';

import '../../../../data/models/cliente_model.dart';
import 'cliente_mobile_card.dart';

class ClienteMobileLista extends StatelessWidget {
  const ClienteMobileLista({
    super.key,
    required this.clientes,
    required this.onClienteTap,
    required this.onEditTap,
  });

  final List<ClienteModel> clientes;
  final ValueChanged<ClienteModel> onClienteTap;
  final ValueChanged<ClienteModel> onEditTap;

  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: ListView.builder(
        padding: EdgeInsets.zero,
        itemCount: clientes.length,
        itemBuilder: (context, index) {
          final cliente = clientes[index];

          return ClienteMobileCard(
            cliente: cliente,
            onTap: () => onClienteTap(cliente),
            onEdit: () => onEditTap(cliente),
          );
        },
      ),
    );
  }
}
