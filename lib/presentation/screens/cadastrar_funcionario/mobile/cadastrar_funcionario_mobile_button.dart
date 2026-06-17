import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:torpheus/presentation/screens/cadastrar_funcionario/bloc/cadastrar_funcionario_bloc.dart';

import '../../../../core/constants/color_constants.dart';
import '../../../components/app_primary_button.dart';

class CadastrarFuncionarioMobileButton extends StatelessWidget {
  const CadastrarFuncionarioMobileButton({
    super.key,
    required this.formKey,
    required this.nomeController,
    required this.telefoneController,
    required this.documentoController,
  });

  final GlobalKey<FormState> formKey;
  final TextEditingController nomeController;
  final TextEditingController telefoneController;
  final TextEditingController documentoController;

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<CadastrarFuncionarioBloc, CadastrarFuncionarioState>(
      builder: (context, state) {
        if (state.funcionario != null) {
          return Container(
            color: ColorConstants.chambray,
            child: AppPrimaryButton(
              fontSize: 17,
              text: 'Atualizar dados do funcionário',
              icon: Icons.check,
              onPressed: () => _onAtualizarFuncionario(context),
            ),
          );
        } else {
          return Container(
            color: ColorConstants.chambray,
            child: AppPrimaryButton(
              fontSize: 17,
              text: 'Adicionar novo funcionário',
              icon: Icons.check,
              onPressed: () => _onCadastrarFuncionario(context),
            ),
          );
        }
      },
    );
  }

  _onCadastrarFuncionario(BuildContext context) {
    if (formKey.currentState?.validate() ?? false) {
      context.read<CadastrarFuncionarioBloc>().add(
            CadastrarFuncionarioSubmit(
              telefone: telefoneController.text,
              documento: documentoController.text,
              nome: nomeController.text,
            ),
          );
    }
  }

  _onAtualizarFuncionario(BuildContext context) {
    if (formKey.currentState?.validate() ?? false) {
      context.read<CadastrarFuncionarioBloc>().add(
        CadastrarFuncionarioUpdate(
          telefone: telefoneController.text,
          documento: documentoController.text,
          nome: nomeController.text,
        ),
      );
    }
  }
}
