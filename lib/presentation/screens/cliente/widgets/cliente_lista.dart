import 'package:flutter/material.dart';
import 'package:torpheus/data/models/cliente_model.dart';
import 'package:torpheus/presentation/screens/cliente/widgets/cliente_card.dart';

class ClienteLista extends StatelessWidget {
  const ClienteLista({
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
        itemCount: clientes.length,
        itemBuilder: (context, index) {
          final cliente = clientes[index];

          return ClienteCard(
            cliente: cliente,
            onTap: () => onClienteTap(cliente),
            onEdit: () => onEditTap(cliente),
          );
        },
      ),
    );
  }
}
