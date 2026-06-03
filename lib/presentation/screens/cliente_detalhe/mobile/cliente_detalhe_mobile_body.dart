import 'package:flutter/material.dart';
import 'package:torpheus/presentation/screens/cliente_detalhe/bloc/cliente_detalhe_bloc.dart';

import 'cliente_detalhe_mobile_info.dart';
import 'cliente_detalhe_mobile_title.dart';

class ClienteDetalheMobileBody extends StatelessWidget {
  const ClienteDetalheMobileBody({super.key, required this.state});

  final ClienteDetalheState state;

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        ClienteDetalheMobileTitle(cliente: state.cliente),
        const SizedBox(height: 15),
        ClienteDetalheMobileInfo(cliente: state.cliente),
      ],
    );
  }
}
