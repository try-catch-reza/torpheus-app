import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:torpheus/data/models/cliente_model.dart';
import 'package:torpheus/presentation/components/lista_vazia_custom.dart';
import 'package:torpheus/presentation/components/search_custom.dart';
import 'package:torpheus/presentation/components/web/header_web_custom.dart';
import 'package:torpheus/presentation/screens/cliente/bloc/cliente_bloc.dart';
import 'package:torpheus/presentation/screens/cliente/web/cliente_web_lista.dart';

import '../../../../core/constants/color_constants.dart';

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
            ClienteWebLista(
              clientes: state.clientes,
              onClienteTap: (value) => _showClienteDetails(context, state, value),
              onEditTap: (value) {
                context.read<ClienteBloc>().add(ClienteAtualizar(value));
              },
            ),
        ],
      ),
    );
  }

  void _showClienteDetails(
    BuildContext context,
    ClienteState state,
    ClienteModel cliente,
  ) {
    showDialog(
      context: context,
      builder: (context) {
        return Dialog(
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(8),
          ),
          child: Container(
            padding: const EdgeInsets.all(24),
            width: MediaQuery.of(context).size.width * 0.4,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisSize: MainAxisSize.min,
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      'Dados do cliente',
                      style: TextStyle(
                        fontSize: 22,
                        fontWeight: FontWeight.w600,
                        color: ColorConstants.chambray,
                      ),
                    ),
                    IconButton(
                      padding: const EdgeInsets.only(bottom: 5),
                      onPressed: () => Navigator.pop(context),
                      icon: const Icon(Icons.close, size: 30),
                    ),
                  ],
                ),
                const SizedBox(height: 16),
                ListTile(
                  contentPadding: EdgeInsets.zero,
                  title: Text(
                    cliente.nome ?? '',
                    style: const TextStyle(
                      fontSize: 18,
                      fontWeight: FontWeight.w500,
                    ),
                  ),
                  subtitle: Text('CPF: ${cliente.documento}'),
                ),
              ],
            ),
          ),
        );
      },
    );
  }
}
