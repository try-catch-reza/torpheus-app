import 'package:flutter/material.dart';
import 'package:torpheus/presentation/screens/cadastrar_cliente/widgets/cadastrar_cliente_content.dart';
import 'bloc/cadastrar_cliente_bloc.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class CadastrarClienteScreen extends StatelessWidget {
  const CadastrarClienteScreen({super.key, required this.cadastrarClienteBloc});

  final CadastrarClienteBloc cadastrarClienteBloc;

  @override
  Widget build(BuildContext context) {
    return BlocProvider<CadastrarClienteBloc>(
      create: (_) => cadastrarClienteBloc..add(const CadastrarClienteLoad()),
      child: const CadastrarClienteContent(),
    );
  }
}
