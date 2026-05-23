import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
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
    return Scaffold(
      body: BlocBuilder<ClienteBloc, ClienteState>(
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

          return const SizedBox.shrink();
        },
      ),
    );
  }
}
