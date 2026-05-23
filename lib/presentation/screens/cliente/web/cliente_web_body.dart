import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:torpheus/presentation/screens/cliente/bloc/cliente_bloc.dart';
import 'package:torpheus/presentation/screens/cliente/web/cliente_web_header.dart';
import 'package:torpheus/presentation/screens/cliente/web/cliente_web_tabela.dart';
import 'cliente_web_search.dart';
import 'cliente_web_vazio.dart';

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
          const ClienteWebHeader(),
          const SizedBox(height: 24),
          ClienteWebSearch(controller: searchController),
          const SizedBox(height: 16),
          if (state.clientes.isEmpty)
            const ClienteWebVazio(),
          if (state.clientes.isNotEmpty)
            ClienteWebTabela(
              clientes: state.clientes,
              onClienteTap: (value) {
                context.read<ClienteBloc>().add(ClienteSelecionar(value));
              },
            ),
        ],
      ),
    );
  }
}
