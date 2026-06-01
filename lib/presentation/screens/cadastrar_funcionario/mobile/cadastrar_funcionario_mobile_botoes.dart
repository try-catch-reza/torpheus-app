import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:torpheus/data/models/mecanico_model.dart';

import '../bloc/cadastrar_funcionario_bloc.dart';
import 'cadastrar_funcionario_mobile_footer.dart';

class CadastrarFuncionarioMobileBotoes extends StatelessWidget {
  const CadastrarFuncionarioMobileBotoes({
    super.key,
    required this.formKey,
    required this.nomeController,
    required this.documentoController,
    required this.telefoneController,
  });

  final GlobalKey<FormState> formKey;
  final TextEditingController nomeController;
  final TextEditingController documentoController;
  final TextEditingController telefoneController;

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<CadastrarFuncionarioBloc, CadastrarFuncionarioState>(
      builder: (context, state) {
        return CadastrarFuncionarioMobileFooter(
          onCadastrar: () => _onCadastrar(context),
          isLoading: state is CadastrarFuncionarioLoading,
        );
      },
    );
  }

  void _onCadastrar(BuildContext context) {
    if (formKey.currentState?.validate() ?? false) {
      FuncionarioModel mecanico = FuncionarioModel(
        nome: nomeController.text.trim(),
        documento: documentoController.text.trim(),
        telefone: telefoneController.text.trim(),
        funcao: '',
      );

      context.read<CadastrarFuncionarioBloc>().add(
            CadastrarFuncionarioSubmit(funcionario: mecanico),
          );
    }
  }
}
