import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../components/loading_state.dart';
import '../bloc/cadastrar_funcionario_bloc.dart';
import 'cadastrar_funcionario_web_body.dart';

class CadastrarFuncionarioWebContent extends StatefulWidget {
  const CadastrarFuncionarioWebContent({super.key});

  @override
  State<CadastrarFuncionarioWebContent> createState() =>
      _CadastrarFuncionarioWebContentState();
}

class _CadastrarFuncionarioWebContentState
    extends State<CadastrarFuncionarioWebContent> {
  final _formKey = GlobalKey<FormState>();
  final _nomeController = TextEditingController();
  final _documentoController = TextEditingController();
  final _telefoneController = TextEditingController();

  @override
  void dispose() {
    _nomeController.dispose();
    _documentoController.dispose();
    _telefoneController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: BlocConsumer<CadastrarFuncionarioBloc, CadastrarFuncionarioState>(
        buildWhen: (p, c) =>
            c is! CadastrarFuncionarioError &&
            c is! CadastrarFuncionarioSuccess,
        listener: (context, state) {
          if (state is CadastrarFuncionarioSuccess) {
            // navega ou mostra dialog por enquanto nada
            Navigator.of(context).pop();
          }
        },
        builder: (context, state) {
          if (state is CadastrarFuncionarioLoading) return const LoadingState();

          if (state is CadastrarFuncionarioLoaded) {
            return CadastrarFuncionarioWebBody(
              state: state,
              formKey: _formKey,
              nomeController: _nomeController,
              documentoController: _documentoController,
              telefoneController: _telefoneController,
            );
          }

          return const SizedBox.shrink();
        },
      ),
    );
  }
}
