import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:torpheus/data/models/mecanico_model.dart';
import 'package:torpheus/presentation/screens/cadastrar_mecanico/bloc/cadastrar_mecanico_bloc.dart';
import 'package:torpheus/presentation/screens/cadastrar_mecanico/mobile/cadastrar_mecanico_mobile_footer.dart';

class CadastrarMecanicoMobileBotoes extends StatelessWidget {
  const CadastrarMecanicoMobileBotoes({
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
    return BlocBuilder<CadastrarMecanicoBloc, CadastrarMecanicoState>(
      builder: (context, state) {
        return CadastrarMecanicoMobileFooter(
          onCancelar: () {
            Navigator.of(context).pop();
          },
          onCadastrar: () {
            if (formKey.currentState?.validate() ?? false) {
              FuncionarioModel mecanico = FuncionarioModel(
                nome: nomeController.text.trim(),
                documento: documentoController.text.trim(),
                telefone: telefoneController.text.trim(),
                funcao: '',
              );

              context.read<CadastrarMecanicoBloc>().add(
                    CadastrarMecanicoSubmit(funcionario: mecanico),
                  );
            }
          },
          isLoading: state is CadastrarMecanicoLoading,
        );
      },
    );
  }
}
