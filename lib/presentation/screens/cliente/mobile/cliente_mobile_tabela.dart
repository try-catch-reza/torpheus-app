import 'package:flutter/material.dart';

import '../../../../data/models/cliente_model.dart';
import 'cliente_mobile_table_row.dart';

class ClienteMobileTabela extends StatelessWidget {
  const ClienteMobileTabela({
    super.key,
    required this.clientes,
    required this.onClienteTap,
  });

  final List<ClienteModel> clientes;
  final ValueChanged<ClienteModel> onClienteTap;

  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: Container(
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(12),
          border: Border.all(color: const Color(0xFFEAEDF2)),
        ),
        child: ClipRRect(
          borderRadius: BorderRadius.circular(12),
          child: Column(
            children: [
              Expanded(
                child: ListView.builder(
                  itemCount: clientes.length,
                  itemBuilder: (context, index) {
                    final cliente = clientes[index];
                    final isLast = index == clientes.length - 1;
                    return ClienteMobileTableRow(
                      cliente: cliente,
                      showDivider: !isLast,
                      onTap: () => onClienteTap(cliente),
                    );
                  },
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
