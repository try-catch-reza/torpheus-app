import 'package:flutter/material.dart';
import 'package:torpheus/data/models/cliente_model.dart';

import 'cliente_web_card.dart';

class ClienteWebLista extends StatelessWidget {
  const ClienteWebLista({
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
        padding: const EdgeInsets.only(top: 12),
        itemCount: 10,
        itemBuilder: (context, index) {
          final cliente = clientes[0];

          return ClienteWebCard(
            cliente: cliente,
            onTap: () => onClienteTap(cliente),
            onEdit: () => onEditTap(cliente),
          );
        },
      ),
    );
  }
}
