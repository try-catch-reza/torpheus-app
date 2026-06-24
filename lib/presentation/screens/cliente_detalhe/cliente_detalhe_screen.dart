import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:torpheus/data/models/cliente_model.dart';

import 'bloc/cliente_detalhe_bloc.dart';
import 'mobile/cliente_detalhe_mobile_content.dart';

class ClienteDetalheScreen extends StatelessWidget {
  const ClienteDetalheScreen({
    super.key,
    required this.clienteDetalheBloc,
    required this.arguments,
  });

  final ClienteDetalheBloc clienteDetalheBloc;
  final ClienteDetalheArguments arguments;

  @override
  Widget build(BuildContext context) {
    return BlocProvider<ClienteDetalheBloc>(
      create: (context) {
        return clienteDetalheBloc..add(ClienteDetalheLoad(arguments.cliente));
      },
      child: const ClienteDetalheMobileContent(),
    );
  }
}

class ClienteDetalheArguments {
  ClienteDetalheArguments({this.cliente});

  final ClienteModel? cliente;
}
