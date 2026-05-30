import 'package:flutter/material.dart';
import 'package:torpheus/config/routes.dart';
import 'package:torpheus/presentation/screens/cliente/bloc/cliente_bloc.dart';
import 'package:torpheus/presentation/screens/cliente_detalhe/cliente_detalhe_screen.dart';

import '../../../components/lista_vazia_custom.dart';
import '../../../components/mobile/header_mobile_custom.dart';
import '../../../components/search_custom.dart';
import '../widgets/cliente_lista.dart';

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
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        HeaderMobileCustom(
          title: 'Clientes',
          subtitle: 'Cadastro e histórico de clientes',
          onPressed: () {
            Navigator.of(context).pushNamed(AppRoutes.cadastrarCliente.route);
          },
        ),
        SearchCustom(controller: controller),
        if (state.clientes.isEmpty)
          const ListaVaziaCustom(
            message: 'Nenhum cliente encontrado ',
            subMessage: 'Cadastre um novo cliente',
          ),
        if (state.clientes.isNotEmpty)
          ClienteLista(
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
    );
  }
}
