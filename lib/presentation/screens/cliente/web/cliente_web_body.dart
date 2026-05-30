import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:torpheus/presentation/components/lista_vazia_custom.dart';
import 'package:torpheus/presentation/components/search_custom.dart';
import 'package:torpheus/presentation/components/web/header_web_custom.dart';
import 'package:torpheus/presentation/screens/cliente/bloc/cliente_bloc.dart';
import 'package:torpheus/presentation/screens/cliente/widgets/cliente_lista.dart';

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
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        HeaderWebCustom(
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
          ClienteLista(
            clientes: state.clientes,
            onClienteTap: (value) {
              context.read<ClienteBloc>().add(ClienteSelecionar(value));
            },
            onEditTap: (value) {

            },
          ),
      ],
    );
  }
}
