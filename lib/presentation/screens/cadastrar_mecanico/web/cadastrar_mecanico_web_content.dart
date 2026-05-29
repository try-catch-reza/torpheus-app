import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../components/loading_state.dart';
import '../bloc/cadastrar_mecanico_bloc.dart';
import 'cadastrar_mecanico_web_body.dart';

class CadastrarMecanicoWebContent extends StatefulWidget {
  const CadastrarMecanicoWebContent({super.key});

  @override
  State<CadastrarMecanicoWebContent> createState() => _CadastrarMecanicoWebContentState();
}

class _CadastrarMecanicoWebContentState extends State<CadastrarMecanicoWebContent> {
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
      body: BlocConsumer<CadastrarMecanicoBloc, CadastrarMecanicoState>(
        buildWhen: (p, c) => c is! CadastrarMecanicoError && c is! CadastrarMecanicoSuccess,
        listener: (context, state) {
          if (state is CadastrarMecanicoSuccess) {
            // navega ou mostra dialog por enquanto nada
            Navigator.of(context).pop();
          }
        },
        builder: (context, state) {
          if (state is CadastrarMecanicoLoading) return const LoadingState();

          if (state is CadastrarMecanicoLoaded) {
            return CadastrarMecanicoWebBody(
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
