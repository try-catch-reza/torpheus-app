import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:torpheus/presentation/components/loading_state.dart';
import 'package:torpheus/presentation/screens/cliente_detalhe/bloc/cliente_detalhe_bloc.dart';
import 'package:torpheus/presentation/screens/cliente_detalhe/web/cliente_detalhe_web_body.dart';

class ClienteDetalheWebContent extends StatelessWidget {
  const ClienteDetalheWebContent({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<ClienteDetalheBloc, ClienteDetalheState>(
      builder: (context, state) {
        if (state is ClienteDetalheLoading) {
          return const LoadingState();
        }

        if (state is ClienteDetalheLoaded) {
          return ClienteDetalheWebBody(state: state);
        }

        return const SizedBox();
      },
    );
  }
}
