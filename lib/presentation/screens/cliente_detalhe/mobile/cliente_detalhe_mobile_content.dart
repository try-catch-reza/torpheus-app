import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:torpheus/presentation/components/app_bar_padrao.dart';
import 'package:torpheus/presentation/screens/cliente_detalhe/bloc/cliente_detalhe_bloc.dart';
import 'package:torpheus/presentation/screens/cliente_detalhe/mobile/cliente_detalhe_mobile_body.dart';

import '../../../components/loading_state.dart';

class ClienteDetalheMobileContent extends StatelessWidget {
  const ClienteDetalheMobileContent({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: const AppBarPadrao(title: 'Detalhes'),
      body: BlocBuilder<ClienteDetalheBloc, ClienteDetalheState>(
        builder: (context, state) {
          if (state is ClienteDetalheLoading) {
            return const LoadingState();
          }

          if (state is ClienteDetalheLoaded) {
            return ClienteDetalheMobileBody(state: state);
          }

          return const SizedBox.shrink();
        },
      ),
    );
  }
}
