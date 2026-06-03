import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:torpheus/presentation/components/dialog/dialog_mobile_padrao.dart';
import 'package:torpheus/presentation/components/loading_state.dart';
import 'package:torpheus/presentation/screens/cadastrar_funcionario/mobile/cadastrar_funcionario_mobile_body.dart';

import '../../../../core/constants/color_constants.dart';
import '../../../../data/models/mecanico_model.dart';
import '../../../components/app_bar_padrao.dart';
import '../../../components/app_primary_button.dart';
import '../bloc/cadastrar_funcionario_bloc.dart';

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
      bottomNavigationBar: Container(
        color: ColorConstants.chambray,
        child: AppPrimaryButton(
          fontSize: 17,
          text: 'Salvar funcionário',
          icon: Icons.check,
          onPressed: () => _onCadastrarFuncionario(context),
        ),
      ),
    );
  }

  void _onCadastrarFuncionario(BuildContext context) {
    if (_formKey.currentState?.validate() ?? false) {
      FuncionarioModel mecanico = FuncionarioModel(
        nome: _nomeController.text.trim(),
        documento: _documentoController.text.trim(),
        telefone: _telefoneController.text.trim(),
      );

      context.read<CadastrarFuncionarioBloc>().add(
            CadastrarFuncionarioSubmit(funcionario: mecanico),
          );
    }
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
  }
}
