import 'package:flutter/material.dart';
import 'package:torpheus/presentation/components/mobile/avatar_card_mobile_custom.dart';

import '../../../../data/models/cliente_model.dart';

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

          return AvatarCardMobileCustom(
            title: cliente.nome ?? '',
            subTitle: cliente.email ?? '',
            onTap: () => onClienteTap(cliente),
            isActive: cliente.isActive ?? false,
          );
        },
      ),
    );
  }
}
