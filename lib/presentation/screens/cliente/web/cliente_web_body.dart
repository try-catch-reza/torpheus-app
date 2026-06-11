import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:torpheus/presentation/components/lista_vazia_custom.dart';
import 'package:torpheus/presentation/components/search_custom.dart';
import 'package:torpheus/presentation/components/web/header_web_custom.dart';
import 'package:torpheus/presentation/screens/cliente/bloc/cliente_bloc.dart';
import 'package:torpheus/presentation/screens/cliente/web/cliente_web_table.dart';

import 'cliente_web_dialog.dart';

class ClienteWebBody extends StatelessWidget {
  const ClienteWebBody({
    super.key,
    required this.state,
    required this.searchController,
  });

  final ClienteState state;
  final TextEditingController searchController;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(32.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          HeaderWebCustom(
            hasPodeCriar: state.hasCriarCliente,
            title: 'Clientes',
            subtitle: 'Cadastro e histórico de clientes',
            buttonText: 'Cadastrar cliente',
            onPressed: () {
              context.read<ClienteBloc>().add(const ClienteCadastrar());
            },
          ),
          SearchCustom(controller: searchController),
          if (state.clientes.isEmpty)
            const ListaVaziaCustom(
              message: 'Nenhum cliente encontrado ',
              subMessage: 'Cadastre um novo cliente',
            ),
          if (state.clientes.isNotEmpty)
            ClienteWebTable(
              clientes: state.clientes,
              onTap: (value) => ClienteWeblDialog.show(
                context,
                value,
                context.read<ClienteBloc>(),
              ),
            ),
        ],
      ),
    );
  }
}
