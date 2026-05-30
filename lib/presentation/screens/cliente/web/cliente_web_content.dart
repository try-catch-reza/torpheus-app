import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:torpheus/presentation/screens/cadastrar_cliente/bloc/cadastrar_cliente_bloc.dart';
import 'package:torpheus/presentation/screens/cadastrar_cliente/cadastrar_cliente_screen.dart';
import 'package:torpheus/presentation/screens/cliente/bloc/cliente_bloc.dart';
import 'package:torpheus/presentation/screens/cliente_detalhe/bloc/cliente_detalhe_bloc.dart';
import 'package:torpheus/presentation/screens/cliente_detalhe/cliente_detalhe_screen.dart';

import '../../../components/loading_state.dart';
import 'cliente_web_body.dart';

class ClienteWebContent extends StatefulWidget {
  const ClienteWebContent({super.key});

  @override
  State<ClienteWebContent> createState() => _ClienteWebContentState();
}

class _ClienteWebContentState extends State<ClienteWebContent> {
  final TextEditingController _searchController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(32.0),
      child: Scaffold(
        body: BlocBuilder<ClienteBloc, ClienteState>(
          buildWhen: _buildWhen,
          builder: (context, state) {
            if (state is ClienteLoading) {
              return const LoadingState();
            }

            if (state is ClienteLoaded) {
              return ClienteWebBody(
                state: state,
                searchController: _searchController,
              );
            }

            if (state is ClienteSelecionado) {
              return ClienteDetalheScreen(
                clienteDetalheBloc: context.read<ClienteDetalheBloc>(),
                arguments: ClienteDetalheArguments(
                  cliente: state.clienteSelecionado,
                ),
              );
            }

            if (state is ClienteCadastrando) {
              return CadastrarClienteScreen(
                cadastrarClienteBloc: context.read<CadastrarClienteBloc>(),
                arguments: CadastrarClienteArguments(),
              );
            }

            if (state is ClienteAtualizando) {
              return CadastrarClienteScreen(
                cadastrarClienteBloc: context.read<CadastrarClienteBloc>(),
                arguments: CadastrarClienteArguments(
                  isEdit: true,
                  clienteId: state.clienteSelecionado?.id ?? '',
                ),
              );
            }

            return const SizedBox.shrink();
          },
        ),
      ),
    );
  }

  bool _buildWhen(ClienteState previous, ClienteState current) {
    return current is! ClienteCEPSetado;
  }
}
