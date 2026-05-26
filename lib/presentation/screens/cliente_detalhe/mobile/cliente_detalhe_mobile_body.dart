import 'package:flutter/material.dart';
import 'package:torpheus/presentation/screens/cliente_detalhe/bloc/cliente_detalhe_bloc.dart';
import 'package:torpheus/presentation/screens/cliente_detalhe/mobile/cliente_detalhe_mobile_estatisticas.dart';

import 'cliente_detalhe_mobile_card_info.dart';

class ClienteDetalheMobileBody extends StatelessWidget {
  const ClienteDetalheMobileBody({super.key, required this.state});

  final ClienteDetalheState state;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(32),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          ClienteDetalheMobileCardInfo(cliente: state.detalhe),
          const SizedBox(height: 24),
          ClienteDetalheMobileEstatisticas(
            estatisticas: state.detalhe?.estatisticas,
          ),
        ],
      ),
    );
  }
}
