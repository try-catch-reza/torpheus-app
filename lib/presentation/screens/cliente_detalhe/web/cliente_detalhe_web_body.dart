import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:torpheus/presentation/screens/cliente_detalhe/bloc/cliente_detalhe_bloc.dart';
import 'package:torpheus/presentation/screens/cliente_detalhe/web/cliente_detalhe_web_card_estatisticas.dart';
import 'package:torpheus/presentation/screens/cliente_detalhe/web/cliente_detalhe_web_card_info.dart';
import 'package:torpheus/presentation/screens/cliente_detalhe/web/cliente_detalhe_web_card_veiculo.dart';
import 'package:torpheus/presentation/screens/cliente_detalhe/web/cliente_detalhe_web_header.dart';

import '../../cliente/bloc/cliente_bloc.dart';

class ClienteDetalheWebBody extends StatelessWidget {
  const ClienteDetalheWebBody({super.key, required this.state});

  final ClienteDetalheState state;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(32),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                ClienteDetalheWebHeader(
                  nomeCliente: state.detalhe?.nome ?? '',
                  onVoltar: () {
                    context.read<ClienteBloc>().add(const ClientesLoad());
                  },
                ),
                const SizedBox(height: 20),
                ClienteDetalheWebCardInfo(cliente: state.detalhe),
              ],
            ),
          ),
          const SizedBox(width: 16),
          ClienteDetalheWebCardEstatisticas(
            estatisticas: state.detalhe?.estatisticas,
          ),
        ],
      ),
    );
  }
}
