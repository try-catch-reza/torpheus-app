import 'package:flutter/material.dart';
import 'package:torpheus/config/routes.dart';
import 'package:torpheus/presentation/components/mobile/app_bar_mobile_search.dart';
import 'package:torpheus/presentation/screens/cadastrar_cliente/cadastrar_cliente_screen.dart';
import 'package:torpheus/presentation/screens/cliente/bloc/cliente_bloc.dart';
import 'package:torpheus/presentation/screens/cliente_detalhe/cliente_detalhe_screen.dart';

import '../../../components/lista_vazia_custom.dart';
import 'cliente_mobile_lista.dart';

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
        AppBarMobileSearch(
          onPressed: () {
            Navigator.of(context).pushNamed(
              AppRoutes.cadastrarCliente.route,
              arguments: CadastrarClienteArguments(),
            );
          },
          title: 'Clientes',
          subtitle: 'Cadastro e histórico de clientes',
          controller: controller,
        ),
        if (state.clientes.isEmpty)
          const ListaVaziaCustom(
            message: 'Nenhum cliente encontrado ',
            subMessage: 'Cadastre um novo cliente',
          ),
        if (state.clientes.isNotEmpty)
          ClienteMobileLista(
            clientes: state.clientes,
            onClienteTap: (value) {
              Navigator.of(context).pushNamed(
                AppRoutes.clienteDetalhe.route,
                arguments: ClienteDetalheArguments(
                  cliente: value,
                ),
              );
            },
            onEditTap: (value) {
              Navigator.of(context).pushNamed(
                AppRoutes.cadastrarCliente.route,
                arguments: CadastrarClienteArguments(
                  isEdit: true,
                  clienteId: value.id ?? '',
                ),
              );
            },
          ),
      ],
    );
  }
}
