import 'package:flutter/material.dart';
import 'package:torpheus/config/routes.dart';
import 'package:torpheus/presentation/screens/cliente/bloc/cliente_bloc.dart';
import 'package:torpheus/presentation/screens/cliente_detalhe/cliente_detalhe_screen.dart';

import '../widgets/cliente_vazio.dart';
import 'cliente_mobile_header.dart';
import 'cliente_mobile_search.dart';
import 'cliente_mobile_tabela.dart';

class ClienteMobileBody extends StatelessWidget {
  const ClienteMobileBody({
    super.key,
    required this.state,
    required this.controller,
  });

  final ClienteState state;
  final TextEditingController controller;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(20.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const ClienteMobileHeader(),
          const SizedBox(height: 24),
          ClienteMobileSearch(controller: controller),
          const SizedBox(height: 16),
          if (state.clientes.isEmpty)
            const ClienteVazio(),
          if (state.clientes.isNotEmpty)
            ClienteMobileTabela(
              clientes: state.clientes,
              onClienteTap: (value) {
                Navigator.of(context).pushNamed(
                  AppRoutes.clienteDetalhe.route,
                  arguments: ClienteDetalheArguments(
                    cliente: value,
                  ),
                );
              },
            ),
        ],
      ),
    );
  }
}
