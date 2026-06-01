import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:torpheus/config/routes.dart';
import 'package:torpheus/presentation/components/dialog/dialog_mobile_padrao.dart';
import 'package:torpheus/presentation/components/loading_state.dart';
import 'package:torpheus/presentation/screens/cadastrar_funcionario/mobile/cadastrar_funcionario_mobile_body.dart';

import '../../../components/app_bar_padrao.dart';
import '../bloc/cadastrar_funcionario_bloc.dart';
import 'cadastrar_funcionario_mobile_botoes.dart';

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
      appBar: const AppBarPadrao(
        title: "Cadastrar Funcionário",
        hasLeading: true,
      ),
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
      bottomNavigationBar: CadastrarFuncionarioMobileBotoes(
        formKey: _formKey,
        nomeController: _nomeController,
        documentoController: _documentoController,
        telefoneController: _telefoneController,
      ),
    );
  }

  bool _buildWhen(
    CadastrarFuncionarioState previous,
    CadastrarFuncionarioState current,
  ) {
    return current is! CadastrarFuncionarioError &&
        current is! CadastrarFuncionarioSuccess;
  }

  void _listener(BuildContext context, CadastrarFuncionarioState state) {
    if (state is CadastrarFuncionarioSuccess) {
      DialogMobilePadrao.successDialog(
        context: context,
        message: 'Mecânico cadastrado com sucesso!',
        onPress: () {
          Navigator.of(context).pushNamed(AppRoutes.funcionario.route);
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
  }
}
