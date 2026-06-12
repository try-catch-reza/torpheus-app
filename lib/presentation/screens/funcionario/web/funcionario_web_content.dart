import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../components/dialog/dialog_web_padrao.dart';
import '../../../components/loading_state.dart';
import '../bloc/funcionario_bloc.dart';
import 'funcionario_web_body.dart';

class FuncionarioWebContent extends StatefulWidget {
  const FuncionarioWebContent({super.key});

  @override
  State<FuncionarioWebContent> createState() => _FuncionarioWebContentState();
}

class _FuncionarioWebContentState extends State<FuncionarioWebContent> {
  final TextEditingController _searchController = TextEditingController();
  final _nomeController = TextEditingController();
  final _documentoController = TextEditingController();
  final _telefoneController = TextEditingController();
  final _formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: BlocConsumer<FuncionarioBloc, FuncionarioState>(
        listener: _listener,
        buildWhen: _buildWhen,
        builder: (context, state) {
          if (state is FuncionarioLoading) {
            return const LoadingState();
          }

          if (state is FuncionarioLoaded) {
            return FuncionarioWebBody(
              state: state,
              controller: _searchController,
              nomeController: _nomeController,
              formKey: _formKey,
              telefoneController: _telefoneController,
              documentoController: _documentoController,
            );
          }

          return const SizedBox.shrink();
        },
      ),
    );
  }

  bool _buildWhen(FuncionarioState previous, FuncionarioState current) {
    return current is! FuncionarioSalvo &&
        current is! FuncionarioError &&
        current is! FuncionarioErrorInicial &&
        current is! FuncionarioAtualizado;
  }

  void _listener(BuildContext context, FuncionarioState state) {
    if (state is FuncionarioSalvo) {
      Navigator.of(context).pop();
      DialogWebPadrao.successDialog(
        context: context,
        message: 'Funcionário cadastrado com sucesso!',
        onPress: () {
          _nomeController.clear();
          _documentoController.clear();
          _telefoneController.clear();

          context.read<FuncionarioBloc>().add(const FuncionarioLoad());
        },
      );
    }

    if (state is FuncionarioError) {
      DialogWebPadrao.errorDialog(
        context: context,
        message: state.message,
        onPress: () {
          context.read<FuncionarioBloc>().add(const FuncionarioLoad());
        },
      );
    }

    if (state is FuncionarioErrorInicial) {
      DialogWebPadrao.errorDialog(
        context: context,
        message: state.message,
        onPress: () {},
      );
    }

    if (state.funcionarioEditar != null) {
      _nomeController.text = state.funcionarioEditar?.nome ?? '';
      _telefoneController.text = state.funcionarioEditar?.telefone ?? '';
      _documentoController.text = state.funcionarioEditar?.documento ?? '';
    }

    if (state is FuncionarioAtualizado) {
      Navigator.of(context).pop();
      DialogWebPadrao.successDialog(
        context: context,
        message: 'Funcionário atualizado com sucesso!',
        onPress: () {
          _nomeController.clear();
          _documentoController.clear();
          _telefoneController.clear();

          context.read<FuncionarioBloc>().add(const FuncionarioLoad());
        },
      );
    }
  }
}
