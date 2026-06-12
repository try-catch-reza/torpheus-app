import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:torpheus/presentation/components/dialog/dialog_mobile_padrao.dart';
import 'package:torpheus/presentation/components/loading_state.dart';
import 'package:torpheus/presentation/screens/cadastrar_funcionario/mobile/cadastrar_funcionario_mobile_body.dart';
import 'package:torpheus/presentation/screens/cadastrar_funcionario/mobile/cadastrar_funcionario_mobile_button.dart';

import '../bloc/cadastrar_funcionario_bloc.dart';
import 'cadastrar_funcionario_mobile_appbar.dart';

class CadastrarFuncionarioMobileContent extends StatefulWidget {
  const CadastrarFuncionarioMobileContent({super.key});

  @override
  State<CadastrarFuncionarioMobileContent> createState() =>
      _CadastrarFuncionarioMobileContentState();
}

class _CadastrarFuncionarioMobileContentState
    extends State<CadastrarFuncionarioMobileContent> {
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
      appBar: const CadastrarFuncionarioMobileAppbar(),
      body: BlocConsumer<CadastrarFuncionarioBloc, CadastrarFuncionarioState>(
        buildWhen: _buildWhen,
        listener: _listener,
        builder: (context, state) {
          if (state is CadastrarFuncionarioLoading) {
            return const LoadingState();
          }

          if (state is CadastrarFuncionarioLoaded) {
            return CadastrarFuncionarioMobileBody(
              formKey: _formKey,
              nomeController: _nomeController,
              documentoController: _documentoController,
              telefoneController: _telefoneController,
              state: state,
            );
          }

          return const SizedBox.shrink();
        },
      ),
      bottomNavigationBar: CadastrarFuncionarioMobileButton(
        documentoController: _documentoController,
        telefoneController: _telefoneController,
        formKey: _formKey,
        nomeController: _nomeController,
      ),
    );
  }

  bool _buildWhen(
    CadastrarFuncionarioState previous,
    CadastrarFuncionarioState current,
  ) {
    return current is! CadastrarFuncionarioError &&
        current is! CadastrarFuncionarioSuccess &&
        current is! CadastrarFuncionarioAtualizado;
  }

  void _listener(BuildContext context, CadastrarFuncionarioState state) {
    if (state is CadastrarFuncionarioSuccess) {
      DialogMobilePadrao.successDialog(
        context: context,
        message: 'Funcionário cadastrado com sucesso!',
        onPress: () {
          Navigator.of(context).pop();
        },
      );
    }

    if (state is CadastrarFuncionarioError) {
      DialogMobilePadrao.errorDialog(
        context: context,
        message: state.message,
        onPress: () {
          context
              .read<CadastrarFuncionarioBloc>()
              .add(const CadastrarFuncionarioLoad());
        },
      );
    }

    if (state.funcionario != null) {
      _documentoController.text = state.funcionario?.documento ?? '';
      _telefoneController.text = state.funcionario?.telefone ?? '';
      _nomeController.text = state.funcionario?.nome ?? '';
    }

    if (state is CadastrarFuncionarioAtualizado) {
      DialogMobilePadrao.successDialog(
        context: context,
        message: 'Funcionário atualizado com sucesso!',
        onPress: () {
          Navigator.of(context).pop();
        },
      );
    }
  }
}
